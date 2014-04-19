#import "STWNativeBridge.h"

@implementation STWNativeBridge


- (id)init
{
    self = [super init];

    if (self) {

        // initialize
        self.mainQueue = [NSOperationQueue mainQueue];
    }

    return self;
}

+ (STWServiceCall *)createServiceCallFromUrl:(NSURL *)url withWebView:(UIWebView *)webView
{
    if (![@"straw" isEqual:[url scheme]]) {
        return nil;
    }

    NSString *callId = [url host];

    NSString *getRequest = [NSString stringWithFormat:@"window.straw.getRequest(%@)", callId];

    NSString *requestJSON = [webView stringByEvaluatingJavaScriptFromString:getRequest];

    return [STWServiceCallFactory createFromCallRequestJSON:[requestJSON dataUsingEncoding:NSUTF8StringEncoding]];

}


+ (BOOL)isStrawURL:(NSURL *)url
{
    return [@"straw" isEqual:[url scheme]];
}


- (void)sendData:(NSDictionary *)object toWebView:(UIWebView *)webView
{
    // create JSON bytes
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:0 error:nil];

    // convert to NSString
    NSString *dataJSON = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    // create JS message string
    NSString *message = [NSString stringWithFormat:@"window.straw.receiveData(%@)", dataJSON];

    // post to the main thread
    [self.mainQueue addOperation:[[STWServiceCallbackOperation alloc] initWithMessage:message withWebView:webView]];
}

@end

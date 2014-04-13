#import "STWNativeBridge.h"

@implementation STWNativeBridge

+ (STWServiceCall *)createServiceCallFromUrl:(NSURL *)url withWebView:(UIWebView *)webView
{
    if ([@"straw" isEqual:[url scheme]]) {

        NSString *callId = [url host];

        NSString *getRequest = [NSString stringWithFormat:@"window.straw.getRequest(%@)", callId];

        NSString *requestJSON = [webView stringByEvaluatingJavaScriptFromString:getRequest];

        return [STWServiceCallFactory createFromCallRequestJSON:[requestJSON dataUsingEncoding:NSUTF8StringEncoding]];

    }

    return nil;
}


+ (BOOL)isStrawURL:(NSURL *)url
{
    return [@"straw" isEqual:[url scheme]];
}


+ (void)sendData:(NSDictionary *)object toWebView:(UIWebView *)webView
{
    // create JSON bytes
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:0 error:nil];

    // convert to NSString
    NSString *dataJSON = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    // create JS message string
    NSString *message = [NSString stringWithFormat:@"window.straw.receiveData(%@)", dataJSON];

    // post to the main thread
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{

        if (webView) {
            // send message to Browser
            [webView stringByEvaluatingJavaScriptFromString:message];
        } else {
            // log - web view deleted, cannot send back message
        }

    }];
}

@end

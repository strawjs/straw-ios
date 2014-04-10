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

@end

#import "STWWebViewDelegate.h"

@implementation STWWebViewDelegate


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];

    if ([@"straw" isEqual:[url scheme]]) {

        NSString *callId = [url host];

        NSString *getRequest = [NSString stringWithFormat:@"window.straw.getRequest(%@)", callId];

        NSString *requestJSON = [webView stringByEvaluatingJavaScriptFromString:getRequest];

        STWServiceCall *serviceCall = [STWServiceCallFactory createFromCallRequestJSON:[requestJSON dataUsingEncoding:NSUTF8StringEncoding]];

        STWServiceRepository *repository = [[STWServiceRepository alloc] init];

        STWCallOperation *operation = [[STWCallOperation alloc] initWithCall:serviceCall withServiceRepository:repository];

        [operation main];

        return NO;

    }

    return YES;
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
}

@end

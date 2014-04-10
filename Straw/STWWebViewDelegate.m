#import "STWWebViewDelegate.h"

@implementation STWWebViewDelegate

- (id)init
{
    self = [super init];

    if (self) {
        self.repository = [[STWServiceRepository alloc] init];
    }

    return self;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];

    if ([STWNativeBridge isStrawURL:url]) {

        STWServiceCall *serviceCall = [STWNativeBridge createServiceCallFromUrl:url withWebView:webView];

        STWCallOperation *operation = [[STWCallOperation alloc] initWithCall:serviceCall withServiceRepository:self.repository withWebView:webView];

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

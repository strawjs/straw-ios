#import "STWWebViewDelegate.h"

@implementation STWWebViewDelegate


-(id)init{
    return [self initWithWebView:nil];
}

- (id)initWithWebView:(UIWebView *)webView
{
    return [self initWithWebView:webView withViewController:nil];
}

- (id)initWithWebView:(UIWebView *)webView withViewController:(UIViewController *)viewController
{
    self = [super init];

    if (!webView) {
        STWLogWarn(@"initialized with webView == nil; without webView any function of Straw Framework doesn't work.");
    }

    if (self) {

        // initialize bridge
        self.bridge = [[STWNativeBridge alloc] initWithWebView:webView withViewController:viewController];

        if (webView) {
            // set delegate to self
            webView.delegate = self;
        }
    }

    return self;
}

//
// ⚡ THE BROWSER-TO-NATIVE ENTRYPOINT ⚡
//
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // log verbose at the entry point
    STWLogVerbose(@"invoked -webView:shouldStartLoadWithRequest:navigationType: url=%@", [[request URL] absoluteString]);

    if (![self.bridge isStrawURLRequest:request]) {

        // If the url scheme is not the form of "straw://", then the request is not relevant to Straw.
        // So return YES to load normally.
        return YES;

    }

    // execute Straw Service Method call
    [self.bridge executeRequest:request];

    // stop loading in usual manner
    return NO;

}


- (void)loadService:(Class<STWService>)serviceClass
{
    [self.bridge loadService:serviceClass];
}



// empty delegate method implementations

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

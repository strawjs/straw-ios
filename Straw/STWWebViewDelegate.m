#import "STWWebViewDelegate.h"

@implementation STWWebViewDelegate

- (id)init
{
    self = [super init];

    if (self) {

        // initialize the bridge
        self.bridge = [[STWNativeBridge alloc] init];
    }

    return self;
}


- (id)initWithWebView:(UIWebView *)webView withViewController:(UIViewController *)viewController
{
    self = [self init];

    if (self) {

        // initialize properties
        self.bridge.webView = webView;
        self.bridge.viewController = viewController;

        // set delegate to self
        webView.delegate = self;

    }

    return self;
}


/**
 *
 * THE BRIDGE FROM BROWSER TO NATIVE
 *
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
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

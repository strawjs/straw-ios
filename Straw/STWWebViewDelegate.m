#import "STWWebViewDelegate.h"

@implementation STWWebViewDelegate

- (id)init
{
    self = [super init];

    if (self) {
        self.repository = [[STWServiceRepository alloc] init];
        self.operationQueue = [[NSOperationQueue alloc] init];
    }

    return self;
}


/** THE BRIDGE */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];


    // If the url doesn't have straw:// scheme, then it is not relevant to Straw
    // and normal url request.
    if (![STWNativeBridge isStrawURL:url]) {
        return YES;
    }


    STWServiceCall *serviceCall = [STWNativeBridge createServiceCallFromUrl:url
                                                                withWebView:webView];

    // If the service call object is nil, then the url is broken.
    if (!serviceCall) {
        STWLogWarn(@"Straw url is broken: '%@'", [url absoluteString]);

        return NO;
    }


    // retrieve service instance from repository
    id<STWService> service = [self.repository getService:serviceCall.service];


    // If the service is nil, then the service of the name doesn't exists
    // and cannot perform anything.
    if (!service) {
        STWLogWarn(@"Straw service not found: service='%@'", serviceCall.service);

        return NO;
    }


    // create operation object
    STWServiceCallOperation *operation = [[STWServiceCallOperation alloc] initWithCall:serviceCall
                                                                           withService:service
                                                                           withWebView:webView];

    // post to background queue
    [self.operationQueue addOperation:operation];



    return NO;

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

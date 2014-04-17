#import "STWWebViewDelegate.h"

@implementation STWWebViewDelegate

- (id)init
{
    self = [super init];

    if (self) {

        // initialize
        self.repository = [[STWServiceRepository alloc] init];
        self.operationQueue = [[NSOperationQueue alloc] init];
        self.webView = nil;
        self.viewController = nil;
    }

    return self;
}


- (id)initWithWebView:(UIWebView *)webView withViewController:(UIViewController *)viewController
{
    self = [self init];

    if (self) {

        // initialize properties
        self.webView = webView;
        self.viewController = viewController;

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
        STWLogError(@"Straw url is broken: '%@'", [url absoluteString]);

        return NO;
    }


    // retrieve service instance from repository
    id<STWService> service = [self.repository getService:serviceCall.service];


    // If the service is nil, then the service of the name doesn't exists
    // and cannot perform anything.
    if (!service) {
        STWLogError(@"Straw service not found: service='%@'", serviceCall.service);

        return NO;
    }


    // create operation object
    STWServiceCallOperation *operation = [[STWServiceCallOperation alloc] initWithCall:serviceCall withService:service withWebView:webView];


    if ([service isBackgroundJob:serviceCall.method]) {

        // post to background queue
        [self.operationQueue addOperation:operation];

    } else {

        // post to the main thread
        [[NSOperationQueue mainQueue] addOperation:operation];

    }



    return NO;

}


- (void)loadService:(Class<STWService>)serviceClass
{
    id<STWService> service = [[serviceClass alloc] init];

    if ([service conformsToProtocol:@protocol(STWServiceWithWebView)]) {

        id<STWServiceWithWebView> serviceWithWebView = (id<STWServiceWithWebView>)service;

        serviceWithWebView.webView = self.webView;

    }

    if ([service conformsToProtocol:@protocol(STWServiceWithViewController)]) {

        id<STWServiceWithViewController> serviceWithViewController = (id<STWServiceWithViewController>)service;

        serviceWithViewController.viewController = self.viewController;

    }

    [self.repository registerService:service];

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

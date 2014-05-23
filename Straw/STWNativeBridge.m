#import "STWNativeBridge.h"

// straw-ios.js interfaces
// see https://github.com/strawjs/straw-ios.js for details

#define kSTWNativeBridgeJSExprGetRequestParams @"straw.core.getRequestParams('%@')"
#define kSTWNativeBridgeJSExprSucceed @"straw.core.succeed('%@',%@,%@)"
#define kSTWNativeBridgeJSExprFail @"straw.core.fail('%@',%@,%@)"

@implementation STWNativeBridge


- (id)init
{
    self = [super init];

    if (self) {

        // initialize properties
        self.mainQueue = [NSOperationQueue mainQueue];
        self.operationQueue = [[NSOperationQueue alloc] init];
        self.repository = [[STWServiceRepository alloc] init];
        self.webView = nil;
        self.viewController = nil;

    }

    return self;
}


- (id)initWithWebView:(UIWebView *)webView withViewController:(UIViewController *)viewController
{
    self = [self init];

    if (self) {

        // initialize
        self.webView = webView;
        self.viewController = viewController;

    }

    return self;
}

- (STWServiceCall *)createServiceCallFromUrlRequest:(NSURLRequest *)request
{
    if (!self.webView) {
        STWLogFatal(@"webView is nil and cannot process Straw call: url=%@", [[request URL] absoluteString]);
        STWLogFatal(@"STWWebViewDelegate class should be initialized with webView.");

        return nil;
    }

    if (![self isStrawURLRequest:request]) {
        STWLogDebug(@"request url is not straw url request: url=%@", [[request URL] absoluteString]);

        return nil;
    }

    NSString *callId = [[request URL] host];

    NSString *getRequest = [NSString stringWithFormat:kSTWNativeBridgeJSExprGetRequestParams, callId];

    NSString *requestJSON = [self.webView stringByEvaluatingJavaScriptFromString:getRequest];

    return [STWServiceCallFactory createFromCallRequestJSON:[requestJSON dataUsingEncoding:NSUTF8StringEncoding]];

}


- (BOOL)isStrawURLRequest:(NSURLRequest *)request
{
    return [@"straw" isEqual:[[request URL] scheme]];
}


- (void)loadService:(Class<STWService>)serviceClass
{
    id<STWService> service = [[serviceClass alloc] init];

    // if service conforms to STWServiceWithWebView protocol
    if ([service conformsToProtocol:@protocol(STWServiceWithWebView)]) {

        id<STWServiceWithWebView> serviceWithWebView = (id<STWServiceWithWebView>)service;

        // inject the webView to webView property
        serviceWithWebView.webView = self.webView;

    }

    // if service conforms to STWServiceWithViewController protocol
    if ([service conformsToProtocol:@protocol(STWServiceWithViewController)]) {

        id<STWServiceWithViewController> serviceWithViewController = (id<STWServiceWithViewController>)service;

        // inject the viewController to viewController property
        serviceWithViewController.viewController = self.viewController;

    }

    // register to the repository
    [self.repository registerService:service];

}


- (void)executeRequest:(NSURLRequest *)request
{

    // If the url doesn't have straw:// scheme, then it is not relevant to Straw
    // and normal url request.
    if (![self isStrawURLRequest:request]) {
        return;
    }

    // create service call from url request
    STWServiceCall *serviceCall = [self createServiceCallFromUrlRequest:request];

    // If the service call object is not created, then return.
    if (!serviceCall) {
        // log nothing here because the reason why service call is not created should have been already logged before here.

        return;
    }


    // retrieve service instance from repository
    id<STWService> service = [self.repository getService:serviceCall.service];


    // If the service is nil, then the service of the name doesn't exists
    // and cannot perform anything.
    if (!service) {
        STWLogError(@"Straw service not found: service='%@'", serviceCall.service);

        return;
    }


    // create operation object
    STWServiceCallOperation *operation = [[STWServiceCallOperation alloc] initWithCall:serviceCall withService:service withBridge:self];


    if ([service isBackgroundJob:serviceCall.method]) {

        // post to background thread queue
        [self.operationQueue addOperation:operation];

    } else {

        // post to the main thread queue
        [self.mainQueue addOperation:operation];

    }

}


- (void)sendData:(NSDictionary *)params withCallId:(NSString *)callId withSuccess:(BOOL)isSuccess withKeepAlive:(BOOL)keepAlive
{
    // create JSON bytes
    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];

    // convert to NSString
    NSString *dataJSON = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    NSString *message;

    if (isSuccess) {
        // create JS message string
        message = [NSString stringWithFormat:kSTWNativeBridgeJSExprSucceed, callId, dataJSON, @(keepAlive)];
    } else {
        // create JS message string
        message = [NSString stringWithFormat:kSTWNativeBridgeJSExprFail, callId, dataJSON, @(keepAlive)];
    }

    // post to the main thread
    [self.mainQueue addOperation:[[STWServiceCallbackOperation alloc] initWithMessage:message withWebView:self.webView]];
}

@end

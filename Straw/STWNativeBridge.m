#import "STWNativeBridge.h"

@implementation STWNativeBridge


- (id)init
{
    self = [super init];

    if (!self) {
        return self;
    }

    // initialize properties
    self.mainQueue = [NSOperationQueue mainQueue];
    self.operationQueue = [[NSOperationQueue alloc] init];
    self.repository = [[STWServiceRepository alloc] init];
    self.webView = nil;
    self.viewController = nil;

    return self;
}


- (id)initWithWebView:(UIWebView *)webView withViewController:(UIViewController *)viewController
{
    self = [self init];

    if (!self) {
        return self;
    }

    // initialize
    self.webView = webView;
    self.viewController = viewController;

    return self;
}

- (STWServiceCall *)createServiceCallFromUrl:(NSURL *)url
{
    if (![@"straw" isEqual:[url scheme]]) {
        return nil;
    }

    NSString *callId = [url host];

    NSString *getRequest = [NSString stringWithFormat:@"window.straw.getRequest(%@)", callId];

    NSString *requestJSON = [self.webView stringByEvaluatingJavaScriptFromString:getRequest];

    return [STWServiceCallFactory createFromCallRequestJSON:[requestJSON dataUsingEncoding:NSUTF8StringEncoding]];

}


- (BOOL)isStrawURLRequest:(NSURLRequest *)request
{
    NSURL *url = [request URL];

    return [@"straw" isEqual:[url scheme]];
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


- (void)executeRequest:(NSURLRequest *)request
{

    // If the url doesn't have straw:// scheme, then it is not relevant to Straw
    // and normal url request.
    if (![self isStrawURLRequest:request]) {
        return;
    }

    NSURL *url = [request URL];


    STWServiceCall *serviceCall = [self createServiceCallFromUrl:url];

    // If the service call object is nil, then the url is broken.
    if (!serviceCall) {
        STWLogError(@"Straw url is broken: '%@'", [url absoluteString]);

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


- (void)sendData:(NSDictionary *)object
{
    // create JSON bytes
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:0 error:nil];

    // convert to NSString
    NSString *dataJSON = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    // create JS message string
    NSString *message = [NSString stringWithFormat:@"window.straw.receiveData(%@)", dataJSON];

    // post to the main thread
    [self.mainQueue addOperation:[[STWServiceCallbackOperation alloc] initWithMessage:message withWebView:self.webView]];
}

@end

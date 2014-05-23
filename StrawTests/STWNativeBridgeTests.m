#import "STWTestCase.h"

@interface STWNativeBridgeTests : STWTestCase

@end

@implementation STWNativeBridgeTests


- (void)testInitWithWebViewWithViewController
{
    // mock webView
    UIWebView *webView = mock([UIWebView class]);

    // mock viewController
    UIViewController *viewController = mock([UIViewController class]);


    // initialize bridge
    STWNativeBridge *bridge = [[STWNativeBridge alloc] initWithWebView:webView withViewController:viewController];


    XCTAssertNotNil(bridge, @"A bridge can init.");

    XCTAssertNotNil(bridge.mainQueue, @"mainQueue property is not nil.");

    XCTAssertNotNil(bridge.operationQueue, @"operationQueue property is not nil.");

    XCTAssertNotNil(bridge.repository, @"repository property is not nil.");

    XCTAssertEqualObjects(webView, bridge.webView, @"webView property is set properly.");

    XCTAssertEqualObjects(viewController, bridge.viewController, @"viewController property is set properly.");
}


- (void)testCreateServiceCallFromURLRequest
{
    // mock webView
    UIWebView *webView = mock([UIWebView class]);

    // stub stringByEvaluatingJavaScriptFromString
    [given([webView stringByEvaluatingJavaScriptFromString:@"JSON.stringify(straw.core.getRequestParams('123'))"]) willReturn:@"{\"service\":\"dummy\",\"method\":\"dummyMethod\",\"callId\":\"123\",\"params\":{\"abc\":\"123\",\"def\":456}}"];

    // mock viewController
    UIViewController *viewController = mock([UIViewController class]);

    // create bridge object
    STWNativeBridge *bridge = [[STWNativeBridge alloc] initWithWebView:webView withViewController:viewController];

    STWServiceCall *call = [bridge createServiceCallFromUrlRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"straw://123"]]];


    // assert things
    XCTAssertNotNil(call, @"STWServiceCall object created.");

    XCTAssertEqualObjects(@"123", call.callId, @"callId property is set properly.");

    XCTAssertEqualObjects(@"dummy", call.service, @"service property is set properly.");

    XCTAssertEqualObjects(@"dummyMethod", call.method, @"method property is set properly.");

    XCTAssertEqualObjects((@{@"abc": @"123", @"def": @456}), call.params, @"params properly is set properly.");
}


- (void)testCreateServiceCallFromNotStrawURLRequest
{
    STWNativeBridge *bridge = [[STWNativeBridge alloc] init];

    // set mock webView
    bridge.webView = mock([UIWebView class]);

    STWServiceCall *serviceCall = [bridge createServiceCallFromUrlRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost/"]]];

    XCTAssertNil(serviceCall, @"serviceCall is not created");

    [verifyCount(self.logger, times(1)) debug:@"request url is not straw url request: url=http://localhost/"];
}


- (void)testCreateServiceCallWithoutWebView
{
    STWNativeBridge *bridge = [[STWNativeBridge alloc] init];

    STWServiceCall *serviceCall = [bridge createServiceCallFromUrlRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost/"]]];

    XCTAssertNil(serviceCall, @"serviceCall is not created");

    [verifyCount(self.logger, times(1)) fatal:@"webView is nil and cannot process Straw call: url=http://localhost/"];
    [verifyCount(self.logger, times(1)) fatal:@"STWWebViewDelegate class should be initialized with webView."];
}


- (void)testIsStrawuURLRequest
{
    STWNativeBridge *bridge = [[STWNativeBridge alloc] init];

    XCTAssertTrue([bridge isStrawURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"straw://123"]]]);
    XCTAssertFalse([bridge isStrawURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://a/b"]]]);
    XCTAssertFalse([bridge isStrawURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"stra://123"]]]);
    XCTAssertFalse([bridge isStrawURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"straww://123"]]]);
    XCTAssertFalse([bridge isStrawURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"straw"]]]);
    XCTAssertFalse([bridge isStrawURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"gap://123"]]]);
}


- (void)testLoadService
{
    // mock webView
    UIWebView *webView = mock([UIWebView class]);

    // mock viewController
    UIViewController *viewController = mock([UIViewController class]);


    // initialize bridge
    STWNativeBridge *bridge = [[STWNativeBridge alloc] initWithWebView:webView withViewController:viewController];


    // load services
    [bridge loadService:[DummyService class]];

    XCTAssertNotNil([bridge.repository getService:@"dummy"], @"`dummy` service is set.");

    XCTAssertTrue([[bridge.repository getService:@"dummy"] isKindOfClass:[DummyService class]], @"`dummy` service is an instance of DummyService.");

    XCTAssertNil([bridge.repository getService:@"dumm"], @"The service named `dumm` is no set.");
}


- (void)testLoadServiceWithWebViewAndOrViewController
{
    // mock webView
    UIWebView *webView = mock([UIWebView class]);

    // mock viewController
    UIViewController *viewController = mock([UIViewController class]);


    // initialize bridge
    STWNativeBridge *bridge = [[STWNativeBridge alloc] initWithWebView:webView withViewController:viewController];


    // load services
    [bridge loadService:[DummyServiceWithWebView class]];
    [bridge loadService:[DummyServiceWithViewController class]];
    [bridge loadService:[DummyServiceWithWebViewAndViewController class]];


    // check the loading of DummyServiceWithWebView
    DummyServiceWithWebView *serviceWithWebView = (DummyServiceWithWebView *)[bridge.repository getService:@"dummyWithWebView"];

    XCTAssertNotNil(serviceWithWebView, @"`dummyWithWebView` service is loaded.");

    XCTAssertTrue([serviceWithWebView isKindOfClass:[DummyServiceWithWebView class]], @"`dummyWithWebView` service is an instance of DummyServiceWithWebView");

    XCTAssertEqualObjects(webView, serviceWithWebView.webView, @"webView property is set.");


    // check the loading of DummyServiceWithViewController
    DummyServiceWithViewController *serviceWithViewController = (DummyServiceWithViewController *)[bridge.repository getService:@"dummyWithViewController"];

    XCTAssertNotNil(serviceWithViewController, @"`dummyWithViewController` service is loaded");

    XCTAssertTrue([serviceWithViewController isKindOfClass:[DummyServiceWithViewController class]], @"`dummyWithViewController` service is an instance of DummyServiceWithViewController");

    XCTAssertEqualObjects(viewController, serviceWithViewController.viewController, @"viewController property is set.");


    // check the loading of DummyServiceWithWebViewAndViewController
    DummyServiceWithWebViewAndViewController *serviceWithWebViewAndViewController = (DummyServiceWithWebViewAndViewController *)[bridge.repository getService:@"dummyWithWebViewAndViewController"];

    XCTAssertNotNil(serviceWithWebViewAndViewController, @"`dummyWithWebViewAndViewController` service is set.");

    XCTAssertTrue([serviceWithWebViewAndViewController isKindOfClass:[DummyServiceWithWebViewAndViewController class]], @"`dummyWithWebViewAndViewController` service is an instance of DummyServiceWithWebViewAndViewController");

    XCTAssertEqualObjects(webView, serviceWithWebViewAndViewController.webView, @"webView property is set.");
    XCTAssertEqualObjects(viewController, serviceWithWebViewAndViewController.viewController, @"viewController property is set.");
}


- (void)testExecuteRequestWithNonStrawURLRequest
{
    STWNativeBridge *bridge = [[STWNativeBridge alloc] init];

    // execution with non straw url request cause nothing.
    [bridge executeRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost/"]]];
}


- (void)testExecuteRequestWithInsufficientStrawRequestObject
{
    // mock up webView
    UIWebView *webView = mock([UIWebView class]);

    // stub stringByEvaluatingJavaScriptFromString
    // it returns insufficient straw request object.
    [given([webView stringByEvaluatingJavaScriptFromString:@"JSON.stringify(straw.core.getRequestParams('123'))"]) willReturn:@"{\"service\":\"dummy\"}"];

    // create bridge
    STWNativeBridge *bridge = [[STWNativeBridge alloc] initWithWebView:webView withViewController:nil];

    // execute
    [bridge executeRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"straw://123"]]];

    // verify logging
    [verifyCount(self.logger, times(1)) error:@"`method` field of the Straw request object is empty and the request is canceled:"];
}


- (void)testExecuteRequestWithServiceNotFound
{
    // mock up webView
    UIWebView *webView = mock([UIWebView class]);

    // stub stringByEvaluatingJavaScriptFromString
    // it returns insufficient straw request object.
    [given([webView stringByEvaluatingJavaScriptFromString:@"JSON.stringify(straw.core.getRequestParams('123'))"]) willReturn:@"{\"service\":\"dummy\",\"method\":\"dummyMethod\",\"callId\":\"123\"}"];

    // create bridge
    STWNativeBridge *bridge = [[STWNativeBridge alloc] initWithWebView:webView withViewController:nil];

    // execute
    [bridge executeRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"straw://123"]]];

    // verify logging
    [verifyCount(self.logger, times(1)) error:@"Straw service not found: service='dummy'"];
}


- (void)testExecuteRequestBackgroundJob
{
    // mock up webView
    UIWebView *webView = mock([UIWebView class]);

    // stub stringByEvaluatingJavaScriptFromString
    // it returns insufficient straw request object.
    [given([webView stringByEvaluatingJavaScriptFromString:@"JSON.stringify(straw.core.getRequestParams('123'))"]) willReturn:@"{\"service\":\"dummy\",\"method\":\"dummyMethod\",\"params\":{\"abc\":\"123\",\"def\":456},\"callId\":\"123\"}"];

    // create bridge
    STWNativeBridge *bridge = [[STWNativeBridge alloc] initWithWebView:webView withViewController:nil];

    // mock up operation
    NSOperationQueue *operationQueue = mock([NSOperationQueue class]);

    // set mock
    bridge.operationQueue = operationQueue;

    // load DummyService
    [bridge loadService:[DummyService class]];

    // execute
    [bridge executeRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"straw://123"]]];

    // create argument captor
    MKTArgumentCaptor *argument = [[MKTArgumentCaptor alloc] init];

    // capture the argument of [operationQueue addOperation:(argument)]
    [verifyCount(operationQueue, times(1)) addOperation:[argument capture]];

    // retrieve value
    STWServiceCallOperation *operation = [argument value];

    XCTAssertNotNil(operation, @"The queued operation is not nil.");

    XCTAssertNotNil(operation.serviceCall, @"The service call is set on the operation.");

    XCTAssertEqualObjects(@"dummy", operation.serviceCall.service, @"`service` corresponds to Straw request object's field.");

    XCTAssertEqualObjects(@"dummyMethod", operation.serviceCall.method, @"`method` corresponds to Straw request object's field.");

    XCTAssertEqualObjects((@{@"abc": @"123", @"def": @456}), operation.serviceCall.params, @"`params` corresponds to Straw request object's field.");

    XCTAssertEqualObjects(@"123", operation.serviceCall.callId, @"`callId` corresponds to Straw request object's field.");

    XCTAssertNotNil(operation.service, @"The service is set on the operation.");

    XCTAssertTrue([operation.service isKindOfClass:[DummyService class]], @"`service` is instance of loaded class");

}


- (void)testExecuteRequestMainThreadJob
{
    // mock up webView
    UIWebView *webView = mock([UIWebView class]);

    // stub stringByEvaluatingJavaScriptFromString
    // it returns insufficient straw request object.
    [given([webView stringByEvaluatingJavaScriptFromString:@"JSON.stringify(straw.core.getRequestParams('123'))"]) willReturn:@"{\"service\":\"dummy\",\"method\":\"dummyMethodMainThread\",\"params\":{\"abc\":\"123\",\"def\":456},\"callId\":\"123\"}"];

    // create bridge
    STWNativeBridge *bridge = [[STWNativeBridge alloc] initWithWebView:webView withViewController:nil];

    // mock up operationQueue
    NSOperationQueue *operationQueue = mock([NSOperationQueue class]);

    // set mock
    bridge.mainQueue = operationQueue;

    // load DummyService
    [bridge loadService:[DummyService class]];

    // execute
    [bridge executeRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"straw://123"]]];

    // create argument captor
    MKTArgumentCaptor *argument = [[MKTArgumentCaptor alloc] init];

    // capture the argument of [operationQueue addOperation:(argument)]
    [verifyCount(operationQueue, times(1)) addOperation:[argument capture]];

    // retrieve value
    STWServiceCallOperation *operation = [argument value];

    XCTAssertNotNil(operation, @"The queued operation is not nil.");

    XCTAssertNotNil(operation.serviceCall, @"The service call is set on the operation.");

    XCTAssertEqualObjects(@"dummy", operation.serviceCall.service, @"`service` corresponds to Straw request object's field.");

    XCTAssertEqualObjects(@"dummyMethodMainThread", operation.serviceCall.method, @"`method` corresponds to Straw request object's field.");

    XCTAssertEqualObjects((@{@"abc": @"123", @"def": @456}), operation.serviceCall.params, @"`params` corresponds to Straw request object's field.");

    XCTAssertEqualObjects(@"123", operation.serviceCall.callId, @"`callId` corresponds to Straw request object's field.");

    XCTAssertNotNil(operation.service, @"The service is set on the operation.");

    XCTAssertTrue([operation.service isKindOfClass:[DummyService class]], @"`service` is instance of loaded class");

}


- (void)testSendData
{
    // mock up webView
    UIWebView *webView = mock([UIWebView class]);

    // create bridge
    STWNativeBridge *bridge = [[STWNativeBridge alloc] initWithWebView:webView withViewController:nil];

    // mock up operationQueue
    NSOperationQueue *operationQueue = mock([NSOperationQueue class]);

    // set mock
    bridge.mainQueue = operationQueue;

    // call sendData
    [bridge sendData:@{@"abc": @123} withCallId:@"id_abc" withSuccess:YES withKeepAlive:NO];

    // create argument captor
    MKTArgumentCaptor *argument = [[MKTArgumentCaptor alloc] init];

    // capture argument of addOperation
    [verifyCount(operationQueue, times(1)) addOperation:[argument capture]];

    // retrieve captured value
    STWServiceCallbackOperation *callbackOperation = [argument value];


    XCTAssertNotNil(callbackOperation, @"callbackOperation is queued.");

    XCTAssertEqualObjects(@"straw.core.succeed('id_abc',{\"abc\":123},0)", callbackOperation.message, @"message property is set.");

    XCTAssertEqualObjects(webView, callbackOperation.webView, @"webView is set.");
}


@end

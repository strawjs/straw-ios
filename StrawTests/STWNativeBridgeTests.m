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


- (void)testCreateServiceCallFromUrlRequest
{
    // mock webView
    UIWebView *webView = mock([UIWebView class]);

    // stub stringByEvaluatingJavaScriptFromString
    [given([webView stringByEvaluatingJavaScriptFromString:@"window.straw.getRequest('123')"]) willReturn:@"{\"service\":\"dummy\",\"method\":\"dummyMethod\",\"callId\":\"123\",\"params\":{\"abc\":\"123\",\"def\":456}}"];

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


- (void)testExecuteRequestWithBrokenStrawURLRequest
{
    // mock up webView
    UIWebView *webView = mock([UIWebView class]);

    // stub stringByEvaluatingJavaScriptFromString
    // it returns insufficient straw request object.
    [given([webView stringByEvaluatingJavaScriptFromString:@"window.straw.getRequest('123')"]) willReturn:@"{\"service\":\"dummy\"}"];

    // mock up logger
    STWLogger *logger = mock([STWLogger class]);

    [STWLogger setSharedLogger:logger];

    // create bridge
    STWNativeBridge *bridge = [[STWNativeBridge alloc] initWithWebView:webView withViewController:nil];

    // execute
    [bridge executeRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"straw://123"]]];

    // verify logging
    [verifyCount(logger, times(1)) error:@"Straw request object is broken: url='straw://123'"];
}


@end

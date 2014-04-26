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


@end

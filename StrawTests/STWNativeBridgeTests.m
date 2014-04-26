#import "STWTestCase.h"

@interface STWNativeBridgeTests : STWTestCase

@end

@implementation STWNativeBridgeTests


- (void)testInitWithWebViewWithViewController
{
    UIWebView *webView = mock([UIWebView class]);
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


@end

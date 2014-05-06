#import "STWTestCase.h"

@interface STWWebViewDelegateTests : STWTestCase

@end

@implementation STWWebViewDelegateTests


- (void)testInitWithWebViewWithViewController
{
    UIViewController *viewController = mock([UIViewController class]);

    UIWebView *webView = mock([UIWebView class]);

    STWWebViewDelegate *delegate = [[STWWebViewDelegate alloc] initWithWebView:webView withViewController:viewController];

    XCTAssertNotNil(delegate, @"delegate can constructor");
    XCTAssertNotNil(delegate.bridge, @"the bridge initialized");

    [verifyCount(webView, times(1)) setDelegate:delegate];
}


- (void)testInitWithWebView
{
    UIWebView *webView = mock([UIWebView class]);

    STWWebViewDelegate *delegate = [[STWWebViewDelegate alloc] initWithWebView:webView];

    XCTAssertNotNil(delegate, @"delegate can constructor");
    XCTAssertNotNil(delegate.bridge, @"the bridge initialized");

    [verifyCount(webView, times(1)) setDelegate:delegate];
}


- (void)testInitWithNilWebView
{
    // doesn't throw runtime error
    STWWebViewDelegate *delegate = [[STWWebViewDelegate alloc] initWithWebView:nil];

    XCTAssertNotNil(delegate, @"delegate can constructor");
    XCTAssertNotNil(delegate.bridge, @"the bridge initialized");

    [verifyCount(self.logger, times(1)) warn:@"initialized with webView == nil; without webView any function of Straw Framework doesn't work."];
}


- (void)testShouldStartLoad
{
    // create delegate instance
    STWWebViewDelegate *delegate = [[STWWebViewDelegate alloc] init];

    // inject mock bridge
    delegate.bridge = mock([STWNativeBridge class]);

    // stub isStrawURLRequest method
    [given([delegate.bridge isStrawURLRequest:anything()]) willReturnBool:YES];

    // create url request object
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"straw://123"]];


    // invoke target method
    BOOL shouldStartLoad = [delegate webView:nil shouldStartLoadWithRequest:request navigationType:UIWebViewNavigationTypeBackForward];

    // the result is NO because the request is a straw request
    XCTAssertFalse(shouldStartLoad, @"the result should be NO because the request is a straw request");

    // verify bridge interaction
    [verifyCount(delegate.bridge, times(1)) executeRequest:request];

    // verify logging
    [verifyCount(self.logger, times(1)) verbose:@"invoked -webView:shouldStartLoadWithRequest:navigationType: url=straw://123"];

}


- (void)testShouldStartLoadNotStrawRequest
{

    // create delegate instance
    STWWebViewDelegate *delegate = [[STWWebViewDelegate alloc] init];

    // inject mock bridge
    delegate.bridge = mock([STWNativeBridge class]);

    // stub isStrawURLRequest method
    [given([delegate.bridge isStrawURLRequest:anything()]) willReturnBool:NO];

    // create url request object
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost/"]];

    // invoke target method
    BOOL shouldStartLoad = [delegate webView:nil shouldStartLoadWithRequest:request navigationType:UIWebViewNavigationTypeBackForward];

    // the result is YES because the request is a straw request
    XCTAssertTrue(shouldStartLoad, @"the result should be YES because the request is not a straw request");

    // verify bridge interaction
    [verifyCount(delegate.bridge, never()) executeRequest:request];

    // verify logging
    [verifyCount(self.logger, times(1)) verbose:@"invoked -webView:shouldStartLoadWithRequest:navigationType: url=http://localhost/"];
}


- (void)testLoadService
{

    // create delegate instance
    STWWebViewDelegate *delegate = [[STWWebViewDelegate alloc] init];

    // inject mock bridge
    delegate.bridge = mock([STWNativeBridge class]);

    Class<STWService> serviceClass = [DummyService class];

    // invoke target method
    [delegate loadService:serviceClass];

    // verify bridge interaction
    [verifyCount(delegate.bridge, times(1)) loadService:serviceClass];

}


// following tests are just for assuring line coverage.


- (void)testDidFinishLoad
{
    // create delegate instance
    STWWebViewDelegate *delegate = [[STWWebViewDelegate alloc] init];

    // invoke target method
    [delegate webViewDidFinishLoad:nil];
}


- (void)testDidStartLoad
{
    // create delegate instance
    STWWebViewDelegate *delegate = [[STWWebViewDelegate alloc] init];

    // invoke target method
    [delegate webViewDidStartLoad:nil];
}


- (void)testDidFailLoadWithError
{
    // create delegate instance
    STWWebViewDelegate *delegate = [[STWWebViewDelegate alloc] init];

    // invoke target method
    [delegate webView:nil didFailLoadWithError:nil];
}


@end

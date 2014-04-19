#import "STWTestCase.h"

@interface STWServiceCallbackOperationTests : STWTestCase

@end

@implementation STWServiceCallbackOperationTests


- (void)testInitialization
{
    UIWebView *webView = mock([UIWebView class]);

    STWServiceCallbackOperation *operation = [[STWServiceCallbackOperation alloc] initWithMessage:@"abc" withWebView:webView];

    XCTAssertNotNil(operation, @"an instance can construct");
    XCTAssertEqualObjects(@"abc", operation.message, @"message property is set");
    XCTAssertEqualObjects(webView, operation.webView, @"webView property is set");

}


- (void)testMain
{
    UIWebView *webView = mock([UIWebView class]);

    STWServiceCallbackOperation *operation = [[STWServiceCallbackOperation alloc] initWithMessage:@"abc" withWebView:webView];

    [operation main];

    [verifyCount(webView, times(1)) stringByEvaluatingJavaScriptFromString:@"abc"];
}


- (void)testMainWithWebViewNil
{
    STWLogger *logger = mock([STWLogger class]);

    [STWLogger setSharedLogger:logger];

    STWServiceCallbackOperation *operation = [[STWServiceCallbackOperation alloc] initWithMessage:@"abc" withWebView:nil];

    [operation main];

    [verifyCount(logger, times(1)) info:@"The target UIWebView has been already released. Cannot perform callback operation: message='abc'"];
}


@end

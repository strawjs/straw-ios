#import "STWServiceCallbackOperation.h"

@implementation STWServiceCallbackOperation


- (instancetype)initWithMessage:(NSString *)message withWebView:(UIWebView *)webView
{
    self = [super init];

    if (self) {

        // initialize properties
        self.message = message;
        self.webView = webView;

    }

    return self;
}


- (void)main
{

    // the webView could be released at this point
    if (!self.webView) {
        STWLogInfo(@"The target UIWebView has been already released. Cannot perform callback operation: message='%@'", self.message);
    }


    // send back the message to the webView
    [self.webView stringByEvaluatingJavaScriptFromString:self.message];

}


@end

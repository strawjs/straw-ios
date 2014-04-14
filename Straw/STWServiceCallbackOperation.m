#import "STWServiceCallbackOperation.h"

@implementation STWServiceCallbackOperation


- (id)initWithMessage:(NSString *)message withWebView:(UIWebView *)webView
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

    // the webView could be released in the main thread.
    if (self.webView) {
        STWLogWarn(@"webView is already released. Cannot perform callback operation: message='%@'", self.message);
    }


    // send back the message to the webView
    [self.webView stringByEvaluatingJavaScriptFromString:self.message];

}


@end

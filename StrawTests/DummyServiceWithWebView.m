#import "DummyServiceWithWebView.h"

@implementation DummyServiceWithWebView


@synthesize webView;


- (BOOL)isBackgroundJob:(NSString *)method
{
    return YES;
}


- (NSString *)name
{
    return @"dummyWithWebView";
}


@end

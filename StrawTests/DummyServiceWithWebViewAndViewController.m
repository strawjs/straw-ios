#import "DummyServiceWithWebViewAndViewController.h"

@implementation DummyServiceWithWebViewAndViewController


@synthesize webView;
@synthesize viewController;


- (BOOL)isBackgroundJob:(NSString *)method
{
    return YES;
}


- (NSString *)name
{
    return @"dummyWithWebViewAndViewController";
}


@end

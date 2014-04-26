#import "DummyServiceWithViewController.h"

@implementation DummyServiceWithViewController


@synthesize viewController;


- (BOOL)isBackgroundJob:(NSString *)method
{
    return YES;
}


- (NSString *)name
{
    return @"dummyWithViewController";
}


@end

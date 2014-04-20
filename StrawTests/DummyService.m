#import "DummyService.h"

@implementation DummyService


- (BOOL)isBackgroundJob:(NSString *)method
{
    return YES;
}


- (NSString *)name
{
    return @"dummy";
}


@end

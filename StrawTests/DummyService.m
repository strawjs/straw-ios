#import "DummyService.h"

@implementation DummyService


- (BOOL)isBackgroundJob:(NSString *)method
{
    if ([method isEqualToString:@"dummyMethodMainThread"]) {
        return NO;
    }

    return YES;
}


- (NSString *)name
{
    return @"dummy";
}


- (void)dummyMethod:(NSDictionary *)params withContext:(id<STWServiceCallContext>)context
{
    self.params = params;

    return;
}


- (void)dummyMethodMainThread:(NSDictionary *)params withContext:(id<STWServiceCallContext>)context
{
    self.params = params;

    return;
}


@end

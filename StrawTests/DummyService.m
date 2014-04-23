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


- (void)dummyMethod:(NSDictionary *)params withContext:(id<STWServiceCallContext>)context
{
    self.params = params;

    return;
}


@end

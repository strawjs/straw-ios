#import "STWServiceCall.h"

@implementation STWServiceCall


- (NSString *)selectorName
{

    // Service Method must have the form of
    // `- (void)methodName:(NSDcitionary *)params withContext:(id<STWServiceCallContext>)`
    return [NSString stringWithFormat:@"%@:withContext:", self.method];

}

- (SEL)selector
{

    // create the selector for Service Method
    return NSSelectorFromString([self selectorName]);

}

@end

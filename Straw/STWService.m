#import "STWService.h"

@implementation STWService

- (void)exec:(id <STWServiceCallContext>)context
{
    STWServiceCall *call = context.serviceCall;

    // Service Method must have the form of
    // `- (void)methodName:(NSDcitionary *)params withCall:(id <STWServiceCallContext>)`
    NSString *methodName = [NSString stringWithFormat:@"%@:withContext:", call.method];

    // create the selector for Service Method
    SEL selector = NSSelectorFromString(methodName);

    if ([self respondsToSelector:selector]) {

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

        // perform Service Method
        [self performSelector:selector withObject:call.params withObject:context];

#pragma clang diagnostic pop

    } else {
        // TODO: log error
    }
}

@end

#import "STWService.h"

@implementation STWService

- (void)exec:(STWCall *)call
{
    // Service Method must have the form of
    // `- (void)methodName:(NSDcitionary *)params withCall:(STWCall *)`
    NSString *methodName = [NSString stringWithFormat:@"%@:withCall:", call.method];

    // create the selector for Service Method
    SEL selector = NSSelectorFromString(methodName);

    if ([self respondsToSelector:selector]) {

        // perform Service Method
        [self performSelector:selector withObject:call.params withObject:call];

    } else {
        // TODO: log error
    }
}

@end

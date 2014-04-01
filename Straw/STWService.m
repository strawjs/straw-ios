#import "STWService.h"

@implementation STWService

- (void)exec:(STWCall *)call
{
    NSString *methodName = [NSString stringWithFormat:@"%@:withCall:", call.method];

    SEL selector = NSSelectorFromString(methodName);

    if ([self respondsToSelector:selector]) {
        [self performSelector:selector withObject:call.params withObject:call];
    } else {
        // TODO: log error
    }
}

@end

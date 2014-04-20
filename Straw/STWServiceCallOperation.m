#import "STWServiceCallOperation.h"

@implementation STWServiceCallOperation

- (id)initWithCall:(STWServiceCall *)call withService:(id<STWService>)service withBridge:(STWNativeBridge *)bridge
{
    self = [super init];

    if (self) {

        // initialize properties
        self.serviceCall = call;
        self.service = service;
        self.bridge = bridge;

    }

    return self;
}

- (void)main
{

    // create the selector for Service Method
    SEL selector = [self.serviceCall selector];


    // If the Service Method is not found, then log error and do nothing.
    if (![self.service respondsToSelector:selector]) {
        STWLogError(@"Selector for the service not found: service='%@' selector='%@'", self.serviceCall.service, [self.serviceCall selectorName]);

        return;
    }


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

    // perform Service Method
    [self.service performSelector:selector withObject:self.serviceCall.params withObject:self];

#pragma clang diagnostic pop


}

- (void)sendBackToBrowser:(NSDictionary *)object
{
    NSDictionary *data = @{
        @"callId": self.serviceCall.callId,
        @"params": object,
        @"keepAlive": @NO,
    };

    [self.bridge sendData:data];
}

- (void)succeed
{
    [self sendBackToBrowser:@{}];
}

- (void)succeedWithString:(NSString *)string
{
    [self sendBackToBrowser:@{@"value": string}];
}

- (void)succeedWithNumber:(NSNumber *)number
{
    [self sendBackToBrowser:@{@"": number}];
}

- (void)succeedWithObject:(NSDictionary *)object
{
    [self sendBackToBrowser:object];
}

- (void)failWithCode:(NSNumber *)code withMessage:(NSString *)message
{
    [self sendBackToBrowser:@{@"code": code, @"message": message}];
}

@end

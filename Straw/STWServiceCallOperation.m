#import "STWServiceCallOperation.h"

@implementation STWServiceCallOperation

- (instancetype)initWithCall:(STWServiceCall *)call withService:(id<STWService>)service withBridge:(STWNativeBridge *)bridge
{
    self = [super init];

    if (self) {

        // initialize properties
        self.serviceCall = call;
        self.service = service;
        self.bridge = bridge;

        // keepAlive is false by default
        self.keepAlive = NO;

    }

    return self;
}

- (void)main
{

    // create the selector for Service Method
    SEL selector = [self.serviceCall selector];


    if (![self.service respondsToSelector:selector]) {

        // If the Service Method is not found, then do nothing and log at error level.

        // The possible reasons of this situation are:
        // - the service method name is wrong (the problem of js wrapper of the service)
        // - the service version is not matching to js wrapper

        // This situation should never happen in the production release.

        STWLogError(@"Selector for the service not found: service='%@' selector='%@'", self.serviceCall.service, [self.serviceCall selectorName]);

        return;

    }

    STWLogInfo(@"Straw Service Method call: service='%@' method='%@' selector='%@'", self.serviceCall.service, self.serviceCall.method, [self.serviceCall selectorName]);


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

    // perform Service Method
    [self.service performSelector:selector withObject:self.serviceCall.params withObject:self];

#pragma clang diagnostic pop


}

- (void)sendBackToBrowser:(NSDictionary *)object withSuccess:(BOOL)isSuccess
{
    [self.bridge sendData:object withCallId:self.serviceCall.callId withSuccess:isSuccess withKeepAlive:self.keepAlive];
}

- (void)succeed
{
    [self sendBackToBrowser:@{} withSuccess:YES];
}

- (void)succeedWithString:(NSString *)string
{
    [self sendBackToBrowser:@{@"value": string} withSuccess:YES];
}

- (void)succeedWithNumber:(NSNumber *)number
{
    [self sendBackToBrowser:@{@"value": number} withSuccess:YES];
}

- (void)succeedWithObject:(NSDictionary *)object
{
    [self sendBackToBrowser:object withSuccess:YES];
}

- (void)failWithCode:(NSNumber *)code withMessage:(NSString *)message
{
    [self sendBackToBrowser:@{@"code": code, @"message": message} withSuccess:NO];
}

@end

#import "STWCallOperation.h"

@implementation STWCallOperation

- (id)initWithCall:(STWServiceCall *)call withServiceRepository:(STWServiceRepository *)repository
{
    self = [super init];

    if (self) {
        // initialize call and service repository
        self.serviceCall = call;
        self.repository = repository;
    }

    return self;
}

- (void)main
{
    STWService *service = [self.repository getService:self.serviceCall.service];

    if (service) {
        [service exec:self];
    } else {
        // TODO: log error
    }
}

- (void)sendBackToBrowser:(NSDictionary *)object
{
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
}

@end

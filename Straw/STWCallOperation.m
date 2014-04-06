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

- (void)succeed
{
}

- (void)succeedWithString:(NSString *)string
{
}

- (void)succeedWithNumber:(NSNumber *)number
{
}

- (void)succeedWithObject:(NSDictionary *)object
{
}

- (void)failWithCode:(NSNumber *)code withMessage:(NSString *)message
{
}

@end

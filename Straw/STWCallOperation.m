#import "STWCallOperation.h"

@implementation STWCallOperation

- (id)initWithCall:(STWCall *)call withServiceRepository:(STWServiceRepository *)repository
{
    self = [super init];

    if (self) {
        self.call = call;
        self.repository = repository;
    }

    return self;
}

- (void)main
{
    STWService *service = [self.repository getService:self.call.service];

    if (service) {
        [service exec:self.call];
    } else {
        // TODO: log error
    }
}

@end

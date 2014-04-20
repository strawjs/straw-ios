#import "STWServiceRepository.h"

@implementation STWServiceRepository

- (id)init
{
    self = [super init];

    if (self) {
        self.services = [[NSMutableDictionary alloc] init];
    }

    return self;
}


- (void)registerService:(id<STWService>)service
{
    self.services[[service name]] = service;
}


- (id<STWService>)getService:(NSString *)serviceName
{
    return self.services[serviceName];
}

@end

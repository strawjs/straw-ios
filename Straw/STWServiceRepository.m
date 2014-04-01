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

- (void)registerService:(STWService *)service forKey:(NSString *)serviceName
{
    self.services[serviceName] = service;
}

- (STWService *)getService:(NSString *)serviceName
{
    return self.services[serviceName];
}

@end

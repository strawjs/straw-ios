#import <Foundation/Foundation.h>
#import "STWService.h"

@interface STWServiceRepository : NSObject

@property (nonatomic, retain) NSMutableDictionary *services;

- (void)registerService:(STWService *)service forKey:(NSString *)serviceName;
- (STWService *)getService:(NSString *)serviceName;

@end

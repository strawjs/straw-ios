#import <Foundation/Foundation.h>
#import "STWService.h"

@interface STWServiceRepository : NSObject

@property (nonatomic, retain) NSMutableDictionary *services;

- (void)registerService:(id <STWService>)service forKey:(NSString *)serviceName;
- (id <STWService>)getService:(NSString *)serviceName;

@end

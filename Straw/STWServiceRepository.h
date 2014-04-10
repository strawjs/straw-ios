#import <Foundation/Foundation.h>
#import "STWService.h"

@interface STWServiceRepository : NSObject

@property (nonatomic, retain) NSMutableDictionary *services;

- (void)registerService:(id <STWService>)service;
- (id <STWService>)getService:(NSString *)serviceName;

@end

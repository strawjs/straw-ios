#import <Foundation/Foundation.h>
#import "STWService.h"


/**
 STWServiceRepository is the repository class of STWService.
 */
@interface STWServiceRepository : NSObject

@property (nonatomic, retain) NSMutableDictionary *services;


/**
 Register a service to the repository.

 @param service the service to register
 */
- (void)registerService:(id <STWService>)service;


/**
 Get the service by its name.

 @param serviceName the service name
 @return the service of the specified name or nil if not exists
 */
- (id <STWService>)getService:(NSString *)serviceName;

@end

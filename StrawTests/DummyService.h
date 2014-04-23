#import <Foundation/Foundation.h>
#import "STWService.h"
#import "STWServiceCallContext.h"

@interface DummyService : NSObject <STWService>

@property (nonatomic, retain) NSDictionary *params;

- (void)dummyMethod:(NSDictionary *)params withContext:(id<STWServiceCallContext>)context;

@end

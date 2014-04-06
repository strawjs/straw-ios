#import <Foundation/Foundation.h>
#import "STWServiceCall.h"
#import "STWServiceCallContext.h"

@interface STWService : NSObject

- (void)exec:(id <STWServiceCallContext>)context;

@end

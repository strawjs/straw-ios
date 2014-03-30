#import <Foundation/Foundation.h>


/**
 STWCall is the domain model which represents each Straw Call from Browser to Native.
 */
@interface STWCall : NSObject

/// service name to call
@property (nonatomic, retain) NSString *service;

/// service method name to call
@property (nonatomic, retain) NSString *method;

/// service method paramter to call
@property (nonatomic, retain) NSDictionary *params;

/// id of the service method call
@property (nonatomic, retain) NSNumber *callId;

@end

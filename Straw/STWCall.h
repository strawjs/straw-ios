#import <Foundation/Foundation.h>


/**
 STWCall is the domain model which represents each Straw Call from Browser to Native.
 */
@interface STWCall : NSObject

@property (nonatomic, retain) NSString *service;
@property (nonatomic, retain) NSString *method;
@property (nonatomic, retain) NSDictionary *params;
@property (nonatomic, retain) NSNumber *callbackId;

@end

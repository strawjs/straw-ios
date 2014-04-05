#import <Foundation/Foundation.h>


/**
 STWServiceCall is the domain model class which represents the Straw Service Call from Browser.
 */
@interface STWServiceCall : NSObject

/** Service name to call */
@property (nonatomic, retain) NSString *service;

/** Service Method name to call */
@property (nonatomic, retain) NSString *method;

/** Service Method paramter to call */
@property (nonatomic, retain) NSDictionary *params;

/** id of the Service Method call */
@property (nonatomic, retain) NSNumber *callId;

@end

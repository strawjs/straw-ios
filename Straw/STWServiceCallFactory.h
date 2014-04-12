#import <Foundation/Foundation.h>
#import "STWServiceCall.h"

/**
 STWServiceCallFactory is the factory class of STWServiceCall.
 */
@interface STWServiceCallFactory : NSObject

/**
 Creates STWServiceCall object from Straw Call Request Object from Browser.
 
 Call Request Object should have following fields

 - service (string)
 - method (string)
 - params (object(dictionary))
 - callId (number)

 @param object Call Request Object from Browser.
 */
+ (STWServiceCall *)createFromCallRequestObject:(NSDictionary *)object;

/**
 Creates STWCall object from Straw Call Request JSON from Browser.

 Call Request JSON should have following fields

 - service (string)
 - method (string)
 - params (object(dictionary))
 - callId (number)

 @param json Call Request JSON from Browser.
 */
+ (STWServiceCall *)createFromCallRequestJSON:(NSData *)json;

@end

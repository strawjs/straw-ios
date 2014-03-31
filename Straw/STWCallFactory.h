#import <Foundation/Foundation.h>
#import "STWCall.h"

/**
 STWCallFactory is the factory class of STWCall.
 */
@interface STWCallFactory : NSObject

/**
 Creates STWCall object from Straw Call Request Object from Browser.
 
 Call Request Object should have following fields

 - service (string)
 - method (string)
 - params (object(dictionary))
 - callId (number)

 @param object Call Request Object from Browser.
 */
+ (STWCall *)createFromCallRequestObject:(NSDictionary *)object;

/**
 Creates STWCall object from Straw Call Request JSON from Browser.

 Call Request JSON should have following fields

 - service (string)
 - method (string)
 - params (object(dictionary))
 - callId (number)

 @param object Call Request JSON from Browser.
 */
+ (STWCall *)createFromCallRequestJSON:(NSString *)json;

@end

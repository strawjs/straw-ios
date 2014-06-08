#import <Foundation/Foundation.h>
#import "STWServiceCall.h"

/**
 STWServiceCallContext is protocol represents Service Method Call context.

 Each Service Method implementations succeed or fail the Service Method Call using protocol's methods.
 */
@protocol STWServiceCallContext <NSObject>

@property (nonatomic, retain) STWServiceCall *serviceCall;

/**
 Succeeds the Service Method call (without any information).
 */
- (void)succeed;

/**
 Succeeds the Service Method call with a string.

 @param string success result string
 */
- (void)succeedWithString:(NSString *)string;

/**
 Succeeds the Service Method call with a number.

 @param number success result number
 */
- (void)succeedWithNumber:(NSNumber *)number;

/**
 Succeeds the Service Method call with a (NSDictionary *)object

 @param object success result object
 */
- (void)succeedWithObject:(NSDictionary *)object;

/**
 Fails the Service Method call with an error code and a message.

 @param code error code
 @param message error message
 */
- (void)failWithCode:(NSInteger)code withMessage:(NSString *)message;

@end

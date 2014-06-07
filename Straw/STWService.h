#import <Foundation/Foundation.h>


/**
 STWService is the protocol which is conformed by Straw Service classes.
 */
@protocol STWService <NSObject>


/**
 Returns the name of the Straw Service.
 */
- (NSString *)name;


/**
 Allocate instance

 @return instance of the class
 */
+ (instancetype)alloc;


/**
 Check if the given selector is a background job or not.

 @param method the method to check
 @return true if the given selector is a main thread job.
 */
- (BOOL)isBackgroundJob:(NSString *)method;

@end

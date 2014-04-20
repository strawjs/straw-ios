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
 Allocate class.

 @return instance of the class
 */
+ (id)alloc;


/**
 Check if the given selector is a main thread job or not.

 @param selector the selector to check
 @return true if the given selector is a main thread job.
 */
- (BOOL)isBackgroundJob:(NSString *)method;

@end

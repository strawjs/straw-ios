#import <Foundation/Foundation.h>


/**
 STWService is the protocol which is conformed by Straw Service classes.
 */
@protocol STWService <NSObject>


/**
 Returns the name of the Straw Service.
 */
- (NSString *)getName;


/**
 Allocate class.

 @return instance of the class
 */
+ (id)alloc;

@end

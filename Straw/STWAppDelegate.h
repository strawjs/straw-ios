#import <UIKit/UIKit.h>
#import "STWViewController.h"

/**
 STWAppDelegate automatically sets STWViewController as rootViewController and load Straw services which are defined in -strawService method.
 */
@interface STWAppDelegate : UIResponder <UIApplicationDelegate>

/**
 UIWindow object
 */
@property (strong, nonatomic) UIWindow *window;

/**
 Returns/Defines Straw services you want to use in this app delegate.

 @return The array of Straw service classes you want to use in the app delegate.
 */
- (NSArray *)strawServices;

@end

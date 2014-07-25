#import <UIKit/UIKit.h>
#import "STWViewController.h"

@interface STWAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 Returns/Defines Straw services you want to use in this app delegate.

 @return The array of Straw service classes you want to use in the app delegate.
 */
- (NSArray *)strawServices;

@end

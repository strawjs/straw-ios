#import <UIKit/UIKit.h>
#import "STWService.h"
#import "STWWebViewDelegate.h"

@interface STWViewController : UIViewController

/**
 Load a Straw service.

 @param service Straw service class
 */
- (void)loadService:(Class<STWService>)serviceClass;

@end

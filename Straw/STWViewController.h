#import <UIKit/UIKit.h>
#import "STWService.h"
#import "STWWebViewDelegate.h"

/**
 STWViewController automatically loads a UIWebView and assign a STWWebViewDelegate into it and starts loading www/index.html in the UIWebView.
 */
@interface STWViewController : UIViewController

/**
 Load a Straw service.

 @param serviceClass Straw service class to load
 */
- (void)loadService:(Class<STWService>)serviceClass;

@end

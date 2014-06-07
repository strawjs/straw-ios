#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "STWNativeBridge.h"


/**
 STWWebViewDelegate is the delegate class for a webView which you want to use the Straw Framework with.
 */
@interface STWWebViewDelegate : NSObject <UIWebViewDelegate>


/**
 The NativeBridge object.
 */
@property (nonatomic, retain) STWNativeBridge *bridge;


/**
 Init with webView.

 @param webView the webView
 @return the instance of the class
 */
- (instancetype)initWithWebView:(UIWebView *)webView;


/**
 Init with webView and viewController.

 viewController is necessary if you want use the services which depends on the viewController property.

 @param webView the webView
 @param viewController the viewController
 @return the instance of the class
 */
- (instancetype)initWithWebView:(UIWebView *)webView withViewController:(UIViewController *)viewController;


/**
 Load the service instance from the class object.

 The resulted service instance will be stored in the NativeBridge object.

 @param serviceClass the service class to load
 */
- (void)loadService:(Class<STWService>)serviceClass;

@end

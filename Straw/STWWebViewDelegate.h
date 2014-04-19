#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "STWServiceCall.h"
#import "STWServiceCallFactory.h"
#import "STWServiceRepository.h"
#import "STWServiceCallOperation.h"
#import "STWNativeBridge.h"
#import "STWLogger.h"
#import "STWServiceWithViewController.h"
#import "STWServiceWithWebView.h"

/**
 STWWebViewDelegate is the delegate class for a webView which you want to use the Straw Framework with.
 */
@interface STWWebViewDelegate : NSObject <UIWebViewDelegate>


/**
 The repository of Straw Services which are active on the webView.
 */
@property (nonatomic, retain) STWServiceRepository *repository;


/**
 The operation queue to manage Straw Service Method call executions.
 */
@property (nonatomic, retain) NSOperationQueue *operationQueue;


/**
 The webView to be delegated
 */
@property (nonatomic, assign) UIWebView *webView;


/**
 The viewController in which the webView placed.
 */
@property (nonatomic, assign) UIViewController *viewController;


/**
 The NativeBridge object.
 */
@property (nonatomic, retain) STWNativeBridge *bridge;


/**
 Init with webView and viewController.

 @param webView the webView
 @param viewController the viewController
 @return the instance of the class
 */
- (id)initWithWebView:(UIWebView *)webView withViewController:(UIViewController *)viewController;


/**
 Load the service instance from the class object.

 The resulted service instance will be stored in the repository property.

 @param klass class to load
 */
- (void)loadService:(Class<STWService>)serviceClass;

@end

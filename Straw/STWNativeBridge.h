#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "STWService.h"
#import "STWServiceWithWebView.h"
#import "STWServiceWithViewController.h"
#import "STWServiceCall.h"
#import "STWServiceCallFactory.h"
#import "STWServiceCallOperation.h"
#import "STWServiceCallbackOperation.h"
#import "STWServiceRepository.h"

/**
 STWNativeBridge is the collection of methods which interacts with the webView with Framework's specific manner.
 */
@interface STWNativeBridge : NSObject


/**
 The main thread queue.
 */
@property (nonatomic, retain) NSOperationQueue *mainQueue;


/**
 The background thread queue.
 */
@property (nonatomic, retain) NSOperationQueue *operationQueue;


/**
 The repository of Straw Services which are active on the webView.
 */
@property (nonatomic, retain) STWServiceRepository *repository;


/**
 The webView to bridge
 */
@property (nonatomic, assign) UIWebView *webView;


/**
 The viewController in which the webView placed.
 */
@property (nonatomic, assign) UIViewController *viewController;


/**
 Initialize with webView and the viewController.

 @param webView the webView
 @param viewController the viewController
 @return the instance of the class
 */
- (id)initWithWebView:(UIWebView *)webView withViewController:(UIViewController *)viewController;


/**
 Creates Service Call object from url and webView.
 
 @param url url to create from
 @return generated Service Call object
 */
- (STWServiceCall *)createServiceCallFromUrl:(NSURL *)url;


/**
 Check if the requested URL is straw custom scheme or not.
 
 @param request url request to check
 @return if the url is of straw custom scheme or not
 */
- (BOOL)isStrawURLRequest:(NSURLRequest *)request;


/**
 Load the service instance from the class object.

 The resulted service instance will be stored in the repository.

 @param serviceClass the service class to load
 */
- (void)loadService:(Class<STWService>)serviceClass;


/**
 Execute the Straw URL request.

 @param request the request to execute
 */
- (void)executeRequest:(NSURLRequest *)request;


/**
 Send the data back to Browser
 
 @param data data to send
 @param webView the webView to send to
 */
- (void)sendData:(NSDictionary *)data;

@end

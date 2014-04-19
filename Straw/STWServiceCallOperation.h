#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "STWServiceCall.h"
#import "STWService.h"
#import "STWServiceRepository.h"
#import "STWServiceCallContext.h"
#import "STWNativeBridge.h"
#import "STWLogger.h"

/**
 STWServiceCallOperation class performs Straw Service Method Call procedure.

 The operation is performed in main thread or in background according to Service Method configuration.
 */
@interface STWServiceCallOperation : NSOperation <STWServiceCallContext>


/** Service Call which the instance performs with */
@property (nonatomic, retain) STWServiceCall *serviceCall;


/** Service which the instance performs with */
@property (nonatomic, assign) id<STWService> service;


/** the webView which the instance performs with */
@property (nonatomic, assign) UIWebView *webView;


/** the NativeBridge object */
@property (nonatomic, assign) STWNativeBridge *bridge;


- (id)initWithCall:(STWServiceCall *)call withService:(id<STWService>)service withWebView:(UIWebView *)webView withBridge:(STWNativeBridge *)bridge;

@end

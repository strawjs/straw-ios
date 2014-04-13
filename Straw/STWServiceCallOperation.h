#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "STWServiceCall.h"
#import "STWService.h"
#import "STWServiceRepository.h"
#import "STWServiceCallContext.h"
#import "STWNativeBridge.h"

/**
 STWServiceCallOperation class performs Straw Service Method Call procedure.

 The operation is performed in main thread or in background according to Service Method configuration.
 */
@interface STWServiceCallOperation : NSOperation <STWServiceCallContext>

/** Service Call which the class performs with */
@property (nonatomic, retain) STWServiceCall *serviceCall;

/** Service Respository */
@property (nonatomic, assign) STWServiceRepository *repository;

/** the webView which the class performs with */
@property (nonatomic, assign) UIWebView *webView;

- (id)initWithCall:(STWServiceCall *)call withServiceRepository:(STWServiceRepository *)repository withWebView:(UIWebView *)webView;

@end

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "STWServiceCall.h"
#import "STWService.h"
#import "STWServiceRepository.h"

/**
 STWCallOperation class performs Straw Service Method Call procedure.

 The operation is performed in main thread or in background according to Service Method configuration.
 */
@interface STWCallOperation : NSOperation <STWServiceCallContext>

@property (nonatomic, retain) STWServiceCall *serviceCall;
@property (nonatomic, assign) STWServiceRepository *repository;
@property (nonatomic, assign) UIWebView *webView;

- (id)initWithCall:(STWServiceCall *)call withServiceRepository:(STWServiceRepository *)repository withWebView:(UIWebView *)webView;

@end

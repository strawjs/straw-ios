#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "STWServiceCall.h"
#import "STWServiceCallFactory.h"
#import "STWServiceRepository.h"
#import "STWCallOperation.h"
#import "STWNativeBridge.h"

/**
 STWWebViewDelegate is the delegate class for a webView which you want to use the Straw Framework with.
 */
@interface STWWebViewDelegate : NSObject <UIWebViewDelegate>

/**
 The repository of Straw Services which are active on the webView.
 */
@property (nonatomic, retain) STWServiceRepository *repository;

@end

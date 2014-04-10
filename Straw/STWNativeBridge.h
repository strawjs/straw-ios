#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "STWServiceCall.h"
#import "STWServiceCallFactory.h"

@interface STWNativeBridge : NSObject

/**
 Creates Service Call object from url and webView.
 
 @param url url to create from
 @param webView webView to create with
 @return generated Service Call object
 */
+ (STWServiceCall *)createServiceCallFromUrl:(NSURL *)url withWebView:(UIWebView *)webView;

/**
 Check if the URL is straw custom scheme or not.
 
 @param url url to check
 @return if url is of straw custom scheme or not
 */
+ (BOOL)isStrawURL:(NSURL *)url;

@end

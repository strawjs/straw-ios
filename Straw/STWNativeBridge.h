#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "STWServiceCall.h"
#import "STWServiceCallFactory.h"

/**
 STWNativeBridge is the collection of methods which interacts with the webView with Framework's specific manner.
 */
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

/**
 Send Data back to Browser
 
 @param data data to send
 @param webView the webView to send to
 */
+ (void)sendData:(NSDictionary *)data toWebView:(UIWebView *)webView;

@end

#import <Foundation/Foundation.h>
#import "STWNativeBridge.h"
#import "STWLogger.h"

/**
 STWServiceCallbackOperation class performs callback operation from Native to Browser
 */
@interface STWServiceCallbackOperation : NSOperation


/** the message to send to the webView */
@property (nonatomic, retain) NSString *message;


/** the webView to send message to */
@property (nonatomic, assign) UIWebView *webView;


/**
 Initialize with the message and the webView

 @param message the message to send
 @param webView the webView to send message to
 @return the instance of the class
 */
- (instancetype)initWithMessage:(NSString *)message withWebView:(UIWebView *)webView;


@end

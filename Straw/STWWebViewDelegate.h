#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 STWWebViewDelegate is the delegate class for a webView which you want to use the Straw Framework with.
 */
@interface STWWebViewDelegate : NSObject <UIWebViewDelegate>

/**

 Called when webView failed to load.

 @param webView the WebView
 @param error the error

 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;

/**

 The hook when webView start loading.

 @param webView the webView
 @param request request to handle
 @param navigationType type of navigation
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;

/**
 Called when webView finished loading.

 @param webView the webView
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView;

/**
 Called when webView started loading.

 @param webView the webView
 */
- (void)webViewDidStartLoad:(UIWebView *)webView;

@end

#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>
#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#import "Straw.h"
#import "DummyService.h"
#import "DummyServiceWithWebView.h"
#import "DummyServiceWithViewController.h"
#import "DummyServiceWithWebViewAndViewController.h"

@interface STWTestCase : XCTestCase

/**
 * The mock logger, used for verifying the Logging of the framework.
 */
@property (nonatomic, retain) STWLogger *logger;

@end

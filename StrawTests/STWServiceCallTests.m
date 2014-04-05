#import <XCTest/XCTest.h>
#import "STWServiceCall.h"

@interface STWServiceCallTests : XCTestCase

@end

@implementation STWServiceCallTests

- (void)testExample
{
    XCTAssertNotNil([[STWServiceCall alloc] init], @"STWServiceCall can construct");
}

@end

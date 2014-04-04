#import <XCTest/XCTest.h>
#import "STWCall.h"

@interface STWCallTests : XCTestCase

@end

@implementation STWCallTests

- (void)testExample
{
    XCTAssertNotNil([[STWCall alloc] init], @"STWCall can construct");
}

@end

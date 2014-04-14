#import <XCTest/XCTest.h>
#import "STWServiceCall.h"

@interface STWServiceCallTests : XCTestCase

@end

@implementation STWServiceCallTests

- (void)testConstructor
{
    XCTAssertNotNil([[STWServiceCall alloc] init], @"STWServiceCall can construct");
}


- (void)testSelector
{
    STWServiceCall *call = [[STWServiceCall alloc] init];

    call.method = @"abc";

    XCTAssertEqualObjects(@"abc:withContext:", NSStringFromSelector([call selector]));
}


- (void)testSelectorName
{
    STWServiceCall *call = [[STWServiceCall alloc] init];

    call.method = @"abc";

    XCTAssertEqualObjects(@"abc:withContext:", [call selectorName]);
}


@end

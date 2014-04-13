#import "STWTestCase.h"

@interface STWServiceCallFactoryTests : STWTestCase

@end


@implementation STWServiceCallFactoryTests


- (void)testCreateFromCallRequestObject
{
    NSDictionary *params = @{@"a": @123, @"b": @"456"};

    STWServiceCall *serviceCall = [STWServiceCallFactory createFromCallRequestObject:@{
        @"service": @"abc",
        @"method": @"def",
        @"params": params,
        @"callId": @"jkl"
    }];

    XCTAssertEqualObjects(@"abc", serviceCall.service);
    XCTAssertEqualObjects(@"def", serviceCall.method);
    XCTAssertEqualObjects(params, serviceCall.params);
    XCTAssertEqualObjects(@"jkl", serviceCall.callId);

}


- (void)testCreateFromCallRequestJSON
{
    NSString *json = @"{\"service\":\"abc\",\"method\":\"def\",\"params\":{\"a\":123,\"b\":\"456\"},\"callId\":\"jkl\"}";

    STWServiceCall *serviceCall = [STWServiceCallFactory createFromCallRequestJSON:[json dataUsingEncoding:NSUTF8StringEncoding]];

    NSDictionary *params = @{@"a": @123, @"b": @"456"};

    XCTAssertEqualObjects(@"abc", serviceCall.service);
    XCTAssertEqualObjects(@"def", serviceCall.method);
    XCTAssertEqualObjects(params, serviceCall.params);
    XCTAssertEqualObjects(@"jkl", serviceCall.callId);

}


@end

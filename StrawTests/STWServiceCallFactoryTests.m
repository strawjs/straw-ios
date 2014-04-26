#import "STWTestCase.h"

@interface STWServiceCallFactoryTests : STWTestCase

@end

@implementation STWServiceCallFactoryTests


- (void)testCreateFromCallRequestObject
{

    STWServiceCall *serviceCall = [STWServiceCallFactory createFromCallRequestObject:@{
        @"service": @"abc",
        @"method": @"def",
        @"params": @{@"a": @123, @"b": @"456"},
        @"callId": @"jkl"
    }];

    XCTAssertEqualObjects(@"abc", serviceCall.service);
    XCTAssertEqualObjects(@"def", serviceCall.method);
    XCTAssertEqualObjects((@{@"a": @123, @"b": @"456"}), serviceCall.params);
    XCTAssertEqualObjects(@"jkl", serviceCall.callId);

}


- (void)testCreateFromCallRequestObjectWithoutService
{

    STWServiceCall *serviceCall = [STWServiceCallFactory createFromCallRequestObject:@{
        @"method": @"def",
        @"params": @{@"a": @123, @"b": @"456"},
        @"callId": @"jkl"
    }];

    XCTAssertNil(serviceCall, @"Service call is nil because `service` parameter is absent.");

}

- (void)testCreateFromCallRequestObjectWithoutMethod
{

    STWServiceCall *serviceCall = [STWServiceCallFactory createFromCallRequestObject:@{
        @"service": @"abc",
        @"params": @{@"a": @123, @"b": @"456"},
        @"callId": @"jkl"
    }];

    XCTAssertNil(serviceCall, @"Service call is nil because `method` parameter is absent.");

}

- (void)testCreateFromCallRequestObjectWithoutCallId
{

    STWServiceCall *serviceCall = [STWServiceCallFactory createFromCallRequestObject:@{
        @"service": @"abc",
        @"method": @"def",
        @"params": @{@"a": @123, @"b": @"456"}
    }];

    XCTAssertNil(serviceCall, @"Service call is nil because `callId` parameter is absent.");

}


- (void)testCreateFromCallRequestObjectWithoutParams
{

    STWServiceCall *serviceCall = [STWServiceCallFactory createFromCallRequestObject:@{
        @"service": @"abc",
        @"method": @"def",
        @"callId": @"jkl"
    }];

    XCTAssertEqualObjects((@{}), serviceCall.params, @"The default value of params is empty dict when `callId` parameter is absent.");

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

#import "STWTestCase.h"

@interface STWServiceCallOperationTests : STWTestCase

@end

@implementation STWServiceCallOperationTests


- (void)testInitialization
{
    // create mocks
    STWServiceCall *call = mock([STWServiceCall class]);
    id<STWService> service = mockProtocol(@protocol(STWService));
    STWNativeBridge *bridge = mock([STWNativeBridge class]);

    // initialize with mocks
    STWServiceCallOperation *operation = [[STWServiceCallOperation alloc] initWithCall:call withService:service withBridge:bridge];

    XCTAssertNotNil(operation, @"STWServiceCallOperation can construct.");
    XCTAssertEqualObjects(call, operation.serviceCall, @"serviceCall property is set properly.");
    XCTAssertEqualObjects(service, operation.service, @"service property is set properly.");
    XCTAssertEqualObjects(bridge, operation.bridge, @"bridge property is set properly.");
    XCTAssertEqual(NO, operation.keepAlive, @"keepAlive propery is set to NO");

}


- (void)testMain
{
    STWServiceCall *call = [STWServiceCallFactory createFromCallRequestObject:@{@"method": @"dummyMethod", @"params": @{@"abc": @123}}];

    DummyService *service = [[DummyService alloc] init];

    STWServiceCallOperation *operation = [[STWServiceCallOperation alloc] initWithCall:call withService:service withBridge:nil];

    [operation main];

    XCTAssertEqualObjects(@{@"abc": @123}, service.params);
}


- (void)testMainWithError
{
    STWServiceCall *call = [STWServiceCallFactory createFromCallRequestObject:@{@"service": @"dummy", @"method": @"nonexistentMethod", @"params": @{@"abc": @123}}];

    DummyService *service = [[DummyService alloc] init];

    STWServiceCallOperation *operation = [[STWServiceCallOperation alloc] initWithCall:call withService:service withBridge:nil];

    STWLogger *logger = mock([STWLogger class]);

    [STWLogger setSharedLogger:logger];

    [operation main];

    [verifyCount(logger, times(1)) error:@"Selector for the service not found: service='dummy' selector='nonexistentMethod:withContext:'"];
}


// STWServiceCallContext methods tests

- (void)testSucceed
{
    // mock bridge
    STWNativeBridge *bridge = mock([STWNativeBridge class]);

    STWServiceCall *call = [STWServiceCallFactory createFromCallRequestObject:@{
        @"service": @"dummyService",
        @"method": @"dummyMethod",
        @"callId": @"id_abc",
        @"params": @{},
    }];

    // init
    STWServiceCallOperation *operation = [[STWServiceCallOperation alloc] initWithCall:call withService:nil withBridge:bridge];

    [operation succeed];

    [verifyCount(bridge, times(1)) sendData:@{
        @"callId": @"id_abc",
        @"keepAlive": @NO,
        @"params": @{},
        @"isSuccess": @YES,
    }];
}


- (void)testSucceedWithNumber
{
    // mock bridge
    STWNativeBridge *bridge = mock([STWNativeBridge class]);

    STWServiceCall *call = [STWServiceCallFactory createFromCallRequestObject:@{
        @"service": @"dummyService",
        @"method": @"dummyMethod",
        @"callId": @"id_abc",
        @"params": @{},
    }];

    // init
    STWServiceCallOperation *operation = [[STWServiceCallOperation alloc] initWithCall:call withService:nil withBridge:bridge];

    [operation succeedWithNumber:@123];

    [verifyCount(bridge, times(1)) sendData:@{
        @"callId": @"id_abc",
        @"keepAlive": @NO,
        @"params": @{@"value": @123},
        @"isSuccess": @YES,
    }];
}


- (void)testSucceedWithString
{
    // mock bridge
    STWNativeBridge *bridge = mock([STWNativeBridge class]);

    STWServiceCall *call = [STWServiceCallFactory createFromCallRequestObject:@{
        @"service": @"dummyService",
        @"method": @"dummyMethod",
        @"callId": @"id_abc",
        @"params": @{},
    }];

    // init
    STWServiceCallOperation *operation = [[STWServiceCallOperation alloc] initWithCall:call withService:nil withBridge:bridge];

    [operation succeedWithString:@"abc"];

    [verifyCount(bridge, times(1)) sendData:@{
        @"callId": @"id_abc",
        @"keepAlive": @NO,
        @"params": @{@"value": @"abc"},
        @"isSuccess": @YES,
    }];
}


- (void)testSucceedWithObject
{
    // mock bridge
    STWNativeBridge *bridge = mock([STWNativeBridge class]);

    STWServiceCall *call = [STWServiceCallFactory createFromCallRequestObject:@{
        @"service": @"dummyService",
        @"method": @"dummyMethod",
        @"callId": @"id_abc",
        @"params": @{},
    }];

    // init
    STWServiceCallOperation *operation = [[STWServiceCallOperation alloc] initWithCall:call withService:nil withBridge:bridge];

    [operation succeedWithObject:@{@"abc": @123, @"def": @"ghi"}];

    [verifyCount(bridge, times(1)) sendData:@{
        @"callId": @"id_abc",
        @"keepAlive": @NO,
        @"params": @{@"abc": @123, @"def": @"ghi"},
        @"isSuccess": @YES,
    }];
}


- (void)testFailWithCodeWithMessage
{
    // mock bridge
    STWNativeBridge *bridge = mock([STWNativeBridge class]);

    STWServiceCall *call = [STWServiceCallFactory createFromCallRequestObject:@{
        @"service": @"dummyService",
        @"method": @"dummyMethod",
        @"callId": @"id_abc",
        @"params": @{},
    }];

    // init
    STWServiceCallOperation *operation = [[STWServiceCallOperation alloc] initWithCall:call withService:nil withBridge:bridge];

    [operation failWithCode:@123 withMessage:@"failed"];

    [verifyCount(bridge, times(1)) sendData:@{
        @"callId": @"id_abc",
        @"keepAlive": @NO,
        @"params": @{@"code": @123, @"message": @"failed"},
        @"isSuccess": @NO,
    }];

}


@end

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


@end

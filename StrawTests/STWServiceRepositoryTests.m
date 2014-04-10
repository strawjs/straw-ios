#import <XCTest/XCTest.h>
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>
#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>
#import "STWServiceRepository.h"

@interface STWServiceRepositoryTests : XCTestCase

@end

@implementation STWServiceRepositoryTests

- (void)testInit
{
    STWServiceRepository *repository = [[STWServiceRepository alloc] init];

    XCTAssertNotNil(repository);

    XCTAssertEqualObjects([[NSMutableDictionary alloc] init], repository.services);
}

- (void)testGetService
{
    STWServiceRepository *repository = [[STWServiceRepository alloc] init];

    // create service mock
    id <STWService> service = mockProtocol(@protocol(STWService));

    // stub -getName:
    [given([service getName]) willReturn:@"abc"];

    // register to repository
    [repository registerService:service];


    XCTAssertEqualObjects(service, [repository getService:@"abc"]);

    XCTAssertNil([repository getService:@"def"]);
}

@end

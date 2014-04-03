#import <XCTest/XCTest.h>
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

    STWService *service = [[STWService alloc] init];

    [repository registerService:service forKey:@"abc"];

    XCTAssertEqualObjects(service, [repository getService:@"abc"]);

    XCTAssertNil([repository getService:@"def"]);
}

@end

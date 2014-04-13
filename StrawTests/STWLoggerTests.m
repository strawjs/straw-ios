#import "STWTestCase.h"

@interface STWLoggerTests : XCTestCase

@end

@implementation STWLoggerTests


- (void)setUp
{
    [STWLogger resetInstance];
}


- (void)testGetInstance
{
    XCTAssertNotNil([STWLogger getInstance], @"getInstance returns not nil");
}


- (void)testSTWLog
{
    STWLogger *logger = mock([STWLogger class]);

    [STWLogger setInstance:logger];

    STWLogVerbose(@"abc");
    STWLogDebug(@"def");
    STWLogInfo(@"ghi");
    STWLogWarn(@"jkl");
    STWLogError(@"mno");
    STWLogFatal(@"pqr");

    [verifyCount(logger, times(1)) verbose:@"abc"];
    [verifyCount(logger, times(1)) debug:@"def"];
    [verifyCount(logger, times(1)) info:@"ghi"];
    [verifyCount(logger, times(1)) warn:@"jkl"];
    [verifyCount(logger, times(1)) error:@"mno"];
    [verifyCount(logger, times(1)) fatal:@"pqr"];

}


- (void)testSTWLogVarg
{
    STWLogger *logger = mock([STWLogger class]);

    [STWLogger setInstance:logger];

    STWLogVerbose(@"%@,,", @"abc");
    STWLogDebug(@"%@,,", @"def");
    STWLogInfo(@"%@,,", @"ghi");
    STWLogWarn(@"%@,,", @"jkl");
    STWLogError(@"%@,,", @"mno");
    STWLogFatal(@"%@,,", @"pqr");

    [verifyCount(logger, times(1)) verbose:@"abc,,"];
    [verifyCount(logger, times(1)) debug:@"def,,"];
    [verifyCount(logger, times(1)) info:@"ghi,,"];
    [verifyCount(logger, times(1)) warn:@"jkl,,"];
    [verifyCount(logger, times(1)) error:@"mno,,"];
    [verifyCount(logger, times(1)) fatal:@"pqr,,"];

}


- (void)testSetLevel
{
    XCTAssertEqual(kSTWLoggerLevelWarn, [STWLogger getInstance].level, @"Default log level is warn.");

    [STWLogger setLevelVerbose];

    XCTAssertEqual(kSTWLoggerLevelVerbose, [STWLogger getInstance].level, @"Log level set to verbose.");

    [STWLogger setLevelDebug];

    XCTAssertEqual(kSTWLoggerLevelDebug, [STWLogger getInstance].level, @"Log level set to debug.");

    [STWLogger setLevelInfo];

    XCTAssertEqual(kSTWLoggerLevelInfo, [STWLogger getInstance].level, @"Log level set to info.");

    [STWLogger setLevelWarn];

    XCTAssertEqual(kSTWLoggerLevelWarn, [STWLogger getInstance].level, @"Log level set to warn.");

    [STWLogger setLevelError];

    XCTAssertEqual(kSTWLoggerLevelError, [STWLogger getInstance].level, @"Log level set to error.");

    [STWLogger setLevelFatal];

    XCTAssertEqual(kSTWLoggerLevelFatal, [STWLogger getInstance].level, @"Log level set to fatal.");

}

@end

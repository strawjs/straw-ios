#import "STWTestCase.h"

@interface STWLoggerTests : XCTestCase

@end

@implementation STWLoggerTests

- (void)testSTWLogs
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

- (void)testSTWLogVargs
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

@end

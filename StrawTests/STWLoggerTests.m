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


- (void)testVerboseLevel
{
    id<STWLoggerDelegate> delegate = mockProtocol(@protocol(STWLoggerDelegate));

    [STWLogger getInstance].delegate = delegate;

    [STWLogger setLevelVerbose];

    [[STWLogger getInstance] verbose:@"verbose"];
    [[STWLogger getInstance] debug:@"debug"];
    [[STWLogger getInstance] info:@"info"];
    [[STWLogger getInstance] warn:@"warn"];
    [[STWLogger getInstance] error:@"error"];
    [[STWLogger getInstance] fatal:@"fatal"];

    [verifyCount(delegate, times(1)) log:@"verbose"];
    [verifyCount(delegate, times(1)) log:@"debug"];
    [verifyCount(delegate, times(1)) log:@"info"];
    [verifyCount(delegate, times(1)) log:@"warn"];
    [verifyCount(delegate, times(1)) log:@"error"];
    [verifyCount(delegate, times(1)) log:@"fatal"];

}


- (void)testDebugLevel
{
    id<STWLoggerDelegate> delegate = mockProtocol(@protocol(STWLoggerDelegate));

    [STWLogger getInstance].delegate = delegate;

    [STWLogger setLevelDebug];

    [[STWLogger getInstance] verbose:@"verbose"];
    [[STWLogger getInstance] debug:@"debug"];
    [[STWLogger getInstance] info:@"info"];
    [[STWLogger getInstance] warn:@"warn"];
    [[STWLogger getInstance] error:@"error"];
    [[STWLogger getInstance] fatal:@"fatal"];

    [verifyCount(delegate, never()) log:@"verbose"];
    [verifyCount(delegate, times(1)) log:@"debug"];
    [verifyCount(delegate, times(1)) log:@"info"];
    [verifyCount(delegate, times(1)) log:@"warn"];
    [verifyCount(delegate, times(1)) log:@"error"];
    [verifyCount(delegate, times(1)) log:@"fatal"];

}


- (void)testInfoLevel
{
    id<STWLoggerDelegate> delegate = mockProtocol(@protocol(STWLoggerDelegate));

    [STWLogger getInstance].delegate = delegate;

    [STWLogger setLevelInfo];

    [[STWLogger getInstance] verbose:@"verbose"];
    [[STWLogger getInstance] debug:@"debug"];
    [[STWLogger getInstance] info:@"info"];
    [[STWLogger getInstance] warn:@"warn"];
    [[STWLogger getInstance] error:@"error"];
    [[STWLogger getInstance] fatal:@"fatal"];

    [verifyCount(delegate, never()) log:@"verbose"];
    [verifyCount(delegate, never()) log:@"debug"];
    [verifyCount(delegate, times(1)) log:@"info"];
    [verifyCount(delegate, times(1)) log:@"warn"];
    [verifyCount(delegate, times(1)) log:@"error"];
    [verifyCount(delegate, times(1)) log:@"fatal"];

}


- (void)testWarnLevel
{
    id<STWLoggerDelegate> delegate = mockProtocol(@protocol(STWLoggerDelegate));

    [STWLogger getInstance].delegate = delegate;

    [STWLogger setLevelWarn];

    [[STWLogger getInstance] verbose:@"verbose"];
    [[STWLogger getInstance] debug:@"debug"];
    [[STWLogger getInstance] info:@"info"];
    [[STWLogger getInstance] warn:@"warn"];
    [[STWLogger getInstance] error:@"error"];
    [[STWLogger getInstance] fatal:@"fatal"];

    [verifyCount(delegate, never()) log:@"verbose"];
    [verifyCount(delegate, never()) log:@"debug"];
    [verifyCount(delegate, never()) log:@"info"];
    [verifyCount(delegate, times(1)) log:@"warn"];
    [verifyCount(delegate, times(1)) log:@"error"];
    [verifyCount(delegate, times(1)) log:@"fatal"];

}


- (void)testErrorLevel
{
    id<STWLoggerDelegate> delegate = mockProtocol(@protocol(STWLoggerDelegate));

    [STWLogger getInstance].delegate = delegate;

    [STWLogger setLevelError];

    [[STWLogger getInstance] verbose:@"verbose"];
    [[STWLogger getInstance] debug:@"debug"];
    [[STWLogger getInstance] info:@"info"];
    [[STWLogger getInstance] warn:@"warn"];
    [[STWLogger getInstance] error:@"error"];
    [[STWLogger getInstance] fatal:@"fatal"];

    [verifyCount(delegate, never()) log:@"verbose"];
    [verifyCount(delegate, never()) log:@"debug"];
    [verifyCount(delegate, never()) log:@"info"];
    [verifyCount(delegate, never()) log:@"warn"];
    [verifyCount(delegate, times(1)) log:@"error"];
    [verifyCount(delegate, times(1)) log:@"fatal"];

}


- (void)testFatalLevel
{
    id<STWLoggerDelegate> delegate = mockProtocol(@protocol(STWLoggerDelegate));

    [STWLogger getInstance].delegate = delegate;

    [STWLogger setLevelFatal];

    [[STWLogger getInstance] verbose:@"verbose"];
    [[STWLogger getInstance] debug:@"debug"];
    [[STWLogger getInstance] info:@"info"];
    [[STWLogger getInstance] warn:@"warn"];
    [[STWLogger getInstance] error:@"error"];
    [[STWLogger getInstance] fatal:@"fatal"];

    [verifyCount(delegate, never()) log:@"verbose"];
    [verifyCount(delegate, never()) log:@"debug"];
    [verifyCount(delegate, never()) log:@"info"];
    [verifyCount(delegate, never()) log:@"warn"];
    [verifyCount(delegate, never()) log:@"error"];
    [verifyCount(delegate, times(1)) log:@"fatal"];

}


- (void)testDefaultLog
{
    [[STWLogger getInstance].delegate log:@"test"];
}


@end

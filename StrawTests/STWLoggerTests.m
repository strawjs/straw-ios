#import "STWTestCase.h"

@interface STWLoggerTests : STWTestCase

@end

@implementation STWLoggerTests


- (void)setUp
{
    [STWLogger resetSharedLogger];
}


- (void)testGetInstance
{
    XCTAssertNotNil([STWLogger sharedLogger], @"getInstance returns not nil");
}


- (void)testSTWLog
{
    STWLogger *logger = mock([STWLogger class]);

    [STWLogger setSharedLogger:logger];

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

    [STWLogger setSharedLogger:logger];

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
    XCTAssertEqual(kSTWLoggerLevelWarn, [STWLogger sharedLogger].level, @"Default log level is warn.");

    [STWLogger setLevelVerbose];

    XCTAssertEqual(kSTWLoggerLevelVerbose, [STWLogger sharedLogger].level, @"Log level set to verbose.");

    [STWLogger setLevelDebug];

    XCTAssertEqual(kSTWLoggerLevelDebug, [STWLogger sharedLogger].level, @"Log level set to debug.");

    [STWLogger setLevelInfo];

    XCTAssertEqual(kSTWLoggerLevelInfo, [STWLogger sharedLogger].level, @"Log level set to info.");

    [STWLogger setLevelWarn];

    XCTAssertEqual(kSTWLoggerLevelWarn, [STWLogger sharedLogger].level, @"Log level set to warn.");

    [STWLogger setLevelError];

    XCTAssertEqual(kSTWLoggerLevelError, [STWLogger sharedLogger].level, @"Log level set to error.");

    [STWLogger setLevelFatal];

    XCTAssertEqual(kSTWLoggerLevelFatal, [STWLogger sharedLogger].level, @"Log level set to fatal.");

}


- (void)testVerboseLevel
{
    id<STWLoggerDelegate> delegate = mockProtocol(@protocol(STWLoggerDelegate));

    [STWLogger sharedLogger].delegate = delegate;

    [STWLogger setLevelVerbose];

    [[STWLogger sharedLogger] verbose:@"verbose"];
    [[STWLogger sharedLogger] debug:@"debug"];
    [[STWLogger sharedLogger] info:@"info"];
    [[STWLogger sharedLogger] warn:@"warn"];
    [[STWLogger sharedLogger] error:@"error"];
    [[STWLogger sharedLogger] fatal:@"fatal"];

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

    [STWLogger sharedLogger].delegate = delegate;

    [STWLogger setLevelDebug];

    [[STWLogger sharedLogger] verbose:@"verbose"];
    [[STWLogger sharedLogger] debug:@"debug"];
    [[STWLogger sharedLogger] info:@"info"];
    [[STWLogger sharedLogger] warn:@"warn"];
    [[STWLogger sharedLogger] error:@"error"];
    [[STWLogger sharedLogger] fatal:@"fatal"];

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

    [STWLogger sharedLogger].delegate = delegate;

    [STWLogger setLevelInfo];

    [[STWLogger sharedLogger] verbose:@"verbose"];
    [[STWLogger sharedLogger] debug:@"debug"];
    [[STWLogger sharedLogger] info:@"info"];
    [[STWLogger sharedLogger] warn:@"warn"];
    [[STWLogger sharedLogger] error:@"error"];
    [[STWLogger sharedLogger] fatal:@"fatal"];

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

    [STWLogger sharedLogger].delegate = delegate;

    [STWLogger setLevelWarn];

    [[STWLogger sharedLogger] verbose:@"verbose"];
    [[STWLogger sharedLogger] debug:@"debug"];
    [[STWLogger sharedLogger] info:@"info"];
    [[STWLogger sharedLogger] warn:@"warn"];
    [[STWLogger sharedLogger] error:@"error"];
    [[STWLogger sharedLogger] fatal:@"fatal"];

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

    [STWLogger sharedLogger].delegate = delegate;

    [STWLogger setLevelError];

    [[STWLogger sharedLogger] verbose:@"verbose"];
    [[STWLogger sharedLogger] debug:@"debug"];
    [[STWLogger sharedLogger] info:@"info"];
    [[STWLogger sharedLogger] warn:@"warn"];
    [[STWLogger sharedLogger] error:@"error"];
    [[STWLogger sharedLogger] fatal:@"fatal"];

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

    [STWLogger sharedLogger].delegate = delegate;

    [STWLogger setLevelFatal];

    [[STWLogger sharedLogger] verbose:@"verbose"];
    [[STWLogger sharedLogger] debug:@"debug"];
    [[STWLogger sharedLogger] info:@"info"];
    [[STWLogger sharedLogger] warn:@"warn"];
    [[STWLogger sharedLogger] error:@"error"];
    [[STWLogger sharedLogger] fatal:@"fatal"];

    [verifyCount(delegate, never()) log:@"verbose"];
    [verifyCount(delegate, never()) log:@"debug"];
    [verifyCount(delegate, never()) log:@"info"];
    [verifyCount(delegate, never()) log:@"warn"];
    [verifyCount(delegate, never()) log:@"error"];
    [verifyCount(delegate, times(1)) log:@"fatal"];

}


- (void)testNoneLevel
{
    id<STWLoggerDelegate> delegate = mockProtocol(@protocol(STWLoggerDelegate));

    [STWLogger sharedLogger].delegate = delegate;

    [STWLogger setLevelNone];

    [[STWLogger sharedLogger] verbose:@"verbose"];
    [[STWLogger sharedLogger] debug:@"debug"];
    [[STWLogger sharedLogger] info:@"info"];
    [[STWLogger sharedLogger] warn:@"warn"];
    [[STWLogger sharedLogger] error:@"error"];
    [[STWLogger sharedLogger] fatal:@"fatal"];

    [verifyCount(delegate, never()) log:@"verbose"];
    [verifyCount(delegate, never()) log:@"debug"];
    [verifyCount(delegate, never()) log:@"info"];
    [verifyCount(delegate, never()) log:@"warn"];
    [verifyCount(delegate, never()) log:@"error"];
    [verifyCount(delegate, never()) log:@"fatal"];

}


- (void)testDefaultLog
{
    [[STWLogger sharedLogger].delegate log:@"test"];
}


@end

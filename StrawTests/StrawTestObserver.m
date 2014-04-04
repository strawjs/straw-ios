#import <XCTest/XCTest.h>

// the workaround for generating coverage data in xcode5.0 + iphonesimulator7.0.
// this workaround will be unnecessary in xcode5.1.

@interface StrawTestObserver : XCTestObserver

@end

@implementation StrawTestObserver

+ (void)load
{
    [[NSUserDefaults standardUserDefaults] setValue:@"StrawTestObserver,XCTestLog" forKey:@"XCTestObserverClass"];

    [super initialize];
}

- (void)stopObserving
{
    [super stopObserving];

    extern void __gcov_flush(void);
    __gcov_flush();

}

@end

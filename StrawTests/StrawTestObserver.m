#import <XCTest/XCTest.h>

// workaround for generating coverage data in iphonesimulator7.0
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

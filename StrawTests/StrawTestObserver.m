#import <XCTest/XCTest.h>

@interface StrawTestObserver : XCTestObserver

@end

@implementation StrawTestObserver


- (void)stopObserving
{
    [super stopObserving];

    extern void __gcov_flush(void);
    __gcov_flush();

}

@end

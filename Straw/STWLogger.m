#import "STWLogger.h"


#define kSTWLoggerLevelVerbose @1
#define kSTWLoggerLevelDebug @2
#define kSTWLoggerLevelInfo @3
#define kSTWLoggerLevelWarn @4
#define kSTWLoggerLevelError @5
#define kSTWLoggerLevelFatal @6

#define kSTWLoggerLevelDefault kSTWLoggerLevelWarn


static STWLogger *instance = nil;


@implementation STWLogger

+ (STWLogger *)getInstance
{
    if (!instance) {
        instance = [[self alloc] init];

        instance.level = kSTWLoggerLevelDefault;
    }

    return instance;
}


+ (void)setInstance:(STWLogger *)logger
{
    instance = logger;
}


- (void)log:(NSString *)message withLevel:(NSNumber *)level
{
    if (level >= self.level) {
        NSLog(@"%@", message);
    }
}


- (void)verbose:(NSString *)message
{
    [self log:message withLevel:kSTWLoggerLevelVerbose];
}


- (void)debug:(NSString *)message
{
    [self log:message withLevel:kSTWLoggerLevelDebug];
}


- (void)info:(NSString *)message
{
    [self log:message withLevel:kSTWLoggerLevelInfo];
}


- (void)warn:(NSString *)message
{
    [self log:message withLevel:kSTWLoggerLevelWarn];
}


- (void)error:(NSString *)message
{
    [self log:message withLevel:kSTWLoggerLevelError];
}


- (void)fatal:(NSString *)message
{
    [self log:message withLevel:kSTWLoggerLevelFatal];
}


- (void)setLevelVerbose
{
    self.level = kSTWLoggerLevelVerbose;
}


- (void)setLevelDebug
{
    self.level = kSTWLoggerLevelDebug;
}

- (void)setLevelInfo
{
    self.level = kSTWLoggerLevelInfo;
}


- (void)setLevelWarn
{
    self.level = kSTWLoggerLevelWarn;
}


- (void)setLevelError
{
    self.level = kSTWLoggerLevelError;
}

- (void)setLevelFatal
{
    self.level = kSTWLoggerLevelFatal;
}


@end

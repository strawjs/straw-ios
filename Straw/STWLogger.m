#import "STWLogger.h"


static STWLogger *instance = nil;


@implementation STWLogger

+ (STWLogger *)getInstance
{
    if (!instance) {
        instance = [[self alloc] init];

        instance.level = kSTWLoggerLevelDefault;
        instance.delegate = instance;

    }

    return instance;
}


+ (void)setInstance:(STWLogger *)logger
{
    instance = logger;
}


+ (void)resetInstance
{
    instance = nil;
}


- (void)log:(NSString *)message
{
    NSLog(@"%@", message);
}


- (void)log:(NSString *)message withLevel:(int)level
{
    if (level >= self.level) {
        [self.delegate log:message];
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


+ (void)setLevelVerbose
{
    [self getInstance].level = kSTWLoggerLevelVerbose;
}


+ (void)setLevelDebug
{
    [self getInstance].level = kSTWLoggerLevelDebug;
}

+ (void)setLevelInfo
{
    [self getInstance].level = kSTWLoggerLevelInfo;
}


+ (void)setLevelWarn
{
    [self getInstance].level = kSTWLoggerLevelWarn;
}


+ (void)setLevelError
{
    [self getInstance].level = kSTWLoggerLevelError;
}

+ (void)setLevelFatal
{
    [self getInstance].level = kSTWLoggerLevelFatal;
}


@end

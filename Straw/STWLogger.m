#import "STWLogger.h"


static STWLogger *instance = nil;


@implementation STWLogger

+ (STWLogger *)sharedLogger
{
    if (!instance) {
        instance = [[self alloc] init];

        instance.level = kSTWLoggerLevelDefault;
        instance.delegate = instance;

    }

    return instance;
}


+ (void)setSharedLogger:(STWLogger *)logger
{
    instance = logger;
}


+ (void)resetSharedLogger
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
    [self sharedLogger].level = kSTWLoggerLevelVerbose;
}


+ (void)setLevelDebug
{
    [self sharedLogger].level = kSTWLoggerLevelDebug;
}

+ (void)setLevelInfo
{
    [self sharedLogger].level = kSTWLoggerLevelInfo;
}


+ (void)setLevelWarn
{
    [self sharedLogger].level = kSTWLoggerLevelWarn;
}


+ (void)setLevelError
{
    [self sharedLogger].level = kSTWLoggerLevelError;
}


+ (void)setLevelFatal
{
    [self sharedLogger].level = kSTWLoggerLevelFatal;
}


+ (void)setLevelNone
{
    [self sharedLogger].level = kSTWLoggerLevelNone;
}


@end

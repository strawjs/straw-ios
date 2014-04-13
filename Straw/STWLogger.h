#import <Foundation/Foundation.h>


#define kSTWLoggerLevelVerbose 1
#define kSTWLoggerLevelDebug 2
#define kSTWLoggerLevelInfo 3
#define kSTWLoggerLevelWarn 4
#define kSTWLoggerLevelError 5
#define kSTWLoggerLevelFatal 6
#define kSTWLoggerLevelNone 7

#define kSTWLoggerLevelDefault kSTWLoggerLevelWarn


#ifdef DEBUG

    #define STWLogVerbose(msg, ...) [[STWLogger getInstance] verbose:[NSString stringWithFormat:msg, ##__VA_ARGS__]]
    #define STWLogDebug(msg, ...) [[STWLogger getInstance] debug:[NSString stringWithFormat:msg, ##__VA_ARGS__]]
    #define STWLogInfo(msg, ...) [[STWLogger getInstance] info:[NSString stringWithFormat:msg, ##__VA_ARGS__]]
    #define STWLogWarn(msg, ...) [[STWLogger getInstance] warn:[NSString stringWithFormat:msg, ##__VA_ARGS__]]
    #define STWLogError(msg, ...) [[STWLogger getInstance] error:[NSString stringWithFormat:msg, ##__VA_ARGS__]]
    #define STWLogFatal(msg, ...) [[STWLogger getInstance] fatal:[NSString stringWithFormat:msg, ##__VA_ARGS__]]

#else

    #define STWLogVerbose(msg, ...) do {} while(0)
    #define STWLogDebug(msg, ...) do {} while(0)
    #define STWLogInfo(msg, ...) do {} while(0)
    #define STWLogWarn(msg, ...) do {} while(0)
    #define STWLogError(msg, ...) do {} while(0)
    #define STWLogFatal(msg, ...) do {} while(0)

#endif


/**
 STWLoggerDelegate is the low level logging interface.

 This protocol exists for testability increasement.
 */
@protocol STWLoggerDelegate <NSObject>

/**
 Just log a message.

 @param message the message to log
 */
- (void)log:(NSString *)message;

@end


/**
 STWLogger is logger classs for Straw Framework.
 */
@interface STWLogger : NSObject <STWLoggerDelegate>

@property (nonatomic, retain) id <STWLoggerDelegate> delegate;
@property (nonatomic, assign) int level;

/**
 Get the instance of the class.

 @return the instance of the class
 */
+ (STWLogger *)getInstance;


/**
 Reset the instance of the class.
 */
+ (void)resetInstance;


/**
 Set the instance of the class.

 This method is for tests.

 @param logger the instance of the class
 */
+ (void)setInstance:(STWLogger *)logger;


/**
 Log at verbose level.

 @param message log message
 */
- (void)verbose:(NSString *)message;


/**
 Log at debug level.

 @param message log message
 */
- (void)debug:(NSString *)message;


/**
 Log at info level.

 @param message log message
 */
- (void)info:(NSString *)message;


/**
 Log at warn level.

 @param message log message
 */
- (void)warn:(NSString *)message;


/**
 Log at error level.

 @param message log message
 */
- (void)error:(NSString *)message;


/**
 Log at fatal level.

 @param message log message
 */
- (void)fatal:(NSString *)message;


/**
 Set log level verbose.
 */
+ (void)setLevelVerbose;


/**
 Set log level Debug.
 */
+ (void)setLevelDebug;


/**
 Set log level Info.
 */
+ (void)setLevelInfo;


/**
 Set log level Warn.
 */
+ (void)setLevelWarn;


/**
 Set log level Error.
 */
+ (void)setLevelError;


/**
 Set log level Fatal.
 */
+ (void)setLevelFatal;


/**
 Set log level None.
 */
+ (void)setLevelNone;


@end

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

    #define STWLogVerbose(msg, ...) [[STWLogger sharedLogger] verbose:[NSString stringWithFormat:msg, ##__VA_ARGS__]]
    #define STWLogDebug(msg, ...) [[STWLogger sharedLogger] debug:[NSString stringWithFormat:msg, ##__VA_ARGS__]]
    #define STWLogInfo(msg, ...) [[STWLogger sharedLogger] info:[NSString stringWithFormat:msg, ##__VA_ARGS__]]
    #define STWLogWarn(msg, ...) [[STWLogger sharedLogger] warn:[NSString stringWithFormat:msg, ##__VA_ARGS__]]
    #define STWLogError(msg, ...) [[STWLogger sharedLogger] error:[NSString stringWithFormat:msg, ##__VA_ARGS__]]
    #define STWLogFatal(msg, ...) [[STWLogger sharedLogger] fatal:[NSString stringWithFormat:msg, ##__VA_ARGS__]]

#else

    #define STWLogVerbose(msg, ...)
    #define STWLogDebug(msg, ...)
    #define STWLogInfo(msg, ...)
    #define STWLogWarn(msg, ...)
    #define STWLogError(msg, ...)
    #define STWLogFatal(msg, ...)

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
 Get the shared instance of the class.

 @return the instance of the class
 */
+ (STWLogger *)sharedLogger;


/**
 Reset the shared instance of the class.
 */
+ (void)resetSharedLogger;


/**
 Set the shared instance of the class.

 This method is for test.

 @param logger the instance of the class
 */
+ (void)setSharedLogger:(STWLogger *)logger;


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

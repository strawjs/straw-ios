#import <Foundation/Foundation.h>

@interface STWLogger : NSObject

@property (nonatomic, retain) NSNumber *level;

/**
 Get the instance of the class.

 @return the instance of the class
 */
+ (STWLogger *)getInstance;


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
- (void)setLevelVerbose;


/**
 Set log level Debug.
 */
- (void)setLevelDebug;


/**
 Set log level Info.
 */
- (void)setLevelInfo;


/**
 Set log level Warn.
 */
- (void)setLevelWarn;


/**
 Set log level Error.
 */
- (void)setLevelError;


/**
 Set log level Fatal.
 */
- (void)setLevelFatal;


@end

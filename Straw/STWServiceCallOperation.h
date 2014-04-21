#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "STWServiceCall.h"
#import "STWService.h"
#import "STWServiceRepository.h"
#import "STWServiceCallContext.h"
#import "STWNativeBridge.h"
#import "STWLogger.h"


@class STWNativeBridge;

/**
 STWServiceCallOperation class performs Straw Service Method Call procedure.

 The operation is performed in main thread or in background according to Service Method configuration.
 */
@interface STWServiceCallOperation : NSOperation <STWServiceCallContext>


/** Service Call which the instance performs with */
@property (nonatomic, retain) STWServiceCall *serviceCall;


/** Service which the instance performs with */
@property (nonatomic, assign) id<STWService> service;


/** the NativeBridge object */
@property (nonatomic, assign) STWNativeBridge *bridge;


/**
 The flag to keep alive the browser's callback function.

 The default value is NO.
 */
@property (nonatomic, assign) BOOL keepAlive;


/**
 Initialize object with service call object, service object and bridge object
 */
- (id)initWithCall:(STWServiceCall *)call withService:(id<STWService>)service withBridge:(STWNativeBridge *)bridge;

@end

#import <Foundation/Foundation.h>
#import "STWCall.h"
#import "STWService.h"
#import "STWServiceRepository.h"

/**
 STWCallOperation class performs Straw Service Method Call procedure.

 The operation is performed in main thread or in background according to Service Method configuration.
 */
@interface STWCallOperation : NSOperation

@property (nonatomic, retain) STWCall *call;
@property (nonatomic, assign) STWServiceRepository *repository;

@end

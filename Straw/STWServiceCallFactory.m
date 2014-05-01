#import "STWServiceCallFactory.h"

@implementation STWServiceCallFactory

+ (STWServiceCall *)createFromCallRequestObject:(NSDictionary *)object
{
    STWServiceCall *call = [[STWServiceCall alloc] init];

    NSString *service = object[@"service"];
    NSString *method = object[@"method"];
    NSDictionary *params = object[@"params"];
    NSString *callId = object[@"callId"];


    if (service == nil) {
        // if service is nil, then the Service Method call is invalid.
        STWLogError(@"`service` field of the Straw request object is empty and the request is canceled: request=(%@)", params);

        return nil;
    }

    if (method == nil) {
        // if the method is nil, then the Service Method call is invalid.
        STWLogError(@"`method` field of the Straw request object is empty and the request is canceled: request=(%@)", params);

        return nil;
    }

    if (params == nil) {
        // if the params is nil, then it default to empty dict.
        STWLogInfo(@"`params` field of the Straw reqeust object is empty and default value (empty dict) is supplied: %@", params);

        params = @{};
    }

    if (callId == nil) {
        // if the call id is nil, then the Service Method call is invalid.
        STWLogError(@"`callId` field of the Straw request object is empty and the request is canceled: request=(%@)", params);

        return nil;
    }


    call.service = service;
    call.method = method;
    call.params = params;
    call.callId = callId;

    return call;
}


+ (STWServiceCall *)createFromCallRequestJSON:(NSData *)json
{
    return [self createFromCallRequestObject:[NSJSONSerialization JSONObjectWithData:json options:0 error:nil]];
}

@end

#import "STWServiceCallFactory.h"

@implementation STWServiceCallFactory

+ (STWServiceCall *)createFromCallRequestObject:(NSDictionary *)object
{
    STWServiceCall *call = [[STWServiceCall alloc] init];

    call.service = object[@"service"];
    call.method = object[@"method"];
    call.params = object[@"params"];
    call.callId = object[@"callId"];

    return call;
}

+ (STWServiceCall *)createFromCallRequestJSON:(NSData *)json
{
    return [self createFromCallRequestObject:[NSJSONSerialization JSONObjectWithData:json options:0 error:nil]];
}

@end

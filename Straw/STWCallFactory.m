#import "STWCallFactory.h"

@implementation STWCallFactory

+ (STWCall *)createFromCallRequestObject:(NSDictionary *)object
{
    STWCall *call = [[STWCall alloc] init];

    call.service = object[@"service"];
    call.method = object[@"method"];
    call.params = object[@"params"];
    call.callId = object[@"callId"];

    return call;
}

+ (STWCall *)createFromCallRequestJSON:(NSString *)json
{
    return [self createFromCallRequestObject:[NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil]];
}

@end

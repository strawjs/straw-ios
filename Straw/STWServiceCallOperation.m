#import "STWServiceCallOperation.h"

@implementation STWServiceCallOperation

- (id)initWithCall:(STWServiceCall *)call withService:(id<STWService>)service withWebView:(UIWebView *)webView
{
    self = [super init];

    if (self) {

        // initialize properties
        self.serviceCall = call;
        self.service = service;
        self.webView = webView;

    }

    return self;
}

- (void)main
{
    if (self.service) {
        [self callService];
    } else {
        // TODO: log error
    }
}

- (void)callService
{

    // Service Method must have the form of
    // `- (void)methodName:(NSDcitionary *)params withContext:(id<STWServiceCallContext>)`
    NSString *methodName = [NSString stringWithFormat:@"%@:withContext:", self.serviceCall.method];

    // create the selector for Service Method
    SEL selector = NSSelectorFromString(methodName);


    // If the Service Method is not found, then log error and do nothing.
    if (![self.service respondsToSelector:selector]) {
        STWLogError(@"Selector for the service not found: service='%@' selector='%@'", self.serviceCall.service, methodName);

        return;
    }


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

    // perform Service Method
    [self.service performSelector:selector withObject:self.serviceCall.params withObject:self];

#pragma clang diagnostic pop


}

- (void)sendBackToBrowser:(NSDictionary *)object
{
    NSDictionary *data = @{
        @"callId": self.serviceCall.callId,
        @"params": object,
        @"keepAlive": @NO,
    };

    [STWNativeBridge sendData:data toWebView:self.webView];
}

- (void)succeed
{
    [self sendBackToBrowser:@{}];
}

- (void)succeedWithString:(NSString *)string
{
    [self sendBackToBrowser:@{@"value": string}];
}

- (void)succeedWithNumber:(NSNumber *)number
{
    [self sendBackToBrowser:@{@"": number}];
}

- (void)succeedWithObject:(NSDictionary *)object
{
    [self sendBackToBrowser:object];
}

- (void)failWithCode:(NSNumber *)code withMessage:(NSString *)message
{
    [self sendBackToBrowser:@{@"code": code, @"message": message}];
}

@end

#import "STWCallOperation.h"

@implementation STWCallOperation

- (id)initWithCall:(STWServiceCall *)call withServiceRepository:(STWServiceRepository *)repository withWebView:(UIWebView *)webView
{
    self = [super init];

    if (self) {
        // initialize properties
        self.serviceCall = call;
        self.repository = repository;
        self.webView = webView;
    }

    return self;
}

- (void)main
{
    STWService *service = [self.repository getService:self.serviceCall.service];

    if (service) {
        [service exec:self];
    } else {
        // TODO: log error
    }
}

- (void)sendBackToBrowser:(NSDictionary *)object
{
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

#import "STWTestCase.h"

@implementation STWTestCase

- (void)setUp
{
    self.logger = mock([STWLogger class]);

    [STWLogger setSharedLogger:self.logger];
}

@end

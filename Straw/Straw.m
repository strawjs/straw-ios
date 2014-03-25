#import "Straw.h"

@implementation Straw

#ifdef DEBUG
+ (void)load
{
    [[NSUserDefaults standardUserDefaults] setValue:@"StrawTestObserver" forKey:@"XCTestObserverClass"];
}
#endif

@end

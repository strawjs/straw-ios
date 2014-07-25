#import "STWAppDelegate.h"

@implementation STWAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    STWViewController *viewController = [[STWViewController alloc] init];

    for (Class<STWService> serviceClass in [self strawServices]) {
        // load a straw service
        [viewController loadService:serviceClass];
    }

    // set as the root controller
    self.window.rootViewController = viewController;

    [self.window makeKeyAndVisible];

    return YES;
}

- (NSArray *)strawServices
{
    return @[];
}

- (void)applicationWillResignActive:(UIApplication *)application {}
- (void)applicationDidEnterBackground:(UIApplication *)application {}
- (void)applicationWillEnterForeground:(UIApplication *)application {}
- (void)applicationDidBecomeActive:(UIApplication *)application {}
- (void)applicationWillTerminate:(UIApplication *)application {}

@end

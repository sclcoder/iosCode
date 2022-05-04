//
//  AppDelegate.m
//  MVVM+RAC
//
//  Created by sunchunlei on 2022/5/3.
//

#import "AppDelegate.h"
#import "RRTabbarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /// window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    RRTabbarController *tabbarVC = [[RRTabbarController alloc] init];
    self.window.rootViewController = tabbarVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}



@end

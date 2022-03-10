//
//  AppDelegate.m
//  SDPlayground
//
//  Created by chunlei.sun on 2021/5/19.
//

#import "AppDelegate.h"
#import "SDTabBarController.h"
#import <FWSideMenu/FWSideMenu-Swift.h>
#import "MenuViewController.h"
#import <DoraemonKit/DoraemonManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[DoraemonManager shareInstance] install];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    SDTabBarController *tabVc = [[SDTabBarController alloc] init];

//    FWSideMenuContainerViewController *sideVC = [FWSideMenuContainerViewController
//                                                 containerWithCenterViewController:tabVc
//                                                 centerLeftPanViewWidth:20
//                                                 centerRightPanViewWidth:0
//                                                 leftMenuViewController:[MenuViewController new]
//                                                 rightMenuViewController:nil];
//    sideVC.leftMenuWidth = UIScreen.mainScreen.bounds.size.width * 0.7;
    
    self.window.rootViewController = tabVc;
    
    [self.window makeKeyAndVisible];
    return YES;
}


@end

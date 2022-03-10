//
//  AppDelegate.m
//  CodeTest
//
//  Created by chunlei.sun on 2022/2/15.
//

#import "AppDelegate.h"
#import <DoraemonKit/DoraemonManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch
    [self configDoraemon];

    return YES;
}

- (void)configDoraemon {
    [[DoraemonManager shareInstance] install];
    
}

@end

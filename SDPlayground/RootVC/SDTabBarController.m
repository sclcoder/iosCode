//
//  SDTabBarController.m
//  SDPlayground
//
//  Created by chunlei.sun on 2021/5/19.
//

#import "SDTabBarController.h"
#import "SDNavigationController.h"

#import "SDPagerController.h"
#import "RRTestViewController.h"
#import "RRNewWebViewController.h"
#import "SDAlertViewController.h"

/// 侧滑测试
#import <FWSideMenu/FWSideMenu-Swift.h>
#import "MenuViewController.h"

/// 转场测试
#import "SDPushViewController.h"
#import "SDPresentingViewController.h"

/// transition
#import "SDTabBarVCDelegate.h"

@interface SDTabBarController ()

@property(nonatomic,strong) SDTabBarVCDelegate<UITabBarControllerDelegate> *strongReferenceDelegate;

@end

@implementation SDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.strongReferenceDelegate = [[SDTabBarVCDelegate alloc] init];
    self.delegate = self.strongReferenceDelegate;
    
    SDAlertViewController *alertVC =  [SDAlertViewController new];
    alertVC.title = @"alertVC";
    SDNavigationController *alertVCNav = [[SDNavigationController alloc] initWithRootViewController:alertVC];
    
    SDPushViewController *pushVC =  [SDPushViewController new];
    pushVC.title = @"push";
    SDNavigationController *pushNav = [[SDNavigationController alloc] initWithRootViewController:pushVC];
    
    SDPresentingViewController *modalVC =  [SDPresentingViewController new];
    modalVC.title = @"modal";
    SDNavigationController *modalNav = [[SDNavigationController alloc] initWithRootViewController:modalVC];
    
    SDPagerController *pageVC =     [SDPagerController new];
    pageVC.title = @"page";
    SDNavigationController *pageNav = [[SDNavigationController alloc] initWithRootViewController:pageVC];



    RRNewWebViewController *webVC = [RRNewWebViewController new];
    webVC.title = @"web";
    SDNavigationController *webNav = [[SDNavigationController alloc] initWithRootViewController:webVC];

    
    RRTestViewController *testVC =  [RRTestViewController new];
    testVC.title = @"test";
    SDNavigationController *testNav = [[SDNavigationController alloc] initWithRootViewController:testVC];
    FWSideMenuContainerViewController *sideVC = [FWSideMenuContainerViewController
                                                 containerWithCenterViewController:testNav
                                                 centerLeftPanViewWidth:20
                                                 centerRightPanViewWidth:0
                                                 leftMenuViewController:[MenuViewController new]
                                                 rightMenuViewController:nil];
    sideVC.leftMenuWidth = UIScreen.mainScreen.bounds.size.width * 0.7;
    sideVC.title = @"side";
    
    [self setViewControllers:@[alertVCNav,pushNav,modalNav,pageNav,sideVC,webNav]];
}

#pragma mark - 旋转 、 status bar

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.selectedViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.selectedViewController;
}

- (UIViewController *)childViewControllerForHomeIndicatorAutoHidden {
    return self.selectedViewController;
}

- (UIViewController *)childViewControllerForScreenEdgesDeferringSystemGestures {
    return self.selectedViewController;
}

- (BOOL)shouldAutorotate {
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.selectedViewController.supportedInterfaceOrientations;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.selectedViewController.preferredInterfaceOrientationForPresentation;
}

@end

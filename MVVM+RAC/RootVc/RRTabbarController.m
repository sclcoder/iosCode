//
//  RRTabbarController.m
//  ChimeSNS
//
//  Created by 孙春磊 on 2022/4/13.
//

#import "RRTabbarController.h"
#import "RRNavigationController.h"
#import "RRSearchViewController.h"
#import "RRSettingsViewController.h"
@interface RRTabbarController ()


@end

@implementation RRTabbarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupChildrenVC];
    
}

#pragma mark - private method

- (void)setupUI{
    
    UITabBarAppearance *appearance = [UITabBarAppearance new];
    appearance.backgroundColor = [UIColor systemPinkColor];
    
    appearance.stackedLayoutAppearance.normal.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14 weight:UIFontWeightLight], NSForegroundColorAttributeName:[UIColor blackColor]};

    appearance.stackedLayoutAppearance.selected.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17 weight:UIFontWeightBold], NSForegroundColorAttributeName:[UIColor blackColor]};

    self.tabBar.standardAppearance = appearance;
    if (@available(iOS 15.0, *)) {
        self.tabBar.scrollEdgeAppearance = appearance;
    }
    
    self.tabBar.translucent = YES;
}



- (void)setupChildrenVC{
    
    RRSearchViewController *searchVC = [RRSearchViewController new];
    RRNavigationController *searchNav = [[RRNavigationController alloc] initWithRootViewController:searchVC];
    searchNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"search" image:[UIImage imageNamed:@"tab_chat"] selectedImage:[UIImage imageNamed:@"tab_chat"]];
    
    RRSettingsViewController *settingVC = [RRSettingsViewController new];
    RRNavigationController *settingNav = [[RRNavigationController alloc] initWithRootViewController:settingVC];
    settingNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"network" image:[UIImage imageNamed:@"tab_group"] selectedImage:[UIImage imageNamed:@"tab_group"]];

    
    [self setViewControllers:@[searchNav,settingNav] animated:YES];
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

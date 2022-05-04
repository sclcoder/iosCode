//
//  RRNavigationController.m
//  ChimeSNS
//
//  Created by 孙春磊 on 2022/4/13.
//

#import "RRNavigationController.h"

@interface RRNavigationController ()

@end

@implementation RRNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupBar];
}

- (void)setupBar{
    
    UINavigationBarAppearance *appearance = [UINavigationBarAppearance new];
    appearance.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17 weight:UIFontWeightBold], NSForegroundColorAttributeName:[UIColor blackColor]};
    appearance.backgroundColor = [UIColor systemPinkColor];
    // 去掉导航条底部黑线
    appearance.shadowColor = [UIColor clearColor];

    self.navigationBar.standardAppearance = appearance;
    self.navigationBar.scrollEdgeAppearance = appearance;
    
    self.navigationBar.translucent = YES;
}



#pragma mark - overwrite
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count != 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 旋转 、 status bar
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}

- (UIViewController *)childViewControllerForHomeIndicatorAutoHidden {
    return self.topViewController;
}

- (UIViewController *)childViewControllerForScreenEdgesDeferringSystemGestures {
    return self.topViewController;
}

- (BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}
@end

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
#import "SDSettingViewController.h"

/// 侧滑测试
#import <FWSideMenu/FWSideMenu-Swift.h>
#import "MenuViewController.h"

/// 转场测试
#import "SDPushViewController.h"
#import "SDPresentingViewController.h"

/// transition
#import "SDTabBarVCDelegate.h"

@interface SDTabBarController ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong) SDTabBarVCDelegate<UITabBarControllerDelegate> *strongReferenceDelegate;

@end

@implementation SDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.strongReferenceDelegate = [[SDTabBarVCDelegate alloc] init];
    self.delegate = self.strongReferenceDelegate;
    
//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanGesture:)];
//    panGesture.delegate = self;
//    [self.view addGestureRecognizer:panGesture];
    
    
    [self setupChildrenVC];
}

#pragma mark - action
- (void)onPanGesture:(UIPanGestureRecognizer *)panGesture{
    
    UIView *targetView = panGesture.view;
    CGPoint location = [panGesture translationInView:targetView];
    CGFloat translationX = location.x;
    NSLog(@"位移: %f",location.x);
    CGFloat percent   = fabs(translationX / targetView.bounds.size.width);
    NSLog(@"percent: %f",percent);

    CGFloat velocityX = [panGesture velocityInView:targetView].x;
    NSLog(@"速度: %f",velocityX);

    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:{
            self.strongReferenceDelegate.interactive = YES;
            if (velocityX > 0) {
                if (self.selectedIndex > 0) {
                    self.selectedIndex -= 1;
                }
            } else {
                if (self.selectedIndex < self.viewControllers.count) {
                    self.selectedIndex += 1;
                }
            }
        }
            break;
        case UIGestureRecognizerStateChanged:{
            [self.strongReferenceDelegate.interactionController updateInteractiveTransition:percent];
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:{
            /*这里有个小问题，转场结束或是取消时有很大几率出现动画不正常的问题。在8.1以上版本的模拟器中都有发现，7.x 由于缺乏条件尚未测试，
              但在我的 iOS 9.2 的真机设备上没有发现，而且似乎只在 UITabBarController 的交互转场中发现了这个问题。在 NavigationController 暂且没发现这个问题，
              Modal 转场尚未测试，因为我在 Demo 里没给它添加交互控制功能。
              
              测试不完整，具体原因也未知，不过解决手段找到了。多谢 @llwenDeng 发现这个 Bug 并且找到了解决手段。
              解决手段是修改交互控制器的 completionSpeed 为1以下的数值，这个属性用来控制动画速度，我猜测是内部实现在边界判断上有问题。
              这里其修改为0.99，既解决了 Bug 同时尽可能贴近原来的动画设定。
            */
            if (percent > 0.3) {
                self.strongReferenceDelegate.interactionController.completionSpeed = 0.99;
                [self.strongReferenceDelegate.interactionController finishInteractiveTransition];
            } else {
                self.strongReferenceDelegate.interactionController.completionSpeed = 0.99;
                //转场取消后，UITabBarController 自动恢复了 selectedIndex 的值，不需要我们手动恢复。
                [self.strongReferenceDelegate.interactionController cancelInteractiveTransition];
            }
            self.strongReferenceDelegate.interactive = NO;
        }
            break;
        default:
            break;
    }
}

#pragma mark - private method
- (void)setupChildrenVC{
    
    SDSettingViewController *settingVC = [SDSettingViewController new];
    settingVC.title = @"settingVC";
    SDNavigationController *settingNav = [[SDNavigationController alloc] initWithRootViewController:settingVC];
    
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
    
    [self setViewControllers:@[modalNav,alertVCNav,pushNav,pageNav,sideVC]];
}


#pragma mark - UIGestureDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]];
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

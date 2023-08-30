//
//  RRTabBarController.m
//  ChimeTest
//
//  Created by chunlei.sun on 2023/8/24.
//

#import "RRTabBarController.h"
#import "RROverlayPresentationController.h"

#import "RRMoreReplaceViewController.h"

#import "RRTestViewController.h"


#import "ChimeTest-Swift.h"


#define  KMoreTabBarItemTag 10000

@interface RRTabBarController ()<UITabBarControllerDelegate,UITabBarDelegate,UIViewControllerTransitioningDelegate,RRTabBarMoreReplaceDelegate>

@property (nonatomic, strong) NSMutableArray *displayViewControllers;

@property (nonatomic, strong) NSMutableArray *exchangedViewControllers;

@property (nonatomic, strong) NSMutableArray *moreViewControllers;

@property (nonatomic, weak)   RRMoreReplaceViewController *moreReplaceViewController;

@end

@implementation RRTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    
    [self setupUI];
    [self setupChildrenVC];
}


- (void)setupUI{
    UITabBarAppearance *appearance = [UITabBarAppearance new];
    appearance.backgroundColor = [UIColor systemBackgroundColor];
    
    self.tabBar.standardAppearance = appearance;
    if (@available(iOS 15.0, *)) {
        self.tabBar.scrollEdgeAppearance = appearance;
    }
    self.tabBar.translucent = YES;
}

- (void)setupChildrenVC{
    RRTestViewController  *VC1    = [RRTestViewController new];
    VC1.tagName                     = @"VC1";
    UITabBarItem            *item1  = [self configTabBarItemWithTitle:@"VC1" imageName:@"home_normal" selectedImageName:@"home_highlight"];
    VC1.tabBarItem                  = item1;
    UINavigationController  *nav1   = [[UINavigationController alloc] initWithRootViewController:VC1];
    
    
    RRTestViewController    *VC2    = [RRTestViewController new];
    VC2.tagName                     = @"VC2";
    UITabBarItem            *item2  = [self configTabBarItemWithTitle:@"VC2" imageName:@"message_normal" selectedImageName:@"message_highlight"];
    VC2.tabBarItem                  = item2;
    UINavigationController  *nav2   = [[UINavigationController alloc] initWithRootViewController:VC2];
    
    
    RRTestViewController    *VC3    = [RRTestViewController new];
    VC3.tagName                     = @"VC3";
    
    UITabBarItem            *item3  = [self configTabBarItemWithTitle:@"VC3" imageName:@"fishpond_normal" selectedImageName:@"fishpond_highlight"];
    VC3.tabBarItem                  = item3;
    UINavigationController  *nav3   = [[UINavigationController alloc] initWithRootViewController:VC3];
    
    
    RRTestViewController    *VC4    = [RRTestViewController new];
    VC4.tagName                     = @"VC4";
    UITabBarItem            *item4  = [self configTabBarItemWithTitle:@"VC4" imageName:@"account_normal" selectedImageName:@"account_highlight"];
    VC4.tabBarItem                  = item4;
    UINavigationController  *nav4   = [[UINavigationController alloc] initWithRootViewController:VC4];
    
    
    
    RRTestViewController    *VC5    = [RRTestViewController new];
    VC5.tagName                     = @"VC5";
    UITabBarItem            *item5  = [self configTabBarItemWithTitle:@"More" imageName:@"more_normal" selectedImageName:@"more_highlight"];
    item5.tag                       =  KMoreTabBarItemTag; /// More tag
    VC5.tabBarItem                  = item5;
    UINavigationController  *nav5   = [[UINavigationController alloc] initWithRootViewController:VC5];
    
    RRTestViewController    *VC6    = [RRTestViewController new];
    VC6.tagName                     = @"VC6";
    UITabBarItem            *item6  = [self configTabBarItemWithTitle:@"VC6" imageName:@"more_normal" selectedImageName:@"more_highlight"];
    VC6.tabBarItem                  = item6;
    UINavigationController  *nav6   = [[UINavigationController alloc] initWithRootViewController:VC6];
    
    
    RRTestViewController    *VC7    = [RRTestViewController new];
    VC7.tagName                     = @"VC7";
    UITabBarItem            *item7  = [self configTabBarItemWithTitle:@"VC7" imageName:@"account_normal" selectedImageName:@"account_highlight"];
    VC7.tabBarItem                  = item7;
    UINavigationController  *nav7   = [[UINavigationController alloc] initWithRootViewController:VC7];
    
    
    //    [self setViewControllers:@[nav1,nav2,nav3,nav4,nav5]];
    
    [self addChildViewController:nav1];
    [self addChildViewController:nav5];
    [self addChildViewController:nav2];
    
    
    self.displayViewControllers = @[].mutableCopy;
    [self.displayViewControllers addObjectsFromArray:self.childViewControllers];
    
    
    self.exchangedViewControllers = @[].mutableCopy;
    self.moreViewControllers = @[].mutableCopy;
    
    
    
    /// FIXME: 不应该此刻就初始化了VC,应该展示时创建。这里只是为了快速测试，暂时这么做
    [self.moreViewControllers addObject:nav3];
    [self.moreViewControllers addObject:nav4];
    [self.moreViewControllers addObject:nav6];
    [self.moreViewControllers addObject:nav7];
}


- (UITabBarItem *)configTabBarItemWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    UIImage *normal         = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *select         = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:normal selectedImage:select];
    return tabBarItem;
}


#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    BOOL isTapMore = viewController.tabBarItem.tag == KMoreTabBarItemTag;
    
    if(isTapMore){
        if(self.moreReplaceViewController == nil){
            if(self.selectedViewController != viewController){
                [self exchangeViewControllerForTabBarContoller:self.selectedViewController andVC:viewController];
            }
            [self showMoreReplaceViewControllerAnimation:YES];
            
        } else {
            [self revertViewControllerForTabBarContoller];
            [self.moreReplaceViewController dismissViewControllerAnimated:YES completion:nil];
        }
        return  NO;
    }
    
    
    if (self.selectedViewController.tabBarItem.tag  == KMoreTabBarItemTag){
        
        [self.moreReplaceViewController dismissViewControllerAnimated:YES completion:nil];

        if([self.exchangedViewControllers containsObject:viewController]){
            [self revertViewControllerForTabBarContoller];
            return  NO;
        } else {
            [self revertViewControllerForTabBarContoller];
            return YES;
        }
        
    }
    return YES;
}


#pragma mark - MoreReplace Method
- (void)showMoreReplaceViewControllerAnimation:(BOOL)animation{
    
    RRMoreReplaceViewController *moreReplaceVC = [[RRMoreReplaceViewController alloc] init];
    self.moreReplaceViewController = moreReplaceVC;
    
    self.moreReplaceViewController.delegate = self;
    
    [self presentViewController:self.moreReplaceViewController animated:YES completion:^{
        
    }];
    
    /// 其他方案
    //    [self addVC];
}

//- (void)removeMoreReplaceViewControllerAnimation:(BOOL)animation{
//    [self.moreReplaceViewController dismissViewControllerAnimated:YES completion:^{
//
//    }];
//}

#pragma mark - RRTabBarMoreReplaceDelegate
- (void)moreItemDidCancel:(RRMoreReplaceViewController *)moreVC{
    [self.moreReplaceViewController dismissViewControllerAnimated:YES completion:^{
        [self revertViewControllerForTabBarContoller];
    }];
}

- (void)moreItem:(RRMoreReplaceViewController *)moreVC didSelectedItemAtIndex:(NSInteger)index{
    
    [self.moreReplaceViewController dismissViewControllerAnimated:YES completion:nil];

    [self revertViewControllerForTabBarContoller];
    
    __block NSUInteger moreItemIndex = self.displayViewControllers.count - 1;
    [self.displayViewControllers enumerateObjectsUsingBlock:^(UIViewController *  _Nonnull viewController, NSUInteger idx, BOOL * _Nonnull stop) {
        if(viewController.tabBarItem.tag == KMoreTabBarItemTag){
            moreItemIndex = idx;
            *stop = YES;
        }
    }];
    
    /// 选中display之外的控制器
    UIViewController *vc  = self.moreViewControllers[arc4random() % self.moreViewControllers.count];
    
    UIViewController *moreVc = (UIViewController *)[self.displayViewControllers objectAtIndex:moreItemIndex];
    
    vc.tabBarItem = moreVc.tabBarItem;
    
    [self.displayViewControllers replaceObjectAtIndex:moreItemIndex withObject:vc];
    
    self.viewControllers = self.displayViewControllers.copy;
    
    self.selectedViewController = vc;
}


//- (void)onPush{
//    [self removeMoreReplaceViewControllerAnimation:YES];
//    [self revertViewControllerForTabBarContoller];
//
//    [self.selectedViewController pushViewController:[RRTestViewController new] animated:YES];
//}



#pragma mark - helper method
- (void)exchangeViewControllerForTabBarContoller:(UIViewController *)VC1 andVC:(UIViewController *)VC2{
    
    [self.exchangedViewControllers addObject:VC1];
    [self.exchangedViewControllers addObject:VC2];
    
    UIViewController *firstVC = self.exchangedViewControllers.firstObject;
    UIViewController *lastVC  = self.exchangedViewControllers.lastObject;
    
    NSInteger fromIndex = [self.displayViewControllers indexOfObject:firstVC];
    NSInteger toIndex   = [self.displayViewControllers indexOfObject:lastVC];
    
    if(fromIndex != toIndex){
        UITabBarItem *tabBarItem = firstVC.tabBarItem;
        firstVC.tabBarItem = lastVC.tabBarItem;
        lastVC.tabBarItem = tabBarItem;
        [self.displayViewControllers exchangeObjectAtIndex:fromIndex withObjectAtIndex:toIndex];
        self.viewControllers = self.displayViewControllers.copy;
    }
}


- (void)revertViewControllerForTabBarContoller{
    
    UIViewController *firstVC = self.exchangedViewControllers.firstObject;
    UIViewController *lastVC  = self.exchangedViewControllers.lastObject;
    
    NSInteger fromIndex = [self.displayViewControllers indexOfObject:firstVC];
    NSInteger toIndex   = [self.displayViewControllers indexOfObject:lastVC];
    
    if(fromIndex != toIndex){
        UITabBarItem *tabBarItem = firstVC.tabBarItem;
        firstVC.tabBarItem = lastVC.tabBarItem;
        lastVC.tabBarItem = tabBarItem;
        [self.displayViewControllers exchangeObjectAtIndex:fromIndex withObjectAtIndex:toIndex];
        self.viewControllers = self.displayViewControllers.copy;
    }
    
    [self.exchangedViewControllers removeAllObjects];
}



- (void)addVC{
    //  以下方案是直接添加ChildViewController
    //    /// 注意, 直接在UITabbarController 添加子控制器，不会直接触发生命周期函数。作为 iOS 原生的 container controller，对 child controller 的添加/移除有内部的实现，从而导致 appear 相关的函数没有执。
    //    /**
    //     Discussion
    //     If you are implementing a custom container controller, use this method to tell the child that its views are about to appear or disappear. Do not invoke viewWillAppear(_:), viewWillDisappear(_:), viewDidAppear(_:), or viewDidDisappear(_:) directly.
    //
    //     func beginAppearanceTransition(_ isAppearing: Bool, animated: Bool)
    //     */
    //
    //    /// 手动控制生命周期
    //    [self.moreReplaceViewController beginAppearanceTransition:YES animated:YES];
    //    [self addChildViewController:self.moreReplaceViewController];
    //    [self.view insertSubview:self.moreReplaceViewController.view belowSubview:self.tabBar];
    //
    //
    //    CGFloat height = 660;
    //    CGFloat containerH = self.view.bounds.size.height;
    //    CGFloat containerW = self.view.bounds.size.width;
    //
    //    self.moreReplaceViewController.view.frame = CGRectMake(0, containerH, containerW, height);
    //
    //    [UIView animateWithDuration:0.25 animations:^{
    //        self.moreReplaceViewController.view.frame = CGRectMake(0, containerH - height, containerW, height);
    //    } completion:^(BOOL finished) {
    //        [self.moreReplaceViewController endAppearanceTransition];
    //        [self.moreReplaceViewController didMoveToParentViewController:self];
    //
    //        [self.moreReplaceViewController.confirmBtn addTarget:self action:@selector(onConfirm) forControlEvents:UIControlEventTouchUpInside];
    //        [self.moreReplaceViewController.cancelBtn addTarget:self action:@selector(onCancel) forControlEvents:UIControlEventTouchUpInside];
    //    }];
}

- (void)removeVC{
    /// 手动控制生命周期
    //    [self.moreReplaceViewController beginAppearanceTransition:NO animated:YES];
    //    [self.moreReplaceViewController willMoveToParentViewController:nil];
    //    [self.moreReplaceViewController.view removeFromSuperview];
    //    [self.moreReplaceViewController removeFromParentViewController];
    //    [self.moreReplaceViewController endAppearanceTransition];
    //
    //    self.moreReplaceViewController = nil;
}

@end

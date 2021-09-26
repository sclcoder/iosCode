//
//  SDTabBarVCDelegate.m
//  SDPlayground
//
//  Created by 孙春磊 on 2021/9/19.
//

#import "SDTabBarVCDelegate.h"
#import "SDSlideAnimationController.h"

@implementation SDTabBarVCDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
        self.interactive = NO;
    }
    return self;
}



- (nullable id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
                     animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                                       toViewController:(UIViewController *)toVC{
    NSInteger fromIndex = [tabBarController.viewControllers indexOfObject:fromVC];
    NSInteger toIndex = [tabBarController.viewControllers indexOfObject:toVC];
    
    SDTabOperationDirection direction = toIndex < fromIndex ? SDTabOperationLeft : SDTabOperationRight;
    SDSlideAnimationController *slideAV = [[SDSlideAnimationController alloc] init];
    slideAV.transitionType = SDTransitionTabBarControllerOperation;
    slideAV.tabDirectionOperation = direction;
    return slideAV;
}


//- (nullable id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
//                               interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController{
//
//    return self.interactive? self.interactionController : nil;
//}



//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
//
//}
//
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//
//}
//
//- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers{
//
//}
//
//- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed {
//
//
//}
//
//- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed{
//
//
//}
//
//- (UIInterfaceOrientationMask)tabBarControllerSupportedInterfaceOrientations:(UITabBarController *)tabBarController {
//
//
//}
//- (UIInterfaceOrientation)tabBarControllerPreferredInterfaceOrientationForPresentation:(UITabBarController *)tabBarController{
//
//}

@end

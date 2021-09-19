//
//  SDNavigationDelegate.m
//  SDPlayground
//
//  Created by chunlei.sun on 2021/9/18.
//

#import "SDNavigationDelegate.h"
#import "SDSlideAnimationController.h"
#import "SDCardAnimationController.h"

@implementation SDNavigationDelegate

#pragma mark - UINavigationControllerDelegate

// 转场动画
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  API_AVAILABLE(ios(7.0)){
    
//    SDSlideAnimationController *slideAC = [SDSlideAnimationController new];
//    slideAC.trasitionType = SDTrasitionNavigationControllerOperation;
//    slideAC.navOperation = operation;
//    return slideAC;
    
    SDCardAnimationController *cardAC = [SDCardAnimationController new];
    cardAC.navOperation = operation;
    return cardAC;
}

// 转场交互
//- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
//                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController API_AVAILABLE(ios(7.0)){
//
//}




// Called when the navigation controller shows a new top view controller via a push, pop or setting of the view controller stack.
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//
//}
//
//
//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//
//}


//- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController API_AVAILABLE(ios(7.0)) API_UNAVAILABLE(tvos){
//
//}
//
//
//- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController API_AVAILABLE(ios(7.0)) API_UNAVAILABLE(tvos){
//
//}
@end

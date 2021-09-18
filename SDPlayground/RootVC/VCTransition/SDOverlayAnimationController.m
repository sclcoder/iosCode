//
//  SDOverlayAnimationControllerr.m
//  SDPlayground
//
//  Created by chunlei.sun on 2021/9/18.
//

#import "SDOverlayAnimationController.h"

@implementation SDOverlayAnimationController

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}


- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = transitionContext.containerView;
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromVC.view;
    UIView *toView= toVC.view;
    
    NSLog(@"%@",NSStringFromCGRect(fromView.frame));
    NSLog(@"%@",NSStringFromCGRect(toView.frame));
    
    if (toVC.isBeingPresented) {
        [containerView addSubview:toView];
        
        toView.bounds = CGRectMake(0, 0, 1, containerView.frame.size.height * 2 / 3);
        toView.center = containerView.center;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            toView.bounds = CGRectMake(0, 0, containerView.frame.size.width * 2 / 3, containerView.frame.size.height * 2 / 3);
            
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    
    //Dismissal 转场中不要将 toView 添加到 containerView
    if (fromVC.isBeingDismissed) {
     
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromView.bounds = CGRectMake(0, 0, 1, fromView.frame.size.height);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    }
}


@end

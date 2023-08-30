//
//  RRPresentAnimationController.m
//  ChimeTest
//
//  Created by sunchunlei on 2023/8/30.
//

#import "RRPresentAnimationController.h"

@implementation RRPresentAnimationController

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25f;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    UIView *fromView = fromVC.view;
    
    if(fromVC.isBeingDismissed){
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
            fromView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, fromView.bounds.size.height);
        }
                         completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    
}
@end

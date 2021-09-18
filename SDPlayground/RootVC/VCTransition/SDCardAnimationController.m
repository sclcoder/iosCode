//
//  SDCardAnimationController.m
//  SDPlayground
//
//  Created by chunlei.sun on 2021/9/18.
//

#import "SDCardAnimationController.h"

@implementation SDCardAnimationController

#pragma mark - UIViewControllerAnimatedTransitioning
// 转场时长
- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}
// 转场过程
- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = transitionContext.containerView;
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromVC.view;
    UIView *toView= toVC.view;
    CGFloat tanslation = containerView.frame.size.width;

    // 注意:一开始fromView\toView的位置是(0,0)
    NSLog(@"%@",NSStringFromCGRect(fromView.frame));
    NSLog(@"%@",NSStringFromCGRect(toView.frame));
    NSLog(@"%f",tanslation);
    
    // 实现头条的转场效果 - 卡片效果: 缩放 - 平移
    CGAffineTransform toViewTransform = CGAffineTransformIdentity;
    CGAffineTransform fromViewTransform = CGAffineTransformIdentity;
    switch (self.navOperation) {
        case UINavigationControllerOperationPush:{
            // toView添加到container容器中
            [containerView addSubview:toView];
            toViewTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, tanslation, 0);
            fromViewTransform = CGAffineTransformScale(CGAffineTransformIdentity, 0.90, 0.98);
        };
            break;
        case UINavigationControllerOperationPop:{
            // toView添加到container容器中
            // 该场景需要调整 fromView 和 toView 的显示顺序，
            [containerView insertSubview:toView belowSubview:fromView];
            fromViewTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, tanslation, 0);
            toViewTransform = CGAffineTransformScale(CGAffineTransformIdentity, 0.90, 0.98);
        };
            break;
        case UINavigationControllerOperationNone:
        default:
            break;
    }
    
    // 动画前位置
    toView.transform = toViewTransform;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        // 动画后位置
        fromView.transform = fromViewTransform;
        toView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        fromView.transform = CGAffineTransformIdentity;
        toView.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
    
}
@end

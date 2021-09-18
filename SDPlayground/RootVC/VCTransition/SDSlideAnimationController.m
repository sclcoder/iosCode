//
//  SDSIideAnimationController.m
//  SDPlayground
//
//  Created by chunlei.sun on 2021/9/18.
//

#import "SDSlideAnimationController.h"

@interface SDSlideAnimationController()

@end

@implementation SDSlideAnimationController

#pragma mark - UIViewControllerAnimatedTransitioning
// 转场时长
- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
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
    
    // toView添加到container容器中
    [containerView addSubview:toView];
    
    // 可以实现移动、缩放或旋转以及组合以上效果 https://juejin.cn/post/6844904039042252814
    CGAffineTransform toViewTransform = CGAffineTransformIdentity;
    CGAffineTransform fromViewTransform = CGAffineTransformIdentity;
    switch (self.navOperation) {
        case UINavigationControllerOperationPush:{
            toViewTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, tanslation, 0);
            fromViewTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, -tanslation, 0);
        };
            break;
        case UINavigationControllerOperationPop:{
            fromViewTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, tanslation, 0);
            toViewTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, -tanslation, 0);
        };
            break;
        case UINavigationControllerOperationNone:
        default:
            break;
    }
    
    
    toView.transform = toViewTransform; // 动画前位置
    fromView.transform = CGAffineTransformIdentity;
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

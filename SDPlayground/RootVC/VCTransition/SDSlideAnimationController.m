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
    /// 默认为黑色
    containerView.backgroundColor = [UIColor whiteColor];
    
    
    // 注意:一开始fromView\toView的位置是(0,0)
    NSLog(@"%@",NSStringFromCGRect(fromView.frame));
    NSLog(@"%@",NSStringFromCGRect(toView.frame));
    NSLog(@"%f",tanslation);
    
    // toView添加到container容器中 - 在后文添加
//    [containerView addSubview:toView];
    
    // 可以实现移动、缩放或旋转以及组合以上效果 https://juejin.cn/post/6844904039042252814
    CGAffineTransform toViewTransform = CGAffineTransformIdentity;
    CGAffineTransform fromViewTransform = CGAffineTransformIdentity;
    
    
    switch (self.transitionType) {
            
            ///  Nav
        case SDTransitionNavigationControllerOperation:{
            
            switch (self.navOperation) {
                case UINavigationControllerOperationPush:{
                    /// toView动画前位置
                    toViewTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, tanslation, 0);
                    /// fromView动画后位置
                    fromViewTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, -tanslation, 0);
                };
                    break;
                case UINavigationControllerOperationPop:{
                    /// toView动画前位置
                    toViewTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, -tanslation, 0);
                    /// fromView动画后位置
                    fromViewTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, tanslation, 0);
                };
                    break;
                case UINavigationControllerOperationNone:
                default:
                    break;
            }
        
        }
            break;
            /// Tab
        case SDTransitionTabBarControllerOperation:{
            switch (self.tabDirectionOperation) {
                case SDTabOperationRight:{
                    /// toView动画前位置
                    toViewTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, tanslation, 0);
                    /// fromView动画后位置
                    fromViewTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, -tanslation, 0);
                }
                    break;
                case SDTabOperationLeft:{
                    /// toView动画前位置
                    toViewTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, -tanslation, 0);
                    /// fromView动画后位置
                    fromViewTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, tanslation, 0);
                }
                    break;
                default:
                    break;
            }
        }
            break;
            /// Modal
        case SDTransitionModalOperation:{
            /// Modal Dismiss动画效果是height
            tanslation = containerView.bounds.size.height;
            
            switch (self.modalOperation) {

                case SDModalOperationModal:{
                    /// toView动画前位置
                    toViewTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, tanslation);
                    /// fromView动画后位置
                    fromViewTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -tanslation);
                }
                    break;
                case SDModalOperationDismissal:{
                    /// toView动画前位置
                    toViewTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, tanslation);
                    /// fromView动画后位置
                    fromViewTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -tanslation);
                }
                    break;
                default:
                    break;
            }

        }
        default:
            break;
    }
    
    
    switch (self.transitionType) {
        case SDTransitionModalOperation:{
            switch (self.modalOperation) {
                case SDModalOperationModal:{
                    [containerView addSubview:toView];
                }
                    break;
                case SDModalOperationDismissal:
                    /**
                    为什么Modal中dismiss时不要将toView添加到containerView,具体请看原文章解释
                    简单的说:modal的custom模式时，presentingView当初modal时并没有被从原来的层级结构移除,因为要给presentedView做背景。
                     所以在dismiss时也不要将toView添加到containerView中。
                     */
                    break;
                default:
                    break;
            }
        }
            break;
        default:{
            [containerView addSubview:toView];
        }
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

/**
 特殊的 Modal 转场
 Modal 转场的差异
 事先声明：尽管 Modal 转场和上面两种容器 VC 的转场在控制器结构以及视图结构都有点差别，但是在代码里实现转场时，差异非常小，仅有一处地方需要注意。所以，本节也可以直奔末尾，记住结论就好。

 上一节里两种容器 VC 的转场里，fromVC 和 toVC 都是其子 VC，而在 Modal 转场里并非这样的关系，fromVC(presentingVC) present toVC(presentedVC)，前者为后者提供显示的环境。两类转场的视图结构差异如下：

 ContainerVC VS Modal

 转场前后可以在控制台打印出它们的视图控制器结构以及视图结构观察变化情况，不熟悉相关命令的话推荐使用 chisel 工具，而使用 Xcode 的 ViewDebugging 功能可以直观地查看应用的视图结构。如果你对转场中 containerView 这个角色感兴趣，可以通过上面的方法来查看。

 容器类 VC 的转场里 fromView 和 toView 是 containerView 的子层次的视图，而 Modal 转场里 presentingView 与 containerView 是同层次的视图，只有 presentedView 是 containerView 的子层次视图。

 这种视图结构上的差异与 Modal 转场的另外一个不同点是相契合的：转场结束后 fromView 可能依然可见，比如 UIModalPresentationPageSheet 模式的 Modal 转场就是这样。Modal 转场有多种模式，由其modalPresentationStyle属性决定，有两种模式可以进行自定义： UIModalPresentationFullScreen 模式(以下简称 FullScreen 模式，该属性的默认值)和 UIModalPresentationCustom 模式(以下简称 Custom 模式)。容器 VC 的转场结束后 fromView 会被主动移出视图结构，这是可预见的结果，我们也可以在转场结束前手动移除；而 Modal 转场中，presentation 结束后 presentingView(fromView) 并未主动被从视图结构中移除。准确来说，在我们可自定义的两种模式里，Custom 模式下 Modal 转场结束时 fromView 并未从视图结构中移除；FullScreen 模式下 Modal 转场结束后 fromView 依然主动被从视图结构中移除了。这种差异导致在处理 dismissal 转场的时候很容易出现问题，没有意识到这个不同点的话出错时就会毫无头绪。

 来看看 dismissal 转场时的场景：

 FullScreen 模式：presentation 结束后，presentingView 被主动移出视图结构，不过，在 dismissal 转场中希望其出现在屏幕上并且在对其添加动画怎么办呢？实际上，你按照容器类 VC 转场里动画控制器里那样做也没有问题，就是将其加入 containerView 并添加动画。不用担心，转场结束后，UIKit 会自动将其恢复到原来的位置。虽然背后的机制不一样，但这个模式下的 Modal 转场和容器类 VC 的转场的动画控制器的代码可以通用，你不必记住背后的差异。
 
 Custom 模式：presentation 结束后，presentingView(fromView) 未被主动移出视图结构，在 dismissal 中，注意不要像其他转场中那样将 presentingView(toView) 加入 containerView 中，否则 dismissal 结束后本来可见的 presentingView 将会随着 containerView 一起被移除。如果你在 Custom 模式下没有注意到这点，很容易出现黑屏之类的现象而不知道问题所在。
 
 
 对于 Custom 模式，我们可以参照其他转场里的处理规则来打理：presentation 转场结束前手动将 fromView(presentingView) 移出它的视图结构，并用一个变量来维护 presentingView 的父视图，以便在 dismissal 转场中恢复；在 dismissal 转场中，presentingView 的角色由原来的 fromView 切换成了 toView，我们再将其重新恢复它原来的视图结构中。测试表明这样做是可行的。但是这样一来，在实现上，需要动画控制器用一个变量来保存 presentingView 的父视图以便在 dismissal 转场中恢复，第三方的动画控制器必须为此改造。显然，这样的代价是无法接受的。为何 FullScreen 模式的 dismissal 转场里就可以任性地将 presentingView 加入到 containerView 里呢？因为 UIKit 知道 presentingView 的视图结构，即使强行将其从原来的视图结构迁移到 containerView，事后将其恢复到正确的位置也是很容易的事情。

 由于以上的区别导致实现交互化的时候在 Custom 模式下无法控制转场过程中添加到 presentingView 上面的动画。解决手段请看特殊的 Modal 转场交互化一节。

 结论：不要干涉官方对 Modal 转场的处理，我们去适应它。在 Custom 模式下的 dismissal 转场中不要像其他的转场那样将 toView(presentingView) 加入 containerView，否则 presentingView 将消失不见，而应用则也很可能假死。而 FullScreen 模式下可以使用与前面的容器类 VC 转场同样的代码。因此，上一节里示范的 Slide 动画控制器不适合在 Custom 模式下使用，放心好了，Demo 里适配好了，具体的处理措施，请看下一节的处理。

 iOS 8 为<UIViewControllerContextTransitioning>协议添加了viewForKey:方法以方便获取 fromView 和 toView，但是在 Modal 转场里要注意：在 Custom 模式下通过viewForKey:方法来获取 presentingView 得到的是 nil，必须通过viewControllerForKey:得到 presentingVC 后来间接获取，FullScreen 模式下没有这个问题。(原来这里没有限定是在 Custom 模式，导致 @JiongXing 浪费了些时间，抱歉)。因此在 Modal 转场中，较稳妥的方法是从 fromVC 和 toVC 中获取 fromView 和 toView。


 
 */

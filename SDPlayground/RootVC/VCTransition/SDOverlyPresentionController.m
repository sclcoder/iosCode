//
//  SDOverlyPresentionController.m
//  SDPlayground
//
//  Created by chunlei.sun on 2021/9/18.
//

#import "SDOverlyPresentionController.h"

@interface SDOverlyPresentionController()

@property (nonatomic, strong) UIView *dimmingView;

@property(nonatomic,weak) UIViewController *presentedVc;

@end

/**
 iOS 8 针对分辨率日益分裂的 iOS 设备带来了新的适应性布局方案，以往有些专为在 iPad 上设计的控制器也能在 iPhone 上使用了，一个大变化是在视图控制器的(模态)显示过程，包括转场过程，引入了UIPresentationController类，该类接管了 UIViewController 的显示过程，为其提供转场和视图管理支持。在 iOS 8.0 以上的系统里，你可以在 presentation 转场结束后打印视图控制器的结构，会发现 presentedVC 是由一个UIPresentationController对象来显示的，查看视图结构也能看到 presentedView 是 UIView 私有子类的UITtansitionView的子视图，这就是前面 containerView 的真面目(剧透了)。
 
 当 UIViewController 的modalPresentationStyle属性为.Custom时(不支持.FullScreen)，我们有机会通过控制器的转场代理提供UIPresentationController的子类对 Modal 转场进行进一步的定制。
 实际上该类也可以在.FullScreen模式下使用，但是会丢失由该类负责的动画，保险起见还是遵循官方的建议，只在.Custom模式下使用该类。官方对该类参与转场的流程和使用方法有非常详细的说明：Creating Custom Presentations。
 */
@implementation SDOverlyPresentionController

- (void)onTapDimmingView:(UITapGestureRecognizer *)tap{
    [self.presentedVc dismissViewControllerAnimated:YES completion:nil];
}

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController{
    if (self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) {
        self.dimmingView = [UIView new];
        [self.dimmingView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapDimmingView:)]];
        self.presentedVc = presentedViewController;
    }
    return self;
}

/**
 在 iOS 7 中，Custom 模式的 Modal 转场里，presentingView 不会被移除，如果我们要移除它并妥善恢复会破坏动画控制器的独立性使得第三方动画控制器无法直接使用；在 iOS 8 中，UIPresentationController解决了这点，给予了我们选择的权力，通过重写下面的方法来决定 presentingView 是否在 presentation 转场结束后被移除：
 
 返回 true 时，presentation 结束后 presentingView 被移除，在 dimissal 结束后 UIKit 会自动将 presentingView 恢复到原来的视图结构中。此时，Custom 模式与 FullScreen 模式下无异，完全不必理会前面 dismissal 转场部分的差异了。另外，这个方法会在实现交互控制的 Modal 转场时起到关键作用，详情请看交互转场部分。
 */


- (BOOL)shouldRemovePresentersView{
    return NO;
}

- (void)presentationTransitionWillBegin{
    
    [self.containerView addSubview:self.dimmingView];
    self.dimmingView.bounds = CGRectMake(0, 0,self.containerView.bounds.size.width * 2 / 3, self.containerView.bounds.size.height * 2 / 3);
    self.dimmingView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    self.dimmingView.center = self.containerView.center;
    
    /**
         与动画控制器中的转场动画同步，执行其他动画
         animateAlongsideTransition:completion:
         与动画控制器中的转场动画同步，在指定的视图内执行动画
         animateAlongsideTransitionInView:animation:completion:
     */

    //使用 transitionCoordinator 与转场动画并行执行 dimmingView 的动画。
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.bounds = self.containerView.bounds;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];

}

//Dismissal 转场开始前该方法被调用。添加了 dimmingView 消失的动画，在上一节中并没有添加这个动画，
//实际上由于 presentedView 的形变动画，这个动画根本不会被注意到，此处只为示范。
- (void)dismissalTransitionWillBegin{
    
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.0;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}

/**
 你可能会疑惑，除了解决了 iOS 7 中无法干涉 presentingView 这个痛点外，还有什么理由值得我们使用UIPresentationController类？除了能与动画控制器配合，UIPresentationController类也能脱离动画控制器独立工作，在转场代理里我们仅仅提供后者也能对 presentedView 的外观进行定制，缺点是无法控制 presentedView 的转场动画，因为这是动画控制器的职责，这种情况下，presentedView 的转场动画采用的是默认的 Slide Up 动画效果，转场协调器实现的动画则是采用默认的动画时间。

 iOS 8 带来了适应性布局，<UIContentContainer>协议用于响应视图尺寸变化和屏幕旋转事件，之前用于处理屏幕旋转的方法都被废弃了。UIViewController 和 UIPresentationController 类都遵守该协议，在 Modal 转场中如果提供了后者，则由后者负责前者的尺寸变化和屏幕旋转，最终的布局机会也在后者里。在OverlayPresentationController中重写以下方法来调整视图布局以及应对屏幕旋转：
 */
/// 适配屏幕尺寸发生变化的场景 如: 屏幕旋转
- (void)containerViewWillLayoutSubviews{
    self.dimmingView.center = self.containerView.center;
    self.dimmingView.bounds = self.containerView.bounds;

    self.presentedView.center = self.containerView.center;
    self.presentedView.bounds = CGRectMake(0, 0, self.containerView.bounds.size.width * 2 / 3, self.containerView.bounds.size.height * 2 / 3);
}

@end

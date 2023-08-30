//
//  RROverlayPresentationController.m
//  ChimeTest
//
//  Created by sunchunlei on 2023/8/29.
//

#import "RROverlayPresentationController.h"
/** 官方文档
 https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/DefiningCustomPresentations.html#//apple_ref/doc/uid/TP40007457-CH25-SW1
 */


@interface RROverlayPresentationController ()

@property (nonatomic, strong) UIView *dimmingView;
//@property (nonatomic, strong) UIView *maskView;


@end

@implementation RROverlayPresentationController




#pragma mark - init
- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                    presentingViewController:(UIViewController *)presentingViewController {
    
    self = [super initWithPresentedViewController:presentedViewController
                         presentingViewController:presentingViewController];
    if(self) {
        // Create the dimming view and set its initial appearance.
        /// 阴影图层
        self.dimmingView = [[UIView alloc] init];
        self.dimmingView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        self.dimmingView.opaque = NO;
        self.dimmingView.alpha = 0;
        [self.dimmingView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapdimmingView:)]];
        
        /// 圆角图层
//        self.maskView = [[UIView alloc] init];
//        self.maskView.layer.cornerRadius = 10;
//        self.maskView.layer.masksToBounds = YES;

    }
    return self;
}


#pragma mark - Layout
- (void)containerViewWillLayoutSubviews{
    [super containerViewWillLayoutSubviews];
    
    self.dimmingView.frame = self.containerView.frame;
//    self.maskView.frame = self.frameOfPresentedViewInContainerView;
}



#pragma mark - overwirte
//- (UIView*)presentedView{
//    return self.maskView;
//}


- (CGRect)frameOfPresentedViewInContainerView {
    CGRect presentedViewFrame = CGRectZero;
    CGRect containerBounds = [[self containerView] bounds];
    presentedViewFrame.size = CGSizeMake(containerBounds.size.width,floorf(containerBounds.size.height * 0.625));
    presentedViewFrame.origin.y = containerBounds.size.height - presentedViewFrame.size.height;
    return presentedViewFrame;
}


- (void)presentationTransitionWillBegin {
    // Get critical information about the presentation.
    
    UIView *containerView = [self containerView];
    UITabBarController *tabVC =  (UITabBarController *)self.presentingViewController;
    [tabVC.view insertSubview:containerView belowSubview:tabVC.tabBar];
    
    self.presentedView.layer.cornerRadius  = 10;
    self.presentedView.layer.masksToBounds = YES;;

//    UIView *presentedViewControllerView = [super presentedView];
//    self.maskView.frame = self.frameOfPresentedViewInContainerView;
//    [self.maskView addSubview:presentedViewControllerView];
//    presentedViewControllerView.frame = self.maskView.bounds;


    // Set the dimming view to the size of the container's
    // bounds, and make it transparent initially.
    [[self dimmingView] setFrame:[containerView bounds]];
    [[self dimmingView] setAlpha:0.0];
    
    
    // Insert the dimming view below everything else.
    [containerView insertSubview:[self dimmingView] atIndex:0];
 
    
    
    UIViewController *presentedViewController = [self presentedViewController];
    // Set up the animations for fading in the dimming view.
    if([presentedViewController transitionCoordinator]) {
        [[presentedViewController transitionCoordinator]
               animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>
                                            context) {
            // Fade in the dimming view.
            [[self dimmingView] setAlpha:1.0];
        } completion:nil];
    }
    else {
        [[self dimmingView] setAlpha:1.0];
    }
}


- (void)presentationTransitionDidEnd:(BOOL)completed {
    // If the presentation was canceled, remove the dimming view.
    if (!completed){
        [self.dimmingView removeFromSuperview];
    }
}


- (void)dismissalTransitionWillBegin {
    // Fade the dimming view back out.
    if([[self presentedViewController] transitionCoordinator]) {
        [[[self presentedViewController] transitionCoordinator]
           animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>
                                        context) {
            [[self dimmingView] setAlpha:0.0];
        } completion:nil];
    }
    else {
        [[self dimmingView] setAlpha:0.0];
    }
}
 
- (void)dismissalTransitionDidEnd:(BOOL)completed {
    // If the dismissal was successful, remove the dimming view.
    if (completed){
        [self.dimmingView removeFromSuperview];
    }
}



#pragma mark - dimmingView event
- (void)onTapdimmingView:(UITapGestureRecognizer *)tapGesture{
    if(self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(onTapDimmingView)]){
        [self.eventDelegate onTapDimmingView];
    }
    
//    [self.presentedViewController dismissViewControllerAnimated:YES completion:^{
//
//    }];
}


@end

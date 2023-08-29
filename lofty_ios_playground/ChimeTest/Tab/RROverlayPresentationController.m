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


@end

@implementation RROverlayPresentationController


- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                    presentingViewController:(UIViewController *)presentingViewController {
    
    self = [super initWithPresentedViewController:presentedViewController
                         presentingViewController:presentingViewController];
    if(self) {
        // Create the dimming view and set its initial appearance.
        self.dimmingView = [[UIView alloc] init];
        [self.dimmingView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.4]];
        [self.dimmingView setAlpha:0.0];
        
        [self.containerView addSubview:presentingViewController.tabBarController.tabBar];
    }
    return self;
}


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
    
    UIViewController* presentedViewController = [self presentedViewController];
 
    // Set the dimming view to the size of the container's
    // bounds, and make it transparent initially.
    [[self dimmingView] setFrame:[containerView bounds]];
    [[self dimmingView] setAlpha:0.0];
 
    // Insert the dimming view below everything else.
    [containerView insertSubview:[self dimmingView] atIndex:0];
 
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
    if (!completed)
        [self.dimmingView removeFromSuperview];
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
    if (completed)
        [self.dimmingView removeFromSuperview];
}

@end

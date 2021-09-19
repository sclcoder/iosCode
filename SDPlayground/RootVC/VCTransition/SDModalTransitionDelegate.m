//
//  SDModalTransitionDelegate.m
//  SDPlayground
//
//  Created by chunlei.sun on 2021/9/18.
//

#import "SDModalTransitionDelegate.h"
#import "SDOverlayAnimationController.h"
#import "SDOverlyPresentionController.h"
#import "SDSlideAnimationController.h"

@implementation SDModalTransitionDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                            presentingController:(UIViewController *)presenting
                                                                                sourceController:(UIViewController *)source{
    
//    SDSlideAnimationController *slidAC = [SDSlideAnimationController new];
//    slidAC.transitionType = SDTransitionModalOperation;
//    slidAC.modalOperation = SDModalOperationModal;
//    return slidAC;
    return [SDOverlayAnimationController new];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
//    SDSlideAnimationController *slidAC = [SDSlideAnimationController new];
//    slidAC.transitionType = SDTransitionModalOperation;
//    slidAC.modalOperation = SDModalOperationDismissal;
//    return slidAC;
    return [SDOverlayAnimationController new];
}

/**
 An object that manages the transition animations and the presentation of view controllers onscreen.
 
 
 From the time a view controller is presented until the time it is dismissed, UIKit uses a presentation controller to manage various aspects of the presentation process for that view controller.
 
 The presentation controller can add its own animations on top of those provided by animator objects, it can respond to size changes, and it can manage other aspects of how the view controller is presented onscreen.
 
 When you present a view controller using the presentViewController:animated:completion: method, UIKit always manages the presentation process.
 Part of that process involves creating the presentation controller that is appropriate for the given presentation style.
 For the built-in styles (such as the UIModalPresentationPageSheet style), UIKit defines and creates the needed presentation controller object.
 
 The only time your app can provide a custom presentation controller is when you set the modalPresentationStyle property of your view controller UIModalPresentationCustom.
 
 You might provide a custom presentation controller when you want to add a shadow view or decoration views underneath the view controller being presented or when you want to modify the presentation behavior in other ways.
 
 You vend your custom presentation controller object through your view controller’s transitioning delegate.
 UIKit maintains a reference to your presentation controller object while the presented view controller is onscreen.
 
 For information about the transitioning delegate and the objects it provides, see UIViewControllerTransitioningDelegate.

 */

// 适合插入shadow view等等
- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                               presentingViewController:(nullable UIViewController *)presenting
                                                                   sourceViewController:(UIViewController *)source API_AVAILABLE(ios(8.0)){
    
    return [[SDOverlyPresentionController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
//
//}
//
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
//
//
//}
//


@end

//
//  SDNavigationController.m
//  SDPlayground
//
//  Created by chunlei.sun on 2021/5/19.
//

#import "SDNavigationController.h"

#import "SDNavigationDelegate.h"

// iOS 视图控制器转场详解
// https://github.com/seedante/iOS-Note/wiki/ViewController-Transition

@interface SDNavigationController () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) SDNavigationDelegate *strongReferenceDelegate;
@end

@implementation SDNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /// 设置代理后,系统的交互效果失效
    self.strongReferenceDelegate = [SDNavigationDelegate new];
    self.delegate = self.strongReferenceDelegate;

    UIScreenEdgePanGestureRecognizer *swipeGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeGesture:)];
    swipeGesture.delegate = self;
    swipeGesture.edges = UIRectEdgeLeft;
    self.swipeGesture = swipeGesture;
    [self.view addGestureRecognizer:swipeGesture];
}

/// 手势返回
- (void)onSwipeGesture:(UIPanGestureRecognizer *)swipeGesture{
    
    UIView *targetView = swipeGesture.view;
    CGPoint location = [swipeGesture translationInView:targetView];
    CGFloat translationX = location.x;
    NSLog(@"%f",location.x);
    CGFloat percent   = translationX / targetView.bounds.size.width;
    switch (swipeGesture.state) {
        case UIGestureRecognizerStateBegan:{
            self.strongReferenceDelegate.interactive = YES;
            [self popViewControllerAnimated:YES];
        }
            break;
        case UIGestureRecognizerStateChanged:{
            [self.strongReferenceDelegate.interactionController updateInteractiveTransition:percent];
        }
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            if (percent > 0.3) {
                [self.strongReferenceDelegate.interactionController finishInteractiveTransition];
            } else{
                [self.strongReferenceDelegate.interactionController cancelInteractiveTransition];
            }
            self.strongReferenceDelegate.interactive = NO;
        }
            break;
        default:
            break;
    };
}



#pragma mark - UIGestureRecognizerDelegate

// called when a gesture recognizer attempts to transition out of UIGestureRecognizerStatePossible. returning NO causes it to transition to UIGestureRecognizerStateFailed
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//
//}

// called when the recognition of one of gestureRecognizer or otherGestureRecognizer would be blocked by the other
// return YES to allow both to recognize simultaneously. the default implementation returns NO (by default no two gestures can be recognized simultaneously)
//
// note: returning YES is guaranteed to allow simultaneous recognition. returning NO is not guaranteed to prevent simultaneous recognition, as the other gesture's delegate may return YES
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    return YES;
//}

// called once per attempt to recognize, so failure requirements can be determined lazily and may be set up between recognizers across view hierarchies
// return YES to set up a dynamic failure requirement between gestureRecognizer and otherGestureRecognizer
//
// note: returning YES is guaranteed to set up the failure requirement. returning NO does not guarantee that there will not be a failure requirement as the other gesture's counterpart delegate or subclass methods may return YES
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//
//}

//// called before touchesBegan:withEvent: is called on the gesture recognizer for a new touch. return NO to prevent the gesture recognizer from seeing this touch
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//
//}
//
//// called before pressesBegan:withEvent: is called on the gesture recognizer for a new press. return NO to prevent the gesture recognizer from seeing this press
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceivePress:(UIPress *)press{
//
//}


#pragma mark - overwrite
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count != 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


#pragma mark - 旋转 、 status bar
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}

- (UIViewController *)childViewControllerForHomeIndicatorAutoHidden {
    return self.topViewController;
}

- (UIViewController *)childViewControllerForScreenEdgesDeferringSystemGestures {
    return self.topViewController;
}

- (BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}

@end

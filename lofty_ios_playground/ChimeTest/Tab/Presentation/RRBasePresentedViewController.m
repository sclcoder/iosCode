//
//  RRBasePresentedViewController.m
//  ChimeTest
//
//  Created by sunchunlei on 2023/8/30.
//

#import "RRBasePresentedViewController.h"
#import "RRPresentAnimationController.h"
#import "RROverlayPresentationController.h"


@interface RRBasePresentedViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@property (nonatomic, assign) BOOL shouldCompleteTransition;

@property (nonatomic, assign) BOOL interactionInProgress;

@end

@implementation RRBasePresentedViewController


-(instancetype)init{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] init];
    [panGesture addTarget:self action:@selector(onPan:)];
    [self.view addGestureRecognizer:panGesture];

    self.panGesture = panGesture;
    
    panGesture.delegate = self;
    self.view.tag = 10001;
}



- (void)interactiveFinishedDismiss{
    
}


#pragma mark - Gesture Event
- (void)onPan:(UIPanGestureRecognizer *)panGesture{
    CGPoint translation = [panGesture translationInView:panGesture.view];
    CGFloat progress    = translation.y / panGesture.view.bounds.size.height;
    progress = MIN(MAX(progress, 0.0), 1.0);
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:{
            self.interactiveTransition = [UIPercentDrivenInteractiveTransition new];
            self.interactionInProgress = YES;
            [self dismissViewControllerAnimated:YES completion:^{
                if(self.shouldCompleteTransition){
                    NSLog(@"---------------");
                    [self interactiveFinishedDismiss];
                }
            }];
        }
            break;
        case UIGestureRecognizerStateChanged:{
            self.interactionInProgress = YES;
            self.shouldCompleteTransition = progress > 0.375;
            [self.interactiveTransition updateInteractiveTransition:progress];
        }
            break;
        case UIGestureRecognizerStateCancelled:{
            self.interactionInProgress = NO;
            [self.interactiveTransition cancelInteractiveTransition];
        }
            break;
        case UIGestureRecognizerStateEnded:{
            self.interactionInProgress = NO;
            if(self.shouldCompleteTransition){
                [self.interactiveTransition finishInteractiveTransition];
            } else {
                [self.interactiveTransition cancelInteractiveTransition];
            }
        }
            break;
            
        default:
            break;
    }
}



#pragma mark - UIViewControllerTransitioningDelegate
/// 设置继承自UIPresentationController 的自定义类的属性
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    
    RROverlayPresentationController *presentVC = [[RROverlayPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    presentVC.eventDelegate = self;
    return presentVC;
}

/// 控制器创建执行的动画（返回一个实现UIViewControllerAnimatedTransitioning协议的类）
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    return nil;
}

// 控制器销毁执行的动画（返回一个实现UIViewControllerAnimatedTransitioning协议的类）
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    //创建实现UIViewControllerAnimatedTransitioning协议的类（命名为AnimatedTransitioning）
    RRPresentAnimationController *animation = [[RRPresentAnimationController alloc] init];
    return animation;
}

// 返回一个交互的对象（实现UIViewControllerInteractiveTransitioning协议的类）
-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    
    if(self.interactionInProgress){
        return self.interactiveTransition;
    }
    /**
     Dismiss 触发时，会调用该方法
     Dismiss 触发时，不要返回UIViewControllerInteractiveTransitioning，不然会假死等待返回UIViewControllerInteractiveTransitioning
     */
    return nil;
}

@end

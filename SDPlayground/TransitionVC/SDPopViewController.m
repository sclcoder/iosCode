//
//  SDPopViewController.m
//  SDPlayground
//
//  Created by chunlei.sun on 2021/9/17.
//

#import "SDPopViewController.h"
#import "SDPushViewController.h"

#import "SDNavigationDelegate.h"
@interface SDPopViewController ()
@property(nonatomic,weak) SDNavigationDelegate *navDelegate;

@end

@implementation SDPopViewController


- (IBAction)onTapPopButton:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)onTapPushButton:(UIButton *)sender {
    [self.navigationController pushViewController:[SDPushViewController new] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    
    UIPanGestureRecognizer *swipeGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeGesture:)];
    
    [self.view addGestureRecognizer:swipeGesture];
    
    self.navDelegate = self.navigationController.delegate;
}


- (void)onSwipeGesture:(UIPanGestureRecognizer *)swipeGesture{
    
    CGPoint location = [swipeGesture translationInView:self.view];
    CGFloat translationX = fabs(location.x);
    CGFloat percent   = translationX / self.view.bounds.size.width;
    switch (swipeGesture.state) {
        case UIGestureRecognizerStateBegan:{
            self.navDelegate.interactive = YES;
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case UIGestureRecognizerStateChanged:{
            [self.navDelegate.interactionController updateInteractiveTransition:percent];
        }
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            if (percent > 0.5) {
                [self.navDelegate.interactionController finishInteractiveTransition];
            } else{
                [self.navDelegate.interactionController cancelInteractiveTransition];
            }
            self.navDelegate.interactive = NO;
        }
            break;
        default:
            break;
    };
}


@end

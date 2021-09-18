//
//  SDPresentingViewController.m
//  SDPlayground
//
//  Created by chunlei.sun on 2021/9/18.
//

#import "SDPresentingViewController.h"
#import "SDPresentedViewController.h"
#import "SDModalTransitionDelegate.h"

@interface SDPresentingViewController ()
@property (nonatomic, strong)  SDModalTransitionDelegate *strongReferanceDelegate;
@end

@implementation SDPresentingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.strongReferanceDelegate = [SDModalTransitionDelegate new];
}

/*
.FullScreen 的时候，presentingView 的移除和添加由 UIKit 负责，在 presentation 转场结束后被移除，dismissal 转场结束时重新回到原来的位置；
.Custom 的时候，presentingView 依然由 UIKit 负责，但 presentation 转场结束后不会被移除。
*/

- (IBAction)onTapPresentButton:(UIButton *)sender {
    SDPresentedViewController *toVC = [SDPresentedViewController new];
    toVC.transitioningDelegate = self.strongReferanceDelegate;
    toVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:toVC animated:YES completion:nil];
}


@end

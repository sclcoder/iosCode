//
//  SDPresentedViewController.m
//  SDPlayground
//
//  Created by chunlei.sun on 2021/9/18.
//

#import "SDPresentedViewController.h"

@interface SDPresentedViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;
@property (nonatomic, weak) __block NSLayoutConstraint *widthConstraint;
@end

@implementation SDPresentedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.cornerRadius = 10;
    self.dismissButton.alpha = 0;

    NSArray *constraints = [self.inputTextField constraints];
    [constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint*  _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([constraint.identifier  isEqual: @"Width"]) { // 注意:需要在xib中设置identifer为Width
            self.widthConstraint = constraint;
        }
    }];
    self.widthConstraint.constant = 0;

}

/// 控制器的转场动画结束后调用
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.widthConstraint.constant = self.view.frame.size.width * 2 / 3;
    // 转场动画结束后的动画
    [UIView animateWithDuration:0.25 animations:^{
        self.dismissButton.alpha = 1;
        [self.view layoutIfNeeded];

    } completion:^(BOOL finished) {

    }];
}

- (IBAction)onTapDismissButton:(UIButton *)sender {
    
    CGAffineTransform applyTransform = CGAffineTransformRotate(CGAffineTransformIdentity, 3 * (CGFloat)M_PI);
    applyTransform = CGAffineTransformScale(applyTransform, 0.1, 0.1);

    self.widthConstraint.constant = 0;
    /// 转场动画开始前的内部动画
    [UIView animateWithDuration:0.25 animations:^{
        self.dismissButton.transform = applyTransform;
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        /// 触发转场动画
        [self dismissViewControllerAnimated:YES completion:nil];
    }];

}

@end

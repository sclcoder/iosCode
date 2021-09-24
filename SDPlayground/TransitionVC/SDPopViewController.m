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
    
    
//    UIPanGestureRecognizer *swipeGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeGesture:)];
//    
//    [self.view addGestureRecognizer:swipeGesture];
//    
//    self.navDelegate = self.navigationController.delegate;
}





@end

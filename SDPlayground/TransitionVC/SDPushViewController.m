//
//  SDTestViewController.m
//  SDPlayground
//
//  Created by chunlei.sun on 2021/9/17.
//

#import "SDPushViewController.h"
#import "SDPopViewController.h"
@interface SDPushViewController ()

@end

@implementation SDPushViewController


- (IBAction)onTapPushButton:(UIButton *)sender {
    SDPopViewController *popVc = [SDPopViewController new];
    [self.navigationController pushViewController:popVc animated:YES];
//    popVc.modalPresentationStyle = UIModalPresentationPageSheet;
//    popVc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:popVc
//                        animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
}


@end

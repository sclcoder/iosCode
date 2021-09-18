//
//  SDPopViewController.m
//  SDPlayground
//
//  Created by chunlei.sun on 2021/9/17.
//

#import "SDPopViewController.h"
#import "SDPushViewController.h"

@interface SDPopViewController ()

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

}

@end

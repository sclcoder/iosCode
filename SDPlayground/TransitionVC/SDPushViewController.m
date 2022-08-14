//
//  SDTestViewController.m
//  SDPlayground
//
//  Created by chunlei.sun on 2021/9/17.
//

#import "SDPushViewController.h"
#import "SDPopViewController.h"
#import "SDPagerController.h"
#import <JSBadgeView/JSBadgeView.h>

@interface SDPushViewController ()
@property (weak, nonatomic) IBOutlet UIView *testView;

@end

@implementation SDPushViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    JSBadgeView *badgeView = [[JSBadgeView alloc] initWithParentView:self.testView alignment:JSBadgeViewAlignmentTopRight];
    badgeView.badgeText = @"123";
}


- (IBAction)onTapPushButton:(UIButton *)sender {
    SDPopViewController *popVc = [SDPopViewController new];
    [self.navigationController pushViewController:popVc animated:YES];
//    popVc.modalPresentationStyle = UIModalPresentationPageSheet;
//    popVc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:popVc
//                        animated:YES completion:nil];
}

- (IBAction)onTapPushToScrollViewButton:(id)sender {
    
    SDPagerController *pageVc = [SDPagerController new];
    
    [self.navigationController pushViewController:pageVc animated:YES];
}


@end

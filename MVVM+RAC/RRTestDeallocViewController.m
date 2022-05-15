//
//  RRTestDeallocViewController.m
//  MVVM+RAC
//
//  Created by sunchunlei on 2022/5/14.
//

#import "RRTestDeallocViewController.h"
#import "RRSearchViewController.h"


@interface RRTestDeallocViewController ()

@end

@implementation RRTestDeallocViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onShowVC:(id)sender {
    
    [self.navigationController pushViewController:RRSearchViewController.new animated:YES];
}

@end

//
//  RRTestSecondViewController.m
//  ChimeTest
//
//  Created by sunchunlei on 2023/8/28.
//

#import "RRTestSecondViewController.h"

@interface RRTestSecondViewController ()

@end

@implementation RRTestSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:(arc4random_uniform(255)/255.0)
                                                green:(arc4random_uniform(255)/255.0)
                                                 blue:(arc4random_uniform(255)/255.0)
                                                alpha:0.1];
    
    self.view.backgroundColor = [UIColor redColor];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

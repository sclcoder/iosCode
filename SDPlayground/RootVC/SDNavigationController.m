//
//  SDNavigationController.m
//  SDPlayground
//
//  Created by chunlei.sun on 2021/5/19.
//

#import "SDNavigationController.h"

#import "SDNavigationDelegate.h"

// iOS 视图控制器转场详解
// https://github.com/seedante/iOS-Note/wiki/ViewController-Transition

@interface SDNavigationController ()
@property (nonatomic, strong) SDNavigationDelegate *strongReferenceDelegate;
@end

@implementation SDNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /// 设置代理后,系统的交互效果失效
    self.strongReferenceDelegate = [SDNavigationDelegate new];
    self.delegate = self.strongReferenceDelegate;
}

#pragma mark - overwrite
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count != 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}



@end

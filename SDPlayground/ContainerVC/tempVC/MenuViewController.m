//
//  MenuViewController.m
//  FWSideMenu_OC
//
//  Created by xfg on 2018/4/11.
//  Copyright © 2018年 xfg. All rights reserved.
//

#import "MenuViewController.h"
#import "ListViewController.h"
#import <FWSideMenu/FWSideMenu-Swift.h>

@interface MenuViewController ()

@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    CGRect tmpFrame = self.view.frame;
    tmpFrame.size.height = [UIScreen mainScreen].bounds.size.height;
    self.view.frame = tmpFrame;
    
    self.titleArray = @[@"了解会员特权", @"QQ钱包", @"个性装扮", @"我的收藏", @"我的相册", @"我的文件", @"免流量特权免流量特权免流量特权免流量特权"];
    
    self.tableView.estimatedRowHeight = 44.0;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 需要容器VC重写相关方法 showViewController:sender:   showViewDetailController:sender方式跳转，
//    [self showDetailViewController:[ListViewController new] sender:nil];
//    [self showViewController:[ListViewController new] sender:nil];
    
    FWSideMenuContainerViewController *sideVc = [self getSideVC];
    UINavigationController *nav = nil;

    if ([sideVc.centerViewController isKindOfClass:[UITabBarController class]]) {

        id tmp = sideVc.childViewControllers[0];
        if ([tmp isKindOfClass:[UINavigationController class]]) {
            nav = (UINavigationController *)tmp;
        }

    } else if ([sideVc.centerViewController isKindOfClass:[UINavigationController class]]) {
        nav = (UINavigationController *)sideVc.centerViewController;
    }

    if (nav) {
        [nav pushViewController:[[ListViewController alloc] init] animated:YES];
    }

    [self.navigationController pushViewController:[[ListViewController alloc] init] animated:YES];

    [sideVc setSideMenuStateWithState:FWSideMenuStateClosed completeBlock:nil];


}

- (FWSideMenuContainerViewController *)getSideVC{
    UIViewController *sideVc = self;
    while (![sideVc isKindOfClass:[FWSideMenuContainerViewController class]]) {
        sideVc = sideVc.parentViewController;
    }
    return (FWSideMenuContainerViewController*)sideVc;
}

@end

//
//  RRTestViewController.m
//  ChimeTest
//
//  Created by chunlei.sun on 2023/8/24.
//

#import "RRTestViewController.h"
#import "RRTestSecondViewController.h"


#import "RRTabBarController.h"

@interface RRTestViewController ()<UIPopoverPresentationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *tagNameLabel;

@end

@implementation RRTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:(arc4random_uniform(255)/255.0)
                                                green:(arc4random_uniform(255)/255.0)
                                                 blue:(arc4random_uniform(255)/255.0)
                                                alpha:1];
    self.tagNameLabel.text = self.tagName;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    NSLog(@"RRTestViewController: %s",__func__);
}

//
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//
//    NSLog(@"RRTestViewController: %s",__func__);
//}
//
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//
//    NSLog(@"RRTestViewController: %s",__func__);
//}
//
//
//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//
//    NSLog(@"RRTestViewController: %s",__func__);
//}

- (IBAction)onTapTopBtn:(id)sender {
    
//    RRTestSecondViewController *testVC = [RRTestSecondViewController new];
//    testVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:testVC animated:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onTap:(id)sender {
    /**
     https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/PresentingaViewController.html#//apple_ref/doc/uid/TP40007457-CH14-SW1
     */
    

    
    
    RRTestViewController *testVC = [[RRTestViewController alloc] init];
    
    
//    testVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    testVC.modalPresentationStyle = UIModalPresentationFullScreen;
//

//
//    testVC.modalPresentationStyle = UIModalPresentationFormSheet;
//    testVC.modalPresentationStyle = UIModalPresentationPageSheet;


    
    
    //    testVC.preferredContentSize = CGSizeMake(400, 200);
    //    testVC.modalPresentationStyle = UIModalPresentationPopover;
    //    testVC.popoverPresentationController.delegate = self;
    //    testVC.popoverPresentationController.sourceView = self.button;
    //    testVC.popoverPresentationController.sourceRect = self.button.bounds;
    //    testVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionDown;
    //    testVC.popoverPresentationController.backgroundColor = [UIColor redColor];
    //    testVC.popoverPresentationController.canOverlapSourceViewRect = NO;
    //
    
    
    /**
        系统bug?, modal后再tab切换再切换回来，再执行dismiss, currentContext消失了。。。
     */
    //    testVC.modalPresentationStyle = UIModalPresentationCurrentContext;
        testVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self presentViewController:testVC animated:YES completion:^{

    }];
    
    
//    RRTabBarController *tabVC = [[RRTabBarController alloc] init];
//
//    UISheetPresentationControllerDetent *medium = [UISheetPresentationControllerDetent mediumDetent];
//    tabVC.sheetPresentationController.detents = @[medium];
//
//    [self presentViewController:tabVC animated:YES completion:^{
//
//    }];

}


#pragma mark - <UIPopoverPresentationControllerDelegate>
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    /// MARK: 更改popoverPresentationController适配的行为
    return UIModalPresentationNone;
}


@end

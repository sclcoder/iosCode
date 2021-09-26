//
//  SDAlertViewController.m
//  SDPlayground
//
//  Created by chunlei.sun on 2021/9/24.
//

#import "SDAlertViewController.h"
#import <LEEAlert/LEEAlert.h>
@interface SDAlertViewController ()

@end

@implementation SDAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)showAlert:(id)sender {
    // 添加设置的顺序决定了显示的顺序 可根据需要去调整
    [LEEAlert alert].config
    .LeeAddTextField(nil) // 如果不需要其他设置 也可以传入nil 输入框会按照默认样式显示
    .LeeContent(@"内容1")
    .LeeTitle(@"标题")
    .LeeContent(@"内容2")
    .LeeAddTextField(^(UITextField *textField) {
        
        textField.placeholder = @"输入框2";
    })
    .LeeAction(@"好的", nil)
    .LeeCancelAction(@"取消", nil)
    .LeeShow();
}

- (IBAction)showActionSheet:(id)sender {
    
}


@end

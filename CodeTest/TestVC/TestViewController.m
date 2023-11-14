//
//  TestViewController.m
//  CodeTest
//
//  Created by chunlei.sun on 2023/11/14.
//

#import "TestViewController.h"

@interface TestViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_textField addTarget:self action:@selector(editingDidBegin) forControlEvents:UIControlEventEditingDidBegin];
}

- (void)editingDidBegin{
    
    /**
     在视图生命周期中的某些时刻，UITextField 可能还没有准备好接受文本输入，或者布局还没有完成，导致无法确保将光标移动到末尾。
     另一种尝试的方法是延迟执行将光标移到末尾的操作，让界面有更多时间准备好。你可以尝试在稍后的运行循环中执行这个操作，例如使用 GCD 的 DispatchQueue.main.async：
     */
    dispatch_async(dispatch_get_main_queue(), ^{
        UITextPosition *position = [_textField endOfDocument];
        _textField.selectedTextRange = [_textField textRangeFromPosition:position toPosition:position];
    });
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textField resignFirstResponder];
}


@end

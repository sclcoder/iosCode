//
//  TestView.m
//  RAC_Play
//
//  Created by chunlei.sun on 2022/1/7.
//

#import "TestView.h"

@interface TestView ()


@end

@implementation TestView

- (RACSubject *)btnClickSignal{
    if (_btnClickSignal == nil) {
        _btnClickSignal = [[RACSubject alloc] init];
    }
    return _btnClickSignal;
}



- (IBAction)onButtonTap:(id)sender {
    NSLog(@"%s",__func__);
    [self.btnClickSignal sendNext:@"可以代替代理"];
}

@end

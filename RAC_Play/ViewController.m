//
//  ViewController.m
//  RAC_Play
//
//  Created by chunlei.sun on 2022/1/4.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface ViewController ()
@property (nonatomic, strong) NSObject<RACSubscriber> *subscriber;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
}

- (IBAction)test_signal{
    
    RACSignal *singal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
      
        NSLog(@"发送信号");
        [subscriber sendNext:@"I'm a signal"];
        // 强引用一下
        self.subscriber = subscriber;
        
        // [subscriber sendCompleted]; // 会触发dispose
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"dispose");
        }];
    }];
    
    NSLog(@"订阅信号");
    RACDisposable *disposable = [singal subscribeNext:^(id  _Nullable x) {
        NSLog(@"收到信号值:%@",x);
    }];
    
    [disposable dispose];
}

- (IBAction)test_subject{
    
    RACSubject *subject = [RACSubject subject];
    [subject sendNext:@"发送信号"];
    
    [subject subscribeNext:^(id  _Nullable x) {
        
    }];
}

- (IBAction)test_replaySubject{
    
}

- (IBAction)test_connect{
    
}

@end

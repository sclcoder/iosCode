//
//  ViewController.m
//  RAC_Play
//
//  Created by chunlei.sun on 2022/1/4.
//

#import "ViewController.h"
#import "TestView.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface ViewController ()
@property (nonatomic, strong) NSObject<RACSubscriber> *subscriber;

@property (weak, nonatomic) IBOutlet TestView *redView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test_use];
}


# pragma mark - 基本使用

- (void)test_use{
    /// 监听方法，并且可以通过元组把参数传出
    [[self.redView rac_signalForSelector:@selector(onButtonTap:)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"%@",x);
    }];
    
}

# pragma mark - 信号的基本原理
- (IBAction)test_signal{
    
    RACSignal *singal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@"I'm a signal - signal"];
        // 强引用一下
        self.subscriber = subscriber;
//         [subscriber sendCompleted]; // 会触发dispose
        RACDisposable *innerDisposable = [RACDisposable disposableWithBlock:^{
            NSLog(@"innerDisposable disposed callBack");
        }];
        return innerDisposable;
    }];
    
    [singal subscribeNext:^(id  _Nullable x) {
        NSLog(@"收到信号值:%@",x);
    }];
    
//    NSLog(@"disposable: %@",disposable);
    
//    [disposable dispose];
}

- (IBAction)test_subject{
    
    RACSubject *subject = [RACSubject subject];
    
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@"I'm a signal - subject"];
    
    // [subject sendCompleted]; // 触发disposable
}

- (IBAction)test_replaySubject{
    
    RACReplaySubject *replay = [RACReplaySubject subject];
    
    [replay sendNext:@"I'm a signal - replay"];
    
    [replay subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [replay sendCompleted];
}



@end

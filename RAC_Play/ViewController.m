//
//  ViewController.m
//  RAC_Play
//
//  Created by chunlei.sun on 2022/1/4.
//

#import "ViewController.h"
#import "TestView.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/RACReturnSignal.h>

#import "NSObject+RACKVOWrapper.h"
@interface ViewController ()
@property (nonatomic, strong) NSObject<RACSubscriber> *subscriber;
@property (weak, nonatomic) IBOutlet UIStackView *stackView1;
@property (weak, nonatomic) IBOutlet UIStackView *stackView2;
@property (weak, nonatomic) IBOutlet UIStackView *stackView3;
@property (weak, nonatomic) IBOutlet UIStackView *stackView4;


@property (weak, nonatomic) IBOutlet TestView *redView;

@property (weak, nonatomic) IBOutlet UIButton *blueBtn;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;


@property (weak, nonatomic) IBOutlet UIButton *connect;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self test_kvo];
//
//    [self test_event];
//
//    [self test_notification];
    
//    [self test_textSingal];
    
//    [self test_selector];
    
    [self demo_flatten];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textField resignFirstResponder];
    [self.textView resignFirstResponder];

}

- (void)demo_flatten{
    RACSignal *signalA1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
         [subscriber sendNext:@1];
         [subscriber sendNext:@2];
         [subscriber sendNext:@3];
         [subscriber sendNext:@4];

        [RACScheduler.scheduler afterDelay:1 schedule:^{
            [subscriber sendNext:@5];
            [subscriber sendCompleted];
        }];
         return [RACDisposable disposableWithBlock:^{
             NSLog(@"signalA1完成");
         }];
     }];
    
    signalA1.name = @"signalA1";

     RACSignal *signalA2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
         [subscriber sendNext:@"a"];
         [subscriber sendNext:@"b"];
         [subscriber sendNext:@"c"];
         [subscriber sendNext:@"d"];
         
         [RACScheduler.scheduler afterDelay:2 schedule:^{
             [subscriber sendNext:@"e"];
             [subscriber sendCompleted];
         }];

         return [RACDisposable disposableWithBlock:^{
             NSLog(@"signalA2完成");
         }];
     }];
    signalA2.name = @"signalA2";


     RACSignal *signalB1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
         [subscriber sendNext:signalA1];
         [subscriber sendNext:signalA2];
         [subscriber sendCompleted];
         return [RACDisposable disposableWithBlock:^{
             NSLog(@"signalB1完成");
         }];
     }];
    
    signalB1.name = @"signalB1";

    

     RACSignal *signalD = [signalB1 flatten];
    signalD.name = @"signalD";
    // 该方法的作用时，同时最多同时执行2个信号，也就是可以解决最大并发量的问题。处理排队，重新添加。
//       RACSignal *signalD = [signalB1 flatten:2];
    
    // 信号串行，信号1执行完之后，继续执行下一个信号。
//       RACSignal *signalD = [signalB1 flatten:1];
     [[signalD subscribeNext:^(id x) {
         NSLog(@"subscribeNext:%@",x);
     }] dispose];



//   RACSignal *signalA2 = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//     [subscriber sendNext:@"a"];
//     [subscriber sendNext:@"b"];
//     [subscriber sendNext:@"c"];
//     [subscriber sendNext:@"d"];
//     [subscriber sendNext:@"e"];
//     [subscriber sendCompleted];
//     return [RACDisposable disposableWithBlock:^{
//         NSLog(@"signalA2完成");
//     }];
//   }] delay:0.5];
   // 这样写会阻塞主线程、如果先dispose之后，则剩余的信号则不再执行。
}


# pragma mark - Command

- (IBAction)onCommand:(id)sender {

//    RACCommand *command = [[RACCommand alloc] initWithEnabled:[RACReturnSignal return:@(YES)] signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//
//        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//            [subscriber sendNext:@"I'm a signal in command"];
//            [subscriber sendCompleted];
//
//            return [RACDisposable disposableWithBlock:^{
//                NSLog(@"signal in command disposable");
//            }];
//        }];
//    }];
//
//
////    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
////        NSLog(@"receive value %@",x);
////    }];
//
//    [command.executionSignals subscribeNext:^(id  _Nullable x) {
//        NSLog(@"receive value:  %@",x);
//    }];
//
//    [command execute:@"execute"];
    
//
//    RACSubject *signalOfsignals = [RACSubject subject];
//    [signalOfsignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
//
//    RACSubject *signalA = [RACSubject subject];
//
//    [signalA subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
//
//    [signalA sendNext:@"signalA"];
//
//    [signalOfsignals sendNext:signalA];
    
    
    
    RACSignal *signalA = @[@1, @2, @3].rac_sequence.signal;
    RACSignal *signalB = @[@4, @6, @7].rac_sequence.signal;
    
    RACSignal *signalC = [signalA combineLatestWith:signalB];
    
    [signalC subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
    }];
    
    
    RACSignal *signalD = [signalA sample:signalB];
    
    [signalD subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

# pragma mark - 进阶

- (IBAction)map:(id)sender {
    
    /// 1.创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        /// 4.发送信号
        [subscriber sendNext:@"I'm a signal!!!"];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"dispose");
        }];
    }];
    
    RACSignal *mapSignal = [signal map:^id _Nullable(id  _Nullable value) {
        return [NSString stringWithFormat:@"%@ 6666",value];
    }];
    
    [mapSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}


- (IBAction)bind:(id)sender {
    /// 1.创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        /// 4.发送信号
        [subscriber sendNext:@"I'm a signal!!!"];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"dispose");
        }];
    }];
    
    /// 2.绑定源信号，生成绑定信号
    /**
     bind操作方法实质上就是生成新的绑定信号，利用returnSignal作为中间信号来改变源数据生成新的数据并执行新绑定信号的nextBlock代码块！
     */
    RACSignal *bindSignal = [signal bind:^RACSignalBindBlock{
        return ^RACSignal *(id value, BOOL *stop){
            NSLog(@"%@",value);
            return [RACReturnSignal return:[NSString stringWithFormat:@"%@ - 12345",value]];
        };
    }];
    
    /// 3.订阅绑定信号 : 该信号被订阅后,会触发源信号被订阅
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"bindSignal : %@",x);
    }];
}

- (IBAction)connect:(id)sender {
    
    RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送网络请求");
        [subscriber sendNext:@"得到网络请求数据"];
        return nil;
    }];
    
    /// RACMulticastConnection这个类了，RACMulticastConnection其实是一个连接类，
    /// 连接类的意思就是当一个信号被多次订阅，他可以帮我们避免多次调用创建信号中的block

    /// connect 会创建一个RACSubject信号设置给signal RACSignal设置给sourceSignal
    RACMulticastConnection *connect = [signal publish];
    /// 订阅是RACSubject信号
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"1 - %@",x);
    }];

    [connect.signal subscribeNext:^(id x) {
        NSLog(@"2 - %@",x);
    }];

    [connect.signal subscribeNext:^(id x) {
        NSLog(@"3 - %@",x);
    }];
    
    /// sourceSignal(RACSignal)会被signal信号订阅,并且signal被直接作为subscriber传入(RACSubject可以作为订阅者).
    [connect connect];
}

# pragma mark - 基本使用

- (void)test_textSingal{
    
    [[self.textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
    }];

    [[self.textView rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    } completed:^{
    }];
    
    RAC(self.showLabel,text) = self.textField.rac_textSignal;
}

- (void)test_notification{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"%@",x);
    }];
}

- (void)test_event{
    
    [[self.blueBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"%@",x);
    }];
    
}

- (void)test_kvo{
    
    /// 1.监听方法，并且可以通过元组把参数传出
    [[self.redView rac_signalForSelector:@selector(onButtonTap:)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"%@",x);
        self.stackView1.backgroundColor = [UIColor redColor];
        self.stackView2.backgroundColor = [UIColor yellowColor];
        self.stackView3.backgroundColor = [UIColor grayColor];
    }];
    
    /// 2.KVO
    [self.stackView1 rac_observeKeyPath:@"backgroundColor" options:NSKeyValueObservingOptionNew observer:nil block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        NSLog(@"KVO_1 - %@",value);
    }];
    
    /// 程序运行的时候就会监听到
    [[self.stackView2 rac_valuesForKeyPath:@"backgroundColor" observer:nil] subscribeNext:^(id  _Nullable x) {
        NSLog(@"KVO_2 - %@",x);
    }];

    [RACObserve(self.stackView3, backgroundColor) subscribeNext:^(id  _Nullable x) {
        NSLog(@"KVO_3 - %@",x);
    }];

}

- (void)test_selector{
    /// 1.监听方法，并且可以通过元组把参数传出
    [[self.redView rac_signalForSelector:@selector(onButtonTap:)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [self.redView.btnClickSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

# pragma mark - 信号的基本原理
- (IBAction)test_signal{
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@"I'm a signal - signal"];
        // 强引用一下
        self.subscriber = subscriber;
//         [subscriber sendCompleted]; // 会触发dispose
        RACDisposable *innerDisposable = [RACDisposable disposableWithBlock:^{
            NSLog(@"innerDisposable disposed callBack");
        }];
        return innerDisposable;
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
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
    
    [replay sendNext:@"I'm a signal - replay1"];
    [replay sendNext:@"I'm a signal - replay2"];

    [replay subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [replay sendCompleted];
}



@end

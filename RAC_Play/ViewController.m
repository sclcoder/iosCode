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

#import "NSObject+Calculator.h"

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
    
    [self testChianPR];

//    [self test_subject];
    
//    [self test_kvo];
//
//    [self test_event];
//
//    [self test_notification];
    
//    [self test_textSingal];
    
//    [self test_selector];
    
//    [self demo_flatten];
}

- (void)testChianPR{
    
    int result = [NSObject makeCalculate:^(CalculateMaker * _Nonnull make) {
        make.add(10).sub(20).muilt(100).divide(4);
    }];
    
    NSLog(@"%d",result);
}



/// https://juejin.cn/post/6844903574690856968 RAC使用总结

/// concat
- (void)demo6{
    
    //创建一个信号管A
    RACSignal *siganlA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"吃饭"];
        RACSignal *siganl = [RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]];
        [siganl subscribeNext:^(id x) {
            [subscriber sendNext:@"1秒我就吃完了"];
            [subscriber sendCompleted];
        }];
        return nil;
        
    }];
    
    //创建一个信号管B
    RACSignal *siganlB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        [subscriber sendNext:@"睡觉"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    //串联管A和管B
    RACSignal *concatSiganl = [siganlA concat:siganlB];
    //串联后的接收端处理 ,两个事件,走两次,第一个打印siggnalA的结果,第二次打印siganlB的结果
    [concatSiganl subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

// merge
- (void)demo7{
  //创建信号A
    RACSignal *siganlA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"烧水"];
        RACSignal *intervalSignal = [RACSignal interval:1.5 onScheduler:RACScheduler.mainThreadScheduler];
        [intervalSignal subscribeNext:^(id  _Nullable x) {
            [subscriber sendNext:@"喝茶"];
            [subscriber sendCompleted];

        }];
        return nil;
    }];
    
    //创建信号B
    RACSignal *siganlB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        [subscriber sendNext:@"做饭"];
        RACSignal *intervalSignal = [RACSignal interval:1 onScheduler:RACScheduler.mainThreadScheduler];
        [intervalSignal subscribeNext:^(id  _Nullable x) {
            [subscriber sendNext:@"吃饭"];
            [subscriber sendCompleted];

        }];
        return nil;
    }];
    
    //并联两个信号,根上面一样,分两次打印
    RACSignal *mergeSiganl = [RACSignal merge:@[siganlA,siganlB]];
    [mergeSiganl subscribeNext:^(id x) {
       
        NSLog(@"%@",x);
        
    }];
    
}

/// combineLatest : 组合,只有两个信号都有值,才可以组合 ？？？？？
- (void)demo8{
    //定义2个自定义信号
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    
    //组合信号
    [[RACSignal combineLatest:@[letters,numbers] reduce:^(NSString *letter, NSString *number){
        
        return [letter stringByAppendingString:number];
    }] subscribeNext:^(id x) {
        NSLog(@"%@",x);
        
    }];

    //自己控制发生信号值
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];
    [numbers sendNext:@"1"]; //打印B1
    [letters sendNext:@"C"];//打印C1
    [numbers sendNext:@"2"];//打印C2
}

/// 合流压缩
- (void)demo9{
    
    //创建信号A
    RACSignal *siganlA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        [subscriber sendNext:@"红"];
        RACSignal *intervalSignal = [RACSignal interval:1 onScheduler:RACScheduler.mainThreadScheduler];
        [intervalSignal subscribeNext:^(id  _Nullable x) {
            [subscriber sendNext:@"蓝"];
            [subscriber sendNext:@"黑"];

            [subscriber sendCompleted];
        }];
        return nil;
    }];
    
    //创建信号B
    RACSignal *siganlB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        [subscriber sendNext:@"白"];
        RACSignal *intervalSignal = [RACSignal interval:1.5 onScheduler:RACScheduler.mainThreadScheduler];
        [intervalSignal subscribeNext:^(id  _Nullable x) {
            [subscriber sendNext:@"绿"];
            [subscriber sendCompleted];
        }];

        return nil;
    }];
    
    //合流后处理的是压缩包,需要解压后才能取到里面的值
    [[siganlA zipWith:siganlB] subscribeNext:^(id x) {
       
        //解压缩
        RACTupleUnpack(NSString *stringA, NSString *stringB) = x;
        NSLog(@"%@ %@",stringA, stringB);
    }];
    
}

/// map
- (void)demo10{
    RACSignal *siganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"石"];
        [subscriber sendNext:@"器"];
        [subscriber sendCompleted];
        return nil;
    }];
    //对信号进行改造,改"石"成"金"
    siganl = [siganl map:^id(NSString *value) {
        if ([value isEqualToString:@"石"]) {
            return @"金";
        }
        return value;
        
    }];
    
    //打印,不论信号发送的是什么,这一步都会走的
    [siganl subscribeNext:^(id x) {
        NSLog(@"%@",x);
        
    }];
    
}

/// filter
- (void)demo11{
    RACSignal *singal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        [subscriber sendNext:@(15)];
        [subscriber sendNext:@(17)];
        [subscriber sendNext:@(21)];
        [subscriber sendNext:@(14)];
        [subscriber sendNext:@(30)];
        
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    //过滤信号,打印
    [[singal filter:^BOOL(NSNumber *value) {
        
        //大于18岁的,才可以通过
        return value.integerValue >= 18;//return为yes可以通过
        
    }] subscribeNext:^(id x) {
        NSLog(@"%@",x);
        
    }];
    
}

-(void)demo12{
    
    RACSignal *siganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"打蛋液");
        [subscriber sendNext:@"蛋液"];
        [subscriber sendCompleted];
        return nil;
        
    }];
    
    //对信号进行秩序秩序的第一步
    siganl = [siganl flattenMap:^RACSignal *(NSString *value) {
        //处理上一步的RACSiganl的信号value.这里的value=@"蛋液"
        NSLog(@"把%@倒进锅里面煎",value);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"煎蛋"];
            [subscriber sendCompleted];
            return nil;
            
        }];
        
    }];
    //对信号进行第二步处理
    siganl = [siganl flattenMap:^RACSignal *(id value) {
        NSLog(@"把%@装载盘里",value);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"上菜"];
            [subscriber sendCompleted];
            return nil;
        }];
        
    }];
    
    //最后打印 最后带有===上菜
    [siganl subscribeNext:^(id x) {
        NSLog(@"====%@",x);
    }];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textField resignFirstResponder];
    [self.textView resignFirstResponder];
    
    [self demo12];
}

///
- (void)demo20{
    RACSignal *takeSiganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
      //创建一个定时器信号,每一秒触发一次
        RACSignal *siganl = [RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]];
        [siganl subscribeNext:^(id x) {
          //在这里定时发送next玻璃球
            [subscriber sendNext:@"直到世界尽头"];
        }];
        return nil;
    }];

    //创建条件信号
    RACSignal *conditionSiganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
      //设置5s后发生complete玻璃球
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"世界的今天到了,请下车");
            [subscriber sendCompleted];
        });
        return nil;
    }];
   
    //设置条件,takeSiganl信号在conditionSignal信号接收完成前,不断取值
    [[takeSiganl takeUntil:conditionSiganl] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}



# pragma 高阶信号操作
- (void)test_signalOfSignal{
     
    RACSubject *signalofsignal = [RACSubject subject];
    signalofsignal.name = @"signalofsignal";
    RACSubject *signal1 = [RACSubject subject];
    signal1.name  = @"signal1";
    RACSubject *signal2 = [RACSubject subject];
    RACSubject *signal3 = [RACSubject subject];
    RACSubject *signal4 = [RACSubject subject];
    
//    [signalofsignal subscribeNext:^(id  _Nullable x) {
//
//        NSLog(@"%@",x);
//
//        [x subscribeNext:^(id  _Nullable x) {
//            NSLog(@"%@",x);
//        }];
//    }];
    
    
    [signalofsignal.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];

    [signalofsignal sendNext:signal2];
    [signal2 sendNext:@"2"];
    
    
    [signalofsignal sendNext:signal1];
    //    [signal1 sendNext:@"1"];
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
    
    [signal subscribeError:^(NSError * _Nullable error) {
        NSLog(@"收到error:%@",error);
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

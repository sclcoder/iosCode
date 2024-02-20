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
#import "Calculator.h"

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




@property(nonatomic,strong) RACCommand *command;

@property (weak, nonatomic) IBOutlet UIButton *commandBtn;

@end

@implementation ViewController

/**
    RAC 更高维度的分析\源码分析
 https://github.com/halfrost/Halfrost-Field/tree/master/contents/iOS/RAC
 */


- (void)testChianPR{
    
    int result = [NSObject makeCalculate:^(CalculateMaker * _Nonnull make) {
        make.add(10).sub(20).muilt(100).divide(4);
    }];
    
    NSLog(@"%d",result);
}

- (void)testFunctionPR{
    
    Calculator *calculator = [[Calculator alloc] init];
    BOOL isEqual = [[[calculator calculator:^int(int result) {
                result += 10;
                result *= 10;
                result /= 4;
                return result;
        }] equal:^BOOL(int result) {
            NSLog(@"result:%d",result);
            return result == 25;
        }] isEqual] ;
    
    NSLog(@"%d",isEqual);
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self testChianPR];
//
//    [self testFunctionPR];

//    [self test_subject];
    
//    [self test_kvo];
//
//    [self test_event];
//
//    [self test_notification];
    
//    [self test_textSingal];
    
//    [self test_selector];
    
    [self demo7];
    
    
    
    
    
//    [self test_bind];
//    [self test_flattenMap];
//    [self test_map];
//    [self test_signalOfSignal];
    
//    [self test_concat];
    
//    [self test_then];

//    [self test_merge];
    
//    [self test_zipWith];
    
    
//    [self testSwitchToLatest];
    
//    [self testCommand];
//    [self testCommand1];
//    [self testCommand2];
    
    
//    [self testThrottle];

}


/*************************** 最快上手RAC  ******************************/

/**
 作者：袁峥
 链接：https://www.jianshu.com/p/e10e5ca413b7
 来源：简书
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */



/****************    RAC基础篇      ***************/

/**
 RACSiganl:信号类,一般表示将来有数据传递，只要有数据改变，信号内部接收到数据，就会马上发出数据。
 注意：
 信号类(RACSiganl)，只是表示当数据改变时，信号内部会发出数据，它本身不具备发送信号的能力，而是交给内部一个订阅者去发出。
 默认一个信号都是冷信号，也就是值改变了，也不会触发，只有订阅了这个信号，这个信号才会变为热信号，值改变了才会触发。
 如何订阅信号：调用信号RACSignal的subscribeNext就能订阅。
 
 RACSubscriber:表示订阅者的意思，用于发送信号，这是一个协议，不是一个类，只要遵守这个协议，并且实现方法才能成为订阅者。通过create创建的信号，都有一个订阅者，帮助他发送数据。

 6.3 RACDisposable:用于取消订阅或者清理资源，当信号发送完成或者发送错误的时候，就会自动触发它。
 使用场景:不想监听某个信号时，可以通过它主动取消订阅信号。

 */

- (void)testSignal{

    // RACSignal使用步骤：
    // 1.创建信号 + (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
    // 2.订阅信号,才会激活信号. - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 3.发送信号 - (void)sendNext:(id)value


    // RACSignal底层实现：
    // 1.创建信号，首先把didSubscribe保存到信号中，还不会触发。
    // 2.当信号被订阅，也就是调用signal的subscribeNext:nextBlock
    // 2.2 subscribeNext内部会创建订阅者subscriber，并且把nextBlock保存到subscriber中。
    // 2.1 subscribeNext内部会调用siganl的didSubscribe
    // 3.siganl的didSubscribe中调用[subscriber sendNext:@1];
    // 3.1 sendNext底层其实就是执行subscriber的nextBlock

    // 1.创建信号
    RACSignal *siganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        // block调用时刻：每当有订阅者订阅信号，就会调用block。
        
        // 2.发送信号
        [subscriber sendNext:@1];
        
        // 如果不在发送数据，最好发送信号完成，内部会自动调用[RACDisposable disposable]取消订阅信号。
        [subscriber sendCompleted];

        return [RACDisposable disposableWithBlock:^{
            
            // block调用时刻：当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。
            
            // 执行完Block后，当前信号就不在被订阅了。
            
            NSLog(@"信号被销毁");
            
        }];
    }];

    // 3.订阅信号,才会激活信号.
    [siganl subscribeNext:^(id x) {
        // block调用时刻：每当有信号发出数据，就会调用block.
        NSLog(@"接收到数据:%@",x);
    }];

}



/**
 RACSubject:RACSubject:信号提供者，自己可以充当信号，又能发送信号。
 使用场景:通常用来代替代理，有了它，就不必要定义代理了。
 
 */
- (void)testSubject{
    // RACSubject使用步骤
    // 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
    // 2.订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 3.发送信号 sendNext:(id)value

    // RACSubject:底层实现和RACSignal不一样。
    // 1.调用subscribeNext订阅信号，只是把订阅者保存起来，并且订阅者的nextBlock已经赋值了。
    // 2.调用sendNext发送信号，遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。
    
    // 1.创建信号
      RACSubject *subject = [RACSubject subject];

      // 2.订阅信号
      [subject subscribeNext:^(id x) {
          // block调用时刻：当信号发出新值，就会调用.
          NSLog(@"第一个订阅者%@",x);
      }];
      [subject subscribeNext:^(id x) {
          // block调用时刻：当信号发出新值，就会调用.
          NSLog(@"第二个订阅者%@",x);
      }];

      // 3.发送信号
      [subject sendNext:@"1"];
}

/**
 RACReplaySubject:重复提供信号类，RACSubject的子类。
 
 RACReplaySubject与RACSubject区别:
 RACReplaySubject可以先发送信号，在订阅信号，RACSubject就不可以。
 
 使用场景一:如果一个信号每被订阅一次，就需要把之前的值重复发送一遍，使用重复提供信号类。
 使用场景二:可以设置capacity数量来限制缓存的value的数量,即只缓充最新的几个值。
 */
- (void)testReplaySubject{

    // RACReplaySubject:底层实现和RACSubject不一样。
    // 1.调用sendNext发送信号，把值保存起来，然后遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。
    // 2.调用subscribeNext订阅信号，遍历保存的所有值，一个一个调用订阅者的nextBlock

    // 如果想当一个信号被订阅，就重复播放之前所有值，需要先发送信号，在订阅信号。
    // 也就是先保存值，在订阅值。

    // 1.创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject subject];

    // 2.发送信号
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];

    // 3.订阅信号
    [replaySubject subscribeNext:^(id x) {
        NSLog(@"第一个订阅者接收到的数据%@",x);
    }];

    // 订阅信号
    [replaySubject subscribeNext:^(id x) {
        NSLog(@"第二个订阅者接收到的数据%@",x);
    }];
}


/**
 RACMulticastConnection:用于当一个信号，被多次订阅时，为了保证创建信号时，避免多次调用创建信号中的block，造成副作用，可以使用这个类处理。
 使用注意:RACMulticastConnection通过RACSignal的-publish或者-muticast:方法创建.
 RACMulticastConnection简单使用:
 
 sourceSignal只有内部的RACSubject一个订阅者
 */
- (void)testMuticastConnection{

    // RACMulticastConnection使用步骤:
    // 1.创建信号 + (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
    // 2.创建连接 RACMulticastConnection *connect = [signal publish];
    // 3.订阅信号,注意：订阅的不在是之前的信号，而是连接的信号。 [connect.signal subscribeNext:nextBlock]
    // 4.连接 [connect connect]
    
    // RACMulticastConnection底层原理:
    // 1.创建connect，connect.sourceSignal -> RACSignal(原始信号)  connect.signal -> RACSubject
    // 2.订阅connect.signal，会调用RACSubject的subscribeNext，创建订阅者，而且把订阅者保存起来，不会执行block。
    // 3.[connect connect]内部会订阅RACSignal(原始信号)，并且订阅者是RACSubject
    // 3.1.订阅原始信号，就会调用原始信号中的didSubscribe
    // 3.2 didSubscribe，拿到订阅者调用sendNext，其实是调用RACSubject的sendNext
    // 4.RACSubject的sendNext,会遍历RACSubject所有订阅者发送信号。
    // 4.1 因为刚刚第二步，都是在订阅RACSubject，因此会拿到第二步所有的订阅者，调用他们的nextBlock

    
    // 需求：假设在一个信号中发送请求，每次订阅一次都会发送请求，这样就会导致多次请求。
    // 解决：使用RACMulticastConnection就能解决.
    
    // 1.创建请求信号
   RACSignal *signal1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送请求");
        return nil;
    }];
    // 2.订阅信号
    [signal1 subscribeNext:^(id x) {
        NSLog(@"接收数据");
    }];
    // 2.订阅信号
    [signal1 subscribeNext:^(id x) {
        NSLog(@"接收数据");
        
    }];
    
    // 3.运行结果，会执行两遍发送请求，也就是每次订阅都会发送一次请求
    
    
    
    // RACMulticastConnection:解决重复请求问题
    // 1.创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送请求");
        [subscriber sendNext:@1];
        
        return nil;
    }];
    
    // 2.创建连接
    RACMulticastConnection *connect = [signal publish];
    
    // 3.订阅信号，
    // 注意：订阅信号，也不能激活信号，只是保存订阅者到数组，必须通过连接,当调用连接，就会一次性调用所有订阅者的sendNext:
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"订阅者一信号");
    }];
    
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"订阅者二信号");
    }];
    
    // 4.连接,激活信号
    [connect connect];
}




/**
    RACTuple:元组类,类似NSArray,用来包装值.
    RACSequence:RAC中的集合类，用于代替NSArray,NSDictionary,可以使用它来快速遍历数组和字典。

 使用场景：1.字典转模型
 RACSequence和RACTuple简单使用
 */

- (void)testSequenceAndtuple{
    
    // 1.遍历数组
    NSArray *numbers = @[@1,@2,@3,@4];
    
    // 这里其实是三步
    // 第一步: 把数组转换成集合RACSequence numbers.rac_sequence
    // 第二步: 把集合RACSequence转换RACSignal信号类,numbers.rac_sequence.signal
    // 第三步: 订阅信号，激活信号，会自动把集合中的所有值，遍历出来。
    [numbers.rac_sequence.signal subscribeNext:^(id x) {
       
        NSLog(@"%@",x);
    }];
    
    
    // 2.遍历字典,遍历出来的键值对会包装成RACTuple(元组对象)
    NSDictionary *dict = @{@"name":@"xmg",@"age":@18};
    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
       
        // 解包元组，会把元组的值，按顺序给参数里面的变量赋值
        RACTupleUnpack(NSString *key,NSString *value) = x;
        
        // 相当于以下写法
//        NSString *key = x[0];
//        NSString *value = x[1];
        
        NSLog(@"%@ %@",key,value);
        
    }];
    
    
//    // 3.字典转模型
//    // 3.1 OC写法
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
//
//    NSArray *dictArr = [NSArray arrayWithContentsOfFile:filePath];
//
//    NSMutableArray *items = [NSMutableArray array];
//
//    for (NSDictionary *dict in dictArr) {
//        FlagItem *item = [FlagItem flagWithDict:dict];
//        [items addObject:item];
//    }
//
//    // 3.2 RAC写法
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
//
//    NSArray *dictArr = [NSArray arrayWithContentsOfFile:filePath];
//
//    NSMutableArray *flags = [NSMutableArray array];
//
//    _flags = flags;
//
//    // rac_sequence注意点：调用subscribeNext，并不会马上执行nextBlock，而是会等一会。
//    [dictArr.rac_sequence.signal subscribeNext:^(id x) {
//        // 运用RAC遍历字典，x：字典
//
//        FlagItem *item = [FlagItem flagWithDict:x];
//
//        [flags addObject:item];
//
//    }];
//
//    NSLog(@"%@",  NSStringFromCGRect([UIScreen mainScreen].bounds));
//
//
//    // 3.3 RAC高级写法:
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
//
//    NSArray *dictArr = [NSArray arrayWithContentsOfFile:filePath];
//    // map:映射的意思，目的：把原始值value映射成一个新值
//    // array: 把集合转换成数组
//    // 底层实现：当信号被订阅，会遍历集合中的原始值，映射成新值，并且保存到新的数组里。
//    NSArray *flags = [[dictArr.rac_sequence map:^id(id value) {
//
//        return [FlagItem flagWithDict:value];
//
//    }] array];

}



/**
 RACCommand:RAC中用于处理事件的类，可以把事件如何处理,事件中的数据如何传递，包装到这个类中，他可以很方便的监控事件的执行过程。
 使用场景:监听按钮点击，网络请求
 RACCommand简单使用
 */
- (void)testCommand{
    
       // 一、RACCommand使用步骤:
       // 1.创建命令 initWithSignalBlock:(RACSignal * (^)(id input))signalBlock
       // 2.在signalBlock中，创建RACSignal，并且作为signalBlock的返回值
       // 3.执行命令 - (RACSignal *)execute:(id)input
       
       // 二、RACCommand使用注意:
       // 1.signalBlock必须要返回一个信号，不能传nil.
       // 2.如果不想要传递信号，直接创建空的信号[RACSignal empty];
       // 3.RACCommand中信号如果数据传递完，必须调用[subscriber sendCompleted]，这时命令才会执行完毕，否则永远处于执行中。
       // 4.RACCommand需要被强引用，否则接收不到RACCommand中的信号，因此RACCommand中的信号是延迟发送的。
       
       // 三、RACCommand设计思想：内部signalBlock为什么要返回一个信号，这个信号有什么用。
       // 1.在RAC开发中，通常会把网络请求封装到RACCommand，直接执行某个RACCommand就能发送请求。
       // 2.当RACCommand内部请求到数据的时候，需要把请求的数据传递给外界，这时候就需要通过signalBlock返回的信号传递了。
       
       // 四、如何拿到RACCommand中返回信号发出的数据。
       // 1.RACCommand有个执行信号源executionSignals，这个是signal of signals(信号的信号),意思是信号发出的数据是信号，不是普通的类型。
       // 2.订阅executionSignals就能拿到RACCommand中返回的信号，然后订阅signalBlock返回的信号，就能获取发出的值。
       
       // 五、监听当前命令是否正在执行executing
       
       // 六、使用场景,监听按钮点击，网络请求


       // 1.创建命令
       RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
           
           NSLog(@"执行命令");
           // 创建空信号,必须返回信号
           //        return [RACSignal empty];
           
           // 2.创建信号,用来传递数据
           return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
               
               [subscriber sendNext:@"请求数据"];
               
               // 注意：数据传递完，最好调用sendCompleted，这时命令才执行完毕。
               [subscriber sendCompleted];
               
               return nil;
           }];
           
       }];
       
       // 强引用命令，不要被销毁，否则接收不到数据
        _command = command;
       
       // 3.订阅RACCommand中的信号
       [command.executionSignals subscribeNext:^(id x) {
           
           [x subscribeNext:^(id x) {
               
               NSLog(@"%@",x);
           }];
           
       }];
       
       // RAC高级用法
       // switchToLatest:用于signal of signals，获取signal of signals发出的最新信号,也就是可以直接拿到RACCommand中的信号
       [command.executionSignals.switchToLatest subscribeNext:^(id x) {
           NSLog(@"%@",x);
       }];
       
       // 4.监听命令是否执行完毕,默认会来一次，可以直接跳过，skip表示跳过第一次信号。
       [[command.executing skip:1] subscribeNext:^(id x) {
           
           if ([x boolValue] == YES) {
               // 正在执行
               NSLog(@"正在执行");
           }else{
               // 执行完成
               NSLog(@"执行完成");
           }
           
       }];
      // 5.执行命令
       [self.command execute:@1];
}

/**
    RACScheduler:RAC中的队列，用GCD封装的。

    RACUnit :表⽰stream不包含有意义的值,也就是看到这个，可以直接理解为nil.

    RACEvent: 把数据包装成信号事件(signal event)。它主要通过RACSignal的-materialize来使用，然并卵。
 */


/**
 ReactiveCocoa开发中常见用法。
 7.1 代替代理:

 rac_signalForSelector：用于替代代理。
 
 
 7.2 代替KVO :

 rac_valuesAndChangesForKeyPath：用于监听某个对象的属性改变。
 
 
 7.3 监听事件:

 rac_signalForControlEvents：用于监听某个事件。
 
 
 7.4 代替通知:

 rac_addObserverForName:用于监听某个通知。
 
 
 7.5 监听文本框文字改变:

 rac_textSignal:只要文本框发出改变就会发出这个信号。
 
 
 7.6 处理当界面有多次请求时，需要都获取到数据时，才能展示界面

 rac_liftSelector:withSignalsFromArray:
 每一个signal都至少sendNext过一次，就会去触发第一个selector参数的方法。
 使用注意：几个信号，参数一的方法就几个参数，每个参数对应信号发出的数据。

 */
- (void)testRAC_xxx{
    
    // 2.KVO
    // 把监听blueBtn的center属性改变转换成信号，只要值改变就会发送信号
    // observer:可以传入nil
    [[self.blueBtn rac_valuesAndChangesForKeyPath:@"center" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {

        NSLog(@"%@",x);

    }];

    // 3.监听事件
    // 把按钮点击事件转换为信号，点击按钮，就会发送信号
    [[self.blueBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"按钮被点击了");
    }];

    // 4.代替通知
    // 把监听到的通知转换信号
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(id x) {
        NSLog(@"键盘弹出");
    }];
    

    // 5.监听文本框的文字改变
   [_textField.rac_textSignal subscribeNext:^(id x) {

       NSLog(@"文字改变了%@",x);
   }];
    
    
    
    
   // 6.处理多个请求，都返回结果的时候，统一做处理.
    RACSignal *request1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 发送请求1
        [subscriber sendNext:@"发送请求1"];
        return nil;
    }];
    
    RACSignal *request2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 发送请求2
        [subscriber sendNext:@"发送请求2"];
        return nil;
    }];
    
    // 使用注意：几个信号，参数一的方法就几个参数，每个参数对应信号发出的数据。
    [self rac_liftSelector:@selector(updateUIWithR1:r2:) withSignalsFromArray:@[request1,request2]];
    
}
// 更新UI
- (void)updateUIWithR1:(id)data r2:(id)data1
{
    NSLog(@"更新UI%@  %@",data,data1);
}

/****************    RAC基础篇       ***************/





/****************    RAC进阶篇      ***************/

// 1.1 ReactiveCocoa核心方法bind
/**
 ReactiveCocoa操作的核心方法是bind（绑定）,而且RAC中核心开发方式，也是绑定，之前的开发方式是赋值，而用RAC开发，应该把重心放在绑定，也就是可以在创建一个对象的时候，就绑定好以后想要做的事情，而不是等赋值之后在去做事情。
 列如：把数据展示到控件上，之前都是重写控件的setModel方法，用RAC就可以在一开始创建控件的时候，就绑定好数据。
 在开发中很少使用bind方法，bind属于RAC中的底层方法，RAC已经封装了很多好用的其他方法，底层都是调用bind，用法比bind简单.
 */
- (void)test_bind{
    // 假设想监听文本框的内容，并且在每次输出结果的时候，都在文本框的内容拼接一段文字“输出：”

      // 方式一:在返回结果后，拼接。
//          [self.textField.rac_textSignal subscribeNext:^(id x) {
//              NSLog(@"输出:%@",x);
//          }];

    
    
      // 方式二:在返回结果前，拼接，使用RAC中bind方法做处理。
      // bind方法参数:需要传入一个返回值是RACStreamBindBlock的block参数
      // RACStreamBindBlock是一个block的类型，返回值是信号，参数（value,stop），因此参数的block返回值也是一个block。

      // RACStreamBindBlock:
      // 参数一(value):表示接收到信号的原始值，还没做处理
      // 参数二(*stop):用来控制绑定Block，如果*stop = yes,那么就会结束绑定。
      // 返回值：信号，做好处理，在通过这个信号返回出去，一般使用RACReturnSignal,需要手动导入头文件RACReturnSignal.h。

      // bind方法使用步骤:
      // 1.传入一个返回值RACStreamBindBlock的block。
      // 2.描述一个RACStreamBindBlock类型的bindBlock作为block的返回值。
      // 3.描述一个返回结果的信号，作为bindBlock的返回值。
      // 注意：在bindBlock中做信号结果的处理。

      // 底层实现:
      // 1.源信号调用bind,会重新创建一个绑定信号。
      // 2.当绑定信号被订阅，就会调用绑定信号中的didSubscribe，生成一个bindingBlock。
      // 3.当源信号有内容发出，就会把内容传递到bindingBlock处理，调用bindingBlock(value,stop)
      // 4.调用bindingBlock(value,stop)，会返回一个内容处理完成的信号（RACReturnSignal）。
      // 5.订阅RACReturnSignal，就会拿到绑定信号的订阅者，把处理完成的信号内容发送出来。

      // 注意:不同订阅者，保存不同的nextBlock，看源码的时候，一定要看清楚订阅者是哪个。
      // 这里需要手动导入#import <ReactiveCocoa/RACReturnSignal.h>，才能使用RACReturnSignal。
    
      [[self.textField.rac_textSignal bind:^RACSignalBindBlock{

          // 什么时候调用:
          // block作用:表示绑定了一个信号.

          return ^RACSignal *(id value, BOOL *stop){

              // 什么时候调用block:当信号有新的值发出，就会来到这个block。

              // block作用:做返回值的处理

              // 做好处理，通过信号返回出去.
              return [RACReturnSignal return:[NSString stringWithFormat:@"输出:%@",value]];
          };

      }] subscribeNext:^(id x) {

          NSLog(@"%@",x);

      }];
}



/// 1.2 ReactiveCocoa操作方法之映射(flattenMap,Map)

/// flattenMap，Map用于把源信号内容映射成新的内容。

- (void)test_flattenMap{
    // 监听文本框的内容改变，把结构重新映射成一个新值.

   // flattenMap作用:把源信号的内容映射成一个新的信号，信号可以是任意类型。

     // flattenMap使用步骤:
     // 1.传入一个block，block类型是返回值RACStream，参数value
     // 2.参数value就是源信号的内容，拿到源信号的内容做处理
     // 3.包装成RACReturnSignal信号，返回出去。

     // flattenMap底层实现:
     // 0.flattenMap内部调用bind方法实现的,flattenMap中block的返回值，会作为bind中bindBlock的返回值。
     // 1.当订阅绑定信号，就会生成bindBlock。
     // 2.当源信号发送内容，就会调用bindBlock(value, *stop)
     // 3.调用bindBlock，内部就会调用flattenMap的block，flattenMap的block作用：就是把处理好的数据包装成信号。
     // 4.返回的信号最终会作为bindBlock中的返回信号，当做bindBlock的返回信号。
     // 5.订阅bindBlock的返回信号，就会拿到绑定信号的订阅者，把处理完成的信号内容发送出来。



     [[self.textField.rac_textSignal flattenMap:^RACSignal *(id value) {

         // block什么时候 : 源信号发出的时候，就会调用这个block。

         // block作用 : 改变源信号的内容。

         // 返回值：绑定信号的内容.
         return [RACReturnSignal return:[NSString stringWithFormat:@"输出:%@",value]];

     }] subscribeNext:^(id x) {

         // 订阅绑定信号，每当源信号发送内容，做完处理，就会调用这个block。

         NSLog(@"%@",x);

     }];

}


- (void)test_map{
    // 监听文本框的内容改变，把结构重新映射成一个新值.

        // Map作用:把源信号的值映射成一个新的值

        // Map使用步骤:
        // 1.传入一个block,类型是返回对象，参数是value
        // 2.value就是源信号的内容，直接拿到源信号的内容做处理
        // 3.把处理好的内容，直接返回就好了，不用包装成信号，返回的值，就是映射的值。

        // Map底层实现:
        // 0.Map底层其实是调用flatternMap,Map中block中的返回的值会作为flatternMap中block中的值。
        // 1.当订阅绑定信号，就会生成bindBlock。
        // 3.当源信号发送内容，就会调用bindBlock(value, *stop)
        // 4.调用bindBlock，内部就会调用flattenMap的block
        // 5.flattenMap的block内部会调用Map中的block，把Map中的block返回的内容包装成返回的信号。
        // 5.返回的信号最终会作为bindBlock中的返回信号，当做bindBlock的返回信号。
        // 6.订阅bindBlock的返回信号，就会拿到绑定信号的订阅者，把处理完成的信号内容发送出来。

           [[self.textField.rac_textSignal map:^id(id value) {
            // 当源信号发出，就会调用这个block，修改源信号的内容
            // 返回值：就是处理完源信号的内容。
            return [NSString stringWithFormat:@"输出:%@",value];
        }] subscribeNext:^(id x) {

            NSLog(@"%@",x);
        }];
}


/**

 FlatternMap和Map的区别

 1.FlatternMap中的Block返回信号。
 2.Map中的Block返回对象。
 3.开发中，如果信号发出的值不是信号，映射一般使用Map
 4.开发中，如果信号发出的值是信号，映射一般使用FlatternMap。
 */


- (void)test_signalOfSignal{
    // 创建信号中的信号
    RACSubject *signalOfsignals = [RACSubject subject];
    RACSubject *signal = [RACSubject subject];

    [[signalOfsignals flattenMap:^RACSignal *(id value) {
     // 当signalOfsignals的signals发出信号才会调用
        return value;
    }] subscribeNext:^(id x) {

        // 只有signalOfsignals的signal发出信号才会调用，因为内部订阅了bindBlock中返回的信号，也就是flattenMap返回的信号。
        // 也就是flattenMap返回的信号发出内容，才会调用。

        NSLog(@"%@aaa",x);
    }];

    // 信号的信号发送信号
    [signalOfsignals sendNext:signal];

    // 信号发送内容
    [signal sendNext:@1];

}

// 1.3 ReactiveCocoa操作方法之组合。

// concat:按一定顺序拼接信号，当多个信号发出的时候，有顺序的接收信号。
- (void)test_concat{
    
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [subscriber sendNext:@1];
            
            [subscriber sendCompleted];
            
            return nil;
        }];
        RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [subscriber sendNext:@2];
            
            return nil;
        }];
        
        // 把signalA拼接到signalB后，signalA发送完成，signalB才会被激活。
        RACSignal *concatSignal = [signalA concat:signalB];
        
        // 以后只需要面对拼接信号开发。
        // 订阅拼接的信号，不需要单独订阅signalA，signalB
        // 内部会自动订阅。
        // 注意：第一个信号必须发送完成，第二个信号才会被激活
        [concatSignal subscribeNext:^(id x) {
            
            NSLog(@"%@",x);
            
        }];
        
        // concat底层实现:
        // 1.当拼接信号被订阅，就会调用拼接信号的didSubscribe
        // 2.didSubscribe中，会先订阅第一个源信号（signalA）
        // 3.会执行第一个源信号（signalA）的didSubscribe
        // 4.第一个源信号（signalA）didSubscribe中发送值，就会调用第一个源信号（signalA）订阅者的nextBlock,通过拼接信号的订阅者把值发送出来.
        // 5.第一个源信号（signalA）didSubscribe中发送完成，就会调用第一个源信号（signalA）订阅者的completedBlock,订阅第二个源信号（signalB）这时候才激活（signalB）。
        // 6.订阅第二个源信号（signalB）,执行第二个源信号（signalB）的didSubscribe
        // 7.第二个源信号（signalA）didSubscribe中发送值,就会通过拼接信号的订阅者把值发送出来.
}



// then:用于连接两个信号，当第一个信号完成，才会连接then返回的信号。
- (void)test_then{
    // then:用于连接两个信号，当第一个信号完成，才会连接then返回的信号
    // 注意使用then，之前信号的值会被忽略掉.
    // 底层实现：1、先过滤掉之前的信号发出的值。2.使用concat连接then返回的信号
   [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
       [subscriber sendNext:@1];
       [subscriber sendCompleted];
       return nil;
   }] then:^RACSignal *{
       return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           [subscriber sendNext:@2];
           return nil;
       }];
   }] subscribeNext:^(id x) {
     
       // 只能接收到第二个信号的值，也就是then返回信号的值
       NSLog(@"%@",x);
   }];
}


- (void)test_merge{
    // `merge`:把多个信号合并为一个信号，任何一个信号有新值的时候就会调用
    // merge:把多个信号合并成一个信号
    //创建多个信号
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@2];
        return nil;
    }];

    // 合并信号,任何一个信号发送数据，都能监听到.
    RACSignal *mergeSignal = [signalA merge:signalB];
    
    [mergeSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    // 底层实现：
    // 1.合并信号被订阅的时候，就会遍历所有信号，并且发出这些信号。
    // 2.每发出一个信号，这个信号就会被订阅
    // 3.也就是合并信号一被订阅，就会订阅里面所有的信号。
    // 4.只要有一个信号被发出就会被监听。

}


///zipWith:把两个信号压缩成一个信号，只有当两个信号同时发出信号内容时，
///并且把两个信号的内容合并成一个元组，才会触发压缩流的next事件。

- (void)test_zipWith{
    
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           [subscriber sendNext:@1];
           return nil;
       }];
       
       RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           [subscriber sendNext:@2];
           return nil;
       }];
       
       // 压缩信号A，信号B
       RACSignal *zipSignal = [signalA zipWith:signalB];
       [zipSignal subscribeNext:^(id x) {
           NSLog(@"%@",x);
       }];
       
       // 底层实现:
       // 1.定义压缩信号，内部就会自动订阅signalA，signalB
       // 2.每当signalA或者signalB发出信号，就会判断signalA，signalB有没有发出个信号，有就会把最近发出的信号都包装成元组发出。
}


/**
 combineLatest:将多个信号合并起来，并且拿到各个信号的最新的值,必须每个合并的signal至少都有过一次sendNext，才会触发合并的信号。

 */
- (void)test_combineLatest{
    
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
      [subscriber sendNext:@1];
      return nil;
  }];
  
  RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
      [subscriber sendNext:@2];
      return nil;
  }];

  // 把两个信号组合成一个信号,跟zip一样，没什么区别
  RACSignal *combineSignal = [signalA combineLatestWith:signalB];
  [combineSignal subscribeNext:^(id x) {
      NSLog(@"%@",x);
  }];
  
  // 底层实现：
  // 1.当组合信号被订阅，内部会自动订阅signalA，signalB,必须两个信号都发出内容，才会被触发。
  // 2.并且把两个信号组合成元组发出。
 
}

// `reduce`聚合:用于信号发出的内容是元组，把信号发出元组的值聚合成一个值

- (void)test_reduce{
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       [subscriber sendNext:@1];
       return nil;
   }];
   
   RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       [subscriber sendNext:@2];
       return nil;
   }];
   
   // 聚合
   // 常见的用法，（先组合在聚合）。combineLatest:(id<NSFastEnumeration>)signals reduce:(id (^)())reduceBlock
   // reduce中的block简介:
   // reduceblcok中的参数，有多少信号组合，reduceblcok就有多少参数，每个参数就是之前信号发出的内容
   // reduceblcok的返回值：聚合信号之后的内容。
  RACSignal *reduceSignal = [RACSignal combineLatest:@[signalA,signalB] reduce:^id(NSNumber *num1 ,NSNumber *num2){
      return [NSString stringWithFormat:@"%@ %@",num1,num2];
  }];
   
   [reduceSignal subscribeNext:^(id x) {
       NSLog(@"%@",x);
   }];
   
   // 底层实现:
   // 1.订阅聚合信号，每次有内容发出，就会执行reduceblcok，把信号内容转换成reduceblcok返回的值。
}



/// 1.4 ReactiveCocoa操作方法之过滤

// filter:过滤信号，使用它可以获取满足条件的信号.
- (void)test_filter{
    // 过滤:
    // 每次信号发出，会先执行过滤条件判断.
    [self.textField.rac_textSignal filter:^BOOL(NSString *value) {
            return value.length > 3;
    }];
}

// ignore:忽略某些值的信号.
- (void)test_ignore{
    // 内部调用filter过滤，忽略掉ignore的值
    [[self.textField.rac_textSignal ignore:@"1"]
     subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
}

// distinctUntilChanged:当上一次的值和当前的值有明显的变化就会发出信号，否则会被忽略掉。
- (void)test_distinctUntilChanged{
 // 过滤，当上一次和当前的值不一样，就会发出内容。
 // 在开发中，刷新UI经常使用，只有两次数据不一样才需要刷新
 [[self.textField.rac_textSignal distinctUntilChanged] subscribeNext:^(id x) {
     NSLog(@"%@",x);
 }];

}


/// take:从开始一共取N次的信号
- (void)testTake{
    // 1、创建信号
    RACSubject *signal = [RACSubject subject];

    // 2、处理信号，订阅信号
    [[signal take:1] subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];

    // 3.发送信号
    [signal sendNext:@1];

    [signal sendNext:@2];
}

/// takeLast:取最后N次的信号,前提条件，订阅者必须调用完成，因为只有完成，就知道总共有多少信号.
- (void)testTakeLast{
    // 1、创建信号
    RACSubject *signal = [RACSubject subject];

    // 2、处理信号，订阅信号
    [[signal takeLast:1] subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];

    // 3.发送信号
    [signal sendNext:@1];

    [signal sendNext:@2];

    [signal sendCompleted];
}

/// takeUntil:(RACSignal *):获取信号直到某个信号执行完成
- (void)testTakeUntil{
    // 监听文本框的改变直到当前对象被销毁
    [[_textField.rac_textSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
    }];

}

/// skip:(NSUInteger):跳过几个信号,不接受。
- (void)testSkip{
    // 表示输入第一次，不会被监听到，跳过第一次发出的信号
    [[_textField.rac_textSignal skip:1] subscribeNext:^(id x) {
       
        NSLog(@"%@",x);
    }];
}

/**
 switchToLatest:用于signalOfSignals（信号的信号），有时候信号也会发出信号，会在signalOfSignals中，
 获取signalOfSignals发送的最新信号。
 */
- (void)testSwitchToLatest{
    RACSubject *signalOfSignals = [RACSubject subject];
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    RACSubject *signalC = [RACSubject subject];


    // 获取信号中信号最近发出信号，订阅最近发出的信号。
    // 注意switchToLatest：只能用于信号中的信号
    [signalOfSignals.switchToLatest subscribeNext:^(id x) {
       
        NSLog(@"%@",x);
    }];
    [signalOfSignals sendNext:signalA];

    [signalA sendNext:@"1a"];
    
    [signalOfSignals sendNext:signalB];

    [signalB sendNext:@"1b"];

    [signalA sendNext:@"2a"];
    
    [signalA sendNext:@"3a"];
    
    [signalOfSignals sendNext:signalC];
    
    [signalC sendNext:@"1c"];
    
    [signalC sendNext:@"3c"];

    [signalB sendNext:@"2b"];
    
    [signalC sendNext:@"2c"];
    
    [signalB sendNext:@"3b"];

}

/****************    RAC进阶篇      ***************/

// https://draveness.me/raccommand/
- (void)testCommand1{
    
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSNumber * _Nullable input) {
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            NSInteger integer = [input integerValue];
            for (NSInteger i = 0; i < integer; i++) {
                [subscriber sendNext:@(i)];
            }
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    [[command.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];

    [command execute:@1];
    
    [RACScheduler.mainThreadScheduler afterDelay:0.1
                                        schedule:^{
                                            [command execute:@2];
                                        }];
    [RACScheduler.mainThreadScheduler afterDelay:0.2
                                        schedule:^{
                                            [command execute:@3];
                                        }];
}


/// RACCommand
- (void)testCommand2{
    
    // https://github.com/halfrost/Halfrost-Field/blob/master/contents/iOS/RAC/reactivecocoa_raccommand.md
    /**
     RACCommand 在ReactiveCocoa 中是对一个动作的触发条件以及它产生的触发事件的封装。

    触发条件：初始化RACCommand的入参enabledSignal就决定了RACCommand是否能开始执行。入参enabledSignal就是触发条件。举个例子，一个按钮是否能点击，是否能触发点击事情，就由入参enabledSignal决定。

    触发事件：初始化RACCommand的另外一个入参(RACSignal * (^)(id input))signalBlock就是对触发事件的封装。RACCommand每次执行都会调用一次signalBlock闭包。
     */
    self.commandBtn.rac_command = [[RACCommand alloc] initWithEnabled:[RACReturnSignal return:@YES] signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"%@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"123"];

            [[RACScheduler scheduler] afterDelay:2 schedule:^{
                [subscriber sendCompleted];
            }];
            
            return nil;
        }];
    }];

    [self.commandBtn.rac_command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}




- (void)testThrottle{
    
    [[self.textField.rac_textSignal throttle:0.5] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
    }];
    
//    [[self.textField.rac_textSignal logAll] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
}

/*************************** 最快上手RAC  ******************************/


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
    
//    [self demo12];
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
- (void)test_signalOfSignal2{
     
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
    /// 可以使用RACMulticastConnection这个类了，RACMulticastConnection其实是一个连接类，当一个信号被多次订阅，他可以帮我们避免多次调用创建信号中的block。
    /// RACMulticastConnection 内部返回一个RACSubject信号，外部的订阅者都订阅这个信号（可能被订阅多次）, 而RACSubject订阅RACSignal信号（只订阅一次），当RACSignal发送内容时，外部的订阅者都可以通过RACSubject收到内容

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

//
//  ViewController.m
//  test
//
//  Created by 孙春磊 on 2021/4/7.
//

#import "ViewController.h"
#import "Person.h"
#import "SubPerson.h"
#import "Father.h"
#import "MoveClickButton.h"
@interface ViewController ()


@property(nonatomic,strong) MoveClickButton *moveBtn;


@end

@implementation ViewController


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [super touchesBegan:touches withEvent:event];
//    NSLog(@"%s",__func__);
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MoveClickButton *moveBtn = [MoveClickButton new];
    moveBtn.frame = CGRectMake(0, 0, 100, 100);
    moveBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:moveBtn];
    self.moveBtn = moveBtn;
    
    
    
//    [self test1];
//    [self test2];
      [self test3];
}


- (void)test3{
    [UIView animateWithDuration:5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.moveBtn.frame = CGRectMake(200, 200, 100, 100);
    } completion:^(BOOL finished) {
        
    }];
}


// GCD、Runloop映客
/**
 我回答: 认为Runloop在处理这些事件的时候 先处理timer事件再处理dispatch到主线程的block
 所以输出为 1 、 2
 
 经过测试: 输出为 2 、1
 
 */
- (void)test2{
    
//    [self performSelector:@selector(log)];
/**
    delay: The minimum time before which the message is sent. Specifying a delay of 0 does not necessarily cause the selector to be performed immediately. The selector is still queued on the thread’s run loop and performed as soon as possible.
 */
    [self performSelector:@selector(log) withObject:NULL afterDelay:0];
    
   
    sleep(1);

    /// 1 2 都是在主线程上执行的。一定有个执行顺序的。
    /// 会唤醒主线程的runloop
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"%@ , 2",[NSThread currentThread]);
    });
    
    
    NSLog(@"结束了");

}

- (void)log{
    NSLog(@"%@ , 1",[NSThread currentThread]);
    
}

/// GCD百度
- (void)test1{
    // 1 3 2 5 4
    dispatch_queue_t queue = dispatch_queue_create("gcd", DISPATCH_QUEUE_SERIAL);

        dispatch_sync(queue, ^{
            NSLog(@"Log 1");

            dispatch_async(queue, ^{
                NSLog(@"Log 2");
            });
            
        });

    sleep(5);
        NSLog(@"Log 3");

        dispatch_async(queue, ^{
            NSLog(@"Log 4");
        });

        NSLog(@"Log 5");
    
    
    NSLog(@"主类: %s",__func__);

//    Person *person = [Person new];
//    [person log];
//    SubPerson * son = [SubPerson new];
//    [SubPerson initialize];
//    Father * father = [Father new];

    
//    dispatch_queue_t queue1 = dispatch_queue_create("com.slccoder.test", DISPATCH_QUEUE_CONCURRENT);
//
//    for(int i = 0 ; i < 10; i++){
//        dispatch_async(queue1, ^{
//            if (i % 2) sleep(0.1);
//            NSLog(@"前任务: %d",i);
//        });
//    }
//
//
//    dispatch_barrier_async(queue, ^{
//        NSLog(@"任务: barrier");
//    });
//
//    for(int i = 0 ; i < 10; i++){
//        dispatch_async(queue1, ^{
//            if (i % 2) sleep(0.1);
//            NSLog(@"后任务: %d",i);
//        });
//    }
}





@end

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
#import <SDWebImage/SDWebImage.h>

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
//      [self test3];
    
//    [self testGCD];
    
    [self testGCD2];
}

- (void)testGCD2{
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    /**
     2022-04-28 23:19:26.668170+0800 Code_Interview[5721:60794] 1111
     2022-04-28 23:19:26.668188+0800 Code_Interview[5721:60788] 2222
     2022-04-28 23:19:26.668193+0800 Code_Interview[5721:60792] 3333
     2022-04-28 23:19:26.668312+0800 Code_Interview[5721:60794] 6666
     2022-04-28 23:19:26.668317+0800 Code_Interview[5721:60788] 7777
     2022-04-28 23:19:26.668325+0800 Code_Interview[5721:60792] 5555
     2022-04-28 23:19:26.668329+0800 Code_Interview[5721:60790] 4444
     */
//    dispatch_queue_t queue = dispatch_get_main_queue();
    /**
     2022-04-28 23:18:45.290316+0800 Code_Interview[5696:59882] 1111
     2022-04-28 23:18:45.290443+0800 Code_Interview[5696:59882] 6666
     2022-04-28 23:18:45.290547+0800 Code_Interview[5696:59882] 2222
     2022-04-28 23:18:45.290650+0800 Code_Interview[5696:59882] 7777
     2022-04-28 23:18:45.290758+0800 Code_Interview[5696:59882] 3333
     2022-04-28 23:18:45.292901+0800 Code_Interview[5696:59882] 4444
     2022-04-28 23:18:45.293084+0800 Code_Interview[5696:59882] 5555

     */

    /// 队列 FIFO  4 3 2 1   -> 1 2 3
    
    
    NSLog(@"currtenThread: %@",[NSThread currentThread]);

    
    ///  5 4 3 2  1   ... end
    dispatch_async(queue, ^{ /// 1
    
        NSLog(@"1111 %@",[NSThread currentThread]);
        
        dispatch_async(queue, ^{ /// 4
            NSLog(@"4444 %@",[NSThread currentThread]);
        });
        
        NSLog(@"6666");

    });
    
//    sleep(5);
    
    NSLog(@"------");
    
    dispatch_async(queue, ^{ /// 2
        
        NSLog(@"2222 %@",[NSThread currentThread]);
        
        dispatch_async(queue, ^{ /// 5
            NSLog(@"5555 %@",[NSThread currentThread]);
        });
        
        NSLog(@"7777");

    });

//    sleep(2);

    NSLog(@"+++++++");

    dispatch_async(queue, ^{ /// 3
        NSLog(@"3333");
    });
    
//    sleep(2);

    NSLog(@"end");
    
}


- (void)testGCD{
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);

    dispatch_group_t group = dispatch_group_create();
    
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSURL *url1 = [NSURL URLWithString:@"https://cdn.pixabay.com/photo/2022/04/04/14/17/milk-7111433_1280.jpg"];
    NSURL *url2 = [NSURL URLWithString:@"https://cdn.pixabay.com/photo/2020/03/18/08/06/envelope-4943161_1280.jpg"];
    NSURL *url3 = [NSURL URLWithString:@"https://cdn.pixabay.com/photo/2022/04/15/11/23/dog-7134183_1280.jpg"];

    
    dispatch_async(queue, ^{
        
        dispatch_group_enter(group);
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url1 completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            
            dispatch_group_leave(group);
        }];
        
        dispatch_group_enter(group);
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url2 completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            
            dispatch_group_leave(group);
        }];
        
        
        dispatch_group_enter(group);
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url3 completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            
            dispatch_group_leave(group);
        }];
        
        dispatch_group_notify(group, queue, ^{
            NSLog(@"success!!!");
        });
    });
    

   
    
//    dispatch_group_enter(group);
//    dispatch_async(queue, ^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSLog(@"1111");
//            dispatch_group_leave(group);
//        });
//    });
//
//    dispatch_group_enter(group);
//    dispatch_async(queue, ^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSLog(@"2222");
//            dispatch_group_leave(group);
//        });
//    });
//
//
//    dispatch_group_enter(group);
//    dispatch_async(queue, ^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSLog(@"3333");
//            dispatch_group_leave(group);
//        });
//    });

    
    
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

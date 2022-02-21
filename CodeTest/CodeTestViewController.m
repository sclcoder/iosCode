//
//  CodeTestViewController.m
//  CodeTest
//
//  Created by chunlei.sun on 2022/2/15.

#import "CodeTestViewController.h"


@interface CodeTestViewController ()
@property (assign, nonatomic) int ticketsCount;
@property (assign, nonatomic) int money;
@end


@implementation CodeTestViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self ticketTest];
//    [self moneyTest];
    
    
}

/// 链表相交的变种
- (UIView *)commonSuperView:(UIView *)oneView otherView:(UIView *)otherView{

    if (oneView == nil || otherView == nil) {
        return nil;
    }
    
    UIView *viewA = oneView;
    UIView *viewB = otherView;
    while (viewA != viewB) {
        viewA = viewA == nil ? viewB : viewA.superview;
        viewB = viewA == nil ? viewA :viewB.superview;
    }
    return viewA;
}




/**
 卖票演示—类型一
 */
- (void)ticketTest
{
    self.ticketsCount = 15;
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
             [self saleTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self saleTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self saleTicket];
        }
    });
}



/**
 卖1张票
 */
- (void)saleTicket
{
    int oldTicketsCount = self.ticketsCount;
    sleep(.2);
    oldTicketsCount--;
    self.ticketsCount = oldTicketsCount;
    
    NSLog(@"还剩%d张票 - %@", oldTicketsCount, [NSThread currentThread]);
}


/**
 存钱、取钱演示  — 类型二
 */
- (void)moneyTest
{
    self.money = 100;
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self saveMoney];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self drawMoney];
        }
    });
}
/**
 存钱
 */
- (void)saveMoney
{
    int oldMoney = self.money;
    sleep(.2);
    oldMoney += 50;
    self.money = oldMoney;
    
    NSLog(@"存50，还剩%d元 - %@", oldMoney, [NSThread currentThread]);
}

/**
 取钱
 */
- (void)drawMoney
{
    int oldMoney = self.money;
    sleep(.2);
    oldMoney -= 20;
    self.money = oldMoney;
    
    NSLog(@"取20，还剩%d元 - %@", oldMoney, [NSThread currentThread]);
}

/// 面试题  顺序打印
- (void)test
{
    
    __block int i = 0;
    
    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("queue2", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue1, ^{
        while (i < 100) {
            NSLog(@"queue1：%d",i);
            i ++;
        }
    });

    dispatch_async(queue2, ^{
        while (i < 100) {
            
            NSLog(@"queue2：%d",i);
            i ++;
        }
    });
}
- (void)test_semaphore{
    dispatch_semaphore_t aSemaphore = dispatch_semaphore_create(1);
    dispatch_semaphore_wait(aSemaphore, DISPATCH_TIME_FOREVER);
//    dispatch_semaphore_signal(aSemaphore);
}

/// 面试题  顺序打印
- (void)semaphore
{
    dispatch_semaphore_t semap1 = dispatch_semaphore_create(1);
    dispatch_semaphore_t semap2 = dispatch_semaphore_create(1);
    
    __block int i = 0;
    
    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("queue2", DISPATCH_QUEUE_CONCURRENT);

    // 消耗掉偶数队列的信号量
    dispatch_semaphore_wait(semap2, DISPATCH_TIME_FOREVER);


    __block int semap2SingalCount = 0;
    __block int semap1WaitCount = 0;

    dispatch_async(queue1, ^{
        

        while (i < 10) {
            
            dispatch_semaphore_wait(semap1, DISPATCH_TIME_FOREVER);
            semap1WaitCount++;
            NSLog(@"semap1WaitCount：%d",semap1WaitCount);

            NSLog(@"queue1：%d",i);
            i ++;
            dispatch_semaphore_signal(semap2);
            
            
            semap2SingalCount++;
            NSLog(@"semap2SingalCount：%d",semap2SingalCount);
        }
        NSLog(@"queue1 over");

    });
    
    __block int semap2WaitCount = 0;
    __block int semap1SingalCount = 0;

    dispatch_async(queue2, ^{
        
//        NSLog(@"queue2 %@",[NSThread currentThread]);

        while (i < 10) {
            dispatch_semaphore_wait(semap2, DISPATCH_TIME_FOREVER);
            semap2WaitCount++;
            NSLog(@"semap2WaitCount：%d",semap2WaitCount);

            NSLog(@"queue2：%d",i);
            i ++;
            dispatch_semaphore_signal(semap1);
            semap1SingalCount++;
            NSLog(@"semap1SingalCount：%d",semap1SingalCount);
        }
        NSLog(@"queue2 over");

    });
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        dispatch_semaphore_signal(semap2);
//
//    });
    
}

@end

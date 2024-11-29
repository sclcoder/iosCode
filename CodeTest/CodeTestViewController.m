//
//  CodeTestViewController.m
//  CodeTest
//
//  Created by chunlei.sun on 2022/2/15.

#import "CodeTestViewController.h"
@import YYText;
@import Masonry;

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
    
//    [self dateTest];
    
    [self testYYLabel];

    [self testYYLabel2];
    
    [self testYYLabel3];

    [self testYYTextView];
}

- (void)testYYLabel{
    
    YYLabel *contentL = [[YYLabel alloc] init];
    contentL.font = [UIFont systemFontOfSize:15];
    contentL.numberOfLines = 3;
    contentL.preferredMaxLayoutWidth = 300;//最大宽度
    [self.view addSubview:contentL];
    [contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(16);
        make.width.mas_equalTo(300);
    }];

    NSString *str = @"好想化做一只蝴蝶，乘着微风振翅高飞，现在马上，只想赶快和你见面，烦心的事放在一边，如果忘记那也无所谓，已经没有，多余时间可以浪费，似乎有，什么事会在这片晴空下出现";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    attrStr.yy_font = contentL.font;
    contentL.attributedText = attrStr;
//
    //添加详情 不需要点击事件
//    NSMutableAttributedString *moreAttrStr = [[NSMutableAttributedString alloc] initWithString:@"...详情"];
//    [moreAttrStr yy_setColor:[UIColor redColor] range:[moreAttrStr.string rangeOfString:@"详情"]];
//    moreAttrStr.yy_font = contentL.font;
//    contentL.truncationToken = moreAttrStr;

    //添加详情 需要点击事件
    NSMutableAttributedString *moreAttrStr = [[NSMutableAttributedString alloc] initWithString:@"...详情"];
    moreAttrStr.yy_font = contentL.font;
    [moreAttrStr yy_setTextHighlightRange:[moreAttrStr.string rangeOfString:@"详情"] color:[UIColor redColor] backgroundColor:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"点击了详情");
    }];
    
    YYLabel *moreL = [[YYLabel alloc] init];
    moreL.attributedText= moreAttrStr;
    [moreL sizeToFit];
    
    NSAttributedString *truncationToken = [NSAttributedString yy_attachmentStringWithContent:moreL 
                                                                                 contentMode:UIViewContentModeCenter
                                                                              attachmentSize:moreL.frame.size
                                                                                 alignToFont:contentL.font
                                                                                   alignment:YYTextVerticalAlignmentCenter];
    contentL.truncationToken= truncationToken;
}


- (void)testYYLabel2{
    
    YYLabel *contentL = [[YYLabel alloc] init];
    contentL.font = [UIFont systemFontOfSize:15];
    contentL.numberOfLines = 0;
    contentL.preferredMaxLayoutWidth = 300;//最大宽度
    [self.view addSubview:contentL];
    [contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(200);
        make.left.mas_equalTo(16);
        make.width.mas_equalTo(300);
    }];
    
    NSString *str = @"好想化做一只蝴蝶，乘着微风振翅高飞，现在马上，只想赶快和你见面，烦心的事放在一边，如果忘记那也无所谓，已经没有，多余时间可以浪费，似乎有，什么事会在这片晴空下出现";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    attrStr.yy_font = contentL.font;
    contentL.attributedText = attrStr;
    
    
    //置顶标签
    UILabel *topL = [[UILabel alloc] init];
    topL.font = [UIFont systemFontOfSize:11];
    topL.text = @"置顶";
    topL.backgroundColor = [UIColor redColor];
    topL.textColor = [UIColor whiteColor];
    topL.layer.cornerRadius = 4;
    topL.layer.masksToBounds = YES;
    topL.textAlignment = NSTextAlignmentCenter;
    topL.frame = CGRectMake(0, 0, 32, 16);//设置大小

    NSAttributedString *topAttr = [NSAttributedString 
                                   yy_attachmentStringWithContent:topL
                                   contentMode:UIViewContentModeScaleAspectFit
                                   attachmentSize:CGSizeMake(topL.frame.size.width+4, topL.frame.size.height)
                                   alignToFont:contentL.font 
                                   alignment:YYTextVerticalAlignmentCenter];
    
    [attrStr insertAttributedString:topAttr atIndex:0];

    //图片、表情
    UIImage *image = [UIImage imageNamed:@"like_Fill"];
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageV.image = image;

    NSAttributedString *imageAttr = [NSAttributedString 
                                     yy_attachmentStringWithContent:imageV
                                     contentMode:UIViewContentModeScaleAspectFit
                                     attachmentSize:image.size
                                     alignToFont:contentL.font
                                     alignment:YYTextVerticalAlignmentCenter];
    
    [attrStr appendAttributedString:imageAttr];

    contentL.attributedText = attrStr;
    
}

- (void)testYYLabel3{
    
    YYLabel *contentL = [[YYLabel alloc] init];
    contentL.font = [UIFont systemFontOfSize:15];
    contentL.numberOfLines = 2;
    contentL.preferredMaxLayoutWidth = 300;//最大宽度
    [self.view addSubview:contentL];
    [contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(300);
        make.left.mas_equalTo(16);
        make.width.mas_equalTo(300);
    }];

    NSString *str = @"好想化做一只蝴蝶，乘着微风振翅高飞，现在马上，只想赶快和你见面，烦心的事放在一边，如果忘记那也无所谓，已经没有，多余时间可以浪费，似乎有，什么事会在这片晴空下出现";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    attrStr.yy_font = contentL.font;
    contentL.attributedText = attrStr;
    
    NSMutableAttributedString *moreAttrStr  = [[NSMutableAttributedString alloc] initWithString:@"...详情"];
    [moreAttrStr yy_setColor:[UIColor clearColor] range:[moreAttrStr.string rangeOfString:@"详情"]];
    moreAttrStr.yy_font = contentL.font;
    contentL.truncationToken = moreAttrStr;

    NSMutableAttributedString *copyAttrStr  =  [[NSMutableAttributedString alloc] initWithString:@"详情"];
    copyAttrStr.yy_color = [UIColor redColor];
    copyAttrStr.yy_font = contentL.font;

    YYLabel *moreL = [[YYLabel alloc] init];
    moreL.attributedText= copyAttrStr;
    [contentL addSubview:moreL];
    [moreL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);//位置自己适当调整哈
        make.bottom.mas_equalTo(0);
    }];

}


- (void)testYYTextView{
    YYTextView *contentV = [[YYTextView alloc] init];
    [self.view addSubview:contentV];
    [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(400);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(300);
    }];

    NSMutableAttributedString *allAttrStr = [[NSMutableAttributedString alloc] init];
    NSArray *arr = @[@"@亚古兽",@"@加布兽",@"@比丘兽",@"@甲虫兽",@"@巴鲁兽",@"@哥玛兽",@"@巴达兽",@"@迪路兽"];
    for (NSString *str in arr) {
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        attrStr.yy_font = [UIFont systemFontOfSize:14];
        [attrStr yy_setTextBinding:[YYTextBinding bindingWithDeleteConfirm:NO] range:attrStr.yy_rangeOfAll];//没有删除确认直接删除
        [allAttrStr appendAttributedString:attrStr];
        [allAttrStr yy_appendString:@" "];
    }

    NSMutableAttributedString *linkAttrStr = [[NSMutableAttributedString alloc] initWithString:@"https://juejin.cn"];
    linkAttrStr.yy_font = [UIFont systemFontOfSize:14];
    linkAttrStr.yy_color = [UIColor blueColor];
    [linkAttrStr yy_setTextBinding:[YYTextBinding bindingWithDeleteConfirm:YES] range:linkAttrStr.yy_rangeOfAll];//有删除确认
    [allAttrStr appendAttributedString:linkAttrStr];

    contentV.attributedText = allAttrStr;

}

- (void)dateTest{
    NSDate *threeDaysAgo        = [NSDate dateWithTimeIntervalSinceNow: -(60 * 60 * 24 * 3)];
    NSDate *nowDate             = [NSDate now];
    NSComparisonResult result   = [nowDate compare:threeDaysAgo];
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

//
//  ChatTableViewController.m
//  CodeTest
//
//  Created by chunlei.sun on 2022/2/21.
//

#import "ChatTableViewController.h"

#import "ChatBaseTableViewCell.h"
#import "ChatBaseCell.h"
#import "ChatTextCell.h"

#import <Masonry/Masonry.h>
#import "YYFPSLabel.h"


@interface ChatTableViewController ()<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic, strong) UITableView *chatTableView;
@property(nonatomic,strong) YYFPSLabel *fpsLabel;

@end

@implementation ChatTableViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self.view addSubview:self.chatTableView];
    
    [self.view addSubview:self.fpsLabel];

    [self.fpsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
        make.left.equalTo(self.view);
    }];
    
    [self.chatTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"------------");
    });
    
}


- (UITableView *)chatTableView{
    if (_chatTableView == nil) {
        _chatTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _chatTableView.dataSource = self;
        _chatTableView.delegate = self;
        /// 自定义的cell提供identifer, 基类注册cell类型
        [_chatTableView registerNib:[UINib nibWithNibName:[ChatBaseTableViewCell registerNameForNib] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[ChatBaseTableViewCell registerIdentifer]];
        
        [_chatTableView registerClass:[ChatBaseCell class] forCellReuseIdentifier:[ChatBaseCell registerIdentifer]];
        
        [_chatTableView registerClass:[ChatTextCell class] forCellReuseIdentifier:[ChatTextCell registerIdentifer]];

        
        _chatTableView.estimatedRowHeight = UITableViewAutomaticDimension;
    }
    return _chatTableView;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ChatBaseCell *cell = nil;
//    cell = [tableView dequeueReusableCellWithIdentifier:[ChatBaseCell registerIdentifer]];
//    if (cell == nil) {
//        cell = [[ChatBaseCell alloc] init];
//    }

    if (indexPath.row % 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:[ChatTextCell registerIdentifer]];
        if (cell == nil) {
            cell = [[ChatTextCell alloc] init];
        }
        ChatTextCell *textCell = (ChatTextCell *)cell;
        [textCell updateText:[self randomString]];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:[ChatBaseCell registerIdentifer]];
        if (cell == nil) {
            cell = [[ChatBaseCell alloc] init];
        }
    }
//
//    cell.leftView.hidden  = indexPath.row % 5;
//    cell.rightView.hidden = indexPath.row % 3;
    [cell updateLayout: indexPath.row % 2];
//    cell.customView.hidden = indexPath.row % 4;
    return cell;
}




//- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
//    <#code#>
//}
//
//- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
//    <#code#>
//}
//
//- (void)setNeedsFocusUpdate {
//    <#code#>
//}
//
//- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
//    <#code#>
//}
//
//- (void)updateFocusIfNeeded {
//    <#code#>
//}



- (NSString *)randomString{

    NSString *strAll = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSInteger len = arc4random() % 200;
    NSString *result = [[NSMutableString alloc]initWithCapacity:len];
    for (int i = 0; i < len; i++)
    {
      NSInteger index = arc4random() % (strAll.length-1);
      char tempStr = [strAll characterAtIndex:index];
      result = (NSMutableString *)[result stringByAppendingString:[NSString stringWithFormat:@"%c",tempStr]];
    }
      
    return result;
}

#pragma mark - lazyadd
- (YYFPSLabel *)fpsLabel{
    
    if (_fpsLabel == nil) {
        _fpsLabel = [[YYFPSLabel alloc] initWithFrame:CGRectMake(0,0,60,30)];
    }
    
    return _fpsLabel;
}

@end

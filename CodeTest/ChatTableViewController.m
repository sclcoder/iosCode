//
//  ChatTableViewController.m
//  CodeTest
//
//  Created by chunlei.sun on 2022/2/21.
//

#import "ChatTableViewController.h"

#import "ChatBaseTableViewCell.h"
#import "ChatBaseCell.h"

#import <Masonry/Masonry.h>



@interface ChatTableViewController ()<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic, strong) UITableView *chatTableView;

@end

@implementation ChatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.chatTableView];
    
    [self.chatTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}


- (UITableView *)chatTableView{
    if (_chatTableView == nil) {
        _chatTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _chatTableView.dataSource = self;
        _chatTableView.delegate = self;
        /// 自定义的cell提供identifer, 基类注册cell类型
        [_chatTableView registerNib:[UINib nibWithNibName:[ChatBaseTableViewCell registerNameForNib] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[ChatBaseTableViewCell registerIdentifer]];
        
        [_chatTableView registerClass:[ChatBaseCell class] forCellReuseIdentifier:[ChatBaseCell registerIdentifer]];
        
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
    
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:[ChatBaseCell registerIdentifer]];
    if (cell == nil) {
        cell = [[ChatBaseCell alloc] init];
    }

//    if (indexPath.row % 2) {
//        cell = [tableView dequeueReusableCellWithIdentifier:[ChatBaseTableViewCell registerIdentifer]];
//        if (cell == nil) {
//            cell = [[ChatBaseTableViewCell alloc] init];
//        }
//    } else {
//        cell = [tableView dequeueReusableCellWithIdentifier:[ChatBaseCell registerIdentifer]];
//        if (cell == nil) {
//            cell = [[ChatBaseCell alloc] init];
//        }
//    }
    
//    cell.stateView.hidden  = indexPath.row % 2;
//    cell.userInfoView.hidden = indexPath.row % 3;
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

@end

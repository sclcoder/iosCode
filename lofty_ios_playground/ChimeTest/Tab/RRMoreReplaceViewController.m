//
//  RRMoreReplaceViewController.m
//  ChimeTest
//
//  Created by chunlei.sun on 2023/8/24.
//

#import "RRMoreReplaceViewController.h"
#import "RROverlayPresentationController.h"


@interface RRMoreReplaceViewController ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,RROverlayPresentationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation RRMoreReplaceViewController


- (void)dealloc{
    NSLog(@"%s",__func__);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s",__func__);
    
    
    
    [self.view addSubview:self.tableView];
    
    [self.pushBtn addTarget:self action:@selector(onPush) forControlEvents:UIControlEventTouchUpInside];
    [self.confirmBtn addTarget:self action:@selector(onConfirm) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn addTarget:self action:@selector(onCancel) forControlEvents:UIControlEventTouchUpInside];
}



//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//
//    NSLog(@"%s",__func__);
//}
//
//
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//
//    NSLog(@"%s",__func__);
//}
//
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//
//    NSLog(@"%s",__func__);
//}
//
//
//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//
//    NSLog(@"%s",__func__);
//}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 88);
}


- (void)onConfirm{
    if(self.delegate && [self.delegate respondsToSelector:@selector(moreItem:didSelectedItemAtIndex:)]){
        [self.delegate moreItem:self didSelectedItemAtIndex:0];
    }

}

- (void)onCancel{
    if(self.delegate && [self.delegate respondsToSelector:@selector(moreItemDidCancel:)]){
        [self.delegate moreItemDidCancel:self];
    }
}

- (void)onPush{
    
}



- (void)interactiveFinishedDismiss{
    if(self.delegate && [self.delegate respondsToSelector:@selector(moreItemDidCancel:)]){
        [self.delegate moreItemDidCancel:self];
    }
}

#pragma mark - RROverlayPresentationControllerDelegate
- (void)onTapDimmingView{
    if(self.delegate && [self.delegate respondsToSelector:@selector(moreItemDidCancel:)]){
        [self.delegate moreItemDidCancel:self];
    }
}


#pragma mark --UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Test--%ld",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if(indexPath.row % 3){
        [self onCancel];
    } else {
        [self onConfirm]; 
    }
}


#pragma mark --UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    // 支持多手势
    return YES;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0){
    // 这个方法返回YES，第一个手势和第二个互斥时，第一个会失效
    if ([otherGestureRecognizer.view isKindOfClass:[UITableView class]]) {
        return YES;
    }
    return NO;
}

#pragma mark --UIScrollViewDelegate
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self setGestureRecognizerEnable:YES scrollView:scrollView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self setGestureRecognizerEnable:YES scrollView:scrollView];
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    // 结束的时候手势可用
    [self setGestureRecognizerEnable:YES scrollView:scrollView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 滑动到顶部的时候设置手势失效
    if (scrollView.contentOffset.y <=0) {
        [self setGestureRecognizerEnable:NO scrollView:scrollView];
    }else{
        // 手势可用
        [self setGestureRecognizerEnable:YES scrollView:scrollView];
    }
}

-(void)setGestureRecognizerEnable:(BOOL)isEnable scrollView:(UIScrollView *)scrollView{
    for (UIGestureRecognizer *gesRec in scrollView.gestureRecognizers) {
        if ([gesRec isKindOfClass:[UIPanGestureRecognizer class]]) {
            gesRec.enabled =isEnable;
        }
    }
}

# pragma mark - lazy add
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.sectionHeaderHeight = 50;
        _tableView.rowHeight = 80;
        
    }
    return _tableView;
}




@end

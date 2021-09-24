//
//  SDPagerController.m
//  SDPlayground
//
//  Created by chunlei.sun on 2021/5/27.
//

#import "SDPagerController.h"
#import "CustomViewController.h"
#import "ListViewController.h"
#import "CollectionViewController.h"
#import "RRTestViewController.h"
#import "RRWebViewController.h"
#import "MenuViewController.h"
#import "SDNavigationController.h"
@interface SDPagerController ()<TYTabPagerControllerDataSource, TYTabPagerControllerDelegate>
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic,strong) MenuViewController *leftVC; // 强引用，可以避免每次显示抽屉都去创建

@end

@implementation SDPagerController

- (MenuViewController *)leftVC {
    if (_leftVC == nil) {
        _leftVC = [MenuViewController new];
    }
    return _leftVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBarItem];
    [self setupPageVc];
    [self loadData];
    [self setupSildVc];
}

- (void)setupNavBarItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(defaultAnimationFromLeft)];
}

- (void)setupPageVc{
    // Do any additional setup after loading the view.
    self.tabBarHeight = 50;
    self.tabBar.layout.barStyle = TYPagerBarStyleProgressView;
    self.tabBar.layout.cellWidth = CGRectGetWidth(self.view.frame)/ 6;
    self.tabBar.layout.cellSpacing = 0;
    self.tabBar.layout.cellEdging = 0;
    self.tabBar.layout.adjustContentCellsCenter = YES;
    self.dataSource = self;
    self.delegate = self;
    SDNavigationController *nav = (SDNavigationController *)self.navigationController;
    [self.pagerController.scrollView.panGestureRecognizer requireGestureRecognizerToFail:nav.swipeGesture];
}

- (void)loadData {
    NSMutableArray *datas = [NSMutableArray array];
    for (NSInteger i = 0; i < 5; ++i) {
        [datas addObject:i%2 == 0 ? [NSString stringWithFormat:@"Tab- %ld",i]:[NSString stringWithFormat:@"Tab2  %ld",i]];
    }
    _datas = [datas copy];
    
    // only add controller at index 1
    [self scrollToControllerAtIndex:1 animate:YES];
    [self reloadData];
    
// first reloadData add controller at index 0,and scroll to index 1
//    [self reloadData];
//    [self scrollToControllerAtIndex:1 animate:YES];
}


- (void)setupSildVc{
    
    // 注册手势驱动
    __weak typeof(self)weakSelf = self;
    [self cw_registerShowIntractiveWithEdgeGesture:YES transitionDirectionAutoBlock:^(CWDrawerTransitionDirection direction) {
        if (direction == CWDrawerTransitionFromLeft) { // 左侧滑出
            [weakSelf defaultAnimationFromLeft];
        } else if (direction == CWDrawerTransitionFromRight) { // 右侧滑出
//            [weakSelf scaleYAnimationFromRight];
        }
    }];
}


- (void)defaultAnimationFromLeft {
    // 强引用leftVC，不用每次创建新的,也可以每次在这里创建leftVC，抽屉收起的时候会释放掉
//    [self cw_showDefaultDrawerViewController:self.leftVC];
    // 或者这样调用
//    [self cw_showDrawerViewController:self.leftVC animationType:CWDrawerAnimationTypeDefault configuration:nil];

    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration defaultConfiguration];
    conf.distance = [UIScreen mainScreen].bounds.size.width * 0.9;
    // 调用这个方法
    [self cw_showDrawerViewController:self.leftVC animationType:CWDrawerAnimationTypeMask configuration:conf];

}

#pragma mark - TYTabPagerControllerDataSource

- (NSInteger)numberOfControllersInTabPagerController {
    return _datas.count;

}

- (nonnull UIViewController *)tabPagerController:(nonnull TYTabPagerController *)tabPagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    if (index % 5 == 0) {
        RRTestViewController *VC = [[RRTestViewController alloc]init];
        VC.view.backgroundColor = [UIColor redColor];
        return VC;
    }else if (index % 5 == 1) {
        ListViewController *VC = [[ListViewController alloc]init];
        VC.text = [@(index) stringValue];
        return VC;
    }else if (index % 5 == 2) {
        CollectionViewController *VC = [[CollectionViewController alloc]init];
        VC.text = [@(index) stringValue];
        return VC;
    } else if (index % 5 == 3){
        CustomViewController *VC = [[CustomViewController alloc]init];
        VC.text = [@(index) stringValue];
        return VC;
    } else {
        RRWebViewController *VC = [[RRWebViewController alloc]init];
        return VC;
    }
}

- (nonnull NSString *)tabPagerController:(nonnull TYTabPagerController *)tabPagerController titleForIndex:(NSInteger)index {
        NSString *title = _datas[index];
        return title;
}

//- (void)encodeWithCoder:(nonnull NSCoder *)coder {
//    <#code#>
//}
//
//- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
//    <#code#>
//}
//
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

//
//  RRPostListViewController.m
//  SDPlayground
//
//  Created by Sun ChunLei (Lofty Team) on 2024/2/20.
//

#import "RRPostListViewController.h"
#import "RRPostTableViewCell.h"

@interface RRPostListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RRPostListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    /// 为了处理初始布局时RRPostListLayout中self.collectionView.frame 不准确，这里重新刷新一下
//    [self.tableView reloadData];
//}
//
//- (void)viewDidLayoutSubviews{
//    [super viewDidLayoutSubviews];
//    /// 为了处理初始布局时RRPostListLayout中self.collectionView.frame 不准确，这里重新刷新一下
//    [self.tableView reloadData];
//}

#pragma mark - tableView delegate & datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RRPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RRPostTableViewCell"];
    cell.itemCount = arc4random() % 5 + 1;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




# pragma mark - lazy add
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.estimatedRowHeight = 100;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        
        [_tableView registerNib:[UINib nibWithNibName:@"RRPostTableViewCell" bundle:nil] forCellReuseIdentifier:@"RRPostTableViewCell"];
    }
    return _tableView;
}

@end

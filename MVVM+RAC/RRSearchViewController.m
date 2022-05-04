//
//  RRSearchViewController.m
//  MVVM+RAC
//
//  Created by sunchunlei on 2022/5/3.
//

#import "RRSearchViewController.h"
#import "RRSearchApi.h"
#import <Masonry/Masonry.h>

#import "RRSettingsViewController.h"

#import "RRSongModel.h"
#import "RRSearchViewModel.h"

@interface RRSearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray <RRSongModel *> *results;

@property (nonatomic, strong) RRSearchViewModel *searchVM;

@property (nonatomic, strong) UISearchController *searchVC;


@property (nonatomic, strong) RACCommand *searchCommand;



@end

@implementation RRSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];

    [self bindVM];
}

- (void)setupView{
    
    self.view.backgroundColor = [UIColor systemCyanColor];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(self.view);
    }];
    
    self.navigationItem.searchController = self.searchVC;
    self.navigationItem.hidesSearchBarWhenScrolling = NO;
}


- (void)bindVM{
    
    self.navigationItem.title = self.searchVM.title;
    self.searchVC.searchBar.text = self.searchVM.searchText;
    
    self.searchCommand = self.searchVM.searchCommand;
    [self.searchCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        self.results = x;
        [self.tableView reloadData];
    }];
}

#pragma mark - searchVC

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    self.searchVM.searchText = self.searchVC.searchBar.text;
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    RRSongModel *songModel = self.results[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ song id: %@",songModel.name,songModel.ID];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[RRSettingsViewController new] animated:YES];
}


# pragma mark - lazy add
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}


# pragma mark - lazy add
- (UISearchController *)searchVC{
    if (_searchVC == nil) {
    //    RRSettingsViewController *settingVC = [RRSettingsViewController new];
        // https://www.cnblogs.com/ming1025/p/6136307.html
        UISearchController *searchVC = [[UISearchController alloc] initWithSearchResultsController:nil];
        searchVC.searchResultsUpdater = self;
        searchVC.obscuresBackgroundDuringPresentation = NO;
        searchVC.definesPresentationContext = YES;
        searchVC.searchBar.tintColor = [UIColor blackColor];
        _searchVC = searchVC;
    }
    return _searchVC;
}


# pragma mark - lazy add
- (RRSearchViewModel *)searchVM{
    if (_searchVM == nil) {
        _searchVM = [RRSearchViewModel new];
    }
    return _searchVM;
}

@end

//
//  RRSettingsViewController.m
//  MVVM+RAC
//
//  Created by sunchunlei on 2022/5/3.
//

#import "RRSettingsViewController.h"
#import "RRSearchApi.h"
#import "RRSongModel.h"
@interface RRSettingsViewController ()

@end

@implementation RRSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor systemYellowColor];
    self.title = @"Settins";
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 
    NSLog(@"%s",__func__);
    
    RRSearchApi *searchApi = [[RRSearchApi alloc] init];
    
    searchApi.keywords = @"beyond";
    
    [searchApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"%@",request.responseString);
        NSArray *songs = [NSArray array];
        songs = [NSArray yy_modelArrayWithClass:[RRSongModel class] json:request.responseObject[@"result"][@"songs"]];
        NSLog(@"%@",songs);

    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"%@",request.error);
    }];
}


@end

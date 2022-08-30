//
//  RRSearchViewModel.m
//  MVVM+RAC
//
//  Created by sunchunlei on 2022/5/4.
//

#import "RRSearchViewModel.h"
#import "RRSearchApi.h"
#import "RRSongModel.h"



@implementation RRSearchViewModel


- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setup{

//    self.title = @"search MVVM";
//    self.searchText = @"beyond";

//    [[[RACObserve(self,searchText) filter:^BOOL(NSString * _Nullable value) {
//        return value.length > 0;
//    }] throttle:0.25] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"throttle:%@",x);
//        [self.searchCommand execute:x];
//    }];
//
//    [[[[[RACObserve(self, searchText)
//    skip:1]
//    map:^id _Nullable(NSString * _Nullable value) {
//        return [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    }]
//    distinctUntilChanged]
//    throttle:0.25]
//    subscribeNext:^(NSString * _Nullable searchKey) {
//        [self.searchCommand execute:searchKey];
//    }];
    
    
    
    [RACScheduler.mainThreadScheduler afterDelay:0.1
                                        schedule:^{
                                            [self.testCommand execute:@3];
                                            [self.testCommand execute:@2];
                                        }];
//    [RACScheduler.mainThreadScheduler afterDelay:0.2
//                                        schedule:^{
//                                            [self.testCommand execute:@3];
//                                        }];
}

# pragma mark - lazy add
- (RACCommand *)testCommand{
    
    if (_testCommand == nil) {
        
        RACCommand *testCommand = [[RACCommand alloc] initWithEnabled:nil signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                NSInteger integer = [input integerValue];
                    for (NSInteger i = 0; i < integer; i++) {
                        [subscriber sendNext:@(i)];
                }
                [subscriber sendCompleted];
                
                return nil;
            }];
        }];
        testCommand.allowsConcurrentExecution = YES;
        
        _testCommand = testCommand;
        
    }
    return _testCommand;
}


/// 注意: Command 一定要一致， 所有这里使用懒加载
- (RACCommand *)searchCommand{
    
    if (_searchCommand == nil) {
        
        RACCommand *searchCommand = [[RACCommand alloc] initWithEnabled:nil signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                NSInteger integer = [input integerValue];
                    for (NSInteger i = 0; i < integer; i++) {
                        [subscriber sendNext:@(i)];
                }
                [subscriber sendCompleted];

//                RRSearchApi *searchApi = [[RRSearchApi alloc] init];
//                searchApi.keywords = input;
//
//                [searchApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//
//                    NSArray *songs = [NSArray array];
//
//                    songs = [NSArray yy_modelArrayWithClass:[RRSongModel class] json:request.responseObject[@"result"][@"songs"]];
//
//                    [subscriber sendNext:songs];
//
//                    [subscriber sendCompleted];
//
//                } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//
//                    [subscriber sendNext:request.error];
//
//                    [subscriber sendCompleted];
//
//                }];
                
                return nil;
            }];
        }];
        
        _searchCommand = searchCommand;
        
    }
    return _searchCommand;
}

@end

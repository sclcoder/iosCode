//
//  RRTestViewController.m
//  SDPlayground
//
//  Created by chunlei.sun on 2021/5/27.
//

#import "RRTestViewController.h"

@interface RRTestViewController ()
@end

@implementation RRTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor systemGrayColor];
//    [self testURL];
    [self testURL2];
}

- (void)testURL2{
    // 截取URL参数
    NSURL *url = [NSURL URLWithString:@"chimeweb://chime.me?open_type=doorknocklist&agentUserId=377894733781378"];
//    NSLog(@"scheme:%@\n host:%@\n path:%@\n pathComponents:%@\n", url.scheme, url.host, url.path, url.pathExtension);
//    NSLog(@"query: %@\n",url.query);
    // open_type=doorknocklist&agentUserId=377894733781378
    NSDictionary *queryDic = [self urlQuery2Dic:url.query];
    for (NSString *key in queryDic) {
        NSLog(@"%@:%@ ", key , queryDic[key]);
    }
    
    NSString *value = [queryDic objectForKey:@"adssdf"];
}

- (NSDictionary *)urlQuery2Dic:(NSString *)queryString{
    NSArray *pairs = nil;
    NSMutableDictionary *queryDic = [NSMutableDictionary new];
    if (queryString != nil && queryString.length != 0) {
        pairs = [queryString componentsSeparatedByString:@"&"];
    }
    if (pairs) {
        NSArray *pair = nil;
        for (NSString *pairString in pairs) {
            pair = [pairString componentsSeparatedByString:@"="];
            if (pair.count == 2) {
                [queryDic setObject:pair[1] forKey:pair[0]];
            }
        }
    }
    return [queryDic copy];
}

- (void)testURL{
    // Do any additional setup after loading the view.
    NSString *URLStr = @"sms:?&body=Take%20a%20look%20at%20this%20property%3A%20https%3A%2F%2Fnewonline.chime.me%2Flisting-detail%2F1051763069%2F1576_Blossom_Hill_RD-San_Jose-CA";
    
    NSString *decodeString = [URLStr stringByRemovingPercentEncoding];
    
//    [self.view makeToast:decodeString duration:100 position:CSToastPositionCenter];
//    NSLog(@"%@", decodeString);
    
    [self.view makeToast:URLStr duration:10 position:CSToastPositionCenter];
    NSLog(@"%@", URLStr);
    
    
    NSString *urlString = [self removeURLParameters:@"https://newonline.chime.me/listing-detail/1054096263/506_W_Sunnyoaks_AVE-Campbell-CA"];
    
    NSLog(@"%@", urlString);
}

- (NSString *)removeURLParameters:(NSString *)urlString{
    NSRange range = [urlString rangeOfString:@"?" options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound) {
        return [urlString substringToIndex:range.location];
    } else {
        return urlString;
    }
}


@end

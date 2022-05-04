//
//  RRSearchApi.m
//  MVVM+RAC
//
//  Created by sunchunlei on 2022/5/3.
//

#import "RRSearchApi.h"

@implementation RRSearchApi

- (instancetype)init{
    if (self = [super init]) {
        [self config];
    }
    return self;
}

- (void)config{
    YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
    
    NSSet *acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", @"text/css", nil];
    [agent setValue:acceptableContentTypes forKeyPath:@"jsonResponseSerializer.acceptableContentTypes"];
}


- (NSString *)baseUrl{
    return @"http://localhost:3000";
}

- (NSString *)requestUrl{
    return @"/search";
}



- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

- (id)requestArgument{
    return @{
        @"keywords":self.keywords,
        @"limit":@(50)
    };
}

@end

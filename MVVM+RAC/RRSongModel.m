//
//  RRSongModel.m
//  MVVM+RAC
//
//  Created by sunchunlei on 2022/5/3.
//

#import "RRSongModel.h"

@implementation RRSongModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
        @"ID":@"id",
    };
}

@end

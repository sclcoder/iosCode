//
//  RRSearchApi.h
//  MVVM+RAC
//
//  Created by sunchunlei on 2022/5/3.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork/YTKNetwork.h>

NS_ASSUME_NONNULL_BEGIN

@interface RRSearchApi : YTKBaseRequest

@property (nonatomic,copy) NSString *keywords;


@end

NS_ASSUME_NONNULL_END

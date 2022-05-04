//
//  RRSearchViewModel.h
//  MVVM+RAC
//
//  Created by sunchunlei on 2022/5/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RRSearchViewModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *searchText;

@property (nonatomic, strong) RACCommand *executeSearch;


@end

NS_ASSUME_NONNULL_END

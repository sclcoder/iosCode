//
//  NSObject+Calculator.h
//  RAC_Play
//
//  Created by sunchunlei on 2022/4/22.
//

#import <Foundation/Foundation.h>
#import "CalculateMaker.h"
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Calculator)

+ (int)makeCalculate:(void(^)(CalculateMaker *make))calculateMaker;

@end

NS_ASSUME_NONNULL_END

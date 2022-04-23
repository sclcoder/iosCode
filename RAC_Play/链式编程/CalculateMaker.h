//
//  CalculateMaker.h
//  RAC_Play
//
//  Created by sunchunlei on 2022/4/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalculateMaker : NSObject

@property(nonatomic,assign) int result;

/// 链式编程的精髓: 1.方法的返回值是闭包(block) 2.闭包一定有返回值且闭包的返回值是自身 3.闭包参数

- (CalculateMaker *(^)(int))add;
- (CalculateMaker *(^)(int))sub;
- (CalculateMaker *(^)(int))muilt;
- (CalculateMaker *(^)(int))divide;


@end

NS_ASSUME_NONNULL_END

//
//  Calculator.h
//  RAC_Play
//
//  Created by sunchunlei on 2022/4/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Calculator : NSObject

@property(nonatomic,assign) int result;
@property(nonatomic,assign) BOOL isEqual;

/// 函数式编程关键: 是把操作尽量写成一系列嵌套的函数或者方法调用
/// 1.每个函数必须要有返回值(对象本身) 2.把函数或者Block当做参数,block参数（需要操作的值）block返回值（操作结果）

- (Calculator *)calculator:(int(^)(int result))calculator;

- (Calculator *)equal:(BOOL(^)(int result))operation;
@end

NS_ASSUME_NONNULL_END

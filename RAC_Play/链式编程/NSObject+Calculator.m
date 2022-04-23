//
//  NSObject+Calculator.m
//  RAC_Play
//
//  Created by sunchunlei on 2022/4/22.
//

#import "NSObject+Calculator.h"


@implementation NSObject (Calculator)

+ (int)makeCalculate:(void (^)(CalculateMaker * _Nonnull))calculateMaker{
    
    CalculateMaker *maker = [[CalculateMaker alloc] init];
    calculateMaker(maker);
    return maker.result;
}

@end

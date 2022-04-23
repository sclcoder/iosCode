//
//  CalculateMaker.m
//  RAC_Play
//
//  Created by sunchunlei on 2022/4/22.
//

#import "CalculateMaker.h"

@implementation CalculateMaker

- (CalculateMaker * (^)(int))add{
    return ^CalculateMaker *(int value){
        self.result += value;
        return self;
    };
}

- (CalculateMaker *(^)(int))sub{
    return ^CalculateMaker *(int value){
        self.result -= value;
        return self;
    };
}

- (CalculateMaker *(^)(int))muilt{
    return ^CalculateMaker *(int value){
        self.result = self.result * value;
        return self;
    };
}

- (CalculateMaker *(^)(int))divide{
    return ^CalculateMaker *(int value){
        self.result = self.result / value;
        return self;
    };
}

@end

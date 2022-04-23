//
//  Calculator.m
//  RAC_Play
//
//  Created by sunchunlei on 2022/4/23.
//

#import "Calculator.h"

@implementation Calculator

- (Calculator *)calculator:(int (^)(int))calculator{
    self.result = calculator(self.result);
    return self;
}

- (Calculator *)equal:(BOOL (^)(int))operation{
    self.isEqual = operation(self.result);
    return self;
}

@end

//
//  Person+B.m
//  test
//
//  Created by 孙春磊 on 2021/4/7.
//

#import "Person+B.h"
#import <objc/runtime.h>

@implementation Person (B)
+ (void)load{
    
    NSLog(@"%s",__func__);
    
//    Method aMethod = class_getInstanceMethod(self, @selector(logA));
//    Method bMethod = class_getInstanceMethod(self, @selector(logB));
//
//    // 直接将方法中的IMP指针指向改变
//    method_exchangeImplementations(aMethod, bMethod);
}

//+ (void)initialize{
//    NSLog(@"%s",__func__);
//}

- (void)logB{
    NSLog(@"B: %s",__func__);
}

@end

//
//  Person+A.m
//  test
//
//  Created by 孙春磊 on 2021/4/7.
//

#import "Person+A.h"
#import <objc/runtime.h>

@implementation Person (A)

+ (void)load{
    
    NSLog(@"%s",__func__);

    
//    Method orgMethod = class_getInstanceMethod(self, @selector(log));
//    Method aMethod = class_getInstanceMethod(self, @selector(logA));
//    
//    method_exchangeImplementations(orgMethod, aMethod);
}

//+ (void)initialize{
//    NSLog(@"%s",__func__);
//}


//- (void)logA{
//    NSLog(@"A: %s",__func__);
//}

@end

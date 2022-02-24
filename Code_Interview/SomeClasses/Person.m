//
//  Person.m
//  test
//
//  Created by 孙春磊 on 2021/4/7.
//

#import "Person.h"

@implementation Person

+ (void)load{
    NSLog(@"%s",__func__);
}

+ (void)initialize{
    NSLog(@"%s",__func__);
}

-(void)log{
    NSLog(@"Person: %s",__func__);
}
@end

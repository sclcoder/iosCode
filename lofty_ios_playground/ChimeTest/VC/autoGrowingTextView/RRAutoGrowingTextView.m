//
//  RRAutoGrowingTextView.m
//  ChimeTest
//
//  Created by Sun ChunLei (Lofty Team) on 2024/7/15.
//

#import "RRAutoGrowingTextView.h"

@implementation RRAutoGrowingTextView

- (void)setContentSize:(CGSize)contentSize{
    [super setContentSize:contentSize];
    
    [self invalidateIntrinsicContentSize];
}

#define MAX_H 200
#define MIN_H 100

//- (CGSize)intrinsicContentSize{
//    return self.contentSize;
//}

@end

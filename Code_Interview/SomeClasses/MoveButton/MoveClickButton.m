//
//  MoveClickButton.m
//  test
//
//  Created by 孙春磊 on 2021/4/12.
//

#import "MoveClickButton.h"

@implementation MoveClickButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(log) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)log{
    NSLog(@"%s",__func__);
}



/**
            动画中的button响应点击事件   相应的扩大button的点击响应范围也需要重写该方法
 */

/// 重写该方法: 为什么重写该方法？因为点击事件的触发后，最终会调用hitTest: 方法查找最适合的响应对象，在hitTest方法内部会调用pointInside方法。该方法用来判断point是否在当前组件的范围内。此时调用到该moveButton的pointInside方法时。默认的范围是其modelLayer的范围。要想判断其运动时的范围，就要使用其presentationLayer的范围。
/// @param point A point that is in the receiver’s local coordinate system (bounds). 在接收者坐标系下
/// @param event event description
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    CGPoint sp = [self convertPoint:point toView:self.superview];
    /// 在父图层的坐标系 sp: A point in the coordinate system of the receiver's superlayer.
    if([self.layer.presentationLayer hitTest:sp]){
        return YES;
    }
////    NSLog(@"%@",NSStringFromCGRect(self.layer.presentationLayer.frame));
//
     /// 扩大点击区域
//    CGRect bigBounds = CGRectInset(self.bounds, -100, -100);
//
//    if (CGRectContainsPoint(bigBounds, point)) {
//        return YES;
//    }
    
    return [super pointInside:point withEvent:event];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//    [super touchesBegan:touches withEvent:event];
//
//    UITouch *touch = touches.allObjects.lastObject;
//
//    CGPoint location  = [touch locationInView:self];
//
//    NSLog(@"%s, %@",__func__,NSStringFromCGPoint(location));
//}


@end

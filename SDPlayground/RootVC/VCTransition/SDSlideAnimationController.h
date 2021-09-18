//
//  SDSIideAnimationController.h
//  SDPlayground
//
//  Created by chunlei.sun on 2021/9/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SDSlideAnimationController : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) UINavigationControllerOperation navOperation;

@end

NS_ASSUME_NONNULL_END

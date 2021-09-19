//
//  SDSIideAnimationController.h
//  SDPlayground
//
//  Created by chunlei.sun on 2021/9/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 触发转场类型
typedef NS_ENUM(NSInteger,SDTransitionType) {
    SDTransitionNavigationControllerOperation,
    SDTransitionTabBarControllerOperation,
    SDTransitionModalOperation,
};


typedef NS_ENUM(NSInteger, SDTabOperationDirection){
    SDTabOperationRight,
    SDTabOperationLeft
};

typedef NS_ENUM(NSInteger,SDModalOperation){
    SDModalOperationModal,
    SDModalOperationDismissal
};

@interface SDSlideAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property(nonatomic,assign) SDTransitionType transitionType;

@property (nonatomic, assign) UINavigationControllerOperation navOperation;

@property(nonatomic,assign) SDTabOperationDirection tabDirectionOperation;

@property(nonatomic,assign) SDModalOperation modalOperation;


@end

NS_ASSUME_NONNULL_END

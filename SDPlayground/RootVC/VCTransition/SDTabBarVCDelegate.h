//
//  SDTabBarVCDelegate.h
//  SDPlayground
//
//  Created by 孙春磊 on 2021/9/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SDTabBarVCDelegate : NSObject <UITabBarControllerDelegate>
@property(nonatomic,strong) UIPercentDrivenInteractiveTransition *interactionController;
@property(nonatomic,assign) BOOL interactive;

@end

NS_ASSUME_NONNULL_END

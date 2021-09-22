//
//  SDNavigationDelegate.h
//  SDPlayground
//
//  Created by chunlei.sun on 2021/9/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SDNavigationDelegate : NSObject<UINavigationControllerDelegate>

@property(nonatomic,strong) UIPercentDrivenInteractiveTransition *interactionController;

// 是否正在交互: 非交互时,不要提供interactionController 不然会假死,一直等待交互
@property(nonatomic,assign) BOOL interactive;

@end

NS_ASSUME_NONNULL_END

//
//  SDNavigationController.h
//  SDPlayground
//
//  Created by chunlei.sun on 2021/5/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SDNavigationController : UINavigationController
@property (nonatomic, weak) UIScreenEdgePanGestureRecognizer *swipeGesture;
@end

NS_ASSUME_NONNULL_END

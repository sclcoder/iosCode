//
//  RRBasePresentedViewController.h
//  ChimeTest
//
//  Created by sunchunlei on 2023/8/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RRBasePresentedViewController : UIViewController

/// 子类可重写，内部空实现
- (void)interactiveFinishedDismiss;

@end

NS_ASSUME_NONNULL_END

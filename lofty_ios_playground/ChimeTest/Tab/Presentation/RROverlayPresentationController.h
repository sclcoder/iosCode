//
//  RROverlayPresentationController.h
//  ChimeTest
//
//  Created by sunchunlei on 2023/8/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 官方文档
 https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/DefiningCustomPresentations.html#//apple_ref/doc/uid/TP40007457-CH25-SW1
 */

@protocol RROverlayPresentationControllerDelegate <NSObject>

@optional

- (void)onTapDimmingView;

@end

@interface RROverlayPresentationController : UIPresentationController

@property (nonatomic, weak) id <RROverlayPresentationControllerDelegate> eventDelegate;


@end

NS_ASSUME_NONNULL_END

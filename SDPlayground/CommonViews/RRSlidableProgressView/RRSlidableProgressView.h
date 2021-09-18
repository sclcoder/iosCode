//
//  RRSlidableProgressView.h
//  RRCommonViews
//
//  Created by renren on 2021/4/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class RRSlidableProgressView;
@protocol RRSlidableProgressViewDelegate  <NSObject>
@optional
/// RRSlidableProgressView 拖拽值改变时调用
/// @param slidableProgressView slidableProgressView
- (void)slidableProgressViewValueDidChanged:(RRSlidableProgressView *)slidableProgressView;

- (void)slidableProgressViewValueDidEndChanged:(RRSlidableProgressView *)slidableProgressView;

@end

@interface RRSlidableProgressView : UIView

@property(nonatomic, weak) id<RRSlidableProgressViewDelegate> delegate;

/// 进度
@property(nonatomic, assign) float progress;
/// 缓冲进度
@property(nonatomic, assign) float cacheProgress;
/// 进度条颜色
@property(nonatomic, strong) UIColor *progressColor;
/// 缓冲进度条颜色
@property(nonatomic, strong) UIColor *cacheProgressColor;
/// 轨道颜色
@property(nonatomic, strong) UIColor *trackColor;

/// 设置进度方法
/// @param progress 进度 0-1
/// @param animated  是否动画
- (void)setProgress:(float)progress animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END

//
//  RRPostListLayout.h
//  SDPlayground
//
//  Created by Sun ChunLei (Lofty Team) on 2024/2/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class RRPostListLayout;
@protocol RRPostListLayoutDelegate <NSObject>

@required
/// 获取collectionView的宽度
- (CGFloat)collectionViewWidth:(RRPostListLayout *)layout;

@end

@interface RRPostListLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<RRPostListLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

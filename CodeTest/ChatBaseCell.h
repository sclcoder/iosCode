//
//  ChatBaseCell.h
//  CodeTest
//
//  Created by chunlei.sun on 2022/2/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RRChatBubbleView : UIView

@property(nonatomic,strong,readonly) UIImageView *bubbleImageView;

@end


@interface ChatBaseCell : UITableViewCell
/// for subClass rewirte
+ (NSString *)registerIdentifer;
+ (NSString *)registerClassName;
+ (NSString *)registerNameForNib;


@property (nonatomic, strong, readonly) RRChatBubbleView *bubbleView;

@property(nonatomic,strong) UIStackView *leftView;

@property(nonatomic,strong) UIStackView *rightView;

@end

NS_ASSUME_NONNULL_END

//
//  ChatBaseCell.m
//  CodeTest
//
//  Created by chunlei.sun on 2022/2/21.
//

#import "ChatBaseCell.h"
#import <Masonry/Masonry.h>
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]


@interface RRChatBubbleView : UIView
@end

@interface ChatBaseCell ()

@property (nonatomic, strong) RRChatBubbleView *bubbleView;

@end

@implementation ChatBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setup];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

/// 采用UIStackView进行布局: 模块的StackView可以封装为单独的View,重写intrinsicContentSize
- (void)setup{
    /// 消息来源不同UI布局方式不同

    
    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeContactAdd];
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.hidesWhenStopped = NO;

    /// 最外层的操作布局 如全选等
    UIStackView *stateStackV  = [[UIStackView alloc] initWithArrangedSubviews:@[btnAdd,indicatorView]];
    stateStackV.axis = UILayoutConstraintAxisVertical;
    stateStackV.alignment = UIStackViewAlignmentCenter;
    stateStackV.distribution = UIStackViewDistributionEqualSpacing;
    stateStackV.spacing = 5;
    stateStackV.backgroundColor =  [UIColor redColor];
    [stateStackV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
    }];
   
    
    
    UISwitch *switcher = [[UISwitch alloc] init];
    RRChatBubbleView *bubbleView = [[RRChatBubbleView alloc] init];
    /// 内部应该再添加StackView 区分状态 如 指示器、失败、重发等操作
    UIStackView *contentStackV  = [[UIStackView alloc] initWithArrangedSubviews:@[switcher,bubbleView]];
    contentStackV.axis = UILayoutConstraintAxisVertical;
    contentStackV.alignment = UIStackViewAlignmentTrailing;
    contentStackV.distribution = UIStackViewDistributionEqualSpacing;
    contentStackV.spacing = 5;
    contentStackV.backgroundColor =  [UIColor yellowColor];
    
    [contentStackV addSubview:self.bubbleView];

    
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    UIImageView *avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_person_avatar"]];
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"user_name";
    nameLabel.numberOfLines = 2;
    nameLabel.font = [UIFont systemFontOfSize:12];
    
    UIStackView *userStackV  = [[UIStackView alloc] initWithArrangedSubviews:@[btn1,avatar,nameLabel]];
    userStackV.axis = UILayoutConstraintAxisVertical;
    userStackV.alignment = UIStackViewAlignmentCenter;
    userStackV.distribution = UIStackViewDistributionEqualSpacing;
    userStackV.spacing = 5;
    userStackV.backgroundColor =  [UIColor greenColor];
    
    [userStackV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
    }];
    
    /// 1.外层Stack-H
    UIStackView *backStackViewH  = [[UIStackView alloc] initWithArrangedSubviews:@[stateStackV,contentStackV,userStackV]];
    backStackViewH.axis = UILayoutConstraintAxisHorizontal;
    backStackViewH.alignment = UIStackViewAlignmentTop;
    backStackViewH.distribution = UIStackViewDistributionFillProportionally;
    backStackViewH.spacing = 10;
    backStackViewH.backgroundColor =  RandomColor;
    
    [self.contentView addSubview:backStackViewH];
    [backStackViewH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    
//    /// 拉伸优先级
//    [stateStackV setContentHuggingPriority:252 forAxis:UILayoutConstraintAxisHorizontal];
//
//    [contentStackV setContentHuggingPriority:250 forAxis:UILayoutConstraintAxisHorizontal];
//
//    [userStackV setContentHuggingPriority:252 forAxis:UILayoutConstraintAxisHorizontal];

}


# pragma mark - subClass rewrite

+ (NSString *)registerIdentifer{
    return @"chat.base.code";
}

+ (NSString *)registerNameForNib{
    return @"ChatBaseCell";
}

+ (NSString *)registerClassName{
    return @"ChatBaseCell";
}

@end




@implementation RRChatBubbleView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_sender_text_bubble"]];

        bubbleImageView.contentMode = UIViewContentModeScaleToFill;
        bubbleImageView.userInteractionEnabled = YES;
        
        [self addSubview:bubbleImageView];
        [bubbleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.textAlignment = NSTextAlignmentRight;
        textLabel.numberOfLines = 0;
        textLabel.font = [UIFont systemFontOfSize:13];
        textLabel.text = @"xxxxxxxxxxxxxxxxxxxxxxxxxxx------------------------------content------------------------------xxxxxxxxxxxxxxxxxxxxxxxxxxx";
        [self addSubview:textLabel];
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(bubbleImageView).insets(UIEdgeInsetsMake(5, 5, 5, 5));
            CGFloat maxWidth =  ([UIScreen mainScreen].bounds.size.width - 100) * 0.85;
            make.width.lessThanOrEqualTo(@(maxWidth));
        }];
    }
    return self;
}

- (CGSize)intrinsicContentSize{
    return CGSizeMake(60, 44);
}

@end

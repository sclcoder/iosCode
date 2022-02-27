//
//  ChatBaseCell.m
//  CodeTest
//
//  Created by chunlei.sun on 2022/2/21.
//

#import "ChatBaseCell.h"
#import <Masonry/Masonry.h>
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]



@interface ChatBaseCell ()
@property (nonatomic, strong, readwrite) RRChatBubbleView *bubbleView;

@property (nonatomic, assign) BOOL layoutForRight;

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
        self.layoutForRight = YES;
        [self setup];
    }
    return self;
}


- (void)updateLayout:(BOOL)layoutForLeft
{
    if (layoutForLeft) {
        if (self.layoutForRight == YES) {
            self.layoutForRight = NO;

            for (UIView *view  in self.backStackView.arrangedSubviews) {
                [self.backStackView insertArrangedSubview:view atIndex:0];
            }
        }
    } else if (self.layoutForRight == NO){
        
        for (UIView *view  in self.backStackView.arrangedSubviews) {
            [self.backStackView insertArrangedSubview:view atIndex:0];
        }
    }
}

/// 采用UIStackView进行布局: 模块的StackView可以封装为单独的View,重写intrinsicContentSize
/// 注意: UIStackView应该可以添加占位  https://www.jianshu.com/p/4d0c07e9ff4c
- (void)setup{
    /// 消息来源不同UI布局方式不同

    
        UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeContactAdd];
        UIButton *btnSys = [UIButton buttonWithType:UIButtonTypeSystem];

    /// 最外层的操作布局 如全选等
    UIStackView *actionStack  = [[UIStackView alloc] initWithArrangedSubviews:@[btnAdd,btnSys]];
    actionStack.axis = UILayoutConstraintAxisVertical;
    actionStack.alignment = UIStackViewAlignmentCenter;
    actionStack.distribution = UIStackViewDistributionEqualSpacing;
    actionStack.spacing = 5;
    actionStack.backgroundColor =  [UIColor redColor];
    [actionStack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
    }];
    self.leftView = actionStack;
   
    
        
                UISwitch *switcher = [[UISwitch alloc] init];

                UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                indicatorView.hidesWhenStopped = NO;
        
            UIStackView *statusStackView = [[UIStackView alloc] initWithArrangedSubviews:@[switcher,indicatorView]];
            statusStackView.axis = UILayoutConstraintAxisVertical;
            statusStackView.alignment = UIStackViewAlignmentTrailing;
            statusStackView.distribution = UIStackViewDistributionEqualSpacing;
            statusStackView.spacing = 5;
            statusStackView.backgroundColor =  [UIColor orangeColor];

        
            RRChatBubbleView *bubbleView = [[RRChatBubbleView alloc] init];
            self.bubbleView = bubbleView;
        
        UIStackView *bubbleStackView = [[UIStackView alloc] initWithArrangedSubviews:@[statusStackView,bubbleView]];
        bubbleStackView.axis = UILayoutConstraintAxisHorizontal;
        bubbleStackView.alignment = UIStackViewAlignmentCenter;
        bubbleStackView.distribution = UIStackViewDistributionEqualSpacing;
        bubbleStackView.spacing = 5;
        bubbleStackView.backgroundColor =  [UIColor whiteColor];
        
            
            UILabel *tips = [[UILabel alloc] init];
            tips.textAlignment = NSTextAlignmentCenter;
            tips.numberOfLines = 1;
            tips.text = @"-----------tips-------------";
            tips.textColor =  [UIColor systemGrayColor];

            UILabel *unread = [[UILabel alloc] init];
            unread.textAlignment = NSTextAlignmentCenter;
            unread.numberOfLines = 1;
            unread.text = @"unread";
            unread.textColor =  [UIColor systemGrayColor];

        UIStackView *tipStackView = [[UIStackView alloc] initWithArrangedSubviews:@[unread,tips]];
        tipStackView.axis = UILayoutConstraintAxisVertical;
        tipStackView.alignment = UIStackViewAlignmentTrailing;
        tipStackView.distribution = UIStackViewDistributionEqualSpacing;
        tipStackView.spacing = 5;
        tipStackView.backgroundColor =  [UIColor whiteColor];
    
    /// 内部应该再添加StackView 区分状态 如 指示器、失败、重发等操作
    UIStackView *contentStack  = [[UIStackView alloc] initWithArrangedSubviews:@[bubbleStackView,tipStackView]];
    contentStack.axis = UILayoutConstraintAxisVertical;
    contentStack.alignment = UIStackViewAlignmentTrailing;
    contentStack.distribution = UIStackViewDistributionEqualSpacing;
    contentStack.spacing = 5;
    contentStack.backgroundColor =  [UIColor yellowColor];
    self.midView = contentStack;


        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeContactAdd];
        UIImageView *avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_person_avatar"]];
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.text = @"user_name";
        nameLabel.numberOfLines = 2;
        nameLabel.font = [UIFont systemFontOfSize:12];
    
    UIStackView *userStack  = [[UIStackView alloc] initWithArrangedSubviews:@[btn1,avatar,nameLabel]];
    userStack.axis = UILayoutConstraintAxisVertical;
    userStack.alignment = UIStackViewAlignmentCenter;
    userStack.distribution = UIStackViewDistributionEqualSpacing;
    userStack.spacing = 5;
    userStack.backgroundColor =  [UIColor greenColor];
    
    [userStack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
    }];
    self.rightView = userStack;
    
    /// 1.外层Stack-H
    UIStackView *backStackView  = [[UIStackView alloc] initWithArrangedSubviews:@[actionStack,contentStack,userStack]];
    backStackView.axis = UILayoutConstraintAxisHorizontal;
    backStackView.alignment = UIStackViewAlignmentTop;
    backStackView.distribution = UIStackViewDistributionFillProportionally;
    backStackView.spacing = 10;
    backStackView.backgroundColor =  RandomColor;
    
    [self.contentView addSubview:backStackView];
    [backStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    self.backStackView = backStackView;

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


@interface RRChatBubbleView ()
@property(nonatomic,strong,readwrite) UIImageView *bubbleImageView;
@end

@implementation RRChatBubbleView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_sender_text_bubble"]];

        bubbleImageView.contentMode = UIViewContentModeScaleToFill;
        bubbleImageView.userInteractionEnabled = YES;
        self.bubbleImageView = bubbleImageView;
        [self addSubview:bubbleImageView];
        [bubbleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (CGSize)intrinsicContentSize{
    return CGSizeMake(60, 44);
}

@end

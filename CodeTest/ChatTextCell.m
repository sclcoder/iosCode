//
//  ChatTextCell.m
//  CodeTest
//
//  Created by 孙春磊 on 2022/2/21.
//

#import "ChatTextCell.h"
#import <Masonry/Masonry.h>

@interface ChatTextCell ()

@property(nonatomic,strong) UILabel *label;


@end

@implementation ChatTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
            UILabel *textLabel = [[UILabel alloc] init];
            textLabel.textAlignment = NSTextAlignmentRight;
            textLabel.numberOfLines = 0;
            textLabel.font = [UIFont systemFontOfSize:13];
            textLabel.text = @"";
            [self.bubbleView addSubview:textLabel];
            [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.bubbleView.bubbleImageView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
                CGFloat maxWidth =  ([UIScreen mainScreen].bounds.size.width - 100) * 0.85;
                make.width.lessThanOrEqualTo(@(maxWidth));
            }];
        
            self.label = textLabel;
    }
    return self;
}

- (void)updateText:(NSString *)text{
    self.text = text;
    _label.text = text;
}

+ (NSString *)registerIdentifer{
    return @"chat.text.code";
}

+ (NSString *)registerNameForNib{
    return @"ChatTextCell";
}

+ (NSString *)registerClassName{
    return @"ChatTextCell";
}
@end

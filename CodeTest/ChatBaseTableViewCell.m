//
//  ChatBaseTableViewCell.m
//  CodeTest
//
//  Created by chunlei.sun on 2022/2/21.
//

#import "ChatBaseTableViewCell.h"
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]

@implementation ChatBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.midContentView.backgroundColor = RandomColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



# pragma mark - subClass rewrite

+ (NSString *)registerIdentifer{
    return @"chat.base";
}

+ (NSString *)registerNameForNib{
    return @"ChatBaseTableViewCell";
}

+ (NSString *)registerClassName{
    return @"ChatBaseTableViewCell";
}

@end

//
//  ChatBaseTableViewCell.h
//  CodeTest
//
//  Created by chunlei.sun on 2022/2/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatBaseTableViewCell : UITableViewCell

/// for subClass rewirte
+ (NSString *)registerIdentifer;
+ (NSString *)registerClassName;
+ (NSString *)registerNameForNib;



@property (weak, nonatomic) IBOutlet UIStackView *stateView;
@property (weak, nonatomic) IBOutlet UIStackView *midContentView;

@property (weak, nonatomic) IBOutlet UIStackView *userInfoView;

@property (weak, nonatomic) IBOutlet UIView *bubbleView;

@property (weak, nonatomic) IBOutlet UIView *customView;

@property (weak, nonatomic) IBOutlet UILabel *tipsView;

@end

NS_ASSUME_NONNULL_END

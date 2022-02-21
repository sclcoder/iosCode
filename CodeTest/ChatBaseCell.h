//
//  ChatBaseCell.h
//  CodeTest
//
//  Created by chunlei.sun on 2022/2/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatBaseCell : UITableViewCell
/// for subClass rewirte
+ (NSString *)registerIdentifer;
+ (NSString *)registerClassName;
+ (NSString *)registerNameForNib;

@end

NS_ASSUME_NONNULL_END

//
//  ChatTextCell.h
//  CodeTest
//
//  Created by 孙春磊 on 2022/2/21.
//

#import "ChatBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChatTextCell : ChatBaseCell

@property(nonatomic,copy) NSString *text;


- (void)updateText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END

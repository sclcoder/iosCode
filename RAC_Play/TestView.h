//
//  TestView.h
//  RAC_Play
//
//  Created by chunlei.sun on 2022/1/7.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestView : UIView
@property (nonatomic, strong) RACSubject *btnClickSignal;

@end

NS_ASSUME_NONNULL_END

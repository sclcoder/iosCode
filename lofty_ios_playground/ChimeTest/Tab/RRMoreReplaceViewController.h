//
//  RRMoreReplaceViewController.h
//  ChimeTest
//
//  Created by chunlei.sun on 2023/8/24.
//

#import <UIKit/UIKit.h>
#import "RRBasePresentedViewController.h"

NS_ASSUME_NONNULL_BEGIN


@class RRMoreReplaceViewController;

@protocol RRTabBarMoreReplaceDataSource <NSObject>

@end


@protocol RRTabBarMoreReplaceDelegate <NSObject>

- (void)moreItem:(RRMoreReplaceViewController *)moreVC didSelectedItemAtIndex:(NSInteger)index;

- (void)moreItemDidCancel:(RRMoreReplaceViewController *)moreVC;

@end


@interface RRMoreReplaceViewController : RRBasePresentedViewController


@property (nonatomic, weak) id <RRTabBarMoreReplaceDelegate> delegate;


@property (weak, nonatomic) IBOutlet UIButton *pushBtn;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end

NS_ASSUME_NONNULL_END

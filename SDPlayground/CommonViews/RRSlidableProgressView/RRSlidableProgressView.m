//
//  RRProgressView.m
//  RRCommonViews
//
//  Created by renren on 2021/4/24.
//

#import "RRSlidableProgressView.h"

@interface RRSlidableProgressView()

@property(nonatomic, strong) UIProgressView *cacheProgressView;
@property(nonatomic, strong) UISlider *sliderView;

@end

@implementation RRSlidableProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews{

    UIProgressView *cacheProgressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    cacheProgressView.progressTintColor = [UIColor systemGray2Color];
    [self addSubview:cacheProgressView];
    self.cacheProgressView = cacheProgressView;
    [cacheProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.centerY.equalTo(self);
    }];
    
    
    UISlider *sliderView = [[UISlider alloc] init];
    [self addSubview:sliderView];
    self.sliderView = sliderView;
    [sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(-1,-1,0,0));;
    }];
    

    
    [sliderView addTarget:self action:@selector(sliderValueWillChange:) forControlEvents:UIControlEventTouchDown];
    
    [sliderView addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    [sliderView addTarget:self action:@selector(sliderValueEndChange:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];

}

- (void)sliderValueWillChange:(UISlider *)slider{
    NSLog(@"%s : %f",__func__, slider.value);
    if (self.delegate && [self.delegate respondsToSelector:@selector(slidableProgressViewValueDidEndChanged:)]) {
        [self.delegate slidableProgressViewValueDidEndChanged:self];
    }
}

- (void)sliderValueDidChange:(UISlider *)slider{
    if (self.delegate && [self.delegate respondsToSelector:@selector(slidableProgressViewValueDidChanged:)]) {
        [self.delegate slidableProgressViewValueDidChanged:self];
    }
}

- (void)sliderValueEndChange:(UISlider *)slider{
    NSLog(@"%s : %f",__func__, slider.value);
    if (self.delegate && [self.delegate respondsToSelector:@selector(slidableProgressViewValueDidEndChanged:)]) {
        [self.delegate slidableProgressViewValueDidEndChanged:self];
    }
}

#pragma mark - getter & setter

- (float)progress{
    return self.sliderView.value;
}

- (void)setProgress:(float)progress{
    [self setProgress:progress animated:NO];
}

- (float)cacheProgress{
    return self.cacheProgressView.progress;
}

- (void)setProgress:(float)progress animated:(BOOL)animated{
    [self.sliderView setValue:progress animated:animated];
}

- (void)setCacheProgress:(float)cacheProgress{
    self.cacheProgressView.progress = cacheProgress;
}

- (UIColor *)progressColor{
    return self.sliderView.tintColor;
}

- (void)setProgressColor:(UIColor *)progressColor{
    self.sliderView.tintColor = progressColor;
}

- (UIColor *)cacheProgressColor{
    return self.cacheProgressView.progressTintColor;
}

- (void)setCacheProgressColor:(UIColor *)cacheProgressColor{
    self.cacheProgressView.progressTintColor = cacheProgressColor;
}

- (UIColor *)trackColor{
    return self.cacheProgressView.trackTintColor;
}
- (void)setTrackColor:(UIColor *)trackColor{
    self.cacheProgressView.trackTintColor = trackColor;
}

@end

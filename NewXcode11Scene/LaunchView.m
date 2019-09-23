//
//  LaunchView.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/22.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "LaunchView.h"

@implementation LaunchView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addlaunchImageView];
        [self addAdImageView];
        [self addSkipBtn];
    }
    return self;
}
- (void)addlaunchImageView {
    UIImageView *imageView = [[UIImageView alloc]init];
    [self addSubview:imageView];
    _launchImageView = imageView;
}

- (void)addAdImageView {
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc]init];
    [self addSubview:imageView];
    _adImageView = imageView;
}

//跳过按钮
- (void)addSkipBtn {
    UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    skipBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
    skipBtn.titleLabel.textColor = [UIColor whiteColor];
    skipBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    skipBtn.alpha = 0.92;
    skipBtn.layer.cornerRadius = 4.0;
    skipBtn.clipsToBounds = YES;
    [self addSubview:skipBtn];
    _skipBtn = skipBtn;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _launchImageView.frame = self.bounds;
    _adImageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-100);
    _skipBtn.frame = CGRectMake(CGRectGetWidth(self.frame) - kSkipBtnWidth - kSkipRightEdging, kSkipTopEdging, kSkipBtnWidth, kSkipBtnHeight);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end

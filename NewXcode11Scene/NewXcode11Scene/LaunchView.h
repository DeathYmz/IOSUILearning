//
//  LaunchView.h
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/22.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImage.h"
//屏幕高度
#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
//屏幕宽度
#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
//跳过按钮宽
#define kSkipBtnWidth 65
//跳过按钮高
#define kSkipBtnHeight 30
//跳过按钮右边距
#define kSkipRightEdging 20
//跳过按钮顶部边距
#define kSkipTopEdging 40
//默认广告页面高度
#define kAdImageViewHeight kScreenHeight-100

NS_ASSUME_NONNULL_BEGIN

@interface LaunchView : UIView
@property (nonatomic, weak) UIImageView *launchImageView;
@property (nonatomic, weak) FLAnimatedImageView *adImageView;
@property (nonatomic, weak) UIButton *skipBtn;
@end
NS_ASSUME_NONNULL_END

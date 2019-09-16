//
//  YMZToast.h
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/11.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD/MBProgressHUD.h"
NS_ASSUME_NONNULL_BEGIN

@interface YMZToast : UIView
+ (void)showStatus:(NSString *)text;
+ (void)showStatus:(NSString *)text duration:(CGFloat)duration;
+ (void)showStatus:(NSString *)text duration:(CGFloat)duration view:(UIView *)view;
+ (void)configure:(MBProgressHUD *)hud;
+ (void)showProgress:(NSString *)text;
+ (void)showProgress:(NSString *)text duration:(CGFloat)duration;
+ (void)showProgress:(NSString *)text duration:(CGFloat)duration view:(UIView *)view;
@end

NS_ASSUME_NONNULL_END

//
//  YMZToast.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/11.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "YMZToast.h"
#import "MBProgressHUD.h"

#define DLToastDefaultBackgroundColor ([[UIColor blackColor] colorWithAlphaComponent:0.7])

@implementation YMZToast

+ (void)showStatus:(NSString *)text {
    [self showStatus:text duration:2.0];
}
+ (void)showStatus:(NSString *)text duration:(CGFloat)duration {
    UIView *view = [UIApplication sharedApplication].delegate.window;
    [self showStatus:text duration:duration view:view];
}
+ (void)showStatus:(NSString *)text duration:(CGFloat)duration view:(UIView *)view {
    MBProgressHUD * hud =[MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    [self configure:hud];
    hud.label.text = text;
    [hud hideAnimated:YES afterDelay:duration];
}

+ (void)configure:(MBProgressHUD *)hud {
    hud.label.textColor = [UIColor whiteColor];
    hud.label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17.0];
    hud.bezelView.color = DLToastDefaultBackgroundColor;
    
}
+ (UIImage *)myImage:(NSString *)name {
    //NSBundle *bundle = [NSString ]
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Bundle" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *path = [bundle pathForResource:@"dl_button_loading@3x" ofType:@"png"];
    UIImage * image = [UIImage imageWithContentsOfFile:path];
    return image;
}

//hidden
+ (void)showProgress:(NSString *)text {
    [self showStatus:text duration:2.0];
}
+ (void)showProgress:(NSString *)text duration:(CGFloat)duration{
    UIView *view = [UIApplication sharedApplication].delegate.window;
    [self showStatus:text duration:duration view:view];
}


+ (void)showProgress:(NSString *)text duration:(CGFloat)duration view:(UIView *)view {
    MBProgressHUD * hud =[MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.text = text;
    hud.customView = [[UIImageView alloc] initWithImage:[self myImage:@"dl_button_loading@3x"]];
    [self configure:hud];
    
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
    animation.duration  = 1;
    animation.autoreverses = NO;
    animation.fillMode =kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT;
    [hud.customView.layer addAnimation:animation forKey:nil];
    [hud hideAnimated:YES afterDelay:duration];

}

@end

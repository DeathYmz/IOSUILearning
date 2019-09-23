//
//  LaunchViewManager.h
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/22.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
#define DURATION 5
@class AdModel;

@interface LaunchViewManager : UIView
@property (nonatomic, strong) AdModel  *adModel;//广告模型
@property (nonatomic, copy) void(^tapClick) ();//点击广告图回调
+(instancetype)launchViewManger;//创建一个对象
-(void)showView:(UIView *)view;//展示对象
@end

NS_ASSUME_NONNULL_END

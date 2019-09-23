//
//  AlertViewController.h
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/9.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
NS_ASSUME_NONNULL_BEGIN

@interface AlertViewController : UIViewController
@property (nonatomic, strong) MBProgressHUD *HUD;
@property (nonatomic, strong) UIButton *cancel;
@property (nonatomic, strong) UIButton *save;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) UIView *background;
@end


NS_ASSUME_NONNULL_END

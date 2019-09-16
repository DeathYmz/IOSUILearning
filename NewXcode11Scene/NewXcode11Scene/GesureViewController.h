//
//  GesureViewController.h
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/8/29.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface GesureViewController : UIViewController
@property(nonatomic, strong)UIWindow *childWindow;
@property(nonatomic, strong) UIButton *addButton;
@property(nonatomic, strong) UIButton *subButton;
@property(nonatomic, strong) UILabel *countLable;
@property(nonatomic, strong)UIButton *checkScan;
@property(nonatomic, strong)UIButton *nextPageButton;
@property(nonatomic, strong)UIButton *prePageButton;
@property(nonatomic, strong) UITextField *inputUrl;


@end

NS_ASSUME_NONNULL_END

//
//  NavihationViewController.h
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/8/29.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContainerController : UIViewController
@property (nonatomic, readonly, strong) __kindof UIViewController *contentViewController;
@end

@interface NavihationViewController : UINavigationController

//contentView
@end

NS_ASSUME_NONNULL_END

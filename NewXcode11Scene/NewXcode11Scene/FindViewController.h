//
//  FindViewController.h
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/2.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FindViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) UIButton * CheckText;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UITextField *inputText;

@end

NS_ASSUME_NONNULL_END

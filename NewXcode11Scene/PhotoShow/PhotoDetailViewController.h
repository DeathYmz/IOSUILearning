//
//  PhotoDetailViewController.h
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/5.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImageView.h"
NS_ASSUME_NONNULL_BEGIN

@interface PhotoDetailViewController : UIViewController<UIScrollViewDelegate>
@property(nonatomic, copy) void (^fs_rightBtnClickBlock)(UIButton * fs_rightBtn);//右侧按钮
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) FLAnimatedImageView *gestImageView;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSArray *imagePaths;
@property (nonatomic) NSUInteger index;

- (void)loadImage:(NSString *)path;
-(void)loadPhoto:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END

//
//  ViewController.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/8/29.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "ViewController.h"
#import "GesureViewController.h"
#import <Masonry/Masonry.h>
#import "NavihationViewController.h"
#define time 0.2
/*可以用了：Cocoapods 安装Masonry框架。
 1、打开工程目录 pod init //会直接出现podfile
 2、可以pod search masonry 搜索源是否存在
 3、podfile 里面加一句： pod ‘Masonry’
 4、open NewXcode11Scene.xcworkspace 不能打开错了若是打开成.xcodeproj 会报错ld: library not found for -lMasonry
*/

@interface ViewController ()
@property (nonatomic, strong) UIView  * navigationView;
@property (nonatomic, strong) UIImageView *imageviewLeft;
@property (nonatomic, strong) UIImageView *imageviewRight;
@end

@implementation ViewController
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)initView{
    [self initNG];
    
    //Label
       self.countLable= [[UILabel alloc] init];
       self.countLable.enabled = YES;
       self.countLable.highlighted = YES;
       [self.countLable setShadowColor:[UIColor blackColor]];//设置阴影颜色
       [self.countLable setShadowOffset:CGSizeMake(2, 2)];
       self.countLable.textColor = [UIColor blackColor];//默认黑色
       self.countLable.font = [UIFont systemFontOfSize:30];//加粗方法
       self.countLable.layer.borderColor = [UIColor grayColor].CGColor;
       self.countLable.layer.borderWidth = 1;//为Label 加上边框
       self.countLable.textAlignment =NSTextAlignmentCenter;// 设置文字对齐方式
       self.countLable.text=@"0";
       [self.view  addSubview:self.countLable];
       [self.countLable mas_makeConstraints:^(MASConstraintMaker *make) {
           //尺寸约束
           make.size.mas_equalTo(CGSizeMake(60, 60));
           //位置约束
           make.center.mas_equalTo(self.view).offset(0);
           
       }];
    
    //addbutton
    self.addButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.addButton setTitle:@"+" forState:UIControlStateNormal];
    self.addButton.titleLabel.font = [UIFont systemFontOfSize:50];//设置button的字体
    [self.addButton addTarget:self action:@selector(onClickAddButton:) forControlEvents:UIControlEventTouchUpInside];//监听点击事件
    [self.view addSubview:self.addButton];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //尺寸约束
        make.size.mas_equalTo(CGSizeMake(100, 100));
        //位置约束
        make.right.equalTo(self.countLable.mas_right).offset(+100);//右边
//        make.top.equalTo(self.countLable.mas_top).offset(-15);//底部
        make.centerY.equalTo(self.countLable);
    }];
    
    
    //subbutton
    self.subButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.subButton setTitle:@"-" forState:UIControlStateNormal];
    self.subButton.titleLabel.font = [UIFont systemFontOfSize:50];//设置button的字体
    [self.subButton addTarget:self action:@selector(onClickSubButton:) forControlEvents:UIControlEventTouchUpInside];//监听点击事件
    [self.view addSubview:self.subButton];
    [self.subButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));//尺寸约束
        make.left.equalTo(self.countLable.mas_left).offset(-100);//左边
        make.centerY.equalTo(self.countLable);
        //make.top.equalTo(self.countLable.mas_top).offset(-15);//底部
        
    }];
    
    //nextpagebutton
    self.nextPageButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //self.subButton.backgroundColor=[UIColor blueColor];//
    [self.nextPageButton setTitle:@"next" forState:UIControlStateNormal];
    self.nextPageButton.titleLabel.font = [UIFont systemFontOfSize:40];//设置button的字体
    //self.subButton.titleLabel.textColor = [UIColor whiteColor];
    [self.nextPageButton addTarget:self action:@selector(onClickNextPageButton:) forControlEvents:UIControlEventTouchUpInside];//监听点击事件
    [self.view addSubview:self.nextPageButton];
    [self.nextPageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));//尺寸约束
        make.centerX.equalTo(self.addButton);
        make.bottom.equalTo(self.view.mas_bottom).offset(-self.tabBarController.accessibilityFrame.size.height-70);
//        make.right.equalTo(self.countLable.mas_right).offset(100);//左边
//        make.bottom.equalTo(self.countLable.mas_top).offset(250);//底部
        
    }];
    
   
}

-(void)initNG{
    UILabel *titleText = [[UILabel alloc] initWithFrame: CGRectMake(160, 0, 120, 50)];
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor=[UIColor whiteColor];
    [titleText setFont:[UIFont systemFontOfSize:17.0]];
    [titleText setText:@"TEST TITLE"];
    self.navigationItem.titleView=titleText;
    //通过navigationBar设置导航栏的外观，包括颜色和tintColor;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UIBarButtonItem * rightButton =
    [[UIBarButtonItem alloc]initWithTitle:@"nextpage"
                                    style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(onClickPushPage:)];
    rightButton.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightButton;//右上

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self initView];
    UIPanGestureRecognizer *edgeGes = [[UIPanGestureRecognizer alloc]  initWithTarget: self  action:@selector(rightPan:)];
    [self.view addGestureRecognizer:edgeGes];
}


-(void)onClickPushPage:(id)sender{
    GesureViewController * GVC = [[GesureViewController alloc]init];
    NSAssert([NSThread isMainThread], @"add child view controller must be called on the main thread");
    [self.navigationController pushViewController:GVC animated:YES];
    
    NSLog(@"push???");
}

- (void)rightPan:(UIPanGestureRecognizer*)recongizer {
    NSLog(@"UIPanGestureRecognizer");
    NSUInteger index = [self.tabBarController selectedIndex];
    CGPoint point = [recongizer translationInView:self.view];
    NSLog(@"%f,%f",point.x,point.y);
    recongizer.view.center = CGPointMake(recongizer.view.center.x + point.x, recongizer.view.center.y);
    [recongizer setTranslation:CGPointMake(0, 0) inView:self.view];
    if (recongizer.state == UIGestureRecognizerStateEnded) {
        if (recongizer.view.center.x < [UIScreen mainScreen].bounds.size.width && recongizer.view.center.x > 0 ) {
            [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                recongizer.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2 ,[UIScreen mainScreen].bounds.size.height/2);
            }completion:^(BOOL finished) {
                
            }];
        } else if (recongizer.view.center.x <= 0 ){
            [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                recongizer.view.center = CGPointMake(-[UIScreen mainScreen].bounds.size.width/2 ,[UIScreen mainScreen].bounds.size.height/2);
            }completion:^(BOOL finished) {
                [self.tabBarController setSelectedIndex:index+1];
                recongizer.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2 ,[UIScreen mainScreen].bounds.size.height/2);
            }];
        } else {
            [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                recongizer.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width*1.5 ,[UIScreen mainScreen].bounds.size.height/2);
            }completion:^(BOOL finished) {
                [self.tabBarController setSelectedIndex:index-1];
                recongizer.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2 ,[UIScreen mainScreen].bounds.size.height/2);
            }];
        }
    }
}

-(void)viewDidAppear:(BOOL)animated {
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    //if(selectedIndex + 1 < 4 ){
        UIViewController* v2 = [self.tabBarController.viewControllers objectAtIndex:selectedIndex+1];
        UIImage* image2 = [self imageByCropping:v2.view toRect:v2.view.bounds];
        _imageviewRight = [[UIImageView alloc] initWithImage:image2];
        _imageviewRight.frame = CGRectMake(_imageviewRight.frame.origin.x + [UIScreen mainScreen].bounds.size.width, 0, _imageviewRight.frame.size.width, _imageviewRight.frame.size.height);
        [self.view addSubview:_imageviewRight];
    //}
}

- (void)viewDidDisappear:(BOOL)animated {
    [_imageviewRight removeFromSuperview];
}
//与pan结合使用 截图方法，图片用来做动画
-(UIImage*)imageByCropping:(UIView*)imageToCrop toRect:(CGRect)rect
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGSize pageSize = CGSizeMake(scale*rect.size.width, scale*rect.size.height) ;
    UIGraphicsBeginImageContext(pageSize);
    CGContextScaleCTM(UIGraphicsGetCurrentContext(), scale, scale);
    
    CGContextRef resizedContext =UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(resizedContext,-1*rect.origin.x,-1*rect.origin.y);
    [imageToCrop.layer renderInContext:resizedContext];
    UIImage*imageOriginBackground =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    imageOriginBackground = [UIImage imageWithCGImage:imageOriginBackground.CGImage scale:scale orientation:UIImageOrientationUp];
    
    return imageOriginBackground;
}

-(void)onClickNextPageButton:(id)sender{
    GesureViewController * GVC = [[GesureViewController alloc] init];
    NSAssert([NSThread isMainThread], @"add child view controller must be called on the main thread");
    [GVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:GVC animated:YES completion:nil];
}


-(void)onClickAddButton:(id)sender{
    //
    NSUInteger num=[self.countLable.text intValue];
    num= num + 1;
    self.countLable.text=[NSString stringWithFormat:@"%i",num];
}
-(void)onClickSubButton:(id)sender{
    //
    NSUInteger num=[self.countLable.text intValue];
    if(num>0) num = num - 1;//
    self.countLable.text=[NSString stringWithFormat:@"%i",num];
}

@end

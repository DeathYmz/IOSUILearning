//
//  FindViewController.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/2.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "FindViewController.h"
#import "Masonry/Masonry.h"
#import "WebViewController.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define time 0.2
@interface FindViewController () <UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *imageviewLeft;
@property (nonatomic, strong) UIImageView *imageviewRight;

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:pan];
}


#pragma mark - Navigation
// 隐藏navigation
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //主界面隐藏导航栏，推荐使用这种方式来设置
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)viewDidAppear:(BOOL)animated {
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    UIViewController* v1 = [self.tabBarController.viewControllers objectAtIndex:selectedIndex-1];
    UIImage* image1 = [self imageByCropping:v1.view toRect:v1.view.bounds];
    _imageviewLeft = [[UIImageView alloc] initWithImage:image1];
    _imageviewLeft.frame = CGRectMake(_imageviewLeft.frame.origin.x - [UIScreen mainScreen].bounds.size.width, _imageviewLeft.frame.origin.y , _imageviewLeft.frame.size.width, _imageviewLeft.frame.size.height);
    [self.view addSubview:_imageviewLeft];
    
    UIViewController* v2 = [self.tabBarController.viewControllers objectAtIndex:selectedIndex+1];
    UIImage* image2 = [self imageByCropping:v2.view toRect:v2.view.bounds];
    _imageviewRight = [[UIImageView alloc] initWithImage:image2];
    _imageviewRight.frame = CGRectMake(_imageviewRight.frame.origin.x + [UIScreen mainScreen].bounds.size.width, 0, _imageviewRight.frame.size.width, _imageviewRight.frame.size.height);
    [self.view addSubview:_imageviewRight];
}

- (void)viewDidDisappear:(BOOL)animated {
    [_imageviewLeft removeFromSuperview];
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

- (void)handlePan:(UIPanGestureRecognizer*)recongizer {
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
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)initView{
    //addiputText
    self.inputText= [[UITextField alloc]init];
    self.inputText.borderStyle = UITextBorderStyleRoundedRect;//设置边框h格式
    self.inputText.backgroundColor = [UIColor whiteColor];//设置背景颜色
    self.inputText.placeholder = @"URL";
    self.inputText.returnKeyType = UIReturnKeyDone;
    self.inputText.delegate = self;//设置委托
    self.inputText.autocapitalizationType = UITextAutocapitalizationTypeNone;// 设置对象自动大写功能，
    self.inputText.autocorrectionType = UITextAutocorrectionTypeNo;//设置拼写纠正
    self.inputText.clearsOnInsertion = YES;
    self.inputText.text =  @"http://wx4.sinaimg.cn/large/006DFKaTly1fenjm82suwj30fk0fkmyn.jpg";
    [self.view addSubview:self.inputText];
    [self.inputText mas_makeConstraints:^(MASConstraintMaker *make) {
        //尺寸约束
        make.size.mas_equalTo(CGSizeMake(250, 50));
        //位置约束
        make.center.equalTo(self.view).offset(0);//右边
    }];
    //check
    self.CheckText=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.CheckText setTitle:@"OK" forState:UIControlStateNormal];
    self.CheckText.titleLabel.font = [UIFont systemFontOfSize:20];//设置button的字体
    [self.CheckText addTarget:self action:@selector(onClickCheckButton:) forControlEvents:UIControlEventTouchUpInside];//监听点击事件
    [self.view addSubview:self.CheckText];
    [self.CheckText mas_makeConstraints:^(MASConstraintMaker *make) {
        //尺寸约束
        make.size.mas_equalTo(CGSizeMake(100, 100));
        //位置约束
        make.center.equalTo(self.view).offset(80);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{//回车相应
    WebViewController * WVC = [[WebViewController alloc]init];
    WVC.URL=self.inputText.text;
    NSLog(@"%@",self.inputText.text);//@"http://www.baidu.com"]];
    [self.navigationController pushViewController:WVC animated:nil];
    return YES;
}

-(void)onClickCheckButton:(id)sender{
    WebViewController * WVC = [[WebViewController alloc]init];
    WVC.hidesBottomBarWhenPushed = YES;//将 push 到的页面的 UItabBar 隐藏
    WVC.URL=self.inputText.text;
    NSLog(@"%@",self.inputText.text);//@"http://www.baidu.com"]];
    [self.navigationController pushViewController:WVC animated:nil];
}



@end

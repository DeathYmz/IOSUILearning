//
//  GesureViewController.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/8/29.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "GesureViewController.h"
#import "ViewController.h"
#import <Masonry/Masonry.h>
@interface GesureViewController ()

@end

@implementation GesureViewController
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)initNG{
    UILabel *titleText = [[UILabel alloc] initWithFrame: CGRectMake(160, 0, 120, 50)];
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor=[UIColor whiteColor];
    [titleText setFont:[UIFont systemFontOfSize:17.0]];
    [titleText setText:@"TEST TITLE"];
    self.navigationItem.titleView=titleText;
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]
                                                    initWithTitle:@"nextpage"
                                                    style:UIBarButtonItemStyleBordered
                                                    target:self
                                     action:@selector(onClickPushPage:)];
    //rightButton.image=[UIImage imageNamed:@"right_button.png"];
    rightButton.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightButton;
    
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
        make.top.equalTo(self.countLable.mas_top).offset(-15);//底部
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
        make.top.equalTo(self.countLable.mas_top).offset(-15);//底部
        
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
        make.right.equalTo(self.countLable.mas_right).offset(100);//左边
        make.bottom.equalTo(self.countLable.mas_top).offset(200);//底部
        
    }];
    //prepagebutton
    self.prePageButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //self.subButton.backgroundColor=[UIColor blueColor];//
    [self.prePageButton setTitle:@"pre" forState:UIControlStateNormal];
    self.prePageButton.titleLabel.font = [UIFont systemFontOfSize:40];//设置button的字体
    //self.subButton.titleLabel.textColor = [UIColor whiteColor];
    [self.prePageButton addTarget:self action:@selector(onClickprePageButton:) forControlEvents:UIControlEventTouchUpInside];//监听点击事件
    [self.view addSubview:self.prePageButton];
    [self.prePageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));//尺寸约束
        make.right.equalTo(self.countLable.mas_right).offset(-100);//左边
        make.bottom.equalTo(self.countLable.mas_top).offset(200);//底部
        
    }];
    
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationController.navigationBarHidden=NO;
    //[self.navigationController setNavigationBarHidden:NO animated:YES];
    [self initView];
}

-(void)onClickPushPage:(id)sender{
    GesureViewController * GVC = [[GesureViewController alloc]init];
    NSAssert([NSThread isMainThread], @"add child view controller must be called on the main thread");
    [self.navigationController pushViewController:GVC animated:YES];
    NSLog(@"push???");
}
-(void)onClickNextPageButton:(id)sender{
    GesureViewController * GVC = [[GesureViewController alloc]init];
    NSAssert([NSThread isMainThread], @"add child view controller must be called on the main thread");
    //self.accessibilityViewIsModal = YES;
    //self.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [GVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:GVC animated:YES completion:nil];
//    [self addChildViewController:GVC];
//    [self.view addSubview:GVC.view];
}

-(void)onClickprePageButton:(id)sender{
    
    UIViewController *vc = self.presentingViewController;
    [vc dismissViewControllerAnimated:YES completion:NULL];
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

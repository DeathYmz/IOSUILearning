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
@interface FindViewController () <UITextFieldDelegate>
@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
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
    //打印此时的界面栈
   // [GlobalKit viewControllersArray:self];
}

@end

//
//  AlertViewController.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/9.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "AlertViewController.h"
#import "Masonry/Masonry.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "MBProgressHUD.h"//open source
#import "YMZToast.h"
@interface AlertViewController ()
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;
@end

@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBackground:)];
    [self.view addGestureRecognizer:tap];
    self.view.userInteractionEnabled = YES;
    [self setupUI];
    //沙盒主目录  stringByAppendingPathComponent:@"Library/Caches"
    NSString *homePath = NSHomeDirectory();
    //沙盒tmp
    NSString *tmp = NSTemporaryDirectory();
    NSLog(@"%@\n%@",tmp,homePath);
    
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [arr lastObject];
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"tese.plist"];
    
    NSDictionary *content = @{@"字典数据测试1":@"1",@"字典数据测试2":@"2",@"字典数据测试":@"3"};
    //用writeToFile方法写文件会覆盖掉原来的内容
    [content writeToFile:filePath atomically:YES];
    //读取数据(通过字典的方式读出文件中的内容)
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSLog(@"%@",dic);
}
-(void)setupUI{
    self.background = [[UIView alloc] init];
    self.background.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];// 背景色透明
    [self.view addSubview:self.background];
    [self.background mas_makeConstraints:^(MASConstraintMaker *make) {
//        /make.size.equalTo()
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    self.cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    self.save = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    self.cancel.backgroundColor = [UIColor whiteColor];
    self.cancel=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancel setTitle:@"取消" forState:UIControlStateNormal];
    self.cancel.titleLabel.font = [UIFont systemFontOfSize:50];//设置button的字体
    [self.view addSubview:self.cancel];
    [self.cancel addTarget:self action:@selector(onClickCancel:) forControlEvents:UIControlEventTouchUpInside];//监听点击事件
    [self.cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.background).offset(-5);//右边
        make.centerX.equalTo(self.background);
    }];

    self.save=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.save setTitle:@"保存" forState:UIControlStateNormal];
    self.save.titleLabel.font = [UIFont systemFontOfSize:50];//设置button的字体
    [self.save addTarget:self action:@selector(onChlickSave:) forControlEvents:UIControlEventTouchUpInside];//监听点击事件
    [self.view addSubview:self.save];
    [self.save mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.background);
        make.bottom.equalTo(self.cancel.mas_top).offset(-5);//右边
    }];
    
}
-(void)onClickCancel:(id)sender{
    NSLog(@"cancel");
    UIViewController *vc = self.presentingViewController;
    [vc dismissViewControllerAnimated:YES completion:NULL];
}
- (void)onChlickSave:(id)sender {
    if([[self.imagePath pathExtension] isEqualToString:@"jpg"]){
        NSLog(@"image.jpg save"); UIImageWriteToSavedPhotosAlbum([UIImage imageWithContentsOfFile:self.imagePath],self,@selector(image:didFinishSavingWithError:contextInfo:),nil);
        
    } else{
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        //    NSDictionary *metadata = @{@"UTI":(__bridge NSString *)kUTTypeGIF};
        NSData *gifData = [NSData dataWithContentsOfFile:self.imagePath];
        [library writeImageDataToSavedPhotosAlbum:gifData metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
            if (error) {
                NSLog(@"you fail to save gif");//not found / can add failed figure
                
            }else{
                NSLog(@"you success to save gif");
                [YMZToast showStatus:@"save success"];
                UIViewController *vc = self.presentingViewController;
                [vc dismissViewControllerAnimated:YES completion:NULL];
            }
        }] ;
    }
    
}

- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo {
    if(error) {
        NSLog(@"failer");//can add failed figure
        
    }else{
        NSLog(@"success");
        [YMZToast showStatus:@"save success"];
        UIViewController *vc = self.presentingViewController;
        [vc dismissViewControllerAnimated:YES completion:NULL];
    }
}
-(void)clickBackground:(id)sender{
    UIViewController *vc = self.presentingViewController;
    [vc dismissViewControllerAnimated:YES completion:NULL];
}

@end

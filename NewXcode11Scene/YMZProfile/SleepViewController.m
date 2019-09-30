//
//  SleepViewController.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/5.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "SleepViewController.h"
#import "PaintView.h"
#import "ProfileViewController.h"
@interface SleepViewController ()

@end

@implementation SleepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view layoutIfNeeded];
    CAGradientLayer * gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.frame = self.view.bounds;
    gradientLayer.colors =  @[(__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor  blueColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    UIColor *color1 = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
    UIColor *color2 = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    UIColor *color3 = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    NSArray *colors = [NSArray arrayWithObjects:(id)color1.CGColor,color2.CGColor,color3.CGColor,nil];
    NSArray *locations = [NSArray arrayWithObjects:@(0.0),@(0.7),@(1.0),nil];
    CAGradientLayer *masker = [CAGradientLayer layer];
    masker.colors  = colors;
    masker.locations = locations;
    masker.frame = self.inputView.bounds;
    masker.startPoint = CGPointMake(0, 0);
    masker.endPoint = CGPointMake(1, 1);
    //[self.view.layer addSublayer:gradientLayer];
    //self.view.layer.mask = masker;
    PaintView *circle = [[PaintView alloc] initWithFrame:self.view.bounds];
    [circle drawRect:self.view.bounds];
    [self.view addSubview:circle];
    
//    dispatch_queue_ myqueue = dispatch_queue_create(@"miaomiao", NULL);
//    dispatch_async(myqueue, ^{
//        NSLog(@"miaomiao");
//    })
    
}

-(void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
    [self initNavigation];
}
-(void) initNavigation {
    //navagation color
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Bundle" ofType:@"bundle"]];
    NSString *imagePath = [bundle pathForResource:@"list" ofType:@"png"];
    UIBarButtonItem *rightButton =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithContentsOfFile:imagePath]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(profileView:)];
    rightButton.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)profileView:(id)sender {
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    [self.navigationController pushViewController:profile animated:nil];
}
-(void)downloadFile{
    //1.创建url
    NSString *urlStr=@"https://github.com/cnbin/insertDemo/archive/master.zip";
    urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    //2.创建请求
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    //3.创建会话（这里使用了一个全局会话）并且启动任务
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDownloadTask *downloadTask=[session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (!error) {
            //注意location是下载后的临时保存路径,需要将它移动到需要保存的位置
            NSError *saveError;
            NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSString *savePath=[cachePath stringByAppendingPathComponent:@"master.zip"];
            NSLog(@"%@",savePath);
            NSURL *saveUrl=[NSURL fileURLWithPath:savePath];
            [[NSFileManager defaultManager] copyItemAtURL:location toURL:saveUrl error:&saveError];
            if (!saveError) {
                NSLog(@"save sucess.");
            }else{
                NSLog(@"error is :%@",saveError.localizedDescription);
            }
        }else{
            NSLog(@"error is :%@",error.localizedDescription);
        }
    }];
    [downloadTask resume];
}


@end

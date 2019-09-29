//
//  YMZAppDelegate.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/6.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "YMZAppDelegate.h"

#import "ViewController.h"
#import "NavihationViewController.h"
#import "WebViewController.h"
#import "FindViewController.h"
#import "PhotoViewController.h"
#import "SleepViewController.h"
#import "StartViewController.h"
#import "LaunchViewManager.h"
#import "AdModel.h"
@implementation YMZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [NSThread sleepForTimeInterval:2];
    [self setupFirstView];
    [self showLaunchImageView];//调用启动图动画
    [self addADLaunchController];
    
    return YES;
}

- (void) setupFirstView {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window setHidden:NO];
    ViewController *VC =  [[ViewController alloc] init];
    VC.title=@"计数器";
    FindViewController  *FVC =[[FindViewController alloc] init];
    FVC.title=@"网址搜索";
    PhotoViewController  *PVC = [[PhotoViewController alloc] init];
    PVC.title=@"照片";
    SleepViewController  *SVC = [[SleepViewController alloc] init];
    SVC.title=@"催眠";
    NavihationViewController * navVC= [[NavihationViewController alloc] initWithRootViewController:VC];
    NavihationViewController * navFVC= [[NavihationViewController alloc] initWithRootViewController:FVC];
    NavihationViewController * navPVC= [[NavihationViewController alloc] initWithRootViewController:PVC];
    NavihationViewController * navSVC = [[NavihationViewController alloc] initWithRootViewController:SVC];
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[navVC,navFVC,navPVC,navSVC];
    self.window.rootViewController =  self.tabBarController;
    [self.window makeKeyAndVisible];
}
//启动动画
-(void)showLaunchImageView{

    UIImageView* launchImageView = [[UIImageView alloc]initWithFrame:self.window.bounds];
    launchImageView.image = [self getLaunchImage];
    [self.window addSubview:launchImageView];
    [self.window bringSubviewToFront:launchImageView];
    _label = [[UILabel alloc] initWithFrame:CGRectMake(140, 220, 250, 100)];
    _label.text = @"DeathYmz";
    _label.font = [UIFont systemFontOfSize:30];
    _label.textColor =[UIColor grayColor];
    [self.window addSubview:_label];
    [self.window bringSubviewToFront:_label];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1.2 animations:^{
            launchImageView.alpha = 0.0;
            launchImageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
            self.label.alpha = 0.0;
            self.label.transform = CGAffineTransformMakeScale(1.2, 1.2);
        }completion:^(BOOL finished) {
            [launchImageView removeFromSuperview];
            [self.label removeFromSuperview];
        }];
    });
}
//根据屏幕尺寸自动选择合适尺寸的启动图片
-(UIImage*)getLaunchImage{
    UIImage *launchImage = nil;
    NSString* viewOrientation = nil;
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    //是否左横屏或者右横屏
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        //home键所在方向为left或者right
        viewOrientation = @"Landscape";  //横屏
    }else{
        viewOrientation =@"Portrait";  //竖屏
    }
    //取得所有启动图片
    NSArray *imagesDictionary = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    
    for (NSDictionary *dict in imagesDictionary) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        //判断图片的尺寸和横竖屏是否和当前屏幕符合
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImage = [UIImage imageNamed:dict[@"UILaunchImageName"]];
        }
    }
    
    return launchImage;
}



//加载广告
- (void)addADLaunchController
{
    AdModel * adModel=[[AdModel alloc]init];
//    adModel.launchUrl = @"https://n.sinaimg.cn/sinacn14/123/w640h1083/20180722/0d22-hfqtahi8201915.jpg";
    //动态图
    adModel.launchUrl = @"http://img.zcool.cn/community/01746f5a83ec26a8012045b361bb8a.gif";
    //    //点击跳转链接
    adModel.adDetailUrl = @"http://www.baidu.com";
    UIViewController *rootViewController = self.window.rootViewController;
    LaunchViewManager *launchController = [[LaunchViewManager alloc] init];
    launchController.adModel = adModel;
    [launchController showView:rootViewController.view];
    __weak typeof(self)weakSelf = self;
    launchController.tapClick =^{
        //点击跳转带url
        
        WebViewController * WVC = [[WebViewController alloc]init];
        WVC.hidesBottomBarWhenPushed = YES;//将 push 到的页面的 UItabBar 隐藏
        WVC.URL=adModel.launchUrl;
        [self.tabBarController.navigationController pushViewController:WVC animated:nil];
        
//        XLAdViewController * adVc=[[XLAdViewController alloc]init];
//        adVc.adModel = adModel;
//        adVc.hidesBottomBarWhenPushed=YES;
//        [weakSelf.tabBarController pushViewController:adVc animated:YES];
    };
}


- (void)aboutLaunchScreen {
    //获取LaunchScreen.storyborad
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Launch Screen" bundle:nil];
    //通过使用storyborardID去获取启动页viewcontroller
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    //获取viewController的视图
    self.window = viewController.view;
    //把视图添加到window
    [self.window addSubview:self.view];
    self.launchView = [[UIImageView alloc] initWithFrame:self.window.frame];
    [self.launchView setImage:[UIImage imageNamed:@"Users/yumengzhen/Documents/photo/86e2-hvscktf7094826.jpg"]];//这边图片可以做网络请求加载图片、视频动画或者其他自定义的引导页
    [self.view addSubview:self.launchView];
    //将图片视图推送到前面
    [self.window bringSubviewToFront:self.launchView];
    //设置3秒定时触发
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(colseLaunchScreen) userInfo:nil repeats:NO];
}
- (void)colseLaunchScreen {
    if (self.launchView) {
        [self.launchView removeFromSuperview];
        self.launchView = nil;
    }
    if (self.view) {
        [self.view removeFromSuperview];
        self.view = nil;
    }
    
}
@end

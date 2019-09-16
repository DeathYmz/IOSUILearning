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

@implementation YMZAppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.tabBarController = [[UITabBarController alloc] init];
    ViewController * VC =  [[ViewController alloc] init];
    VC.title=@"计数器";
    FindViewController  * FVC =[[FindViewController alloc] init];
    FVC.title=@"网址搜索";
    PhotoViewController  * PVC = [[PhotoViewController alloc] init];
    PVC.title=@"照片";
    SleepViewController  * SVC = [[SleepViewController alloc] init];
    SVC.title=@"催眠";
    
    NavihationViewController * navVC= [[NavihationViewController alloc] initWithRootViewController:VC];
    NavihationViewController * navFVC= [[NavihationViewController alloc] initWithRootViewController:FVC];
    NavihationViewController * navPVC= [[NavihationViewController alloc] initWithRootViewController:PVC];
    NavihationViewController * navSVC = [[NavihationViewController alloc] initWithRootViewController:SVC];
    self.tabBarController.viewControllers = @[navVC,navFVC,navPVC,navSVC];
    self.window.rootViewController =  self.tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}
@end

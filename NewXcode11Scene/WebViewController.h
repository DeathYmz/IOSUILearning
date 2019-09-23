//
//  WebViewController.h
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/8/30.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : UIViewController<NSURLConnectionDataDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) NSString * URL;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UITabBarController * tabBarController;
@end
NS_ASSUME_NONNULL_END

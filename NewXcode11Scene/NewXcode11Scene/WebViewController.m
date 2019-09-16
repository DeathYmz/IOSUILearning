//
//  WebViewController.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/8/30.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "WebViewController.h"
#import "AFHTTPSessionManager.h"
#import "HSNormalHeader.h"
#import "MJRefresh.h"
#import "FreshGifHeader.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;//直接隐藏当前页面的 UITabBar
    self.tableView = [[UITableView alloc] initWithFrame: self.view.bounds];
    //添加b，不设置边界
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    // 下拉刷新
    __weak typeof(self)  weakSelf = self;//这是为啥
    self.tableView.mj_header = [FreshGifHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [weakSelf.tableView.mj_header endRefreshing];
        });
    }];
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [weakSelf.tableView.mj_footer endRefreshing];
        });
    }];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.URL]];
    [self.tableView addSubview:self.webView];
    [self.webView loadRequest:request];//请求
    //[self setupRefresh];
    //UITableView UIScrollView UICollection
}
//-(void)setupRefresh
//{
//    //1.添加刷新控件
//    UIRefreshControl *control=[[UIRefreshControl alloc]init];
//    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
//    [self.tableView addSubview:control];
//    //2.马上进入刷新状态，并不会触发UIControlEventValueChanged事件
//    [control beginRefreshing];
//    // 3.加载数据
//    [self refreshStateChange:control];
//}
//UIRefreshControl进入刷新状态：加载最新的数据
//
//-(void)refreshStateChange:(UIRefreshControl *)control
//{
//    // 3.发送请求
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//    [mgr GET:@"https://api.weibo.com/2/statuses/public_timeline.json" parameters:nil success:^(AFHTTPSessionManager *operation, NSDictionary *responseObject){
//
//        //1.获取数据，处理数据，传递数据给tableView,如：
//        //2.刷新表格
//        [self.tableView reloadData];
//
//        // 3. 结束刷新
//        [control endRefreshing];
//
//    } failure:^(AFHTTPSessionManager *operation, NSError *error) {
//        // 结束刷新刷新 ，为了避免网络加载失败，一直显示刷新状态的错误
//        [control endRefreshing];
//    }];
//}


@end

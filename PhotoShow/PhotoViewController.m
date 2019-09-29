//
//  PhotoViewController.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/2.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "PhotoViewController.h"
#import "SDWebImage.h"
#import "FLAnimatedImage.h"
#import "PhotoItem.h"
#import "PhotoItemStore.h"
#import "PhotoDetailViewController.h"
#import "PictureCollectionViewController.h"
#import "NSObject+Extensions.h"
#import "PhotoModel.h"
#import "PhotoMainTableView.h"
#import "TableViewSectionModel.h"
#import "TableViewModel.h"
#import "Masonry/Masonry.h"
#import "UIResponder+Extensions.h"
#import "UIKit/UIKit.h"
#import "NSDictionary+Extensions.h"

@interface PhotoViewController ()

@property (nonatomic, strong) PhotoMainTableView *mainView;
@property (nonatomic, strong) TableViewModel *dataModel;
@property (nonatomic, strong) NSMutableArray * dataList;
@property (nonatomic, strong) TableViewCellModel *cellModel;

@end

@implementation PhotoViewController

- (instancetype)init {
    self = [super init];
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    [self setupData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (PhotoMainTableView *)mainView {
    if (!_mainView) {
        _mainView = [[PhotoMainTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mainView.delegate = self.dataModel;
        _mainView.dataSource = self.dataModel;
        
        CGFloat height = 44;
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.origin.x, height)];
        headerView.backgroundColor = [UIColor whiteColor];
        _mainView.tableHeaderView = headerView;
        [_mainView registerClass:[PhotoTableViewCell class]
          forCellReuseIdentifier:NSStringFromClass([PhotoTableViewCell class])];
        [self.view addSubview:_mainView];
    }
    return _mainView;
}

- (TableViewModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[TableViewModel alloc] init];
    }
    return _dataModel;
}

-(NSMutableArray *)dataList{
    if(!_dataList){
        NSArray *array = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Bundle" ofType:@"bundle"]] pathsForResourcesOfType:@"" inDirectory:nil];
        _dataList = [NSMutableArray arrayWithCapacity:array.count];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [userDefaults objectForKey:@"dataList"];
        NSArray *oldDataList = [NSKeyedUnarchiver unarchiveObjectWithData:data];

        [array enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *_Nonnull stop) {
            PhotoModel *model = [[PhotoModel alloc] init];
            model.title = [array[idx] lastPathComponent];
            model.imageName = array[idx];
            model.detail = array[idx];
            model.isLike = NO;
            PhotoModel *oldModel = oldDataList[idx];
            if(oldModel.isLike){
                model.isLike = YES;
            }
            [self->_dataList addObject:model];
        }];
    }
    return _dataList;
}

#pragma mark - 懒加载
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    [self setUpView];
}

-(void)setUpView{
    
    //navagation color
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem * rightButton =
    [[UIBarButtonItem alloc]initWithImage:[self mw_imageNamed:@"moshi" inBundle:@"PhotoShowResource"]
                                    style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(collectionView:)];
    
    rightButton.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightButton;//右上
    
    
    [self.view addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    
}

-(void)setupData{
    [self.dataModel.sectionModelArray removeAllObjects];
    
    TableViewSectionModel *sectionModel = [[TableViewSectionModel alloc] init];
    [self.dataList enumerateObjectsUsingBlock:^(id model, NSUInteger idx, BOOL * _Nonnull stop) {
        TableViewCellModel *cellModel = [[TableViewCellModel alloc] init];
        __weak typeof(self) wself = self;
        cellModel.selectionBlock = ^(NSIndexPath *indexPath, UITableView *tableView) {
            [wself didSelectedCellInIndexPath:indexPath];
        };
        cellModel.dataModel = model;
        cellModel.cellHeight = 80;
        cellModel.cellIdentifier = NSStringFromClass([PhotoTableViewCell class]);
        [sectionModel.cellModelArray addObject:cellModel];
    }];
    [self.dataModel.sectionModelArray addObject:sectionModel];
    [self.mainView reloadData];
}

- (void)didSelectedCellInIndexPath:(NSIndexPath *)indexPath {
    PhotoDetailViewController *PDVC = [[PhotoDetailViewController alloc]init];
    PhotoModel *model = (PhotoModel *)_dataList[indexPath.row];
    [PDVC loadImage:model.detail];
    [self.navigationController pushViewController:PDVC animated:nil];

}

- (void)mw_respondEvent:(NSObject<MWEvent> *)event {
    if ([event.sender isKindOfClass:[PhotoTableViewCell class]]) {
        if ([[event.userInfo stringForKey:@"name"] isEqualToString:@"arrowIcon"]) {
            
            NSIndexPath *indexPath = [self.mainView indexPathForCell:event.sender];
            PhotoModel *model = _dataList[indexPath.row];
            model.isLike = !model.isLike;
            _dataList[indexPath.row] = model;
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.dataList];
            [userDefaults setObject:data forKey:@"dataList"];
            [userDefaults synchronize];
            //添加手势获取cell的信息
            [self setupData];
            
        }
    }
}


#pragma mark - test
-(void)showAllImageName{
    NSArray *array = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Bundle" ofType:@"bundle"]] pathsForResourcesOfType:@"gif" inDirectory:nil];
    for(NSString *str in array){
        NSLog(@"%@",str);
   }
}

#pragma mark -action
-(void)collectionView:(id)sender{
    NSLog(@"colletion model");
    PictureCollectionViewController *PCVC = [[PictureCollectionViewController alloc] init];
    //PCVC.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];// 背景色透明
    [self.navigationController pushViewController:PCVC animated:nil];
}


@end

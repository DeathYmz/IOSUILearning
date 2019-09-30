//
//  LikeViewController.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/27.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "LikeViewController.h"
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


@interface LikeViewController ()

@property (nonatomic, strong) PhotoMainTableView *mainView;
@property (nonatomic, strong) TableViewModel *dataModel;
@property (nonatomic, strong) NSMutableArray * dataList;
@property (nonatomic, strong) TableViewCellModel *cellModel;

@end

@implementation LikeViewController


- (instancetype)init {
    self = [super init];
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    [self setupData];
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
}

- (void)viewDidDisappear:(BOOL)animated {
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
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [userDefaults objectForKey:@"dataList"];
        NSArray *oldDataList = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        _dataList = [NSMutableArray arrayWithCapacity:oldDataList.count];
        [oldDataList enumerateObjectsUsingBlock:^(id model, NSUInteger idx, BOOL *_Nonnull stop) {
            PhotoModel *oldModel = model;
            if(oldModel.isLike == YES){
                [self.dataList addObject:oldModel];
            }
        }];
    }
    return _dataList;
}


-(void)setUpView{
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
    NSLog(@"miao!!");
//    PhotoModel *model = _dataList[indexPath.row];
//    model.isLike = !model.isLike;//存储
//    _dataList[indexPath.row] = model;
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.dataList];
//    [userDefaults setObject:data forKey:@"dataList"];
//    [userDefaults synchronize];
//
//    [self setupData];
}

@end

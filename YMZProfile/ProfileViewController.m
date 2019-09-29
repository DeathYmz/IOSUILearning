//
//  ProfileViewController.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/23.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "ProfileViewController.h"
#import "YMZToast.h"
#import "ProfileTableViewCell.h"
#import "ProfileModel.h"
#import "LikeViewController.h"
typedef enum : NSUInteger {
    ImageTypeCamera,
    ImageTypePhotoLibrary,
    ImageTypeCancel,
} ImageType;
@interface ProfileViewController ()

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) UIView *fromView;
@property (nonatomic, copy) void (^callbackHandler)(UIImage *image);
@property (nonatomic, assign) BOOL allowsEditing;
@property (nonatomic, strong) UIView *backView;

@end

@implementation ProfileViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated {
    self.tableView.rowHeight = 80;
    self.title = @"我的";
    [self.navigationItem setHidesBackButton:YES];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initNavigation];
    [self setupData];
}

-(NSMutableArray *)dataList{
    if(!_dataList){
        NSArray *titles = @[@"我的",@"收藏"];
        NSArray *imageNames = @[@"detail",@"photo"];
        NSArray *details = @[@"",@""];
        _dataList = [NSMutableArray arrayWithCapacity:titles.count];
        [titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *_Nonnull stop) {
            ProfileModel *model = [[ProfileModel alloc] init];
            model.title = title;
            model.imageName = imageNames[idx];
            model.detail = details[idx];
            [self->_dataList addObject:model];
        }];
    }
    return _dataList;
}

- (void)setupData {
    
}
-(void)initNavigation {
    self.navigationItem.title = @"个人中心";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Bundle" ofType:@"bundle"]];
    NSString *imagePath = [bundle pathForResource:@"list" ofType:@"png"];
    UIBarButtonItem *rightButton =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithContentsOfFile:imagePath]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(backToSleep:)];
    rightButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightButton;
}
-(void)backToSleep:(id)sender {
    [self.navigationController popViewControllerAnimated:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

     ProfileTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileTableViewCell"];
    if(!cell){
        cell = [[ProfileTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"UITableViewCell"];
    }
    [cell setDataModel:_dataList[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfileModel *model = _dataList[indexPath.row];
    if([model.title isEqualToString:@"我的"]){
        NSLog(@"miao");
    }
    else if([model.title isEqualToString:@"收藏"]){
        NSLog(@"hei");
        LikeViewController *Lvc =[[LikeViewController alloc] init];
        [self.navigationController  pushViewController:Lvc animated:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

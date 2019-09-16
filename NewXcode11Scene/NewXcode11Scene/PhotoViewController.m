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
@interface PhotoViewController ()
@property (nonatomic, strong) IBOutlet UIView *headerView;
@property (nonatomic, strong) NSMutableArray * listData;
@end

@implementation PhotoViewController
- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStylePlain];//UITableViewStylePlain
    if(self){
        [[PhotoItemStore sharedStore] createCell];
    }
    return self;
}
- (NSMutableArray *)listData{
    if(_listData == nil){
        _listData = [[NSMutableArray alloc] init];
    }
    return _listData;
}

#pragma mark - 懒加载
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 80;
    [self.tableView setEditing:NO animated:YES];
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.delegate = self;
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
//重用UIYableViewCell意味着UITableView对象只需要创建少量的UITableViewCell，从而减少内存的占用量，提升用户界面的流畅性。
}
#pragma mark - test
-(void)showAllImageName{
    NSArray *array = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Bundle" ofType:@"bundle"]] pathsForResourcesOfType:@"gif" inDirectory:nil];
    for(NSString *str in array){
        NSLog(@"%@",str);
   }
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[PhotoItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    PhotoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoTableViewCell"];
    if(!cell){
        cell = [[PhotoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"UITableViewCell"];
    }
    NSString *str = [[PhotoItemStore sharedStore] allItems][indexPath.row];
    cell.detailTextLabel.text = str;
    cell.textLabel.text = [str lastPathComponent];
    cell.imageView.image = [UIImage imageWithContentsOfFile:str];
    cell.navigation = self.navigationController;//复制了
    return cell;
}
//选中一个cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if(cell.accessoryType == UITableViewCellEditingStyleNone){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellEditingStyleNone;
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}
/// 按压结束的时候调用

#pragma mark -编辑模式

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 使用 Block 回调,实现点击后的方法
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"增加" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"删除");
        [self.tableView setEditing:NO animated:YES];
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        //[[PhotoItemStore sharedStore] addCell:cell]
        [[PhotoItemStore sharedStore] addCell:indexPath.row];
        
        [self.tableView reloadData];
        [self.tableView endUpdates];
        
        
    }];
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"减少" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"减少");
        [self.tableView setEditing:NO animated:YES];
        
        [self.tableView beginUpdates];
        //[self.listData removeObjectAtIndex:indexPath.row];
        NSIndexPath *newPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];//
        [self.tableView deleteRowsAtIndexPaths:@[newPath] withRowAnimation:UITableViewRowAnimationFade];//删除
        [[PhotoItemStore sharedStore] deleteCell:indexPath.row];
        //s删去数据源
        //原因：删section必须用deleteSections。 删row必须用deleteRowsAtIndexPaths。
        //另外，删了后，数据源需要相应地删，否则数据不一致，crash
        [self.tableView reloadData];
        [self.tableView endUpdates];

    }];
    
    // 苹果的习惯,右侧的多个按钮,显示位置是反着的
    return @[action, action1];
}
- (IBAction)editingModel {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];//调用父类方法
    [self.tableView setEditing:editing animated:animated];//
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return TRUE;
}
@end

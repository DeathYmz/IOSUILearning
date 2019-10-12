//
//  PictureCollectionViewController.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/17.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "PictureCollectionViewController.h"
#import "PictureCollectionViewCell.h"
#import "PhotoItem.h"
#import "PhotoItemStore.h"
#import "PhotoDetailViewController.h"
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
@interface PictureCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation PictureCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

-(instancetype)init{
//    self.view = [[UIView alloc] init];//因为我没有init？？
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((screenWidth-2)/2.0, (screenHeight-4)/3.0);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];

    flowLayout.minimumLineSpacing = 2; // 设置最小行间距
    flowLayout.minimumInteritemSpacing = 2;    // 设置垂直间距
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;    // 设置滚动方向（默认垂直滚动）
    [[PhotoItemStore sharedStore] createCell];
    
    return [self initWithCollectionViewLayout:flowLayout];
}

-(void)viewWillAppear:(BOOL)animated{
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.title = @"照片";
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRightMoreItem];
//    self.clearsSelectionOnViewWillAppear = NO;
//    // Register cell classes
//    // Do any additional setup after loading the view.
    [self.collectionView registerClass:[PictureCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
}
-(void)setupRightMoreItem{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *bundlePath = [[ NSBundle mainBundle] pathForResource:@"Bundle" ofType :@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *img_path = [bundle pathForResource:@"list" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:img_path];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backToTable:) forControlEvents:UIControlEventTouchUpInside];
    //button.frame.size = CGSizeMake(40, 40);
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)backToTable:(id)sender{
    [self.navigationController popViewControllerAnimated:nil];
}
/*
#pragma mark - Navigation
*/

#pragma mark <UICollectionViewDataSource>
//row
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 5;
}
// col
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
   
//    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Bundle" ofType:@"bundle"];
//    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
//    NSString *str = [bundle pathForResource:@"d5d4f16aac" ofType:@"jpg"];
    NSString *str = [[PhotoItemStore sharedStore] allItems][indexPath.item * 5 + indexPath.section] ;
    UIImage *image = [UIImage imageWithContentsOfFile:str];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.imageView.image = image;
    cell.imageName.text = str;
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"you touch me");
    
    PictureCollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    PhotoDetailViewController *PDVC = [[PhotoDetailViewController alloc]init];
    [PDVC loadImage:cell.imageName.text];
    [self.navigationController pushViewController:PDVC animated:nil]; //
}
#pragma mark <UICollectionViewDelegate>


@end

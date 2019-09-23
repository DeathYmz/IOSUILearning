//
//  StartViewController.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/19.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "StartViewController.h"
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define identifier @"welcomeCell"

@interface StartViewController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageArray = [NSMutableArray arrayWithArray:@[@"86e2-hvscktf7094826",@"2017-11-11-09-32-43921825277115",@"bfcc-icapxpi3060395"]];
    [self initWithCollection];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)initWithCollection {
    NSInteger imageCount = self.imageArray.count;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    flowLayout.minimumLineSpacing = 2; // 设置最小行间距
    flowLayout.minimumInteritemSpacing = 2;    // 设置垂直间距
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;    // 设置滚动方向（默认垂直滚动）
    
    self.collectionView = [[UICollectionView  alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    [self.view addSubview:self.collectionView];
    
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT- 60, 40, 40)];
    self.pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    self.pageControl.numberOfPages = self.imageArray.count;
    if(self.imageArray.count == 1){
        self.pageControl.alpha = 0;
    }
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor greenColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    [self.view insertSubview:_pageControl aboveSubview:_collectionView];
    
    
}
//row
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}
// col
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return _imageArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    for(UIView  *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Bundle" ofType:@"bundle"];
    NSBundle *bundle  = [NSBundle bundleWithPath:bundlePath];
    NSString *str = [bundle pathForResource:_imageArray[indexPath.row] ofType:@"jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:str]];
    imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [cell.contentView addSubview:imageView];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat pageWidth = scrollView.frame.size.width;
    _currentIndex = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth) + 1;
    self.pageControl.currentPage = _currentIndex;
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

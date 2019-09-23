//
//  StartViewController.h
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/19.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StartViewController : UIViewController 
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, assign) Boolean isFullScreen;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) int currentIndex;
@end

NS_ASSUME_NONNULL_END

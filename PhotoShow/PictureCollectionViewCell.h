//
//  PictureCollectionView.h
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/4.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PictureCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *imageName;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *imagePath;

@end

NS_ASSUME_NONNULL_END

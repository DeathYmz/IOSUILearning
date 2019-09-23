//
//  PictureCollectionView.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/4.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "PictureCollectionViewCell.h"
#import "Masonry/Masonry.h"
#import "PhotoDetailViewController.h"
@interface PictureCollectionViewCell ()


@end

@implementation PictureCollectionViewCell


#pragma mark - Lifecycle
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self buildUI];
        [self buildConstranints];
    }
    return self;
}

#pragma mark - Private
- (void)buildUI {

    [self.contentView addSubview:self.imageName];
    [self.contentView addSubview:self.imageView];

}
- (void)buildConstranints {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    [self.imageName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-8);
        make.centerY.equalTo(self.contentView);
        
    }];
}


#pragma mark - Custom Accessors

- (UILabel *)imageName {
    if (!_imageName) {
        _imageName = [[UILabel alloc] init];
        _imageName.textAlignment = NSTextAlignmentLeft;
        _imageName.textColor = [UIColor whiteColor];
        _imageName.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14.0];
    }
    return _imageName;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.frame];
    }
    return _imageView;
}

@end

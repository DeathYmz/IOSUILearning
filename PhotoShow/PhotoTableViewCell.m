//
//  PhotoTableViewCell.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/6.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "PhotoTableViewCell.h"
#import "PhotoDetailViewController.h"
#import "NSObject+Extensions.h"
#import "PhotoModel.h"
#import "Masonry/Masonry.h"
#import "UIResponder+Extensions.h"
@implementation PhotoTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 一下两个clipsToBounds都必须设置，缺一不可
        self.clipsToBounds = YES;
        self.contentView.clipsToBounds = YES; // 解决iOS13的bug，设置界面设置cellheight为0但是还是显示的问题
        [self.contentView addSubview:self.icon];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.arrowImageView];
        [self __initConstranints];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage:)];
        [self.imageView addGestureRecognizer:tap];
        self.imageView.userInteractionEnabled = YES;
    }
    return self;
}
- (void)setDataModel:(id)dataModel {
    PhotoModel *model = dataModel;
    self.titleLabel.text = model.title;
    self.detailLabel.attributedText = model.attrbutedDetail;
    self.icon.image = [UIImage imageWithContentsOfFile:model.detail];
    self.isLike = model.isLike;
    
    if(model.isLike) {
        UIImage *arrowImage = [self mw_imageNamed:@"like" inBundle:@"YMZProfileResource"];
        self.arrowImageView.image = arrowImage;
    } else {
        UIImage *arrowImage = [self mw_imageNamed:@"dislike" inBundle:@"YMZProfileResource"];
        self.arrowImageView.image = arrowImage;
    }
}

- (void)__initConstranints {
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_equalTo(80);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(6);
        make.centerY.equalTo(self.contentView);
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-20);
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_equalTo(16);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImageView.mas_left);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(180);
    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        
    }
    return _icon;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:10];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = [UIColor blackColor];
        _detailLabel.font = [UIFont systemFontOfSize:10];
        _detailLabel.textAlignment = NSTextAlignmentRight;
    }
    return _detailLabel;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        UIImage *arrowImage = [self mw_imageNamed:@"dislike" inBundle:@"YMZProfileResource"];
        _arrowImageView = [[UIImageView alloc] initWithImage:arrowImage];
        _arrowImageView.userInteractionEnabled = YES;
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(arrowImageDidClick)];
        [_arrowImageView addGestureRecognizer:gesture];
    }
    return _arrowImageView;
}
- (void)arrowImageDidClick{
    MWEvent *event = [[MWEvent alloc] init];
    event.sender = self;
    event.userInfo = [@{
                        @"name" : @"arrowIcon"
                        } mutableCopy];
    //event.indexPath = self;
    [self.nextResponder mw_respondEvent:event];
}


@end

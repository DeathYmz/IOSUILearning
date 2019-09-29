//
//  ProfileTableViewCell.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/23.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "ProfileTableViewCell.h"
#import "Masonry/Masonry.h"
#import "ProfileModel.h"
#import "NSObject+Extensions.h"
@interface ProfileTableViewCell ()
@end

@implementation ProfileTableViewCell

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
    }
    return self;
}
- (void)setDataModel:(id)dataModel {
    ProfileModel *model = dataModel;
    self.titleLabel.text = model.title;
    self.detailLabel.attributedText = model.attrbutedDetail;
    self.icon.image = [self mw_imageNamed:model.imageName inBundle:@"YMZProfileResource"];
    if ([model.title isEqualToString:@""]) {
        self.arrowImageView.hidden = YES;
    } else {
        self.arrowImageView.hidden = NO;
    }
}

- (void)__initConstranints {
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_equalTo(24);
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
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = [UIColor blackColor];
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.textAlignment = NSTextAlignmentRight;
    }
    return _detailLabel;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        UIImage *arrowImage = [self mw_imageNamed:@"rightArrow" inBundle:@"YMZProfileResource"];
        //[UIImage imageWithContentsOfFile:@"/Users/yumengzhen/Documents/image/right-arrow.png"];
        _arrowImageView = [[UIImageView alloc] initWithImage:arrowImage];
    }
    return _arrowImageView;
}
@end

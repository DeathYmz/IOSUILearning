//
//  ProfileTableViewCell.h
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/23.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UILabel *detailLabel;
- (void)setDataModel:(id)dataModel;
@end

NS_ASSUME_NONNULL_END

//
//  PhotoTableViewCell.h
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/6.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCellDataModelProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface PhotoTableViewCell : UITableViewCell <TableViewCellDataModelProtocol>
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, assign) BOOL isLike;

- (void)setDataModel:(id)dataModel;
@end

NS_ASSUME_NONNULL_END

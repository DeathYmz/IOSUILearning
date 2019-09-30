//
//  TableViewSectionModel.h
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/26.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableViewCellModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef UIView * (^LSViewRenderBlock)(NSInteger section, UITableView *tableView);

@interface TableViewSectionModel : NSObject

@property (nonatomic, strong) NSString *headerTitle;
@property (nonatomic, strong) NSString *footerTitle;
@property (nonatomic, strong) NSMutableArray<TableViewCellModel *> *cellModelArray;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat footerHeight;

@property (nonatomic, copy) LSViewRenderBlock headerViewRenderBlock;
@property (nonatomic, copy) LSViewRenderBlock footerViewRenderBlock;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;

@end

NS_ASSUME_NONNULL_END

//
//  TableViewCellModel.h
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/26.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

typedef void (^LSCellSelectionBlock)(NSIndexPath *indexPath, UITableView *tableView);
typedef void (^LSCellWillDisplayBlock)(UITableViewCell *cell, NSIndexPath *indexPath, UITableView *tableView);
typedef void (^LSCellRenderBlock)(UITableViewCell *cell, id dataModel);

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCellModel : NSObject

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NSString *cellIdentifier;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, assign) UITableViewCellAccessoryType accessoryType;
@property (nonatomic, strong) id dataModel;
@property (nonatomic, strong) Class cellClass;
@property (nonatomic, assign) BOOL showSeperateLine;
@property (nonatomic, strong) UIColor *seperateLineColor;
@property (nonatomic, copy) LSCellSelectionBlock selectionBlock;     // optional
@property (nonatomic, copy) LSCellWillDisplayBlock willDisplayBlock; // optional
@property (nonatomic, copy) LSCellRenderBlock renderBlock;           // required
@property (nonatomic, strong) NSDictionary *trackerParams;

@end

NS_ASSUME_NONNULL_END

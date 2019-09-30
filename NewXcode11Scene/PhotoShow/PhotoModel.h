//
//  PhotoModel.h
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/24.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoTableViewCell.h"
#import "TableViewSectionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PhotoModel : NSObject <UITableViewDelegate, UITableViewDataSource,NSCoding>
  
@property (nonatomic, strong) NSMutableArray<TableViewSectionModel *> *sectionModelArray;

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, assign) BOOL shouldImageViewResponse;
@property (nonatomic, strong) NSAttributedString *attrbutedDetail;//这玩意是啥
@property (nonatomic, assign) BOOL isLike;
@end

NS_ASSUME_NONNULL_END

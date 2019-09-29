//
//  TableViewModel.h
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/26.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableViewSectionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TableViewModel : NSObject <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<TableViewSectionModel *> *sectionModelArray;
@end

NS_ASSUME_NONNULL_END

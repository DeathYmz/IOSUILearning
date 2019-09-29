//
//  TableViewCellDataModelProtocol.h
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/26.
//  Copyright © 2019 yumengzhen. All rights reserved.
//


#ifndef LSTableViewCellDataModelProtocol_h
#define LSTableViewCellDataModelProtocol_h

#import "TableViewCellModel.h"

@protocol TableViewCellDataModelProtocol

@property (nonatomic, strong) id dataModel;
@property (nonatomic, strong) TableViewCellModel *cellViewModel;
@end

#endif

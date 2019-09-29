//
//  TableViewSectionModel.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/26.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "TableViewSectionModel.h"

@implementation TableViewSectionModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.cellModelArray = [NSMutableArray array];
    }
    return self;
}
@end

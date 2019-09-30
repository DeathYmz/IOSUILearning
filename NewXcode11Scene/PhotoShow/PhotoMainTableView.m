//
//  PhotoMainTableView.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/25.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "PhotoMainTableView.h"

@implementation PhotoMainTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.decelerationRate = 0.5;
    }
    
    return self;
}

@end

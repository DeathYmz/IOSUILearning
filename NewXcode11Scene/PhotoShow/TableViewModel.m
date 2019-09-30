//
//  TableViewModel.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/26.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "TableViewModel.h"
#import "TableViewSectionModel.h"
#import "TableViewCellModel.h"
#import "TableViewCellDataModelProtocol.h"
@implementation TableViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.sectionModelArray = [NSMutableArray array];
    }
    return self;
}

- (TableViewSectionModel *)sectionModelAtSection:(NSInteger)section {
    @try {
        TableViewSectionModel *sectionModel = self.sectionModelArray[section];
        return sectionModel;
    } @catch (NSException *exception) {
        return nil;
    }
}

- (TableViewCellModel *)cellModelAtIndexPath:(NSIndexPath *)indexPath {
    @try {
        TableViewSectionModel *sectionModel = self.sectionModelArray[indexPath.section];
        TableViewCellModel *cellModel = sectionModel.cellModelArray[indexPath.row];
        return cellModel;
    } @catch (NSException *exception) {
        return nil;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCellModel *cellModel = [self cellModelAtIndexPath:indexPath];
    return cellModel.cellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    TableViewSectionModel *sectionModel = [self sectionModelAtSection:section];
    return sectionModel.headerHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    TableViewSectionModel *sectionModel = [self sectionModelAtSection:section];
    return sectionModel.footerHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TableViewSectionModel *sectionModel = [self sectionModelAtSection:section];
    LSViewRenderBlock headerViewRenderBlock = sectionModel.headerViewRenderBlock;
    if (headerViewRenderBlock) {
        return headerViewRenderBlock(section, tableView);
    } else {
        return sectionModel.headerView;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    TableViewSectionModel *sectionModel = [self sectionModelAtSection:section];
    LSViewRenderBlock footerViewRenderBlock = sectionModel.footerViewRenderBlock;
    if (footerViewRenderBlock) {
        return footerViewRenderBlock(section, tableView);
    } else {
        return sectionModel.footerView;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCellModel *cellModel = [self cellModelAtIndexPath:indexPath];
    LSCellSelectionBlock selectionBlock = cellModel.selectionBlock;
    if (selectionBlock) {
        selectionBlock(indexPath, tableView);
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionModelArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TableViewSectionModel *sectionModel = [self sectionModelAtSection:section];
    return sectionModel.cellModelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCellModel *cellModel = [self cellModelAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellModel.cellIdentifier
                                                            forIndexPath:indexPath];
    
    if (cellModel.renderBlock) {
        LSCellRenderBlock renderBlock = cellModel.renderBlock;
        if (renderBlock) {
            renderBlock(cell, cellModel.dataModel);
        }
    }
    if ([cell conformsToProtocol:@protocol(TableViewCellDataModelProtocol)]) {
        UITableViewCell<TableViewCellDataModelProtocol> *aCell = cell;
        if ([aCell respondsToSelector:@selector(setDataModel:)]) {
            [aCell setDataModel:cellModel.dataModel];
        }
        if ([aCell respondsToSelector:@selector(setCellViewModel:)]) {
            [aCell setCellViewModel:cellModel];
        }
    }
    cell.accessoryType = cellModel.accessoryType;
    if (cellModel.backgroundColor) {
        cell.backgroundColor = cellModel.backgroundColor;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCellModel *cellModel = [self cellModelAtIndexPath:indexPath];
    LSCellWillDisplayBlock willDisplayBlock = cellModel.willDisplayBlock;
    if (willDisplayBlock) {
        willDisplayBlock(cell, indexPath, tableView);
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    TableViewSectionModel *sectionModel = [self sectionModelAtSection:section];
    return sectionModel.headerTitle;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    TableViewSectionModel *sectionModel = [self sectionModelAtSection:section];
    return sectionModel.footerTitle;
}
@end

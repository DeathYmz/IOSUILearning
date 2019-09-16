//
//  PhotoItemStore.h
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/5.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoItem.h"
#import "PhotoTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface PhotoItemStore : NSObject
@property (nonatomic, readonly) NSArray * allItems;
+ (instancetype)sharedStore;
- (void)createCell;
- (void)deleteCell:(NSUInteger *)pos;
//- (void)addCell:(PhotoTableViewCell *)cell;
-(void)addCell:(NSUInteger *) pos;
- (void)addString:(NSString *)str;
@end

NS_ASSUME_NONNULL_END

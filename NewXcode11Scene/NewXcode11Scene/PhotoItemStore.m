//
//  PhotoItemStore.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/5.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "PhotoItemStore.h"
#import "PhotoItem.h"
#import "PhotoTableViewCell.h"
@interface PhotoItemStore()
@property (nonatomic,strong) NSMutableArray *privateItems;
@property (nonatomic, readwrite) NSArray *allItems;
@end
@implementation PhotoItemStore

+ (instancetype)sharedStore {
    static PhotoItemStore * sharedStore = nil;
    // 判断是否需要创建一个 sharedStore 对象
    if (!sharedStore) {
        sharedStore = [[self alloc] init];
    }
    return sharedStore;
}
- (NSArray *)allItems{
    return self.privateItems;//NSMutabelArray 是NSArry的子类
}
- (void)deleteCell:(NSUInteger *) pos{
    [self.privateItems removeObjectAtIndex:pos];
}
-(void)addCell:(NSUInteger *) pos{
    [self.privateItems insertObject:[self.allItems objectAtIndex:pos] atIndex:pos];
}

//-(void)addCell:(PhotoTableViewCell *) cell{
//    [self.privateItems addObject:cell];
//}
- (void)createCell{
    //读取文件文件地址
    NSArray *array = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Bundle" ofType:@"bundle"]] pathsForResourcesOfType:@"" inDirectory:nil];
    self.allItems = array;//  只存储地址
    self.privateItems = array;
}

- (void)addString:(NSString *)str {
    NSMutableArray *array = [self.allItems mutableCopy];
    [array addObject:str];
    self.allItems = array;
    self.privateItems = array;
}

#pragma mark - 加载
- (NSMutableArray *)privateItems{
    if(_privateItems == nil){
        _privateItems = [[NSMutableArray alloc] init];
    }
    return _privateItems;
}

@end

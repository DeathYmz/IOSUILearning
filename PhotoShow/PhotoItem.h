//
//  PhotoItem.h
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/5.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoItem : NSObject
@property (nonatomic,strong,readonly) NSDate * createDate;//日期
@property (nonatomic,strong) NSString * itemName;//名字
@property (nonatomic,strong) NSString * serialnumber;//序号
@property (nonatomic,assign) NSInteger valueInDollars;//价值
@property (nonatomic,strong) NSString * itemKey;

+ (instancetype)randomItem;
- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(NSInteger)value
                    serialNumber:(NSString *)sNumber;

- (instancetype)initWithItemName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END

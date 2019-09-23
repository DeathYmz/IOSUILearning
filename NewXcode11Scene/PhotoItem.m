//
//  PhotoItem.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/5.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "PhotoItem.h"

@implementation PhotoItem
+ (instancetype)randomItem {
    // 创建不可变数组对象，包含三个形容词
    NSArray * randomAdjectiveList = @[
                                      @"Fluffy",
                                      @"Rusty",
                                      @"Shiny"
                                      ];
    // 创建不可变数组对象，包含三个名词
    NSArray * randomNounList = @[
                                 @"Bear",
                                 @"Spork",
                                 @"Mac"
                                 ];
    
    // 根据数组对象所含的对象的个数，得到随机索引
    // 注意：运算符%是模运算符，运算后得到的是余数
    NSInteger adjectiveIndex = arc4random() % randomAdjectiveList.count;
    NSInteger nounIndex = arc4random() % randomNounList.count;
    // 注意，类型为NSInteger 的变量不是对象
    NSString * randomName = [NSString stringWithFormat:@"%@ %@",randomAdjectiveList[adjectiveIndex],randomNounList[nounIndex]];
    
    NSInteger randomValue = arc4random_uniform(100);
    
    NSString * randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c",
                                     '0' + arc4random_uniform(10),
                                     'A' + arc4random_uniform(26),
                                     '0' + arc4random_uniform(10),
                                     'A' + arc4random_uniform(26)];
    
    PhotoItem * newItem = [[self alloc] initWithItemName:randomName
                                       valueInDollars:randomValue
                                         serialNumber:randomSerialNumber];
    
    return newItem;
}

- (NSString *)description {
    NSString * descriptionString = [NSString stringWithFormat:@"%@ (%@):Worth $%zd, recorded on %@",self.itemName,self.serialnumber,self.valueInDollars,self.createDate];
    return descriptionString;
}

- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(NSInteger)value
                    serialNumber:(NSString *)sNumber {
    
    // 调用父类的指定初始化方法
    self = [super init];
    // 父类的指定初始化方法是否成功创建了对象
    if (self) {
        // 为实例变量设置初始值
        _itemName = name;
        _valueInDollars = value;
        _serialnumber = sNumber;
        // 设置_createDate为当前时间
        _createDate = [NSDate date];
        // 创建一个 NSUUID 对象
        NSUUID * uuid = [[NSUUID alloc] init];
        NSString * key = [uuid UUIDString];
        _itemKey = key;
    }
    // 返回初始化后的对象的新地址
    return self;
}
- (instancetype)initWithItemName:(NSString *)name {
    return [self initWithItemName:name valueInDollars:0 serialNumber:@""];
}
- (instancetype)init {
    return [self initWithItemName:@"Item"];
}
- (void)dealloc {
    NSLog(@"Destoryed:%@",self);
}
@end

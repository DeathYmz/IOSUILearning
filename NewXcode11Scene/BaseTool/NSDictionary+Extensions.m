//
//  NSDictionary.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/27.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "NSDictionary+Extensions.h"

@implementation NSDictionary(Extensions)

- (nullable id)safeObjectForKey:(id<NSCopying>)aKey {
    NSParameterAssert(aKey);
    if (aKey) {
        return [self objectForKey:aKey];
    }
    return nil;
}
- (NSString *)stringForKey:(NSString *)key {
    return [self stringForKey:key defaultValue:nil];
}
- (NSString *)stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue
{
    return [self expectClassForKey:key expectClass:NSString.class defaultValue:defaultValue];
}
- (id)expectClassForKey:(const NSString *)key expectClass:(Class)expectClass defaultValue:(id)defaultValue {
    id obj = [self safeObjectForKey:key];
    return [obj isKindOfClass:expectClass] ? obj : defaultValue;
}
@end

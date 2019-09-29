//
//  PhotoModel.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/24.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.imageName forKey:@"imageName"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.detail forKey:@"detail"];
    [aCoder encodeBool:self.shouldImageViewResponse forKey:@"shouldImageViewResponse"];
    [aCoder encodeObject:self.attrbutedDetail forKey:@"attrbutedDetail"];
    [aCoder encodeBool:self.isLike forKey:@"isLike"];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if(self = [super init]) {
        self.imageName = [aDecoder decodeObjectForKey:@"imageName"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.detail = [aDecoder decodeObjectForKey:@"detail"];
        self.shouldImageViewResponse = [aDecoder decodeBoolForKey:@"shouldImageViewResponse"];
        self.attrbutedDetail = [aDecoder decodeObjectForKey:@"attrbutedDetail"];
        self.isLike = [aDecoder decodeBoolForKey:@"isLike"];
    }
    return self;
}

@end

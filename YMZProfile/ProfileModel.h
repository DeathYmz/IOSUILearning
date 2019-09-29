//
//  ProfileModel.h
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/23.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileModel : NSObject
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, assign) BOOL shouldImageViewResponse;
@property (nonatomic, strong) NSAttributedString *attrbutedDetail;//这玩意是啥
@end

NS_ASSUME_NONNULL_END

//
//  UIResponder.h
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/27.
//  Copyright © 2019 yumengzhen. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol MWEvent <NSObject>
@required
@property (nonatomic, strong) UIResponder *sender;
@property (nonatomic, strong) NSMutableDictionary *userInfo;
@optional
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@interface MWEvent : NSObject<MWEvent>

@end

@interface UIResponder(Extensions)

- (void)mw_respondEvent:(NSObject<MWEvent> *)event;

@end

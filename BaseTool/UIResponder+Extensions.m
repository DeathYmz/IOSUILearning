//
//  UIResponder.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/27.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "UIResponder+Extensions.h"

@implementation MWEvent
@synthesize sender;
@synthesize userInfo;
@synthesize indexPath;
@end

@implementation UIResponder(Extensions)

- (void)mw_respondEvent:(NSObject<MWEvent> *)event{
    [self.nextResponder mw_respondEvent:event];
}

@end

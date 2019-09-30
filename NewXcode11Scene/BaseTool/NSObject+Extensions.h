//
//  NSObject+Extensions.h
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/24.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Extensions)

- (NSBundle *)mw_bundleForBundleName:(NSString *)bundleName;
- (NSString *)mw_bundlePathForBundleName:(NSString *)bundleName;
- (UIImage *)mw_imageNamed:(NSString *)imageName inBundle:(NSString *)bundleName;

@end

NS_ASSUME_NONNULL_END

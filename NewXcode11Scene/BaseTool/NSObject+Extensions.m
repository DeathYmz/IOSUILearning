//
//  NSObject+Extensions.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/24.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "NSObject+Extensions.h"
#import <UIKit/UIKit.h>

@implementation NSObject (Extensions)
- (NSString *)mw_bundlePathForBundleName:(NSString *)bundleName {
    if (!bundleName) {
        return nil;
    }
    NSBundle *classBundle = [NSBundle bundleForClass:[self class]];
    if (classBundle) {
        NSURL *bundleURL = [classBundle URLForResource:bundleName withExtension:@"bundle"];
        if (bundleURL) {
            return bundleURL.path;
        }
    }
    return nil;
}
    
- (NSBundle *)mw_bundleForBundleName:(NSString *)bundleName {
    if (!bundleName) {
        return nil;
    }
    NSString *bundlePath = [self mw_bundlePathForBundleName:bundleName];
    if (!bundlePath) {
        return nil;
    }
    return [NSBundle bundleWithPath:bundlePath];
}
    
- (UIImage *)mw_imageNamed:(NSString *)imageName inBundle:(NSString *)bundleName {
    if (!imageName || !bundleName) {
        return nil;
    }
    NSBundle *bundle = [self mw_bundleForBundleName:bundleName];
    UIImage *image = [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
    return image;
}

@end

//
//  UIImage (XLLaunchImage).m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/22.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "UIImage+LaunchImage.h"

@implementation UIImage(LaunchImage)
+ (UIImage *)getLaunchImageWithbIsLaunchImage:(BOOL)bIsLaunchImage {
    if (!bIsLaunchImage) {
        // 通过LaunchScreen.StoryBoard加载的本地图片 只需要两张本地图片iPhone 7和 7 plus尺寸的图 取名为LaunchImage@2x.png 和LaunchImage@3x.png
        UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
        UIImageView * imageView=viewController.view.subviews[0];
        return imageView.image;
    }else{
        //下面是通过LaunchImage 获取的本地图片 需要四张本地图片 放入LaunchImage即可  不包括横屏和竖屏
        NSString *viewOrientation = @"Portrait";
        //    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        //        viewOrientation = @"Landscape";
        //    }
        NSString *launchImageName = nil;
        NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
        CGSize viewSize = [UIApplication sharedApplication].keyWindow.bounds.size;
        for (NSDictionary* dict in imagesDict)
        {
            CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
            if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
            {
                launchImageName = dict[@"UILaunchImageName"];
            }
        }
        return [UIImage imageNamed:launchImageName];
    }
}
@end

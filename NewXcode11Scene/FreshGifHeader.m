//
//  FreshGifHeader.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/2.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "FreshGifHeader.h"
#import "FLAnimatedImage.h"
@implementation FreshGifHeader
#pragma mark - 重写父类的方法
- (void)prepare{
    [super prepare];
    NSString *bundlePath = [[ NSBundle mainBundle] pathForResource:@"Bundle" ofType :@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *img_path = [bundle pathForResource:@"1344129Qu" ofType:@"jpg"];
    //1.加载Gif图片，转换成Data类型
    NSData *data = [NSData dataWithContentsOfFile:img_path];
    //2.将data数据转换成CGImageSource对象
    CGImageSourceRef imageSource = CGImageSourceCreateWithData(CFBridgingRetain(data), nil);
    size_t imageCount = CGImageSourceGetCount(imageSource);
    //3.遍历所有图片
    NSMutableArray *images = [NSMutableArray array];
    NSTimeInterval totalDuration = 0;
    for (int i = 0; i<imageCount; i++) {
        //取出每一张图片
        CGImageRef cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil);
        UIImage *image = [UIImage imageWithCGImage:cgImage];
        [images addObject:image];

        //持续时间
        NSDictionary *properties = (__bridge_transfer  NSDictionary*)CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil);
        NSDictionary *gifDict = [properties objectForKey:(__bridge NSString *)kCGImagePropertyGIFDictionary];
        NSNumber *frameDuration =
        [gifDict objectForKey:(__bridge NSString *)kCGImagePropertyGIFDelayTime];
        totalDuration += frameDuration.doubleValue;
    }
    
    [self setImages:images forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [self setImages:images forState:MJRefreshStateRefreshing];
    //隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    //隐藏状态
    self.stateLabel.hidden = NO;
    self.stateLabel.textColor = [UIColor blackColor];
    self.mj_h=150;//加了这一句话
    
}
- (void)placeSubviews
{
    [super placeSubviews];
    self.gifView.contentMode = UIViewContentModeCenter;

    //调整图片的位置
    CGRect labelframe = self.stateLabel.frame;
    labelframe.size.height = 15;
    labelframe.origin.y = self.bounds.size.height - 20;
    self.stateLabel.frame = labelframe;
    CGPoint center = self.center;
    center.y = CGRectGetMinY(self.stateLabel.frame) - self.gifView.mj_h / 2.0;
    self.gifView.center = center;
}
/*
// Only overr
  ide drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

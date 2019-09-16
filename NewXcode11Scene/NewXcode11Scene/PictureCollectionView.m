//
//  PictureCollectionView.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/4.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "PictureCollectionView.h"

@implementation PictureCollectionView





//- (void)prepareLayout{
//    //完成布局的初始化操作
//    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;//设置滚动方向 水平滚动？
//    //设置内边距
//    CGFloat inset = (self.collectionView.frame.size.width -  self.itemSize.width) * 0.5;
//    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
//}
//
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
//    //当尺寸改变时是否r更新布局
//    return YES;
//}
////布局UICollectionView的元素
//- (nullable NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    //设置所有元素的布局属性
//    //获取rect区域中所有元素的布局属性
//    NSArray *array = [super layoutAttributesForElementsInRect:rect];
//
//    //获取UICollectionView的中点，以contentView的左上角为原点
//    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
//
//    //重置rect区域中所有元素的布局属性，即基于他们距离UICollectionView的中点的剧烈，改变其大小
//    for (UICollectionViewLayoutAttributes *attribute in array)
//    {
//        //获取距离中点的距离
//        CGFloat delta = ABS(attribute.center.x - centerX);
//        //计算缩放比例
//        CGFloat scale = 1 - delta / self.collectionView.bounds.size.width;
//        //设置布局属性
//        attribute.transform = CGAffineTransformMakeScale(scale, scale);
//    }
//    //返回所有元素的布局属性
//    return [array copy];
//}


@end

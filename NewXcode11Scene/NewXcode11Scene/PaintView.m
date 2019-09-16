//
//  PaintView.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/9.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "PaintView.h"

@implementation PaintView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGRect bounds=self.bounds;
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    double Maxradius = (hypot(bounds.size.width, bounds.size.height) / 2.0);
    UIBezierPath  *path = [[UIBezierPath alloc] init];
    path.lineWidth = 10;
    for (double currentRadius = Maxradius; currentRadius > 0; currentRadius -= 20){
        [path moveToPoint:CGPointMake(center.x+currentRadius, center.y)];
        [path  addArcWithCenter:center
                         radius:currentRadius
                     startAngle:0.0
                       endAngle:M_PI * 2.0 clockwise:YES];
    }
    [self.circleColor setStroke];
    [path stroke];//绘制路径
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"attention you had touched circle !!!!");
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.circleColor = randomColor;// 没有重绘
}
-(void)setCircleColor:(UIColor *)circleColor{
    _circleColor = circleColor;
    [self setNeedsDisplay];//加上这个
}
@end

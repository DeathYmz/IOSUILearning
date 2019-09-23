//
//  PhotoTableViewCell.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/6.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "PhotoTableViewCell.h"
#import "PhotoDetailViewController.h"
@implementation PhotoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSLog(@"初始化时，cell的frame是%@", NSStringFromCGRect(self.frame));
    }
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage:)];
    [self.imageView addGestureRecognizer:tap];
    self.imageView.userInteractionEnabled = YES;
    return self;
}
-(void)clickImage:(id)sender{
    //NSLog(@"mioamioam");
    PhotoDetailViewController * PDVC = [[PhotoDetailViewController alloc]init];
    PDVC.navigationController = self.navigation;

    [PDVC loadImage:self.detailTextLabel.text];// no all array
    [self.navigation pushViewController:PDVC animated:nil]; //
    // 在cell里面触发点击Image 触发事件 但是 怎么转换页面呢  cell里面添加navigation
    //点击之后 又出现没有图像 是detailTextLabel为nil

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.imageView.image forKey:@"imageView"];
}

@end

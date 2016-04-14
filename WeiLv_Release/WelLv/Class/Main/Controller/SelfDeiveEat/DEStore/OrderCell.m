//
//  OrderCell.m
//  WelLv
//
//  Created by liuxin on 15/11/24.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//


#import "OrderCell.h"
#import "orderModel.h"
#import "ShowFoodViewController.h"
@implementation OrderCell
{
   
}
- (void)awakeFromNib {
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCellView];
    }
    return self;
}
-(void)initCellView
{
    //商品名字
    self.leftImageView = [[UIImageView alloc] init];
    self.leftImageView.frame = CGRectMake(10, 10, 60, 60);
    //self.leftImageView.image = [UIImage imageNamed:@"默认图1"];
    [self addSubview:self.leftImageView];
    //商品名字
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.frame = CGRectMake(80, 25, 100, 30);
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.nameLabel];
    self.btn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.btn.frame = CGRectMake(windowContentWidth-170, 25, 40, 30);
    //[self.btn setTitle:@"点我" forState:UIControlStateNormal];
    self.btn.backgroundColor = [UIColor orangeColor];
    
    [self addSubview:self.btn];
    self.dataLabel = [[UILabel alloc] init];
    self.dataLabel.textAlignment = NSTextAlignmentRight;
    self.dataLabel.frame = CGRectMake(windowContentWidth-130, 25, 60, 30);
    [self addSubview:self.dataLabel];
    self.sw = [[UISwitch alloc] init];
    self.sw.frame = CGRectMake(windowContentWidth-60, 25, 50, 30);
    [self addSubview:self.sw];
}
-(void)setModel:(orderModel *)model
{
    // [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:[UIImage imageNamed:@"默认图1.png"]];
    self.nameLabel.text = model.nameStr;
    if ([model.SWStr isEqual:@"1"]) {
        self.dataLabel.text = @"已上架";
    }
    else
    {
        self.dataLabel.text = @"未上架";

    }
    NSLog(@"model.namelabel==%@",self.nameLabel.text);
    NSLog(@"model.dataLabel==%@",self.dataLabel.text);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

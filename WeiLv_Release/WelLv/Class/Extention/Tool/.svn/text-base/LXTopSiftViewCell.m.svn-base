//
//  LXTopSiftViewCell.m
//  WelLv
//
//  Created by lyx on 16/1/11.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "LXTopSiftViewCell.h"
@implementation LXTopSiftViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    self.leftLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 40)];
    self.leftLabel.textColor=[UIColor blackColor];
    self.leftLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:self.leftLabel];
    self.rightImage=[[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-10-20, 10, 20, 20)];
    self.rightImage.layer.cornerRadius=10.0;
    [self addSubview:self.rightImage];
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

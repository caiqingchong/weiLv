//
//  JYCDepositDetailCell.m
//  WelLv
//
//  Created by lyx on 16/1/21.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "JYCDepositDetailCell.h"

@implementation JYCDepositDetailCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    self.leftLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 20)];
    self.leftLabel.font=[UIFont systemFontOfSize:18];
    self.leftLabel.textColor=[UIColor blackColor];
    [self addSubview:self.leftLabel];
    self.leftTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, 100, 20)];
    self.leftTimeLabel.font=[UIFont systemFontOfSize:16];
    self.leftTimeLabel.textColor=[UIColor blackColor];
    [self addSubview:self.leftTimeLabel];
    self.amountLabel=[[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth-10-100, 10, 100, 20)];
    self.amountLabel.font=[UIFont systemFontOfSize:18];
    self.amountLabel.textAlignment=NSTextAlignmentRight;
    self.amountLabel.textColor=[UIColor colorWithRed:252/255.0 green:119/255.0 blue:42/255.0 alpha:1.0];
    [self addSubview:self.amountLabel];

    self.statusLabel=[[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth-10-100, 50, 100, 20)];
    self.statusLabel.font=[UIFont systemFontOfSize:16];
    self.statusLabel.textAlignment=NSTextAlignmentRight;
    self.statusLabel.textColor=[UIColor grayColor];
    [self addSubview:self.statusLabel];
    return self;
}

-(void)setModel:(DepositModel *)model
{
    self.leftLabel.text=[NSString stringWithFormat:@"%@",[model.apply_time substringWithRange:NSMakeRange(0, 10)]];
    self.leftTimeLabel.text=[NSString stringWithFormat:@"%@",[model.apply_time substringWithRange:NSMakeRange(11, 8)]];
    self.amountLabel.text=[NSString stringWithFormat:@"-%@",model.money];
    self.statusLabel.text=[NSString stringWithFormat:@"%@",model.state_text];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  JYCcustomerCell.m
//  WelLv
//
//  Created by lyx on 15/11/20.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCcustomerCell.h"

@implementation JYCcustomerCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    self.bgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, windowContentWidth-20, 130-10)];
    [self addSubview:self.bgImageView];
    self.bgImageView.userInteractionEnabled=YES;
    //self.btn=[[UIButton alloc]initWithFrame:CGRectMake(14, 15, 90, 90)];
    self.igView = [[ClickZoomImageView alloc] initWithFrame:CGRectMake(14, 15, 90, 90)];
    self.igView.clickable = YES;
    //self.igView.image = [UIImage imageNamed:@"定位btn"];
    //self.igView.backgroundColor=[UIColor redColor];
    [self.bgImageView addSubview:self.igView];
    self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(self.igView)+24, ViewY(self.igView), ViewWidth(self.bgImageView)-118, 20)];
    self.nameLabel.textColor=[UIColor whiteColor];
    self.nameLabel.font=systemFont(18);
    [self.bgImageView addSubview:self.nameLabel];
    self.timeLabel1=[[UILabel alloc]initWithFrame:CGRectMake(ViewX(self.nameLabel), ViewBelow(self.nameLabel)+25, 65, 13)];
    self.timeLabel1.textColor=[UIColor whiteColor];
    self.timeLabel1.text=@"有效期至:";
    self.timeLabel1.font=systemFont(11);
    [self.bgImageView addSubview:self.timeLabel1];
    self.timeLabel2=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(self.timeLabel1), ViewY(self.timeLabel1),ViewWidth(self.bgImageView)-ViewRight(self.timeLabel1)-9-13, 13)];
    self.timeLabel2.font=systemFont(11);
    self.timeLabel2.textColor=[UIColor whiteColor];
    [self.bgImageView addSubview:self.timeLabel2];
    self.secretVIew1=[[UIImageView alloc]initWithFrame:CGRectMake(ViewX(self.nameLabel), ViewBelow(self.timeLabel1)+10, 34, 22)];
   self.secretVIew1.image=[UIImage imageNamed:@"密码底色"];
    [self.bgImageView addSubview:self.secretVIew1];
    self.secretLabel1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self.secretVIew1), ViewHeight(self.secretVIew1))];
    [self.secretVIew1 addSubview:self.secretLabel1];
    self.secretLabel1.textColor=[UIColor grayColor];
    self.secretLabel1.text=@"密码";
    self.secretLabel1.textAlignment=NSTextAlignmentCenter;
    self.secretLabel1.font=systemFont(11);
    self.secretVIew2=[[UIImageView alloc]initWithFrame:CGRectMake(ViewRight(self.secretVIew1)+2, ViewY(self.secretVIew1), 128, 22)];
    self.secretVIew2.image=[UIImage imageNamed:@"数字底色"];
    [self.bgImageView addSubview:self.secretVIew2];
    self.secretLabel2=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 128, 22)];
    self.secretLabel2.textAlignment=NSTextAlignmentCenter;
    self.secretLabel2.textColor=[UIColor orangeColor];
    self.secretLabel2.font=systemFont(14);
    self.secretLabel2.text=@"168168167";
    [self.secretVIew2 addSubview:self.secretLabel2];
    self.rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(ViewWidth(self.bgImageView)-13-10, 60-8.5, 10, 17)];
    [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"箭头1"] forState:UIControlStateNormal];
    [self.bgImageView addSubview:self.rightBtn];
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
   // [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

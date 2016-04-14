//
//  DetailHeaderView.m
//  WelLv
//
//  Created by mac for csh on 15/10/10.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "DetailHeaderView.h"

@implementation DetailHeaderView
@synthesize titleLab;
@synthesize detailLab1;
@synthesize detailLab2;
@synthesize priceLab;
@synthesize igv;
@synthesize leftIGV;


- (id)initWithFrame:(CGRect)frame
 AndLeftImageString:(NSString *)leftIGVString
           AndTitle:(NSString *)title
          AndString:(NSString *)string
         AndDString:(NSString *)dsring
           AndPrice:(NSString *)price
       AndImageName:(NSString *)imageString
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
    //左侧图片
    self.leftIGV =[[UIImageView alloc] init];
    self.leftIGV.frame=CGRectMake(10,7.5, 75,75 );
    self.leftIGV.layer.masksToBounds = YES;
    self.leftIGV.layer.cornerRadius = 3.5;
    self.leftIGV.image = [UIImage imageNamed:leftIGVString];
    [self addSubview: self.leftIGV];
    
    //标题
    self.titleLab=[[UILabel alloc] init];
    float with = ViewX(self.leftIGV)+ViewWidth(self.leftIGV);
    self.titleLab.frame=CGRectMake(with+10, ViewY(self.leftIGV), windowContentWidth-with-20, 35);
    self.titleLab.textAlignment=NSTextAlignmentLeft;
    self.titleLab.adjustsFontSizeToFitWidth = YES;
    self.titleLab.textColor = [UIColor blackColor];
    self.titleLab.font=[UIFont systemFontOfSize:16];
    self.titleLab.text = title;
    [self addSubview:self.titleLab];
    
    //detailLab1
    self.detailLab1=[[UILabel alloc] init];
    self.detailLab1.frame=CGRectMake(with+10, ViewY(self.titleLab)+ViewHeight(self.titleLab), windowContentWidth-with-20, 20);
    self.detailLab1.textAlignment=NSTextAlignmentLeft;
    self.detailLab1.adjustsFontSizeToFitWidth = YES;
    self.detailLab1.textColor = kColor(134, 134, 134);
    self.detailLab1.font=[UIFont systemFontOfSize:12];
    self.detailLab1.text = string;
    [self addSubview:self.detailLab1];
    
    //detailLab2
    self.detailLab2=[[UILabel alloc] init];
    self.detailLab2.frame=CGRectMake(with+10, ViewY(self.detailLab1)+ViewHeight(self.detailLab1), windowContentWidth-with-20, 20);
    self.detailLab2.textAlignment=NSTextAlignmentLeft;
    self.detailLab2.adjustsFontSizeToFitWidth = YES;
    self.detailLab2.textColor = kColor(134, 134, 134);
    self.detailLab2.font=[UIFont systemFontOfSize:12];
    self.detailLab2.text = dsring;
    [self addSubview:self.detailLab2];
    
    //价格
    self.priceLab=[[UILabel alloc] init];
    self.priceLab.frame=CGRectMake(windowContentWidth -110, ViewHeight(self)/2 - 25/2, 90, 25);
    self.priceLab.font=[UIFont systemFontOfSize:19];
    self.priceLab.textAlignment=NSTextAlignmentLeft;
    self.priceLab.textColor= kColor(255, 91, 38);
    self.priceLab.text = price;
    [self addSubview:self.priceLab];
    
    //右侧图片
    self.igv =[[UIImageView alloc] init];
    self.igv.frame=CGRectMake(windowContentWidth -12-10, ViewHeight(self)/2 - 6.67/2, 12, 6.67 );
    // self.leftIGV.layer.masksToBounds = YES;
    self.igv.image = [UIImage imageNamed:imageString];
    [self addSubview: self.igv];
    }
    return self;
}



@end

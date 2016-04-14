//
//  DownnView.m
//  FillOrder
//
//  Created by WeiLv on 16/1/14.
//  Copyright © 2016年 WeiLv. All rights reserved.
//

#import "DownnView.h"

#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation DownnView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addControl];
    }
    return self;
}

- (void)addControl{
    
    //总额
    self.totalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.totalBtn.frame = CGRectMake(0, 0, UISCREEN_WIDTH / 2, UISCREEN_HEIGHT / 14);
    self.totalBtn.tag = 108;
    [self addSubview:self.totalBtn];
    
    UILabel *prictLable = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 40, 0, UISCREEN_WIDTH / 6, UISCREEN_HEIGHT / 14)];
    prictLable.text = @"总额:";
    prictLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 20];
    [self addSubview:prictLable];
    
    self.totalLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(prictLable.frame) - 18, 0, UISCREEN_WIDTH / 3.6, UISCREEN_HEIGHT / 14)];
    self.totalLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 20];
    self.totalLable.textColor = [UIColor colorWithRed:255 / 255.0 green:108 / 255.0 blue:106 / 255.0 alpha:1.0];
    [self addSubview:self.totalLable];
    
    self.triangleImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.totalLable.frame) + UISCREEN_WIDTH / 28, UISCREEN_HEIGHT / 36 , UISCREEN_WIDTH / 26, UISCREEN_WIDTH / 46)];
    self.triangleImage.image = [UIImage imageNamed:@"订单明细按钮-上"];
    [self addSubview:self.triangleImage];
    
    
    //提交订单按钮
    self.referBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.referBtn.tag = 109;
    self.referBtn.frame = CGRectMake(CGRectGetMaxX(self.totalBtn.frame), 0, UISCREEN_WIDTH /2, UISCREEN_HEIGHT / 14);
    self.referBtn.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:153 / 255.0 blue:102 / 255.0 alpha:1.0];
    [self.referBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    self.referBtn.titleLabel.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 22];
    [self addSubview:self.referBtn];
    
}



@end

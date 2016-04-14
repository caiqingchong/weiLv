//
//  CostView.m
//  FillOrder
//
//  Created by WeiLv on 16/1/14.
//  Copyright © 2016年 WeiLv. All rights reserved.
//

#import "CostView.h"

#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation CostView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addControl];
    }
    return self;
}

/**
 *  添加相关控件
 */
- (void)addControl{
    //成人
    self.adultLable = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 26, 0, UISCREEN_WIDTH / 6, UISCREEN_HEIGHT / 24.5 * 2)];
    self.adultLable.text = @"成人";
    self.adultLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 22.8];
    self.adultLable.textColor = [UIColor grayColor];
    [self addSubview:self.adultLable];
    //成人总价
    self.aPriceLable = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 3, 0, UISCREEN_WIDTH / 3, UISCREEN_HEIGHT / 24.5 * 2)];
    self.aPriceLable.textColor = [UIColor grayColor];
    self.aPriceLable.text = @"¥ 1030*2人";
    self.aPriceLable.textAlignment = NSTextAlignmentCenter;
    self.aPriceLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 22.8];
    [self addSubview:self.aPriceLable];
    
    //分隔线
    UILabel *firstLine = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 26, CGRectGetMaxY(self.adultLable.frame), UISCREEN_WIDTH - UISCREEN_WIDTH / 26, 1)];
    firstLine.backgroundColor = [UIColor grayColor];
    firstLine.alpha = 0.3;
    [self addSubview:firstLine];
    
    //儿童
    self.childLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.adultLable.frame), CGRectGetMaxY(firstLine.frame), UISCREEN_WIDTH / 6, UISCREEN_HEIGHT / 24.5 * 2)];
    self.childLable.text = @"儿童";
    self.childLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 22.8];
    self.childLable.textColor = [UIColor grayColor];
    [self addSubview:self.childLable];
    
    //儿童总价
    self.cPriceLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.aPriceLable.frame), CGRectGetMaxY(firstLine.frame), UISCREEN_WIDTH / 3, UISCREEN_HEIGHT / 24.5 * 2)];
    self.cPriceLable.textColor = [UIColor grayColor];
    self.cPriceLable.text = @"¥ 1030*2人";
    self.cPriceLable.textAlignment = NSTextAlignmentCenter;
    self.cPriceLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 22.8];
    [self addSubview:self.cPriceLable];
    

    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

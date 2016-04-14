//
//  ToppView.m
//  FillOrder
//
//  Created by WeiLv on 16/1/14.
//  Copyright © 2016年 WeiLv. All rights reserved.
//

#import "ToppView.h"

#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation ToppView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addControl];
    }
    return self;
}

/**
 *  添加 控件
 */

- (void)addControl{
    
    //标题
    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 35, 6, UISCREEN_WIDTH - UISCREEN_WIDTH / 16, UISCREEN_HEIGHT / 15)];
    self.titleLable.text = @"< 郑州到新乡宝泉西沟一日游 >";
    self.titleLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 21];
    self.titleLable.numberOfLines = 0;
    [self addSubview:self.titleLable];
    
    //出发日期
    self.dateLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLable.frame), CGRectGetMaxY(self.titleLable.frame) + 12, UISCREEN_WIDTH - UISCREEN_WIDTH / 16, UISCREEN_HEIGHT / 31)];
    self.dateLable.text = @"出发日期:2015-06-18(余位24)";
    self.dateLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26];
    [self addSubview:self.dateLable];
    
    //出游人数
    self.peopleLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.dateLable.frame), CGRectGetMaxY(self.dateLable.frame) + 6, UISCREEN_WIDTH - UISCREEN_WIDTH / 16, UISCREEN_HEIGHT / 31)];
    self.peopleLable.text = @"出游人数:2成人 1儿童";
    self.peopleLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26];
    [self addSubview:self.peopleLable];
    
    
}




@end
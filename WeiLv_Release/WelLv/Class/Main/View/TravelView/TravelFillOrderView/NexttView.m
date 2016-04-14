//
//  NexttView.m
//  FillOrder
//
//  Created by WeiLv on 16/1/14.
//  Copyright © 2016年 WeiLv. All rights reserved.
//

#import "NexttView.h"

#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation NexttView

- (id) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addControl];
    }
    return self;
}

/**
 *  添加子控件
 */
- (void)addControl{
    
    //联系人信息
    self.contactLable = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 35, 0, UISCREEN_WIDTH - 9, UISCREEN_HEIGHT / 14)];
    self.contactLable.text = @"联系人信息";
    self.contactLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26];
    [self addSubview:self.contactLable];
    
    //分隔线1
    UILabel *firstLine = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.contactLable.frame), CGRectGetMaxY(self.contactLable.frame), UISCREEN_WIDTH - 9, 1)];
    firstLine.alpha = 0.3;
    firstLine.backgroundColor = [UIColor grayColor];
    [self addSubview:firstLine];
    
    //填写姓名
    self.nameLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(firstLine.frame), CGRectGetMaxY(firstLine.frame), UISCREEN_WIDTH / 8, UISCREEN_HEIGHT / 14)];
    self.nameLable.text = @"姓名";
    self.nameLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26];
    [self addSubview:self.nameLable];
    
    //姓名输入框
    self.nameField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLable.frame) + UISCREEN_WIDTH / 9, CGRectGetMinY(self.nameLable.frame), UISCREEN_WIDTH / 1.8, UISCREEN_HEIGHT / 14)];
    self.nameField.placeholder = @"必填";
    [self addSubview:self.nameField];
    
    //分隔线2
    UILabel *secondLine = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.nameLable.frame), CGRectGetMaxY(self.nameLable.frame), UISCREEN_WIDTH - 9, 1)];
    secondLine.alpha = 0.3;
    secondLine.backgroundColor = [UIColor grayColor];
    [self  addSubview:secondLine];
    
    //手机号码
    self.teleLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(secondLine.frame), CGRectGetMaxY(secondLine.frame), UISCREEN_WIDTH / 8, UISCREEN_HEIGHT / 14)];
    self.teleLable.text = @"手机";
    self.teleLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26];
    [self addSubview:self.teleLable];
    
    //手机号输入框
    self.teleField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.teleLable.frame) + UISCREEN_WIDTH / 9, CGRectGetMinY(self.teleLable.frame), UISCREEN_WIDTH / 2, UISCREEN_HEIGHT / 14)];
    self.teleField.placeholder = @"必填";
    [self addSubview:self.teleField];
    
}


@end

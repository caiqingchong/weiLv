//
//  ChangeCountView.m
//  bottomView
//
//  Created by 张子乾 on 16/1/21.
//  Copyright © 2016年 张子乾. All rights reserved.
//

#import "ChangeCountView.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kItemWidthAndHeight kScreenWidth/(kScreenWidth/28)

@implementation ChangeCountView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutAllViews];
    }
    return self;
}

- (void) layoutAllViews {
    
    
    
    //减
    self.minusView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kItemWidthAndHeight, kItemWidthAndHeight)];
    [self.minusView setImage:[UIImage imageNamed:@"-"]];
    [self addSubview:self.addView];
    
    //数字显示
    self.countLable = [[UILabel alloc]initWithFrame:CGRectMake(kItemWidthAndHeight, 0, kItemWidthAndHeight, kItemWidthAndHeight)];
    self.countLable.text = @"2";
    [self addSubview:self.countLable];
    
    //加
    self.addView = [[UIImageView alloc]initWithFrame:CGRectMake(kItemWidthAndHeight * 2, 0, kItemWidthAndHeight, kItemWidthAndHeight)];
    [self.addView setImage:[UIImage imageNamed:@"+"]];
    [self addSubview:self.addView];
    
    
}

@end

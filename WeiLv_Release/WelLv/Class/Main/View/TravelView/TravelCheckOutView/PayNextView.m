//
//  PayNextView.m
//  FillOrder
//
//  Created by WeiLv on 16/1/14.
//  Copyright © 2016年 WeiLv. All rights reserved.
//

#import "PayNextView.h"

#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation PayNextView

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
    
    self.payBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.payBtn.frame = CGRectMake(UISCREEN_WIDTH /36, 0, UISCREEN_WIDTH - UISCREEN_WIDTH / 36, UISCREEN_HEIGHT / 14.5);
    self.payBtn.tag = 110;
    [self addSubview:self.payBtn];
    
    self.weiBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.weiBtn.frame = CGRectMake(UISCREEN_WIDTH / 36, UISCREEN_HEIGHT / 14.5, UISCREEN_WIDTH - UISCREEN_WIDTH / 36, UISCREEN_HEIGHT / 14.5);
    self.weiBtn.tag = 111;
    [self addSubview:self.weiBtn];
    
    NSArray *typeArray = @[@"支付宝支付",@"微信支付"];
    int i = 0;
    for (i = 0; i < typeArray.count; i++) {
        self.typeLable = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 6.5, UISCREEN_HEIGHT / 14.5 * i, UISCREEN_WIDTH / 3, UISCREEN_HEIGHT / 14.5)];
        self.typeLable.text = [NSString stringWithFormat:@"%@",typeArray[i]];
        self.typeLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26];
        self.typeLable.tag = 500 + i;
        [self addSubview:self.typeLable];
    }
    //添加分隔线
    _firstLable = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 36, UISCREEN_HEIGHT / 14.5, UISCREEN_WIDTH - UISCREEN_WIDTH / 36, 1)];
    _firstLable.alpha = 0.3;
    _firstLable.backgroundColor = [UIColor grayColor];
    [self addSubview:_firstLable];

    //添加选择图片
 
    self.firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];

    self.firstBtn.frame = CGRectMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 26 - UISCREEN_WIDTH / 25.5, UISCREEN_WIDTH / 25, UISCREEN_WIDTH / 25.5, UISCREEN_WIDTH / 25.5);
    [self.firstBtn setBackgroundImage:[UIImage imageNamed:@"选中按钮"] forState:UIControlStateNormal];
    [self addSubview:self.firstBtn];
    
    self.secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
 
    self.secondBtn.frame = CGRectMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 26 - UISCREEN_WIDTH / 25.5, UISCREEN_WIDTH / 25 + UISCREEN_HEIGHT / 14.5, UISCREEN_WIDTH / 25.5, UISCREEN_WIDTH / 25.5);
    [self.secondBtn setBackgroundImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    [self addSubview:self.secondBtn];
//        self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.selectBtn.frame = CGRectMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 26 - UISCREEN_WIDTH / 25.5, UISCREEN_WIDTH / 25 + i * UISCREEN_HEIGHT / 14.5, UISCREEN_WIDTH / 25.5, UISCREEN_WIDTH / 25.5);
//        self.selectBtn.tag = 111 + i;
//        if (i == 0) {
//            [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"选中按钮-副本"] forState:UIControlStateNormal];
//        }else {
//            [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"未选中状态-副本"] forState:UIControlStateNormal];
//        }
//        [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"未选中状态-副本"] forState:UIControlStateNormal];
      
    
    
    //支付方式图片标识
    self.purseImage = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 36, 6, UISCREEN_HEIGHT / 20, UISCREEN_HEIGHT / 20)];
    _purseImage.image = [UIImage imageNamed:@"支付宝"];
    [self addSubview:_purseImage];
    
    _wxImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_purseImage.frame), CGRectGetMaxY(_firstLable.frame) + 6, UISCREEN_HEIGHT / 20, UISCREEN_HEIGHT / 20)];
    _wxImage.image = [UIImage imageNamed:@"微信支付"];
    [self addSubview:_wxImage];
    
}


@end

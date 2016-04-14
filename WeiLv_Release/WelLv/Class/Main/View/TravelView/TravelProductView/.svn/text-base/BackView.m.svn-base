//
//  BackView.m
//  TraveDetail
//
//  Created by WeiLv on 16/1/17.
//  Copyright © 2016年 WeiLv. All rights reserved.
//

#import "BackView.h"

#define UISCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

@implementation BackView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addControl];
    }
    return self;
}

//添加行程介绍和产品特色按钮
- (void)addControl{
    //行程介绍 button
    self.firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.firstButton.frame = CGRectMake(0, 0, UISCREEN_WIDTH / 2, UISCREEN_HEIGHT / 16.7);
    self.firstButton.tag = 102;
    [self.firstButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.firstButton setTitle:@"行程介绍" forState:UIControlStateNormal];
    self.firstButton.titleLabel.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 22.8];
    [self addSubview:self.firstButton];
    
    //产品特色 button
    self.secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.secondButton.tag = 103;
    self.secondButton.frame = CGRectMake(CGRectGetMaxX(self.firstButton.frame), CGRectGetMinY(self.firstButton.frame), UISCREEN_WIDTH / 2, UISCREEN_HEIGHT / 16.7);
    self.secondButton.backgroundColor = [UIColor whiteColor];
    [self.secondButton setTitle:@"产品特色" forState:UIControlStateNormal];
    self.secondButton.titleLabel.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 22.8];
    [self.secondButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self addSubview:self.secondButton];
    
    //长横线
    self.longLine = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.firstButton.frame), UISCREEN_WIDTH, 1)];
    _longLine.alpha = 0.2;
    _longLine.backgroundColor = [UIColor grayColor];
    [self addSubview:_longLine];
    
    //滚动线
    self.lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 10, CGRectGetMinY(self.longLine.frame) - 2, (UISCREEN_WIDTH - 20) / 3, 4)];
    self.lineImage.alpha = 1.0;
    self.lineImage.image = [UIImage imageNamed:@"行程下滑条"];
    [self addSubview:self.lineImage];

}



@end























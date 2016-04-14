//
//  AffirmView.m
//  FillOrder
//
//  Created by WeiLv on 16/1/25.
//  Copyright © 2016年 WeiLv. All rights reserved.
//

#import "AffirmView.h"

#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation AffirmView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addControl];
    }
    return self;
}

- (void)addControl{
    
   //  self.pictureImage = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 2 - UISCREEN_WIDTH / 7.08 / 2, UISCREEN_HEIGHT/ 44.46, UISCREEN_WIDTH / 7.08 , UISCREEN_WIDTH / 7.08 )];
   // self.pictureImage.layer.cornerRadius = UISCREEN_WIDTH / 7.08 / 2 ;
    self.pictureImage = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 2 - UISCREEN_WIDTH / 7.08 / 2, UISCREEN_HEIGHT/ 44.46, UISCREEN_WIDTH / 5.08 , UISCREEN_WIDTH / 5.08 )];
    self.pictureImage.layer.cornerRadius = UISCREEN_WIDTH / 5.08 / 2 ;
    self.pictureImage.layer.masksToBounds = YES;
   self.pictureImage.image = [UIImage imageNamed:@"提交图片6"];
    [self addSubview:self.pictureImage];
    
  self.lable = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 18, CGRectGetMaxY(self.pictureImage.frame) + [UIScreen mainScreen].bounds.size.height / 30.3-5, [UIScreen mainScreen].bounds.size.width - [UIScreen mainScreen].bounds.size.width / 18, UISCREEN_HEIGHT / 28)];
    self.lable.text = @"您的订单已提交,待供销商确认后,支付金额。";
    self.lable.textColor = [UIColor orangeColor];
    _lable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 21];
    [self addSubview:self.lable];
    

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

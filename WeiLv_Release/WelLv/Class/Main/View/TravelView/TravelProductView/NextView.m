//
//  NextView.m
//  TraveDetail
//
//  Created by WeiLv on 16/1/11.
//  Copyright © 2016年 WeiLv. All rights reserved.
//

#import "NextView.h"


#define UISCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

@implementation NextView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self layoutOfView];
    }
    return self;
}
/**
 *  button 的布局
 */

- (void)layoutOfView{
    
    
    self.detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.detailButton.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.detailButton.tag = 104;
    [self addSubview:self.detailButton];
    
    
    self.lable = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 32, 0, UISCREEN_WIDTH - UISCREEN_WIDTH / 5, UISCREEN_HEIGHT / 15)];
    self.lable.text = @"费用&预订须知";
    self.lable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 21.3];
    self.lable.textColor = [UIColor grayColor];
    [self addSubview:self.lable];
    
    self.moreImage = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 50.39 - UISCREEN_WIDTH / 21.33, CGRectGetMinY(self.lable.frame) + UISCREEN_WIDTH / 25, UISCREEN_WIDTH /50.39, UISCREEN_HEIGHT / 53.68)];
    self.moreImage.image = [UIImage imageNamed:@"矩形-32-副本-2"];
    [self addSubview:self.moreImage];
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

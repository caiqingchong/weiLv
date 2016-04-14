//
//  TravelCancelTitleView.m
//  CancelTitle
//
//  Created by 张子乾 on 16/1/30.
//  Copyright © 2016年 张子乾. All rights reserved.
//

#import "TravelCancelTitleView.h"
#define UISCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height


@implementation TravelCancelTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutAllView];
    }
    return self;
}


- (void)layoutAllView {
    NSInteger firstLableX;
    NSInteger firstLableY;
    NSInteger firstLabelWidth;
    NSInteger firstLabelHeight;
    
    NSInteger secondLabelX;
    NSInteger secondLableY;
    NSInteger secondLableWidth;
    NSInteger secondLableHeight;
    
    NSInteger leftButtonX;
    NSInteger leftButtonY;
    NSInteger leftButtonWidth;
    NSInteger leftButtonHeight;
    
    NSInteger rightButtonX;
    NSInteger rightButtonY;
    NSInteger rightButtonWidth;
    NSInteger rightButtonHeight;
    
    NSInteger firstLabelSize;
    NSInteger secondLabelSize;
    
    if (UISCREEN_HEIGHT == 736) {
        firstLableX = 334/2-40;
        firstLableY = 12;
        firstLabelWidth = 80;
        firstLabelHeight = 20;
        firstLabelSize = 20;
        
        secondLabelX = 334/2-80;
        secondLableY = 54;
        secondLableWidth = 165;
        secondLableHeight = 15;
        secondLabelSize = 15;
        
        leftButtonX = 334/2-5.5-133;
        leftButtonY = 105;
        leftButtonWidth = 133;
        leftButtonHeight = 34;
        
        rightButtonX = 334/2+5.5;
        rightButtonY = 105;
        rightButtonWidth = 133;
        rightButtonHeight = 34;
        
    } else if (UISCREEN_HEIGHT == 667) {
        firstLableX = 300/2-40;
        firstLableY = 12;
        firstLabelWidth = 80;
        firstLabelHeight = 20;
        firstLabelSize = 20;
        
        secondLabelX = 300/2-80;
        secondLableY = 54;
        secondLableWidth = 165;
        secondLableHeight = 15;
        secondLabelSize = 15;
        
        leftButtonX = 300/2-5.5-133;
        leftButtonY = 105;
        leftButtonWidth = 133;
        leftButtonHeight = 34;
        
        rightButtonX = 300/2+5.5;
        rightButtonY = 105;
        rightButtonWidth = 133;
        rightButtonHeight = 34;
    } else if (UISCREEN_HEIGHT < 569) {
        firstLableX = 254/2-30;
        firstLableY = 10;
        firstLabelWidth = 80;
        firstLabelHeight = 20;
        firstLabelSize = 17;
        secondLabelSize = 13;
        
        secondLabelX = 254/2-65;
        secondLableY = 44;
        secondLableWidth = 143;
        secondLableHeight = 15;
        secondLabelSize = 13;
        
        leftButtonX = 254/2-4-102;
        leftButtonY = 80;
        leftButtonWidth = 102;
        leftButtonHeight = 34;
        
        rightButtonX = 254/2+4;
        rightButtonY = 80;
        rightButtonWidth = 102;
        rightButtonHeight = 34;
    }
    
    //主标题
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstLableX, firstLableY, firstLabelWidth, firstLabelHeight)];
    _titleLabel.text = @"取消提示";
    _titleLabel.font = [UIFont systemFontOfSize:firstLabelSize];
    _titleLabel.textColor = [UIColor orangeColor];
    [self addSubview:_titleLabel];
    
    //副标题
    _secondLitleLable = [[UILabel alloc]initWithFrame:CGRectMake(secondLabelX, secondLableY, secondLableWidth, secondLableHeight)];
    _secondLitleLable.text = @"您确定要取消该订单吗？";
    _secondLitleLable.font = [UIFont systemFontOfSize:secondLabelSize];
    _secondLitleLable.textColor = [UIColor orangeColor];
    [self addSubview:_secondLitleLable];
    
    //让我想想
    _leftButton = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _leftButton.frame = CGRectMake(leftButtonX, leftButtonY, leftButtonWidth, leftButtonHeight);
    _leftButton.layer.borderWidth = 1.f;
//    _leftButton.titleLabel.text = @"让我再想想";
    [_leftButton setTitle:@"让我再想想" forState:UIControlStateNormal];
    [_leftButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _leftButton.layer.masksToBounds = YES;
    _leftButton.layer.cornerRadius = 2.5;
    _leftButton.layer.borderColor = [UIColor orangeColor].CGColor;
  
    [self addSubview:_leftButton];
    
    //确定
    _rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _rightButton.frame = CGRectMake(rightButtonX, rightButtonY, rightButtonWidth, rightButtonHeight);
//    _rightButton.layer.borderWidth = 1.f;
    [_rightButton setTitle:@"确定" forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _rightButton.layer.masksToBounds = YES;
    _rightButton.layer.cornerRadius = 2.5;
    _rightButton.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:153 / 255.0 blue:102 / 255.0 alpha:1.0];
    [self addSubview:_rightButton];
    
    
}



@end

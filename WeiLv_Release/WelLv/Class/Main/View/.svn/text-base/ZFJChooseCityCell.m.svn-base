//
//  ZFJChooseCityCell.m
//  WelLv
//
//  Created by 张发杰 on 15/6/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJChooseCityCell.h"
#define M_TEXT_FONT_SIZE 15
@implementation ZFJChooseCityCell
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(ViewWidth(self), 0, 0.5, ViewHeight(self))];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:line];
        UIView * downLine = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(self), ViewWidth(self) + 0.5, 0.5)];
        downLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:downLine];
        self.masgLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _masgLabel.textColor = [UIColor grayColor];
        _masgLabel.font = [UIFont systemFontOfSize:M_TEXT_FONT_SIZE];
        _masgLabel.textAlignment = NSTextAlignmentCenter;
        _masgLabel.numberOfLines = 0;
        _masgLabel.adjustsFontSizeToFitWidth=YES;
        [self addSubview:_masgLabel];
    }
    return self;
}

@end

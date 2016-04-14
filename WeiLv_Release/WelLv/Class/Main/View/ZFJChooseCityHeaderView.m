//
//  ZFJChooseCityHeaderView.m
//  WelLv
//
//  Created by 张发杰 on 15/6/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJChooseCityHeaderView.h"
#define M_TEXT_FONT_SIZE 15
@implementation ZFJChooseCityHeaderView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.headerTitel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, windowContentWidth - 15, ViewHeight(self))];
        _headerTitel.textColor = [UIColor grayColor];
        _headerTitel.font = [UIFont systemFontOfSize:M_TEXT_FONT_SIZE];
        [self addSubview:_headerTitel];
        
    }
    return self;
}

@end

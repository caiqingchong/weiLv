//
//  ZFJTicketHeaderView.m
//  WelLv
//
//  Created by 张发杰 on 15/8/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJTicketHeaderView.h"

@implementation ZFJTicketHeaderView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(self) - 45, ViewWidth(self), 45)];
        backgroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backgroundView];
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 25, 25)];
        [backgroundView addSubview:_iconImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(_iconImageView) + ViewWidth(_iconImageView) + 10, 10, ViewWidth(self) - ViewX(self.titleLabel), 25)];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor blackColor];
        [backgroundView addSubview:_titleLabel];
        
    }
    return self;
}

@end

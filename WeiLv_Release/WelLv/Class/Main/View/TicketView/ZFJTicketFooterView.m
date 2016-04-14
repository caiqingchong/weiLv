//
//  ZFJTicketFooterView.m
//  WelLv
//
//  Created by 张发杰 on 15/8/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJTicketFooterView.h"

@implementation ZFJTicketFooterView
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.titleBut.backgroundColor = [UIColor whiteColor];
        self.titleBut.frame = CGRectMake(0, 0, ViewWidth(self), ViewHeight(self));
        [self.titleBut setTitleColor:kColor(123, 174, 253) forState:UIControlStateNormal];
        [self.titleBut setTitle:@"查看更多" forState:UIControlStateNormal];
        self.titleBut.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleBut.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleBut];
    }
    return self;
}

@end

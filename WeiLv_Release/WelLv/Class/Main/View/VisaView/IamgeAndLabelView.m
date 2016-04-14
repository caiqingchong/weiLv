//
//  IamgeAndLabelView.m
//  WelLv
//
//  Created by 张发杰 on 15/4/7.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "IamgeAndLabelView.h"

@implementation IamgeAndLabelView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self coustomView];
    }
    return self;
}

- (void)coustomView
{
    self.iconIamge = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
    //self.iconIamge.backgroundColor = [UIColor orangeColor];
    [self addSubview:_iconIamge];
    
    self.infoLanel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.height + 10, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height)];
    //self.infoLanel.backgroundColor = [UIColor cyanColor];
    [self addSubview:_infoLanel];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

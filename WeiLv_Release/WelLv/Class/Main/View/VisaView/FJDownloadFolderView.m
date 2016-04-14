//
//  FJDownloadFolderView.m
//  WelLv
//
//  Created by 张发杰 on 15/4/10.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "FJDownloadFolderView.h"

@implementation FJDownloadFolderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.frame.size.width - self.frame.size.height - 5, self.frame.size.height)];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textColor = [UIColor grayColor];
        [self addSubview:_titleLabel];
        self.chooesIcon = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - self.frame.size.height, 5, self.frame.size.height - 10, self.frame.size.height - 10)];
        [self addSubview:_chooesIcon];
        
        self.chooesButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.chooesButton.frame = CGRectMake(0, 0, windowContentWidth, self.frame.size.height);
        [self addSubview:_chooesButton];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

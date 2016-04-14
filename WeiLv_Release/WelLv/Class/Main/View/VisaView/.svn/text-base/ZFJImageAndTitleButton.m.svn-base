//
//  ZFJImageAndTitleButton.m
//  WelLv
//
//  Created by 张发杰 on 15/4/17.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJImageAndTitleButton.h"

@implementation ZFJImageAndTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //self.backgroundColor = [UIColor orangeColor];
        self.iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(10 , 0, self.frame.size.width - 20, self.frame.size.width - 20)];
        self.iconImage.layer.cornerRadius = (self.frame.size.width - 20) / 2;
        self.iconImage.layer.masksToBounds = YES;
        //self.iconImage.backgroundColor = [UIColor brownColor];
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:@"http://www.huabian.com/uploadfile/2014/0821/20140821101516903.jpg"]];
        
        [self addSubview:_iconImage];
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, self.iconImage.frame.size.height + 5, self.frame.size.width ,self.frame.size.height - self.iconImage.frame.size.height - 5)];
        //self.title.text = @"管家";
        self.title.font = [UIFont systemFontOfSize:15];
        self.title.textAlignment = NSTextAlignmentCenter;
        //self.title.backgroundColor = [UIColor blackColor];
        [self addSubview:_title];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame cornerRadius:(CGFloat )cornerRadius masksToBounds:(BOOL)masksToBounds
{
    if (self = [super initWithFrame:frame]) {
        //self.backgroundColor = [UIColor orangeColor];
        self.iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(10 , 0, frame.size.width - 20, frame.size.width - 20)];
        self.iconImage.layer.cornerRadius = cornerRadius;
        self.iconImage.layer.masksToBounds = masksToBounds;
        //self.iconImage.backgroundColor = [UIColor brownColor];
        //[self.iconImage sd_setImageWithURL:[NSURL URLWithString:@"http://www.huabian.com/uploadfile/2014/0821/20140821101516903.jpg"]];
        
        [self addSubview:_iconImage];
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, self.iconImage.frame.size.height + 5, frame.size.width ,self.frame.size.height - self.iconImage.frame.size.height - 5)];
        //self.title.text = @"管家";
        self.title.font = [UIFont systemFontOfSize:15];
        self.title.textAlignment = NSTextAlignmentCenter;
        //self.title.backgroundColor = [UIColor blackColor];
        [self addSubview:_title];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame shipViewCornerRadius:(CGFloat )cornerRadius masksToBounds:(BOOL)masksToBounds{
    if (self = [super initWithFrame:frame]) {
        self.iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(0 , 0, frame.size.width, frame.size.width)];
        self.iconImage.layer.cornerRadius = cornerRadius;
        self.iconImage.layer.masksToBounds = masksToBounds;
        [self addSubview:self.iconImage];
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.width + 5, frame.size.width, 20)];
        self.title.font = [UIFont systemFontOfSize:12];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.userInteractionEnabled=YES;
        [self addSubview:self.title];
    }
    return self;
}

//新年换图标用到的 2016.1.25 add by:ly
- (instancetype)initWithFrames:(CGRect)frame shipViewCornerRadiuss:(CGFloat )cornerRadius masksToBoundss:(BOOL)masksToBounds{
    if (self = [super initWithFrame:frame])
    {
        //self.backgroundColor = [UIColor redColor];
        self.iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(0 , 0, frame.size.width, frame.size.width)];
        self.iconImage.layer.cornerRadius = cornerRadius;
        self.iconImage.layer.masksToBounds = masksToBounds;
        [self addSubview:_iconImage];
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(-10, frame.size.width + 12, frame.size.width + 20, 20)];
        self.title.font = [UIFont systemFontOfSize:12];
        self.title.textAlignment = NSTextAlignmentCenter;
        //self.title.adjustsFontSizeToFitWidth=YES;
        [self addSubview:_title];
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

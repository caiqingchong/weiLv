//
//  MainIconAndTitleVIew.m
//  WelLv
//
//  Created by mac for csh on 15/11/3.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "MainIconAndTitleVIews.h"

//#define M_BUT_Width 70
//#define M_BUT_Heigth 58

#define M_MainView_But_Width 50


@implementation MainIconAndTitleVIews
@synthesize iconImageView,goIcon,titleLabel;
@synthesize but;

- (id)initWithFrame:(CGRect)frame MainTitleArray:(NSArray *)titleArr ImageURLArray:(NSArray *)ImageUrlStrArr
{
    if (self = [super initWithFrame:frame])
    {
        float beginxxx = 30 ;
        float sw=5;
        float iconWidth=50;
        if (iPhone4S || iPhone5)
        {
            beginxxx = 16;
        }
        
        if (iPhone6) {
            sw=15;
            iconWidth=59;
        }
        
        if (IS_IPHONE_6P) {
            sw=21;
            iconWidth=60;
        }
        
        
        int colWidth =(windowContentWidth - M_MainView_But_Width * 5 - beginxxx*2) / 3;
        
        for (int i = 0; i < titleArr.count; i++)
        {
            NSString * imageStr = [ImageUrlStrArr objectAtIndex:i];
            NSString * title = [titleArr objectAtIndex:i];
            
            but = [[ZFJImageAndTitleButton alloc] initWithFrames:CGRectMake(beginxxx + M_MainView_But_Width * i  + colWidth * i-sw, 0,iconWidth, iconWidth + 12 + 20) shipViewCornerRadiuss:M_MainView_But_Width/2 masksToBoundss:YES];
            
            but.iconImage.image = [UIImage imageNamed:imageStr];
            but.title.text = title;
            but.title.font=[UIFont systemFontOfSize:15];
            but.tag = 1000 + i + frame.origin.x / windowContentWidth * 5;
            [but addTarget:self action:@selector(tagForBtn:) forControlEvents:UIControlEventTouchUpInside];

            [self addSubview:but];
            
        }
    }
    return self;
}

-(NSInteger)tagForBtn:(UIButton *)sender
{
    if (self.tapBut)
    {
        self.tapBut([NSIndexPath indexPathForRow:sender.tag inSection:0]);
    }
    return (long)sender.tag;
}

@end

//
//  MainIconAndTitleVIew.m
//  WelLv
//
//  Created by mac for csh on 15/11/3.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "MainIconAndTitleVIew.h"

//#define M_BUT_Width 70
//#define M_BUT_Heigth 58

#define M_MainView_But_Width 60


@implementation MainIconAndTitleVIew
@synthesize iconImageView,goIcon,titleLabel;
@synthesize but;

- (id)initWithFrame:(CGRect)frame MainTitleArray:(NSArray *)titleArr ImageURLArray:(NSArray *)ImageUrlStrArr{
    if (self = [super initWithFrame:frame]) {
        float beginxxx = 30 ;
        if (iPhone4S || iPhone5) {
            beginxxx = 15;
        }
        int colWidth =(windowContentWidth - M_MainView_But_Width * 4 - beginxxx*2) / 3;
        for (int i = 0; i < titleArr.count; i++) {
            NSString * imageStr = [ImageUrlStrArr objectAtIndex:i];
            NSString * title = [titleArr objectAtIndex:i];
          
                but = [[ZFJImageAndTitleButton alloc] initWithFrame:CGRectMake(beginxxx + M_MainView_But_Width * i  + colWidth * i, 0, M_MainView_But_Width, 60 + 12 + 20) shipViewCornerRadius:M_MainView_But_Width/2 masksToBounds:YES];
                but.iconImage.image = [UIImage imageNamed:imageStr];
                but.title.text = title;
                but.tag = 1000 + i + frame.origin.x / windowContentWidth * 4;
                [but addTarget:self action:@selector(tagForBtn:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:but];
            
        }
    }
    return self;
}
/*
- (id)initWithFrame:(CGRect)frame MainTitleArray:(NSArray *)titleArr ImageURLArray:(NSArray *)ImageUrlStrArr{
    if (self = [super initWithFrame:frame]) {
  
        int colWidth =(windowContentWidth - M_MainView_But_Width * 4 ) / 5;
        float beginxxx = colWidth;
        for (int i = 0; i < titleArr.count; i++) {
            NSString * imageStr = [ImageUrlStrArr objectAtIndex:i];
            NSString * title = [titleArr objectAtIndex:i];
            
            but = [[ZFJImageAndTitleButton alloc] initWithFrame:CGRectMake(beginxxx + M_MainView_But_Width * i  + colWidth * i, 0, M_MainView_But_Width, 60 + 12 + 20) shipViewCornerRadius:M_MainView_But_Width/2 masksToBounds:YES];
            but.iconImage.image = [UIImage imageNamed:imageStr];
            but.title.text = title;
            but.tag = 1000 + i ;
            [but addTarget:self action:@selector(tagForBtn:) forControlEvents:UIControlEventTouchUpInside];
               NSLog(@"but.tag =%ld",(long)but.tag);
            [self addSubview:but];
        }
    }
    return self;
}*/
-(NSInteger)tagForBtn:(UIButton *)sender{
    if (self.tapBut) {
        self.tapBut([NSIndexPath indexPathForRow:sender.tag inSection:0]);
    }
    return (long)sender.tag;
}

@end

//
//  CSProductBlackLineView.m
//  WelLv
//
//  Created by 吴伟华 on 16/3/17.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "CSProductBlackLineView.h"

@implementation CSProductBlackLineView
-(instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName starAddress:(NSString *)starAddress andStarTime:(NSString *)starTime
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
         self.alpha = 0.7;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 3, 14, 14)];
        imageView.image = [UIImage imageNamed:imageName];
        [self addSubview:imageView];
        
        UILabel *starLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 5, windowContentWidth/2 , 12)];
        starLabel.backgroundColor = [UIColor clearColor];
        starLabel.textColor = [UIColor whiteColor];
        starLabel.font = [UIFont systemFontOfSize:10];
        starLabel.text =[NSString stringWithFormat:@"%@出发",starAddress];
        [self addSubview:starLabel];
        
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth/2, 5, windowContentWidth/2 - 15, 12)];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = [UIColor whiteColor];
        timeLabel.font = [UIFont systemFontOfSize:10];
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.text = starTime;
        [self addSubview:timeLabel];
    }

    return self;
}

@end

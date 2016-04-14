//
//  ButtonWithImage.m
//  WelLv
//
//  Created by mac for csh on 15/11/23.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ButtonWithImage.h"

@implementation ButtonWithImage

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
       
        //self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-17 -20 , 45/2-12/2, 17, 12)];
        self.imageV.image = [UIImage imageNamed:@"selected-自驾吃"];
        self.imageV.hidden = YES;
        [self addSubview:self.imageV];
    
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 45)];
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.textLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, -0.5, windowContentWidth, 0.5)];
        line.backgroundColor = bordColor;
        [self addSubview:line];

    }
    return self;
}


@end

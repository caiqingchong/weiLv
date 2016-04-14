//
//  ZFJChooseDateView.m
//  TestProject
//
//  Created by 张发杰 on 15/9/10.
//  Copyright (c) 2015年 张发杰. All rights reserved.
//

#import "ZFJChooseDateView.h"
#define M_VIEW_WIDTH(view) view.frame.size.width

#define M_VIEW_HEIGHT(view) view.frame.size.height


#define M_WINDOW_HEIGHT  ([[UIScreen mainScreen] bounds].size.height)
#define M_WINDOW_WIDTH  ([[UIScreen mainScreen] bounds].size.width)

@implementation ZFJChooseDateView
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        
        UITapGestureRecognizer * leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        UITapGestureRecognizer * middleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        UITapGestureRecognizer * rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        
        
        
        //左
        self.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, M_VIEW_WIDTH(self) / 3.0, M_VIEW_HEIGHT(self))];
        self.leftLabel.text = @"暂无";
        self.leftLabel.textColor = [UIColor grayColor];
        self.leftLabel.textAlignment = NSTextAlignmentCenter;
        self.leftLabel.numberOfLines = 0;
        self.leftLabel.tag = 101;
        self.leftLabel.userInteractionEnabled = YES;
        self.leftLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_leftLabel];
        UIImageView * leftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(2.5, (M_VIEW_HEIGHT(self) - 17) / 2.0, 9, 17)];
        leftIcon.image = [UIImage imageNamed:@"矩形-40"];
        [self.leftLabel addSubview:leftIcon];
        [self.leftLabel addGestureRecognizer:leftTap];
        
        
        //中
        self.middleLabel = [[UILabel alloc] initWithFrame:CGRectMake(M_VIEW_WIDTH(self) / 3.0, 0, M_VIEW_WIDTH(self) / 3.0, M_VIEW_HEIGHT(self))];
        //self.middleLabel.text = @"09-20\n";
        self.middleLabel.textAlignment = NSTextAlignmentCenter;
        self.middleLabel.textColor = [UIColor grayColor];
        self.middleLabel.font = [UIFont systemFontOfSize:15];
        //self.middleLabel.adjustsFontSizeToFitWidth = YES;
        self.middleLabel.numberOfLines = 0;
        self.middleLabel.tag = 102;
        self.middleLabel.userInteractionEnabled = YES;
        [self addSubview:_middleLabel];
        
        UIView * leftLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 0.5, M_VIEW_HEIGHT(self) - 10)];
        leftLineView.backgroundColor = [UIColor grayColor];
        [self.middleLabel addSubview:leftLineView];
        
        UIView * rightLineView = [[UIView alloc] initWithFrame:CGRectMake(M_VIEW_WIDTH(self) / 3.0 - 0.5, 5, 0.5, M_VIEW_HEIGHT(self) - 10)];
        rightLineView.backgroundColor = [UIColor grayColor];
        [self.middleLabel addSubview:rightLineView];
        
        UIView * flagLineView = [[UIView alloc] initWithFrame:CGRectMake(12, M_VIEW_HEIGHT(self) - 2,M_VIEW_WIDTH(self) / 3.0 - 24, 2)];
        flagLineView.backgroundColor = [UIColor greenColor];
        [self.middleLabel addSubview:flagLineView];
        [self.middleLabel addGestureRecognizer:middleTap];

        //右
        self.rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(M_VIEW_WIDTH(self)* 2 / 3.0, 0, M_VIEW_WIDTH(self) / 3.0, M_VIEW_HEIGHT(self))];
        self.rightLabel.textAlignment = NSTextAlignmentCenter;
        self.rightLabel.textColor = [UIColor grayColor];
        //self.rightLabel.text = @"09-21\n";
        self.rightLabel.font = [UIFont systemFontOfSize:15];
        self.rightLabel.numberOfLines = 0;
        self.rightLabel.tag = 103;
        self.rightLabel.userInteractionEnabled = YES;
        //底部横线
        
        
        [self addSubview:_rightLabel];
        
        UIImageView * rightIcon = [[UIImageView alloc] initWithFrame:CGRectMake(M_VIEW_WIDTH(self) / 3.0 - 9 - 5, (M_VIEW_HEIGHT(self) - 17) / 2.0, 9, 17)];
        rightIcon.image = [UIImage imageNamed:@"矩形-41"];
        [self.rightLabel addSubview:rightIcon];
        [self.rightLabel addGestureRecognizer:rightTap];

    }
    return self;
}

- (void)tapView:(UITapGestureRecognizer *)tap {
    NSLog(@"*** = %d", tap.view.tag - 100);
    self.index(tap.view.tag - 100);
}
- (void)chooseViewIndex:(ChooseViewIndex)index {
    self.index = index;
}


@end

//
//  DownView.m
//  TraveDetail
//
//  Created by WeiLv on 16/1/11.
//  Copyright © 2016年 WeiLv. All rights reserved.
//

#import "DownView.h"

#define UISCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

@implementation DownView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addButtons];
    }
    return self;
}

/**
 * Buttons
 */
- (void)addButtons{
    
    if([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward){
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 0.5)];
        label.alpha = 0.3;
        label.backgroundColor = [UIColor grayColor];
        [self addSubview:label];
        //咨询按钮
        self.referBU = [UIButton buttonWithType:UIButtonTypeCustom];
        self.referBU.frame = CGRectMake(0, 0, UISCREEN_WIDTH / 3.6, UISCREEN_WIDTH / 8);
        self.referBU.tag = 302;
        //    self.referBU.backgroundColor = [UIColor redColor];
        [self addSubview:self.referBU];
        
        UIImageView *secondImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.attentionBU.frame) + UISCREEN_WIDTH / 10, 3, UISCREEN_WIDTH / 16, UISCREEN_WIDTH / 16)];
        secondImage.image = [UIImage imageNamed:@"咨询管家"];
        [self addSubview:secondImage];
        UILabel *secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(secondImage.frame) -10, CGRectGetMaxY(secondImage.frame) + 3,UISCREEN_WIDTH / 8, UISCREEN_WIDTH / 22)];
        secondLabel.textColor = [UIColor grayColor];
        secondLabel.text = @"电话咨询";
        secondLabel.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 32];
        [self addSubview:secondLabel];
        
        //预订
        self.scheduleBU = [UIButton buttonWithType:UIButtonTypeCustom];
        self.scheduleBU.frame = CGRectMake(CGRectGetMaxX(self.referBU.frame), 0, UISCREEN_WIDTH - UISCREEN_WIDTH / 3.6, UISCREEN_WIDTH / 8);
        [self.scheduleBU setTitle:@"立即预订" forState:UIControlStateNormal];
        self.scheduleBU.titleLabel.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 22];
        self.scheduleBU.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.scheduleBU.backgroundColor = [UIColor colorWithRed:255/255.0 green:153/255.0 blue:102/255.0 alpha:1];
        self.scheduleBU.tag = 303;
        [self addSubview:self.scheduleBU];
        
    }else{
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 0.5)];
        label.alpha = 0.3;
        label.backgroundColor = [UIColor grayColor];
        [self addSubview:label];
        
        //关注按钮
        self.attentionBU = [UIButton buttonWithType:UIButtonTypeCustom];
        self.attentionBU.frame = CGRectMake(0, 0, UISCREEN_WIDTH / 6, UISCREEN_WIDTH / 8);
        self.attentionBU.tag = 301;
        [self addSubview:self.attentionBU];
        
        self.firstImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.attentionBU.frame) + UISCREEN_WIDTH / 20, 3, UISCREEN_WIDTH / 16, UISCREEN_WIDTH / 16)];
        self.firstImage.image = [UIImage imageNamed:@"关注"];
        
        [self addSubview:_firstImage];
        self.firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_firstImage.frame) - UISCREEN_WIDTH / 40, CGRectGetMaxY(_firstImage.frame) +3, UISCREEN_WIDTH / 9, UISCREEN_WIDTH / 22)];
        _firstLabel.text = @"收藏";
        _firstLabel.textAlignment = NSTextAlignmentCenter;
        _firstLabel.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 32];
        _firstLabel.textColor = [UIColor grayColor];
        [self addSubview:_firstLabel];
        
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 6, 0, 0.5, UISCREEN_WIDTH / 8)];
        lineLabel.alpha = 0.3;
        lineLabel.backgroundColor = [UIColor grayColor];
        [self addSubview:lineLabel];
        //咨询按钮
        self.referBU = [UIButton buttonWithType:UIButtonTypeCustom];
        self.referBU.frame = CGRectMake(UISCREEN_WIDTH / 6, 0, UISCREEN_WIDTH / 6, UISCREEN_WIDTH / 8);
        self.referBU.tag = 302;
        //   self.referBU.backgroundColor = [UIColor redColor];
        [self addSubview:self.referBU];
        
        UIImageView *secondImage = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 6 + UISCREEN_WIDTH / 20, 3, UISCREEN_WIDTH / 16, UISCREEN_WIDTH / 16)];
        secondImage.image = [UIImage imageNamed:@"咨询管家"];
        [self addSubview:secondImage];
        UILabel *secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(secondImage.frame) -10, CGRectGetMaxY(secondImage.frame) + 3,UISCREEN_WIDTH / 8, UISCREEN_WIDTH / 22)];
        secondLabel.textColor = [UIColor grayColor];
        secondLabel.text = @"电话咨询";
        secondLabel.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 32];
        [self addSubview:secondLabel];
        
        //预订
        self.scheduleBU = [UIButton buttonWithType:UIButtonTypeCustom];
        self.scheduleBU.frame = CGRectMake(UISCREEN_WIDTH / 3, 0, UISCREEN_WIDTH * 2 / 3, UISCREEN_WIDTH / 8);
        
        [self.scheduleBU setTitle:@"立即预订" forState:UIControlStateNormal];
        self.scheduleBU.titleLabel.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 22];
        self.scheduleBU.backgroundColor = [UIColor colorWithRed:255/255.0 green:153/255.0 blue:102/255.0 alpha:1];
        self.scheduleBU.tag = 303;
        [self addSubview:self.scheduleBU];

    }
}


@end

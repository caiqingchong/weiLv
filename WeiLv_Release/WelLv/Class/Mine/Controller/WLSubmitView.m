//
//  WLSubmitView.m
//  WelLv
//
//  Created by 赵阳 on 16/1/1.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "WLSubmitView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation WLSubmitView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        self.frame = CGRectMake(SCREEN_WIDTH - 55, SCREEN_HEIGHT - 64 - 140, 50, 80);
        
        self.layer.masksToBounds = YES;
        
        self.layer.cornerRadius = 12.0;
        
        self.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:144.0/255.0 blue:65.0/255.0 alpha:1];
        
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapSubmitView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapSubmit:)];
        
        [self addGestureRecognizer:tapSubmitView];
        
        [self setSubview];
    }
    
    return self;
}

- (void)setSubview {
    
    UILabel *submitLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height)];
    
    submitLabel.text = @"提交测试";
    
    submitLabel.font = [UIFont systemFontOfSize:15.0];
    
    submitLabel.numberOfLines = 2;
    
    submitLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:submitLabel];
}

- (void)onTapSubmit:(UITapGestureRecognizer *)tap {
    
    [self.delegate didClickedSubmitView];
}

@end









//
//  CSSearchBar.m
//  WelLv
//
//  Created by nick on 16/3/11.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "CSSearchBar.h"

@implementation CSSearchBar

- (instancetype)initWithFrame:(CGRect)frame SearchBarType:(SearchBarType)type andPlaceholder:(NSString *)placeholder {

    self = [super initWithFrame:frame];
    
    self.type = type;
    
    self.placeholder = placeholder;
    
    [self setLayout];
    
    return self;
}

- (void)setLayout {
    
    //搜索图标
    CGFloat iconSize = self.frame.size.height - MARGIN_HEIGHT * 2;
    
    UIImageView *searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN_WIDTH, MARGIN_HEIGHT, iconSize, iconSize)];
    
    searchIcon.image = [UIImage imageNamed:@"Search"];
    
    [self addSubview:searchIcon];
    
    //默认提示文本
    CGFloat placeholderOriginX = CGRectGetMaxX(searchIcon.frame) + MARGIN_WIDTH;
    
    UILabel *placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(placeholderOriginX, 0, self.frame.size.width - placeholderOriginX, self.frame.size.height)];
    
    placeholderLabel.text = self.placeholder;
    
    placeholderLabel.font = [UIFont systemFontOfSize:13.0];
    
    placeholderLabel.textColor = kColor(200.0, 202.0, 202.0);
    
    [self addSubview:placeholderLabel];

    if(self.type == SearchBarTypeView){
    
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.borderWidth = 0.5;
        
        self.layer.borderColor = kColor(222.0, 222.0, 222.0).CGColor;
        
        self.layer.cornerRadius = 4.0;
    }
}

@end

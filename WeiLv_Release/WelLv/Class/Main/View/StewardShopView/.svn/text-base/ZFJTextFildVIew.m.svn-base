//
//  ZFJTextFildVIew.m
//  WelLv
//
//  Created by WeiLv on 15/10/23.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJTextFildVIew.h"

@implementation ZFJTextFildVIew

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel * titleLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, 0, [self returnTextCGRectText:title textFont:16 cGSize:CGSizeMake(0, ViewHeight(self))].size.width, ViewHeight(self))];
        titleLabel.text = title;
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.textColor = [UIColor blackColor];
        [self addSubview:titleLabel];
        
        self.textFiled = [[UITextField alloc] initWithFrame:CGRectMake(ViewRight(titleLabel) + 10, 0, ViewWidth(self) - ViewRight(titleLabel) - 20, ViewHeight(self))];
        self.textFiled.borderStyle = UITextBorderStyleNone;
        [self addSubview:_textFiled];
    }
    return self;
}

@end

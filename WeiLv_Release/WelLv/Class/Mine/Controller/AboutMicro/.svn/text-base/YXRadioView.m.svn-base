//
//  YXRadioView.m
//  WelLv
//
//  Created by lyx on 15/4/13.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "YXRadioView.h"

@implementation YXRadioView
@synthesize array=_array;
@synthesize selectedIndex = _selectedIndex;
- (id)initWithFrame:(CGRect)frame array:(NSMutableArray *)array
{
    if (self = [super initWithFrame:frame])
    {
        self.frame = frame;
        self.array = array;
        _viewArray = [[NSMutableArray alloc] init];
        float w = (ViewWidth(self)-20)/3;
        for (int i= 0 ; i<_array.count; i++) {
            UIButton *radioBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            radioBtn.frame = CGRectMake((w+10)*(i%3), 10+10*(i/3)+i/3*40, w, 35);
            [radioBtn setTitle:[self.array objectAtIndex:i] forState:UIControlStateNormal];
            [radioBtn setTitleColor:[UIColor colorWithRed:116/255.0 green:119/255.0 blue:121/255.0 alpha:1.0] forState:UIControlStateNormal];
            radioBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
            radioBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
            radioBtn.titleLabel.font = systemFont(14);
            radioBtn.layer.borderWidth = 0.5;
            [radioBtn.layer setCornerRadius:2.0];
            [radioBtn.layer setMasksToBounds:YES];
            radioBtn.tag = i;
            [radioBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:radioBtn];
            [_viewArray addObject:radioBtn];
            
        }
    }
    return self;
}

- (void)selectedIndexBtn:(NSInteger)index
{
    _selectedIndex = index;
 
    for (UIButton *btn in _viewArray)
    {
      [btn setTitleColor:[UIColor colorWithRed:116/255.0 green:119/255.0 blue:121/255.0 alpha:1.0] forState:UIControlStateNormal];
      [btn setBackgroundColor:[UIColor clearColor]];
      btn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    }

    UIButton *view = [_viewArray objectAtIndex:index];
    [view setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view setBackgroundColor:[UIColor orangeColor]];
    view.layer.borderColor = [UIColor orangeColor].CGColor;
 
 
    
    
}
- (void)selectBtnClick:(UIButton *)sender
{
    [self selectedIndexBtn:sender.tag];
    
}
@end



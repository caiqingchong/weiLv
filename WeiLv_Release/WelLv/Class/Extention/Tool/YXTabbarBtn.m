//
//  YXTabbarBtn.m
//  enData
//
//  Created by lyx on 14-9-5.
//  Copyright (c) 2014年 lyx. All rights reserved.
//

#import "YXTabbarBtn.h"

@implementation YXTabbarBtn
@synthesize delegate=_delegate;
@synthesize btnArr=_btnArr;
@synthesize selectedIndex=_selectedIndex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithNomal:(NSArray *)titleArray  frame:(CGRect)frame;
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        self.frame = frame;
        [self initViewNomal:titleArray];
    }
    return self;
}
- (void)initViewNomal:(NSArray *)nomalArray
{
    CGFloat width = 0;
    _btnArr = [[NSMutableArray alloc] init];
    for (int i = 0; i<nomalArray.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(width, 0, self.frame.size.width/nomalArray.count,self.frame.size.height);
        btn.tag = i;
        [btn setTitle:[nomalArray objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = systemFont(15);
        [btn addTarget:self action:@selector(setBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [_btnArr addObject:btn];
        width = width + btn.frame.size.width;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(width, 5, 0.5, self.frame.size.height -10)];
        line.backgroundColor = [UIColor orangeColor];
        line.alpha = 0.8;
        [self addSubview:line];
    }
    _nomalArray = nomalArray;
}
- (void)btnClick:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(segmentedButtonSelectedIndex:button:)])
    {
        [_delegate segmentedButtonSelectedIndex:btn.tag button:btn];
    }
}

- (void)setBtn:(UIButton *)btn
{
    _selectedIndex = btn.tag;
    for (int i = 0; i<_btnArr.count; i++)
    {
        UIButton *button = (UIButton *)[_btnArr objectAtIndex:i];
        if (btn.tag == button.tag)
        {
            [button setBackgroundImage:[UIImage imageNamed:@"red_line_and_shadow"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }
        else
        {
            [button setBackgroundImage:nil forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    [self btnClick:btn];
}

- (void)setSelectIndex:(NSInteger)index
{
    if (index < _btnArr.count)
    {
        _selectedIndex = index;
        for (int i = 0; i<_btnArr.count; i++)
        {
             UIButton *button = (UIButton *)[_btnArr objectAtIndex:i];
            if (index == button.tag)
            {
                [button setBackgroundImage:[UIImage imageNamed:@"red_line_and_shadow"] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            }
            else
            {
                [button setBackgroundImage:nil forState:UIControlStateNormal];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
           
        }
    }
}

@end

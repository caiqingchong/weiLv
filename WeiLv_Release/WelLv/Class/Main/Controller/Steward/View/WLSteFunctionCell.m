//
//  WLSteFunctionCell.m
//  WelLv
//
//  Created by zhangjie on 15/12/5.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "WLSteFunctionCell.h"

#define M_CELL_HEIGHT 60
#define M_FUNCTION_VIEW_HEIGHT 60

@interface WLSteFunctionCell ()

@property (nonatomic, copy) ClickItem item;

@end

@implementation WLSteFunctionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setIconArr:(NSArray *)iconArr {
    _iconArr = iconArr;
    [self customView];
}

- (void)setTitleArr:(NSArray *)titleArr {
    _titleArr = titleArr;
    [self customView];
}

- (void)customView {
    if (self.iconArr && self.titleArr) {
        for (int i = 0; i < _titleArr.count; i++) {
        
            if ([self viewWithTag:100 + i]) {
                [[self viewWithTag:100 + i] removeFromSuperview];
                UIView * view = [self viewWithTag:100 + i];
                view = nil;
            }
            
            if ([self viewWithTag:1000 + i]) {
                [[self viewWithTag:1000 + i] removeFromSuperview];
                UIView * view = [self viewWithTag:1000 + i];
                view = nil;
            }
            
            if ([self viewWithTag:10000 + i]) {
                [[self viewWithTag:10000 + i] removeFromSuperview];
                UIView * view = [self viewWithTag:10000 + i];
                view = nil;
            }
            
            UIImageView * funcIcon = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth / self.titleArr.count * i + (windowContentWidth / self.titleArr.count - 20) / 2.0 , 10, 20, 20)];
            funcIcon.image = [UIImage imageNamed:[self.iconArr objectAtIndex:i]];
            funcIcon.contentMode = UIViewContentModeScaleAspectFit;
            funcIcon.clipsToBounds = YES;
            funcIcon.userInteractionEnabled = YES;
            funcIcon.tag = 1000 + i;
            [self addSubview:funcIcon];
            
            UILabel * funcTitle = [[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth / self.titleArr.count * i, ViewBelow(funcIcon), windowContentWidth / self.titleArr.count, M_FUNCTION_VIEW_HEIGHT - ViewBelow(funcIcon))];
            funcTitle.text = [self.titleArr objectAtIndex:i];
            funcTitle.font = [UIFont systemFontOfSize:14];
            funcTitle.userInteractionEnabled = YES;
            funcTitle.textAlignment = NSTextAlignmentCenter;
            funcIcon.tag = 10000 + i;
            [self addSubview:funcTitle];
        
            UIButton * funcBut = [UIButton buttonWithType:UIButtonTypeCustom];
            funcBut.frame = CGRectMake(windowContentWidth / self.titleArr.count * i, 0, windowContentWidth / self.titleArr.count, M_FUNCTION_VIEW_HEIGHT);
            funcBut.tag = 100 + i;
            [funcBut addTarget:self action:@selector(goFunctionView:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:funcBut];
            
        }

    }
}

- (void)goFunctionView:(UIButton *)button {
    if (self.item) {
        self.item([NSIndexPath indexPathForItem:(button.tag - 100) inSection:0]);
    }
}

- (void)clickFunctionItem:(ClickItem)item {
    self.item = item;
}

/*
 if (self.iconArr && self.titleArr) {
 for (int i = 0; i < _titleArr.count; i++) {
 if ([self viewWithTag:100 + i]) {
 [[self viewWithTag:100 + i] removeFromSuperview];
 UIView * view = [self viewWithTag:100 + i];
 view = nil;
 }
 
 UIButton * funcBut = [UIButton buttonWithType:UIButtonTypeCustom];
 funcBut.frame = CGRectMake(windowContentWidth / self.titleArr.count * i, 0, windowContentWidth / self.titleArr.count, M_FUNCTION_VIEW_HEIGHT);
 funcBut.tag = 100 + i;
 [funcBut addTarget:self action:@selector(goFunctionView:) forControlEvents:UIControlEventTouchUpInside];
 [self addSubview:funcBut];
 
 UIImageView * funcIcon = [[UIImageView alloc] initWithFrame:CGRectMake((funcBut.width - 20) / 2.0 , 10, 20, 20)];
 funcIcon.image = [UIImage imageNamed:[self.iconArr objectAtIndex:i]];
 funcIcon.contentMode = UIViewContentModeScaleAspectFit;
 funcIcon.clipsToBounds = YES;
 funcIcon.userInteractionEnabled = YES;
 [funcBut addSubview:funcIcon];
 
 UILabel * funcTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewBelow(funcIcon), funcBut.width, funcBut.height - ViewBelow(funcIcon))];
 funcTitle.text = [self.titleArr objectAtIndex:i];
 funcTitle.font = [UIFont systemFontOfSize:14];
 funcTitle.userInteractionEnabled = YES;
 funcTitle.textAlignment = NSTextAlignmentCenter;
 [funcBut addSubview:funcTitle];
 
 }
 
 }
 */

@end

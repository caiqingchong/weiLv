//
//  ZFJFilterView.m
//  WelLv
//
//  Created by zhangjie on 15/10/2.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJFilterView.h"
#define M_ICON_proportion 2/3
@interface ZFJFilterView ()
@property (nonatomic, strong) UIView * tempView;

@end

@implementation ZFJFilterView

- (instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray *)titleArr iconArr:(NSArray *)iconArr chooseIconArr:(NSArray *)chooseIconArr {
    if (self = [super initWithFrame:frame]) {
        for (int i = 0; i < titleArr.count; i++) {
          
           UIImage * image = [UIImage imageNamed:[iconArr objectAtIndex:i]];

            UIImageView * icon = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width / titleArr.count * i + (frame.size.width / titleArr.count - image.size.width) / 2, 5, image.size.width, image.size.height)];
            icon.image = image;
            icon.userInteractionEnabled = YES;
            [self addSubview:icon];
            
            UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width / titleArr.count * i, frame.size.height * M_ICON_proportion - 2, frame.size.width / titleArr.count, frame.size.height / 3)];
            titleLabel.userInteractionEnabled = YES;
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.font = [UIFont systemFontOfSize:14];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.text = [titleArr objectAtIndex:i];
            [self addSubview:titleLabel];
            
            UIButton * but =[UIButton buttonWithType:UIButtonTypeCustom];
            but.frame = CGRectMake(frame.size.width / titleArr.count * i, 0, frame.size.width / titleArr.count, frame.size.height);
            [but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
            but.tag = 100 + i;
            [self addSubview:but];
            
        }
    }
    return self;
}

- (void)clickBut:(UIButton *)button {
    
    
    if (self.selectIndex) {
        NSIndexPath * index = [NSIndexPath indexPathForRow:(button.tag - 100) inSection:0];
        self.selectIndex (index);
    }
}

- (void)didSelectIndex:(SelectIndex)index {
    self.selectIndex = index;
}
- (id)initWithFrame:(CGRect)frame withTitleArray:(NSArray *)titleArr {
    if (self == [super initWithFrame:frame]) {
        
        for (int i = 0; i < titleArr.count; i++) {
            
            self.backgroundColor = [UIColor whiteColor];
            
            UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewWidth(self) / titleArr.count * i, 0, ViewWidth(self) / titleArr.count, ViewHeight(self))];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.text = [titleArr objectAtIndex:i];
            titleLabel.font = [UIFont systemFontOfSize:16];
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.tag = 100 + i;
            titleLabel.userInteractionEnabled = YES;
            titleLabel.adjustsFontSizeToFitWidth = YES;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFilterView:)];
            [titleLabel addGestureRecognizer:tap];
            [self addSubview:titleLabel];
            CGFloat titleWidth = [self returnTextCGRectText:titleLabel.text textFont:16 cGSize:CGSizeMake(ViewWidth(titleLabel), ViewHeight(titleLabel))].size.width;
            UIImageView *chooseIcon = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(titleLabel) / 2 + titleWidth / 2 + 5, ViewHeight(titleLabel) * 0.7, 5, 5)];
            chooseIcon.image = [UIImage imageNamed:@"矩形-3-副本-2"];
            chooseIcon.tag = 150  + i;
            [titleLabel addSubview:chooseIcon];
            
            if (i < titleArr.count - 1) {
                UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(ViewWidth(self) / titleArr.count * (i + 1), ViewHeight(self) * 0.1, 0.5, ViewHeight(self) * 0.8)];
                lineView.backgroundColor = [UIColor orangeColor];
                [self addSubview:lineView];
            }
            UIView * belowView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(self) - 1, ViewWidth(self), 0.5)];
            belowView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [self addSubview:belowView];
        }
    }
    return self;
}
- (void)tapFilterView:(UITapGestureRecognizer *)tap {
    
    UILabel * tapLabel = (UILabel *)tap.view;
    UIImageView * chooseIcon = (UIImageView *)[self viewWithTag:50 + tap.view.tag];
    if ([self.tempView isEqual: tap.view]) {
        if ([tapLabel.textColor isEqual:[UIColor orangeColor]]) {
            
            tapLabel.textColor = [UIColor blackColor];
            //chooseIcon.image = [UIImage imageNamed:@"矩形-3-副本-2"];;
            
        } else {
            tapLabel.textColor = [UIColor orangeColor];
            //chooseIcon.image = [UIImage imageNamed:@"矩形-3"];
        }
        
        
    } else
        {
        UILabel * lastLabel = (UILabel *)self.tempView;
        //lastLabel.textColor = [UIColor blackColor];
        UIImageView * lastChooseIcon = (UIImageView *)[self viewWithTag:lastLabel.tag + 50];
        lastChooseIcon.image = [UIImage imageNamed:@"矩形-3-副本-2"];
        
        tapLabel.textColor = [UIColor orangeColor];
        chooseIcon.image = [UIImage imageNamed:@"矩形-3"];
        
    }
    
    
    self.tempView = tap.view;
    
    if (self.oneFilter) {
        self.oneFilter(tap.view.tag - 100);
    }
}
- (void)chooseFilterNoReturn:(ChooseOneFilter)oneFilter {
    self.oneFilter = oneFilter;
}

- (void)setChooseNavTitleStr:(NSString *)chooseNavTitleStr {
    _chooseNavTitleStr = chooseNavTitleStr;
    UILabel * chooseLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self))];
    chooseLab.text = chooseNavTitleStr;
    chooseLab.userInteractionEnabled = YES;
    chooseLab.backgroundColor = [UIColor whiteColor];
    UIImageView * iconChoose = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(chooseLab) - 20 + 7.5, (ViewHeight(chooseLab)) / 2, 5, 5)];
    iconChoose.image = [UIImage imageNamed:@"矩形-3-副本-2"];
    iconChoose.transform = CGAffineTransformMakeRotation(M_PI_4);
    [chooseLab addSubview:iconChoose];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseNavieTitle:)];
    [self addGestureRecognizer:tap];
}

- (void)chooseNavieTitle:(UITapGestureRecognizer *)tap {
    
    if (self.chooseNaviTitle) {
        self.chooseNaviTitle(0);
    }
}

- (void)chooseNaviTitle:(ChooseNaviTitle)chooseNavi {
    self.chooseNaviTitle = chooseNavi;
}

- (void)setGoBackColor:(BOOL)goBackColor {
    UILabel * lastLabel = (UILabel *)self.tempView;
    lastLabel.textColor = [UIColor orangeColor];
    UIImageView * lastChooseIcon = (UIImageView *)[self viewWithTag:lastLabel.tag + 50];
    lastChooseIcon.image = [UIImage imageNamed:@"矩形-3-副本-2"];

}

@end

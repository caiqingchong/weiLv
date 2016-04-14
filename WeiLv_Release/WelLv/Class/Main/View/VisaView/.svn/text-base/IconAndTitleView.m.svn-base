//
//  IconAndTitleView.m
//  WelLv
//
//  Created by 张发杰 on 15/7/7.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "IconAndTitleView.h"
#import "ZFJImageAndTitleButton.h"
#define M_BUT_Width 70
#define M_BUT_Heigth 58

#define M_ShipLine_But_Width 60

@interface IconAndTitleView ()
@property (nonatomic, copy) chooseTopBlock chooseTop;
@end

@implementation IconAndTitleView
- (id)initWithFrame:(CGRect)frame iconImageName:(NSString *)iconStr titleLabel:(NSString *)title{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UIImage * image = [UIImage imageNamed:iconStr];
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (ViewHeight(self) - image.size.height) / 2 , image.size.width, image.size.height)];//25
        _iconImageView.image = [UIImage imageNamed:iconStr];
        [self addSubview:_iconImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(_iconImageView) + ViewWidth(_iconImageView) + 10, 0, ViewWidth(self) - ViewX(self.titleLabel), ViewHeight(self))];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = title;
        //_titleLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseView:)];
        [_titleLabel addGestureRecognizer:tap];
        [self addSubview:_titleLabel];
        self.goIcon = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(self) - 30, (ViewHeight(self) - 17) / 2 , 10, 17)];
        self.goIcon.backgroundColor = [UIColor whiteColor];
        self.goIcon.image = [UIImage imageNamed:@"矩形-32"];
        self.goIcon.hidden = YES;
        [self addSubview:self.goIcon];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame downTitleArray:(NSArray *)titleArr ImageURLStrArrary:(NSArray *)ImageUrlStrArr{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        for (int i = 0; i < titleArr.count; i++) {
            UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
            but.backgroundColor = [UIColor whiteColor];
            but.contentMode = UIViewContentModeScaleAspectFill;
            but.clipsToBounds = YES;
            but.layer.cornerRadius = 4;
            but.layer.masksToBounds = YES;
            but.tag = 100 + i;
            [but addTarget:self action:@selector(chooseBut:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel * butTitleLabel = [[UILabel alloc] init];
            butTitleLabel.backgroundColor = [UIColor whiteColor];
            butTitleLabel.font = [UIFont systemFontOfSize:15];
            butTitleLabel.textAlignment = NSTextAlignmentCenter;
            butTitleLabel.textColor = [UIColor grayColor];
            butTitleLabel.text = [titleArr objectAtIndex:i];
            
            NSString * imageURLStr = [ImageUrlStrArr objectAtIndex:i];
            if ([imageURLStr hasPrefix:@"http"]) {
                [but sd_setBackgroundImageWithURL:[NSURL URLWithString:imageURLStr] forState:UIControlStateNormal];
            } else {
                [but setBackgroundImage:[UIImage imageNamed:imageURLStr] forState:UIControlStateNormal];
            }
            int colWidth =(windowContentWidth - M_BUT_Width * 4 - 30)/3;
            if (i >= 4) {
                but.frame =  CGRectMake(M_BUT_Width * (i - 4)+ colWidth * (i - 4) + 15, 90, M_BUT_Width, M_BUT_Heigth);
                butTitleLabel.frame = CGRectMake(M_BUT_Width * (i - 4) + colWidth * (i - 4) + 15, ViewY(but) + ViewHeight(but) + 5, M_BUT_Width, 25);
            } else {
                but.frame =  CGRectMake(M_BUT_Width * i + colWidth * i  + 15, 0, M_BUT_Width, M_BUT_Heigth);
                butTitleLabel.frame = CGRectMake(M_BUT_Width * i + colWidth * i + 15, ViewY(but) + ViewHeight(but) + 5, M_BUT_Width, 25);
            }
            [self addSubview:but];
            [self addSubview:butTitleLabel];
        }
    }
    return self;

}


- (id)initWithFrame:(CGRect)frame shipLineTitleArray:(NSArray *)titleArr ImageURLArray:(NSArray *)ImageUrlStrArr{
    if (self = [super initWithFrame:frame]) {
        int colWidth = (windowContentWidth - M_ShipLine_But_Width * 4 - 30) / 3;
        for (int i = 0; i < titleArr.count; i++) {
            NSString * imageStr = [ImageUrlStrArr objectAtIndex:i];
            NSString * title = [titleArr objectAtIndex:i];
            if (i >= 4) {
                ZFJImageAndTitleButton * but = [[ZFJImageAndTitleButton alloc] initWithFrame:CGRectMake(M_ShipLine_But_Width * (i - 4)  + colWidth * (i - 4) + 15, 80+ 12 + 20 + 15, M_ShipLine_But_Width, 60 + 12 + 20) shipViewCornerRadius:0 masksToBounds:NO];
                but.backgroundColor = [UIColor redColor];
                if ([imageStr hasPrefix:@"http"]) {
                    [but.iconImage sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"默认图1"]];

                } else {
                    but.iconImage.image = [UIImage imageNamed:imageStr];

                }
                but.title.text = title;
                but.tag = 100 + i + frame.origin.x / windowContentWidth * 8;
                [but addTarget:self action:@selector(chooseBut:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:but];
            } else {
                ZFJImageAndTitleButton * but = [[ZFJImageAndTitleButton alloc] initWithFrame:CGRectMake(M_ShipLine_But_Width * i  + colWidth * i + 15, 0, M_ShipLine_But_Width, 60 + 12 + 20) shipViewCornerRadius:0 masksToBounds:NO];
                //but.iconImage.backgroundColor = [UIColor orangeColor];
                if ([imageStr hasPrefix:@"http"]) {
                    [but.iconImage sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"默认图1"]];
                    
                } else {
                    but.iconImage.image = [UIImage imageNamed:imageStr];
                    
                }
                
                but.title.text = [NSString stringWithFormat:@"%@航线",title];
                but.tag = 100 + i + frame.origin.x / windowContentWidth * 8;
                [but addTarget:self action:@selector(chooseBut:) forControlEvents:UIControlEventTouchUpInside];
                //but.title.backgroundColor = [UIColor cyanColor];
                [self addSubview:but];
            }
        }
    }
    return self;
}



- (id)initWithFrame:(CGRect)frame roundIconIamge:(NSString *)imageStr titleStr:(NSString *)titleStr {
    if (self = [super initWithFrame:frame]) {
        UIImageView * iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        iconImageView.layer.cornerRadius = frame.size.width / 2;
        iconImageView.layer.masksToBounds = YES;
        iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        iconImageView.clipsToBounds = YES;
        
        if ([imageStr hasPrefix:@"http"]) {
            [iconImageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"默认图2"]];
        } else {
            [iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", WLHTTP, imageStr]] placeholderImage:[UIImage imageNamed:@"默认图2"]];
        }
        [self addSubview:iconImageView];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewBelow(iconImageView) + 5, frame.size.width , 25)];
        titleLabel.text = titleStr;
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:titleLabel];
    }
    return self;
}


- (void)chooseBut:(UIButton *)button{
    self.chooseTop(button.tag - 100);
}

- (void)chooseTop:(chooseTopBlock)chooseTop{
    self.chooseTop = chooseTop;
}

- (void)chooseView:(UITapGestureRecognizer *)tap{
    self.chooseTop(1);
}

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)titleStr secondTitle:(NSString *)secondTitle {
    
    if (self = [super initWithFrame:frame]) {
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, [self returnTextCGRectText:titleStr textFont:15 cGSize:CGSizeMake(0, ViewHeight(self))].size.width, ViewHeight(self))];
        titleLabel.text = titleStr;
        titleLabel.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:titleLabel];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, [self returnTextCGRectText:self.titleStr textFont:16 cGSize:CGSizeMake(0, ViewHeight(self))].size.width, ViewHeight(self))];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.text = self.titleStr;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    self.titleLabel.text = titleStr;
}

- (void)setMore:(BOOL)more {
    self.userInteractionEnabled = YES;
    UILabel * moreLab = [[UILabel alloc] initWithFrame:CGRectMake(ViewWidth(self) - 60, 0, 35, ViewHeight(self))];
    moreLab.text = @"更多";
    moreLab.font = [UIFont systemFontOfSize:16];
    moreLab.textColor = UIColorFromRGB(0x6F7378);
    [self addSubview:moreLab];
    UIImageView * iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(self) - 25, (ViewHeight(self) - 19) / 2, 19, 19)];
    iconImage.image = [UIImage imageNamed:@"更多-首页"];
    //iconImage.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:iconImage];
}


@end

//
//  WLSteHomeHeaderView.m
//  WelLv
//
//  Created by WeiLv on 15/12/1.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "WLSteHomeHeaderView.h"

@implementation WLSteHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self customView];
    }
    return self;
}

- (void)customView {
    WS(weakSelf);
    self.titleOneLab = [[UILabel alloc] init];
    [self addSubview:_titleOneLab];
    [self.titleOneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.height.mas_equalTo(ViewHeight(weakSelf) / 2.0);
    }];
    self.titleOneLab.textAlignment = NSTextAlignmentCenter;
    self.titleOneLab.textColor = [UIColor blackColor];
    self.titleOneLab.text = @"旅行管家";
    
    self.titleSmallLab = [[UILabel alloc] init];
    [self addSubview:self.titleSmallLab];
    [self.titleSmallLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleOneLab.mas_bottom);
        make.right.equalTo(weakSelf);
        make.left.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
    }];
    self.titleSmallLab.textAlignment = NSTextAlignmentCenter;
    self.titleSmallLab.textColor = UIColorFromRGB(0x6f7378);
    self.titleSmallLab.text = @"追逐梦想的旅程充满精彩";
}

- (UIButton *)moreBut {
    if (!_moreBut) {
        WS(weakSelf);
        self.moreBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.titleOneLab addSubview:_moreBut];
        [self.moreBut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.titleOneLab);
            make.right.equalTo(weakSelf.titleOneLab).with.offset(-15);
            make.bottom.equalTo(weakSelf.titleOneLab);
            make.width.mas_equalTo(@60);
        }];
        [self.moreBut setTitle:@"更多" forState:UIControlStateNormal];
        [self.moreBut setTitleColor:UIColorFromRGB(0x6f7378) forState:UIControlStateNormal];
        self.moreBut.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _moreBut;
}

@end

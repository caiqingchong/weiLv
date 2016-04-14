//
//  WLStewardHomeCell.m
//  WelLv
//
//  Created by WeiLv on 15/12/1.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "WLStewardHomeCell.h"

@implementation WLStewardHomeCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self customView];
    }
    return self;
}

- (void)customView {
    WS(weakSelf);
    self.headPortraitIcon = [[UIImageView alloc] init];
    self.headPortraitIcon.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:_headPortraitIcon];
    [self.headPortraitIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.equalTo(weakSelf.mas_top).with.offset(10);
        make.width.mas_equalTo(ViewWidth(weakSelf) - 30);
        make.height.mas_equalTo(ViewWidth(weakSelf) - 30);
    }];
    self.headPortraitIcon.layer.cornerRadius = (ViewWidth(weakSelf) - 30) / 2.0;
    self.headPortraitIcon.layer.masksToBounds = YES;

    self.nameLab = [[UILabel alloc] init];
    self.nameLab.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:_nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.headPortraitIcon.mas_centerX);
        make.top.equalTo(weakSelf.headPortraitIcon.mas_bottom).with.offset(5.0);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.width.mas_equalTo(ViewWidth(weakSelf));
    }];
}

@end

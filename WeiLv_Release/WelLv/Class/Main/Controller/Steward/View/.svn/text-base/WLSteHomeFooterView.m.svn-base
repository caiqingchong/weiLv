//
//  WLSteHomeFooterView.m
//  WelLv
//
//  Created by WeiLv on 15/12/1.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "WLSteHomeFooterView.h"

@implementation WLSteHomeFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (UIButton *)changeBut {
    if (!_changeBut) {
        WS(ws);
        self.changeBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_changeBut];
        [self.changeBut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.mas_left).with.offset(20);
            make.right.equalTo(ws.mas_right).with.offset(-20);
            make.top.equalTo(ws.mas_top).with.offset(5);
            make.bottom.equalTo(ws.mas_bottom).with.offset(-15);
        }];
        self.changeBut.layer.cornerRadius = 5.0;
        self.changeBut.layer.masksToBounds = YES;
        self.changeBut.layer.borderWidth = 0.5;
        self.changeBut.layer.borderColor = [UIColor orangeColor].CGColor;
        [self.changeBut setTitle:@"换一批" forState:UIControlStateNormal];
        [self.changeBut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }
    return _changeBut;
}

@end

//
//  WLMineHeaderCell.m
//  WelLv
//
//  Created by WeiLv on 15/12/3.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "WLMineHeaderCell.h"

@implementation WLMineHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}
#pragma mark - 懒加载
- (UIImageView *)bgIcon {
    if (!_bgIcon) {
        self.bgIcon = [[UIImageView alloc] init];
        //self.bgIcon.backgroundColor = [UIColor whiteColor];
        self.bgIcon.image = [UIImage imageNamed:@"wl_user_header_bg_icon"];
        self.bgIcon.userInteractionEnabled = YES;
        [self addSubview:_bgIcon];
        WS(ws);
        [self.bgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
               make.edges.equalTo(ws).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _bgIcon;
}

- (UIImageView *)headIcon {
    if (!_headIcon) {
        self.headIcon = [[UIImageView alloc] init];
        self.headIcon.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.headIcon.layer.masksToBounds = YES;
        self.headIcon.layer.cornerRadius = 40;
        self.headIcon.layer.borderWidth = 2;
        self.headIcon.layer.borderColor = [UIColor whiteColor].CGColor;
        [self.bgIcon addSubview:_headIcon];
        WS(ws);
        [self.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(ws.bgIcon.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(80, 80));
            make.top.equalTo(ws.bgIcon).with.offset(25);
        }];
    }
    return _headIcon;
}

- (UILabel *)nameLab {
    
    if (_loginBut){
        [_loginBut removeFromSuperview];
    }
    
    if (!_nameLab) {
        self.nameLab = [[UILabel alloc] init];
        self.nameLab.textColor = [UIColor whiteColor];
        self.nameLab.textAlignment = NSTextAlignmentCenter;
        self.nameLab.backgroundColor = [UIColor cyanColor];
        [self.bgIcon addSubview:_nameLab];
        WS(ws);
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.centerX.equalTo(ws.bgIcon.mas_centerX);
            make.top.mas_equalTo(ws.headIcon.mas_bottom).with.offset(10);
            //make.width.mas_equalTo(ws.bgIcon.mas_width );
            make.left.equalTo(ws.bgIcon).with.offset(15);
            make.right.equalTo(ws.bgIcon).with.offset(-15);
            make.height.mas_equalTo(20);
        }];
    }
    return _nameLab;
}

- (UILabel *)companyLab {
    
    if (!_companyLab) {
        _companyLab = [[UILabel alloc] init];
        _companyLab.textColor = [UIColor whiteColor];
        _companyLab.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        _companyLab.textAlignment = NSTextAlignmentCenter;
        _companyLab.font = [UIFont systemFontOfSize:15];
        [self.bgIcon addSubview:_companyLab];

//         WS(ws);
//        [_companyLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            //make.centerX.equalTo(ws.bgIcon.mas_centerX);
//            make.left.equalTo(ws.bgIcon).with.offset(15);
//            make.right.equalTo(ws.bgIcon).with.offset(-15);
//            make.top.mas_equalTo(ws.headIcon.mas_bottom).with.offset(10);
//            //make.width.equalTo(ws.bgIcon).with.offset(30);
//            make.height.mas_equalTo((30 ));
//        }];
    }
    /*
    if (_nameLab) {
        
    }else {
        CGFloat height = [self returnTextCGRectText:_companyLab.text textFont:15 cGSize:CGSizeMake(self.bgIcon.width - 40, 0)].size.height;
        NSLog(@"height ==== %g", height);
        height = 30;
        if (height > [self returnTextCGRectText:@"高" textFont:15 cGSize:CGSizeMake(20, 0)].size.height) {
//            _companyLab.top = self.headIcon.bottom + 10;
//            _companyLab.width = self.bgIcon.width - 40;
//            _companyLab.height = (height + 10);
//            _companyLab.layer.cornerRadius = (height + 10) / 2.0;
//            _companyLab.layer.masksToBounds = YES;
            WS(ws);
            
            [_companyLab mas_makeConstraints:^(MASConstraintMaker *make) {
                //make.centerX.equalTo(ws.bgIcon.mas_centerX);
                make.left.equalTo(ws.bgIcon).with.offset(15);
                make.right.equalTo(ws.bgIcon).with.offset(-15);
                make.top.mas_equalTo(ws.headIcon.mas_bottom).with.offset(10);
                //make.width.equalTo(ws.bgIcon).with.offset(30);
                make.height.mas_equalTo((height + 10));
            }];
            
            _companyLab.layer.cornerRadius = (height + 10) / 2.0;
            _companyLab.layer.masksToBounds = YES;
            
        } else {
            CGFloat width = [self returnTextCGRectText:_companyLab.text textFont:15 cGSize:CGSizeMake(0, 30)].size.width;
//            _companyLab.top = self.headIcon.bottom + 20;
//            _companyLab.width = width + 60;
//            _companyLab.height = 30;
//            _companyLab.layer.cornerRadius = 15;
//            _companyLab.layer.masksToBounds = YES;
        }
        //_companyLab.centerX = windowContentWidth / 2.0;
        
    }
    */
    return _companyLab;
}

- (UIButton *)loginBut {
    if (!_loginBut) {
        self.loginBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.loginBut setTitle:@"立即登录" forState:UIControlStateNormal];
        [self.loginBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.loginBut.backgroundColor = kColor(98, 135, 247);
        self.loginBut.layer.cornerRadius = 3.0;
        self.loginBut.layer.masksToBounds = YES;
        self.loginBut.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.bgIcon addSubview:_loginBut];
        WS(ws);
        [self.loginBut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.headIcon.mas_bottom).with.offset(10);
            make.centerX.equalTo(ws.bgIcon.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(100, 25));
        }];
    }
    return _loginBut;
}
@end

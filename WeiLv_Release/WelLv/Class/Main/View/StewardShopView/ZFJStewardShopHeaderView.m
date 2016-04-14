//
//  ZFJStewardShopHeaderView.m
//  WelLv
//
//  Created by WeiLv on 15/10/22.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJStewardShopHeaderView.h"
#define M_GAP_LEFT 10

@interface ZFJStewardShopHeaderView ()
//店铺名称
@property (nonatomic, strong) UILabel * shopTitleLabel;
//分销产品数量
@property (nonatomic, strong) UILabel * productCountLabel;
//合伙人数量
@property (nonatomic, strong) UILabel * partnerCountlabel;
//账号余额
@property (nonatomic, strong) UILabel * balanceNumLabel;


@end

@implementation ZFJStewardShopHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =[UIColor whiteColor];
        [self customView];
    }
    return self;
}

- (void)customView {
    self.headerBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth(self), 90)];
    _headerBgImageView.image = [UIImage imageNamed:@"steward_shop_own_header_bg"];
    [self addSubview:_headerBgImageView];
 
    self.shopMsgBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _shopMsgBut.frame =_headerBgImageView.frame;
    //[shopMsgBut addTarget:self action:@selector(goShopMsgView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_shopMsgBut];

}


- (void)setShopTitleStr:(NSString *)shopTitleStr {
    _shopTitleStr = shopTitleStr;
    self.shopTitleLabel.text = shopTitleStr;
}
- (void)setProductCountStr:(NSString *)productCountStr {
    _productCountStr = productCountStr;
    self.productCountLabel.text = productCountStr;
}
- (void)setPartnerCountStr:(NSString *)partnerCountStr {
    _partnerCountStr = partnerCountStr;
    self.partnerCountlabel.text = partnerCountStr;
}
- (void)setBalanceNumStr:(NSString *)balanceNumStr {
    _balanceNumStr = balanceNumStr;
    self.balanceNumLabel.text = balanceNumStr;
}

#pragma mark --- 懒加载
- (UIImageView *)shopIcon {
    if (!_shopIcon) {
        self.shopIcon = [[UIImageView alloc] initWithFrame:CGRectMake(22, 10, 70, 70)];
        _shopIcon.layer.cornerRadius = 35.0;
        _shopIcon.layer.masksToBounds = YES;
        _shopIcon.layer.borderWidth = 3.0;
        _shopIcon.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.7].CGColor;
        //[_shopIcon sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"默认图2"]];
        [_headerBgImageView addSubview:_shopIcon];
    }
    return _shopIcon;
}

- (UILabel *)shopTitleLabel {
    if (!_shopTitleLabel) {
        self.shopTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(_shopIcon) + M_GAP_LEFT, ViewY(_shopIcon), ViewWidth(self) - ViewRight(_shopIcon) - M_GAP_LEFT, 35)];
        _shopTitleLabel.text = @"店铺名称";
        _shopTitleLabel.font = [UIFont systemFontOfSize:15];
        _shopTitleLabel.textColor = [UIColor whiteColor];
        [_headerBgImageView addSubview:_shopTitleLabel];
    }
    return _shopTitleLabel;
}

- (UILabel *)productCountLabel {
    if (!_productCountLabel) {
        self.productCountLabel = [[UILabel alloc] init];//WithFrame:CGRectMake(ViewY(shopTitleLabel), ViewBelow(shopTitleLabel), 50, 35)
        _productCountLabel.text = @"分销产品:20个";
        _productCountLabel.font = [UIFont systemFontOfSize:12];
        _productCountLabel.backgroundColor = UIColorFromRGB(0xff5b26);
        _productCountLabel.textColor = [UIColor whiteColor];
        _productCountLabel.textAlignment = NSTextAlignmentCenter;
        _productCountLabel.layer.cornerRadius = 3.0;
        _productCountLabel.layer.masksToBounds = YES;
        _productCountLabel.frame = CGRectMake(ViewX(_shopTitleLabel), ViewBelow(_shopTitleLabel), [self returnTextCGRectText:_productCountStr textFont:12 cGSize:CGSizeMake(0, 30)].size.width + 10, 30);
        
        [_headerBgImageView addSubview:_productCountLabel];
    }
    return _productCountLabel;
}

- (UILabel *)partnerCountlabel {
    if (!_partnerCountlabel) {
        self.partnerCountlabel = [[UILabel alloc] init];//WithFrame:CGRectMake(ViewRight(productCountLabel) + M_GAP_LEFT, ViewY(productCountLabel), 50, 30)
        _partnerCountlabel.text = @"合伙人:20个";
        _partnerCountlabel.font = [UIFont systemFontOfSize:12];
        _partnerCountlabel.backgroundColor = kColor(25, 166, 236);
        _partnerCountlabel.textColor = [UIColor whiteColor];
        _partnerCountlabel.textAlignment = NSTextAlignmentCenter;
        _partnerCountlabel.layer.cornerRadius = 3.0;
        _partnerCountlabel.layer.masksToBounds = YES;
        _partnerCountlabel.frame = CGRectMake(ViewRight(_productCountLabel) + M_GAP_LEFT  * 2, ViewY(_productCountLabel), [self returnTextCGRectText:_partnerCountStr textFont:12 cGSize:CGSizeMake(0, 30)].size.width + 10, 30);
        
        [_headerBgImageView addSubview:_partnerCountlabel];
    }
    return _partnerCountlabel;
}

- (UILabel *)balanceNumLabel {
    if (!_balanceNumLabel) {
        UILabel * balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(M_GAP_LEFT, ViewBelow(_headerBgImageView), 90, 50)];
        balanceLabel.text = @"账户余额(元)";
        balanceLabel.font = [UIFont systemFontOfSize:15];
        balanceLabel.textColor = UIColorFromRGB(0x2f2f2f);
        [self addSubview:balanceLabel];
        
        self.balanceNumLabel = [[UILabel alloc] init];
        _balanceNumLabel.text = @"1156.00";
        _balanceNumLabel.textColor = UIColorFromRGB(0xff5b26);
        _balanceNumLabel.font = [UIFont systemFontOfSize:15];
        _balanceNumLabel.frame = CGRectMake(ViewRight(balanceLabel) + 10, ViewBelow(_headerBgImageView), [self returnTextCGRectText:_balanceNumStr textFont:15 cGSize:CGSizeMake(0, 50)].size.width, 50);
        [self addSubview:_balanceNumLabel];
        UIImageView * goIcon = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth - 20, ViewBelow(_headerBgImageView) + (50 - 17) / 2 , 10, 17)];
        goIcon.backgroundColor = [UIColor whiteColor];
        goIcon.image = [UIImage imageNamed:@"矩形-32"];
        [self addSubview:goIcon];
        
        UILabel * detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth - 60, ViewBelow(_headerBgImageView), 40, 50)];
        detailsLabel.text = @"明细";
        detailsLabel.font = [UIFont systemFontOfSize:15];
        detailsLabel.textColor = UIColorFromRGB(0xabb4bc);
        [self addSubview:detailsLabel];
        
        //self.detailsBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.detailsBut.frame = CGRectMake(0, ViewBelow(_headerBgImageView), windowContentWidth, 50);
        //[detailsBut addTarget:self action:@selector(goDetailMoneyView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_detailsBut];
    }
    return _balanceNumLabel;
}

- (UIButton *)detailsBut {
    if (!_detailsBut) {
        self.detailsBut = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _detailsBut;
}


@end

//
//  ZFJSteShopDistributionTravelView.m
//  WelLv
//
//  Created by WeiLv on 15/10/24.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJSteShopDistributionTravelView.h"

@implementation ZFJSteShopDistributionTravelView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self customView];
    }
    return self;
}
- (void)customView {
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, ViewWidth(self), 45)];
    self.titleLab.textColor = TimeGreenColor;
    [self addSubview:_titleLab];
    
    self.priceLab = [[UILabel alloc] initWithFrame:CGRectMake(10, ViewBelow(_titleLab), (ViewWidth(self) - 20) / 2.0, 45)];
    [self addSubview:_priceLab];
    self.commisstionLab = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(_priceLab), ViewBelow(_titleLab), (ViewWidth(self) - 20) / 2.0, 45)];
    [self addSubview:self.commisstionLab];
    self.distributionLab = [[UILabel alloc] initWithFrame:CGRectMake(10, ViewBelow(_priceLab), (ViewWidth(self) - 20), 45)];
    [self addSubview:self.distributionLab];
}

@end

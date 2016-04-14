//
//  ZFJSteShopMoneyDetailCell.m
//  WelLv
//
//  Created by WeiLv on 15/10/23.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJSteShopMoneyDetailCell.h"

@implementation ZFJSteShopMoneyDetailCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self customView];
    }
    return self;
}

- (void)customView {
    self.iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
    _iconImage.layer.cornerRadius = 25.0;
    _iconImage.layer.masksToBounds = YES;
    _iconImage.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:_iconImage];
    
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(_iconImage) + 5, 0, windowContentWidth - ViewRight(_iconImage) + 5 - windowContentWidth / 4.0, 30)];
    self.numLabel.font = [UIFont systemFontOfSize:15];
    self.numLabel.textColor = UIColorFromRGB(0x2f2f2f);
    //self.numLabel.text = @"12345678911111";
    [self.contentView addSubview:_numLabel];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(_iconImage) + 5, ViewBelow(_numLabel), windowContentWidth - ViewRight(_iconImage) + 5 - windowContentWidth / 4.0, 30)];
    self.titleLabel.font = [UIFont systemFontOfSize:10];
    self.titleLabel.textColor = UIColorFromRGB(0x2f2f2f);
    //self.titleLabel.text = @"旅游产品测试123";
    [self.contentView addSubview:_titleLabel];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(_numLabel), 0, windowContentWidth  - ViewRight(_numLabel) - 10, 60)];
    self.priceLabel.textColor = UIColorFromRGB(0x6f7278);
    self.priceLabel.textAlignment = NSTextAlignmentRight;
    //self.priceLabel.text = @"+188.00";
    [self.contentView addSubview:_priceLabel];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59.5, windowContentWidth, 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:lineView];
}



@end

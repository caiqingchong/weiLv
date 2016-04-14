//
//  ZFJSteShopGoodsTypeCell.m
//  WelLv
//
//  Created by WeiLv on 15/10/24.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJSteShopGoodsTypeCell.h"

@implementation ZFJSteShopGoodsTypeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self customeView];
    }
    return self;
}

- (void)customeView {
    self.iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 25 / 2.0, 25, 25)];
    //self.iconImage.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:_iconImage];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(_iconImage) + 8, 0, windowContentWidth - ViewRight(_iconImage) - 28, 50)];
    self.titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_titleLabel];
    
    UIImageView * goIcon = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth - 20,  (50 - 17) / 2 , 10, 17)];
    goIcon.backgroundColor = [UIColor whiteColor];
    goIcon.image = [UIImage imageNamed:@"矩形-32"];
    [self.contentView addSubview:goIcon];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, windowContentWidth, 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:lineView];

}

@end

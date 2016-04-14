//
//  ZFJShipTableViewCell.h
//  WelLv
//
//  Created by 张发杰 on 15/5/18.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShipListModel.h"
@class ZFJShipListModel;

typedef NS_ENUM(NSInteger, ZFJShipTableViewCellStyle) {
    ZFJShipTableViewCellStyleOne,
    ZFJShipTableViewCellStyleTwo,
    ZFJShipTableViewCellStyleThree
};


@interface ZFJShipTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *iconImageView;   //图标
@property (nonatomic, strong) UILabel * titleLbel;          //标题
@property (nonatomic, strong) UILabel * setSailCityLabel;   //出发地
@property (nonatomic, strong) UILabel * priceLabel;         //价格
@property (nonatomic, strong) UILabel * startLabel;         //起字
@property (nonatomic,strong)UILabel *gj_commissionLab;//返佣

@property (nonatomic, assign) ZFJShipTableViewCellStyle shipCellStyle;

@property (nonatomic, strong) ZFJShipListModel *shipListModel;
@property (nonatomic, strong) ShipListModel *shipListModels;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier customStry:(ZFJShipTableViewCellStyle)customStey;

@end

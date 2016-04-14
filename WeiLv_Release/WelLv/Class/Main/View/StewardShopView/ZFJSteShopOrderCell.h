//
//  ZFJSteShopOrderCell.h
//  WelLv
//
//  Created by WeiLv on 15/10/24.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZFJSteShopOrderModel, orderModel;

@interface ZFJSteShopOrderCell : UITableViewCell
@property (nonatomic, strong) UILabel * productTypeLab; //产品类型
@property (nonatomic, strong) UILabel * startTimeLab;   //出发日期
@property (nonatomic, strong) UILabel * payStatus;      //状态
@property (nonatomic, strong) UIImageView * thumbImage; //图片
@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) UILabel * partnerLab;
@property (nonatomic, strong) UILabel * commissionLab;
@property (nonatomic, strong) UILabel * priceLab;

@property (nonatomic, strong) ZFJSteShopOrderModel *modelOrder;
//自驾吃订单model
@property (nonatomic, strong) orderModel * modelDEOrder;


@end

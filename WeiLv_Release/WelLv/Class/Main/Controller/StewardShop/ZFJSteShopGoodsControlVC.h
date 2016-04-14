//
//  ZFJSteShopGoodsControlVC.h
//  WelLv
//
//  Created by WeiLv on 15/10/23.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"

typedef NS_ENUM(NSInteger, ZFJGoodsType){
    ZFJGoodsTypeOfTravel,
    ZFJGoodsTypeOfShip,
    ZFJGoodsTypeOfVisa,
    ZFJGoodsTypeOfStudyTour,
    ZFJGoodsTypeOfTicket
};
typedef NS_ENUM(NSInteger, ZFJGoodsTeam) {
    ZFJGoodsTeamOfOwn,       //分销产品
    ZFJGoodsTeamOfRetailer   //销售商产品
};
@interface ZFJSteShopGoodsControlVC : XCSuperObjectViewController
@property (nonatomic, assign) ZFJGoodsType goodsType;
@property (nonatomic, assign)  ZFJGoodsTeam goodsTeam;

@end

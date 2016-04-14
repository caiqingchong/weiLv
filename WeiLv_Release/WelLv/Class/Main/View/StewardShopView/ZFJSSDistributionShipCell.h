//
//  ZFJSSDistributionShipCell.h
//  WelLv
//
//  Created by WeiLv on 15/10/26.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZFJSteShopDistributionTravelView, ZFJSSShipRoomModel;

@interface ZFJSSDistributionShipCell : UITableViewCell
@property (nonatomic, strong) ZFJSteShopDistributionTravelView * view;
@property (nonatomic, strong) ZFJSSShipRoomModel * modelShipRoom;

@end

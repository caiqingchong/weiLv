//
//  ZFJShipShoreTravelOneCell.h
//  WelLv
//
//  Created by zhangjie on 15/10/11.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZFJShoreTraveModel;

@interface ZFJShipShoreTravelOneCell : UITableViewCell
@property (nonatomic, strong) UILabel * titleLabel;//标题
@property (nonatomic, strong) UILabel * arrivalAndSail;//进港和离港时间
@property (nonatomic, strong) UILabel * messageLabel;//介绍
@property (nonatomic, strong) UILabel * eatAndLiveLabel;//食宿

//岸上观光model
@property (nonatomic, strong) ZFJShoreTraveModel * shoreTraveModel;

@end

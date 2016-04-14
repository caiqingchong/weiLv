//
//  ZFJHotelListCell.h
//  WelLv
//
//  Created by zhangjie on 15/10/2.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelListModel.h"
typedef NS_ENUM(NSInteger, HotelListCellStyle) {
    HotelListcellNomel,
    HotelListCellAD
};


@interface ZFJHotelListCell : UITableViewCell

@property (nonatomic, strong) UIImageView * iconImageView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * messageLabel;
@property (nonatomic, strong) UILabel * priceLabel;

@property (nonatomic, strong)HotelListModel *hotelModel;

@end

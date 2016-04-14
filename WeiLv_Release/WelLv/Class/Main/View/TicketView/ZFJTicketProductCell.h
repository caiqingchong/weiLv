//
//  ZFJTicketProductCell.h
//  WelLv
//
//  Created by 张发杰 on 15/8/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TicketListModel;

@interface ZFJTicketProductCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView * iconImage;
@property (nonatomic, strong) UILabel *  titleLabel;
@property (nonatomic, strong) UILabel * priceLabel;
@property (nonatomic, strong) TicketListModel * model;

@end

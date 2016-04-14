//
//  ZFJSecondView.h
//  WelLv
//
//  Created by 张发杰 on 15/8/16.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketListModel.h"

typedef void(^TapReserveBut)(UIButton * but);
typedef void(^OnAndOffInforView)(CGFloat viewHeight);
@interface ZFJSecondView : UIView

@property (nonatomic, strong) UILabel *  titleLabel;
@property (nonatomic, strong) UILabel * commissionLabel; //返佣Label

@property (nonatomic, strong) UIImageView *  onAndOffIcon;
@property (nonatomic, strong) UILabel * priceLabel;
@property (nonatomic, strong) UIButton * reserveBut;



@property (nonatomic, strong) TicketGoodsModel * goodsModel;
@property (nonatomic, copy) TapReserveBut tapReserveBut;
@property (nonatomic, copy) OnAndOffInforView onAndOffInforView;


- (void)reserveTicket:(TapReserveBut)reserveBut;
- (void)returnInforViewHeight:(OnAndOffInforView)inforViewHeight;
@end

//
//  ZFJStewardShopHeaderView.h
//  WelLv
//
//  Created by WeiLv on 15/10/22.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFJStewardShopHeaderView : UIView
//背景图片
@property (nonatomic, strong) UIImageView * headerBgImageView;
//店铺图标
@property (nonatomic, strong) UIImageView * shopIcon;

//店铺信息按钮
@property (nonatomic, strong) UIButton * shopMsgBut;
//账户明细按钮
@property (nonatomic, strong) UIButton * detailsBut;

//店铺名称
@property (nonatomic, copy) NSString * shopTitleStr;
//分销产品数量
@property (nonatomic, copy) NSString * productCountStr;
//合伙人数量
@property (nonatomic, copy) NSString * partnerCountStr;
//账号余额
@property (nonatomic, copy) NSString * balanceNumStr;




@end

//
//  NewGuanJiaInfoController.h
//  WelLv
//
//  Created by mac for csh on 16/1/18.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//
/**
 *  管家详情信息
 */
#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"
#import "UIImage+BoxBlur.h"
#import "YXAutoEditVIew.h"
#import "YXHouseModel.h"
#import "KeepViewController.h"  //保存信息
#import "GuanJiaServiceRecoredViewController.h"
#import "ZFJSteShopOrderVC.h"   //部落信息

@interface NewGuanJiaInfoController : XCSuperObjectViewController
{
    UIScrollView *_scrollView;
    
    UIButton *btn;
    UIButton  *bindBtn;
    UIButton  *consultBtn;
    YXHouseModel *_model;
    
     NSString * is_detachable;//是否可以更换管家（0，1）
    
      UILabel *_nameLabel ; // 用户昵称
      UILabel *_addRess ;//  头视图公司信息
}

@property (nonatomic,copy)NSString *userID;          //管家Id
@property (nonatomic,copy)NSString *userIcon;       //管家头像
@property (nonatomic,copy)NSString *userName;       //管家姓名
@property (nonatomic,copy)NSString *userPhone;
@property (nonatomic,copy)NSString *mottoLabel;     //格言
@property (nonatomic,copy)NSString *schoolLabel;    //公司地址

@property (nonatomic,assign)NSInteger isBind;       //是否绑定     0未绑定

@property (nonatomic, assign) BOOL isNeedR;

@end

//
//  YXVisaPayViewController.h
//  WelLv
//
//  Created by lyx on 15/4/9.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"
#import "payRequsestHandler.h"
#import "YXWeiXinPayRequest.h"
#import "YXAutoEditVIew.h"
#import <AlipaySDK/AlipaySDK.h>

@interface YXVisaPayViewController : XCSuperObjectViewController
{
    NSString *_place;
    NSString *_price;
    NSString *_contact;
    NSString *_tel;
    
    NSMutableArray *_btnViewArray;
    NSInteger _btnIndex;
}
@property (nonatomic,copy)NSString *place;      //产品名称
@property (nonatomic,copy)NSString *price;      //产品价格
@property (nonatomic,copy)NSString *orderId;    //订单号
@property (nonatomic,copy)NSString *contact;
@property (nonatomic,copy)NSString *tel;
@property (nonatomic,copy)NSString *time;      //出行日期
@property (nonatomic,copy)NSString *renshu;    //出行人数
@property (nonatomic,copy)NSString *memberId;   //memberId;
@property (nonatomic,copy)NSString *dingdanId;    //订单编号

@property (nonatomic,copy)NSString *adultNum;  //成人数
@property (nonatomic,copy)NSString *childNum; //儿童数
@property (nonatomic,assign) BOOL isTicket;//门票
@property (nonatomic,assign) BOOL isVisa;//签证
@property (nonatomic,assign) BOOL isStudyTour;//游学
@property (nonatomic,assign) BOOL isShip;//邮轮
@property (nonatomic,copy)NSString *pay_way;//支付方式，1直接付款，2确认后付款
@property (nonatomic,copy)NSString *pay_type;//1全额   2定金
@property (nonatomic,copy)NSString *earnest;//定金总额

@property (nonatomic, strong) NSString *order_statu;//销售商//供应商//余额待确认状态


@end

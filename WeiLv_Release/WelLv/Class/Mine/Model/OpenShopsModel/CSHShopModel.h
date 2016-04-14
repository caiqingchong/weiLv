//
//  CSHShopModel.h
//  WelLv
//
//  Created by mac for csh on 15/11/20.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSHShopModel : NSObject
/*
 @"open_branch_name":bankM.open_brance_name,
 
 @property (nonatomic ,strong ) NSString *open_bank_dir;//开户地区
 @property (nonatomic ,strong ) NSString *open_brance_name;//支行名称
 */


@property (nonatomic ,copy ) NSString *province;//定位省
@property (nonatomic ,copy ) NSString *city;//定位市
@property (nonatomic ,copy ) NSString *shop_dir; //定位地址
@property (nonatomic ,copy ) NSString *longitude;//定位经度
@property (nonatomic ,copy ) NSString *latitude;//定位纬度

@property (nonatomic ,copy ) NSString *main_phone;//登录名（店主手机号）
@property (nonatomic ,copy ) NSString *open_bank_name;//银行名
@property (nonatomic ,copy ) NSString *bank_sn;//银行卡号
@property (nonatomic ,copy ) NSString *cardholder;//持卡人

@property (nonatomic ,copy ) NSString *business_licenses;//营业执照
@property (nonatomic ,copy ) NSString *hygiene_licenses;//卫生许可
@property (nonatomic ,copy ) NSString *logo;// 商铺logo


@property (nonatomic ,strong ) NSDictionary *contact;//联系电话
@property (nonatomic ,copy ) NSString *partner_shop_main_name;//店主姓名
@property (nonatomic ,copy ) NSString *partner_shop_name;//商铺名称
@property (nonatomic ,copy ) NSString *wx_sn;//微信号
@property (nonatomic ,copy ) NSString *friendly_msg;//友好提示-详细地址

@property (nonatomic ,copy ) NSString *country;//
@property (nonatomic ,copy ) NSString *create_time;
@property (nonatomic ,copy ) NSString *deduct;//
@property (nonatomic ,copy ) NSString *assistant_id;//
@property (nonatomic ,copy ) NSString *appointment;//
@property (nonatomic ,copy ) NSString *shopid;//
@property (nonatomic ,copy ) NSString *open_hours;//
@property (nonatomic ,copy ) NSString *member_id;//
@property (nonatomic ,copy ) NSString *rooms;//
@property (nonatomic ,copy ) NSString *status;//
@property (nonatomic ,copy ) NSString *remark;//




- (id)initWithDictionary:(NSDictionary *)dic;

@end

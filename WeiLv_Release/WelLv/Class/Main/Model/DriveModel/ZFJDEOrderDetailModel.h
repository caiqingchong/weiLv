//
//  ZFJDEOrderDetailModel.h
//  WelLv
//
//  Created by WeiLv on 15/11/26.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFJDEOrderDetailModel : LXBaseModel
@property (nonatomic, copy) NSString * cancel_time;
@property (nonatomic, copy) NSString * come_time;
@property (nonatomic, copy) NSString * contacts;
@property (nonatomic, copy) NSString * create_time;
@property (nonatomic, copy) NSString * deduct;
@property (nonatomic, copy) NSString * describe;
@property (nonatomic, copy) NSString * driving_features_eat_partner_id;
@property (nonatomic, copy) NSString * driving_features_eat_partner_member_id;
@property (nonatomic, copy) NSString * driving_order_id;
@property (nonatomic, copy) NSString * extra_common_param;
@property (nonatomic, copy) NSString * is_delete;
@property (nonatomic, copy) NSString * is_room;
@property (nonatomic, copy) NSString * mark;
@property (nonatomic, copy) NSString * member_id;
@property (nonatomic, copy) NSString * model_id;
@property (nonatomic, copy) NSString * nums;
@property (nonatomic, copy) NSString * order_status;
@property (nonatomic, copy) NSDictionary * partner;
@property (nonatomic, copy) NSString * pay_sn;
@property (nonatomic, copy) NSString * pay_status;
@property (nonatomic, copy) NSString * pay_time;
@property (nonatomic, copy) NSString * pay_type;
@property (nonatomic, copy) NSString * phone;
@property (nonatomic, copy) NSString * price;
@property (nonatomic, copy) NSArray * products;
@property (nonatomic, copy) NSString * receive_time;
@property (nonatomic, copy) NSString * refund_time;
@property (nonatomic, copy) NSString * sn;
@property (nonatomic, copy) NSArray * timeLog;
@property (nonatomic, copy) NSString * use_time;
@end

@interface ZFJDEOrderDetailProductModel : LXBaseModel
@property (nonatomic, copy) NSString * commission;
@property (nonatomic, copy) NSString * create_time;
@property (nonatomic, copy) NSString * describe;
@property (nonatomic, copy) NSString * driving_order_driving_order_id;
@property (nonatomic, copy) NSString * driving_shop_product_id;
@property (nonatomic, copy) NSString * features_eat_partner_id;
@property (nonatomic, copy) NSString * features_eat_partner_member_id;
@property (nonatomic, copy) NSString * product_id;
@property (nonatomic, copy) NSString * images;
@property (nonatomic, copy) NSString * last_time;
@property (nonatomic, copy) NSString * number;
@property (nonatomic, copy) NSString * nums;
@property (nonatomic, copy) NSString * original_price;
@property (nonatomic, copy) NSString * price;
@property (nonatomic, copy) NSString * sales;
@property (nonatomic, copy) NSString * status;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * univalence;
@end
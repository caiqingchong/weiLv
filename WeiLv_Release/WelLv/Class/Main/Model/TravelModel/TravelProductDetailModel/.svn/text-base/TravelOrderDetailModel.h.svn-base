//
//  TravelOrderDetailModel.h
//  WelLv
//
//  Created by 张子乾 on 16/1/24.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelOrderDetailModel : NSObject

//产品详情页获取
@property (nonatomic, copy) NSString *product_id;
@property (nonatomic, copy) NSString *product_name;

//订单所需补充字段
//dataMain
//从会员登录处获取

@property (nonatomic, copy) NSString *contacts;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *is_comment;
@property (nonatomic, copy) NSString *is_ticket;
@property (nonatomic, copy) NSString *member_id;
@property (nonatomic, copy) NSString *group;
@property (nonatomic, copy) NSString *order_source;
@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *product_category;
@property (nonatomic, copy) NSString *order_status;

//产品详情页获取
@property (nonatomic, copy) NSString *admin_type;

//dataTravel
@property (nonatomic, copy) NSString *is_oldman;//老人
@property (nonatomic, copy) NSString *is_adult;//成人
@property (nonatomic, copy) NSString *is_foreign;//外国人
@property (nonatomic, copy) NSString *insurance;//保险
@property (nonatomic, assign) NSInteger adule;//成人个数
@property (nonatomic, assign) NSInteger child;//儿童个数
@property (nonatomic, copy) NSString *adult_price;//成人价格
@property (nonatomic, copy) NSString *child_price;//儿童价格
@property (nonatomic, copy) NSString *f_city;//城市
@property (nonatomic, copy) NSString *f_time;//时间
@property (nonatomic, copy) NSString *order_id;//订单id
//用户信息拼接字典
@property (nonatomic, copy) NSDictionary *person_info;
@property (nonatomic, strong) NSString *cat_id;

@property (nonatomic, strong) NSString *route_type;

//儿童说明字段
@property (nonatomic, strong) NSString *child_standard;

//目的地参团成人价
@property (nonatomic, copy) NSString *sell_price;
//目的地参团儿童价
@property (nonatomic, copy) NSString *child_sell_price;
//目的地参团标志1
@property (nonatomic, copy) NSString *belongs;
//目的地参团标志2
@property (nonatomic, copy) NSString *supply_type;


- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end

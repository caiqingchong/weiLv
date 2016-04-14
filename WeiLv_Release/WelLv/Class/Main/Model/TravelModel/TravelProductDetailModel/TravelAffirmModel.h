//
//  TravelAffirmModel.h
//  WelLv
//
//  Created by 张子乾 on 16/1/29.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelAffirmModel : NSObject

//订单编号
@property (nonatomic, copy) NSString *order_id;
//出发城市
@property (nonatomic, copy) NSString *f_city_name;
//出发日期(时间戳)
@property (nonatomic, copy) NSString *f_time;
//出游人数成人
@property (nonatomic, copy) NSString *adule;
//出游人数儿童
@property (nonatomic, copy) NSString *child;
//订单总额(需要转换成Float)
@property (nonatomic, copy) NSString *order_price;
//产品名称
@property (nonatomic, copy) NSString *product_name;
//产品sn
@property (nonatomic, copy) NSString *order_sn;
//产品分类
@property (nonatomic, strong) NSString *route_type;


//联系人姓名
@property (nonatomic, copy) NSString *orderContactPersonName;
//联系人电话
@property (nonatomic, copy) NSString *orderContactPhone;

@end

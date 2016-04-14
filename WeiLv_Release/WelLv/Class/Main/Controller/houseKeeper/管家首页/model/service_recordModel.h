//
//  service_recordModel.h
//  WelLv
//
//  Created by daihengbin on 16/1/15.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface service_recordModel : NSObject
@property(nonatomic,copy)NSString *category_name;//产品种类
@property(nonatomic,assign)NSString *setoff_time;//出发时间
@property(nonatomic,copy)NSString *back_home;//返回时间
@property(nonatomic,copy)NSString *product_name;//产品名称
@property(nonatomic,copy)NSString *order_price;//订单价格
@property(nonatomic,copy)NSString *phone;//电话
@property(nonatomic,copy)NSString *img;//头像
@property(nonatomic,copy)NSString *username;//下单会员
@property(nonatomic,copy)NSString *pay_status;//支付状态
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end

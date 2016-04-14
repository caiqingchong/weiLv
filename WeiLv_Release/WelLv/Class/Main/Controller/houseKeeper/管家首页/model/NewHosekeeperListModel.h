//
//  NewHosekeeperListModel.h
//  WelLv
//
//  Created by daihengbin on 16/1/13.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewHosekeeperListModel : NSObject
@property (nonatomic,copy)NSString *seller_id;
@property (nonatomic,copy)NSString *name;//管家名字
@property (nonatomic,copy)NSString *region;//管家所属城市
@property (nonatomic,copy)NSString *level_vir;//星级
@property (nonatomic,copy)NSString *product_count;//分销产品数
@property (nonatomic,copy)NSString *gender;//性别
@property (nonatomic,copy)NSString *avatar;//头像
@property (nonatomic,copy)NSString *order_count;//服务记录
@property (nonatomic,copy)NSString *assistant_id;
@property (nonatomic,copy)NSString *mobile;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
//"seller_id": "2012",
//"assistant_id": "29903",
//"group_id": "2",
//"name": "贺成英",
//"nickname": null,
//"mobile": "15574317531",
//"gender": null,
//"birth_date": null,
//"horoscope": null,
//"index_bg": "home/frontimg/images/24.jpg",
//"telephone": null,
//"level_vir": "5.0",
//"advantage": null,
//"occupation": null,
//"motto": null,
//"amount": "0.00",
//"order_count_vir": "200",
//"avatar": "home/frontimg/images/8.jpg",
//"region_id": "1653",
//"address": null,
//"qq": null,
//"wechat": null,
//"email": null,
//"position": null,
//"education_background": null,
//"school": null,
//"native_place": null,
//"signature": null,
//"company": null,
//"bank_name": null,
//"bank_account": null,
//"closed": "0",
//"froze": "0",
//"trash": "0",
//"create_time": "1435926051",
//"id": "29903",
//"region": "亚洲 - 中国 - 湖南 - 浏阳",
//"level": "5.0",
//"order_count": "200",
//"sellers": [],
//"product_count": 0
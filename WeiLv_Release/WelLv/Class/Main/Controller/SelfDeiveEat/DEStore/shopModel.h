//
//  shopModel.h
//  WelLv
//
//  Created by liuxin on 15/11/17.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface shopModel : NSObject
{
    
}
@property(nonatomic,strong)NSString *wltoken;
//@property(nonatomic,strong)NSString *uid;
@property(nonatomic,strong)NSString *uid;
@property(nonatomic,strong)NSString *member_id;
@property(nonatomic,strong)NSString *partner_shop_name;
@property(nonatomic,strong)NSString *hygiene_licenses;
@property(nonatomic,strong)NSString *business_licenses;
@property(nonatomic,strong)NSString *partner_shop_main_name;
@property(nonatomic,strong)NSString *longitude;
@property(nonatomic,strong)NSString *latitude;
@property(nonatomic,strong)NSString *shop_dir;
@property(nonatomic,strong)NSString *main_phone;
@property(nonatomic,strong)NSString *wx_sn;
@property(nonatomic,strong)NSString *friendly_msg;
@property(nonatomic,strong)NSString *logo;
@property(nonatomic,strong)NSString *open_hours;
@property(nonatomic,strong)NSString *deduct;
@property(nonatomic,strong)NSString *rooms;
@property(nonatomic,strong)NSString *appointment;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSString *country;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *contact_phone;
@property(nonatomic,strong)NSString *province;
-(void)fill;
//@property(nonatomic,strong)NSString *country;
@end

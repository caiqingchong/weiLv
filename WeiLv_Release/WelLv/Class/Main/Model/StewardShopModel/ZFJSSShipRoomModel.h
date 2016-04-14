//
//  ZFJSSShipRoomModel.h
//  WelLv
//
//  Created by WeiLv on 15/10/26.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFJSSShipRoomModel : NSObject

@property (nonatomic, copy)NSString *butler_s;
@property (nonatomic, copy)NSString *cabin_id;
@property (nonatomic, copy)NSString *cabin_name;
@property (nonatomic, copy)NSString *reward;
@property (nonatomic, copy)NSString *room_34_price2;
@property (nonatomic, copy)NSString *room_id;
@property (nonatomic, copy)NSString *room_price2;
@property(nonatomic,copy)NSString *partner_reward;
- (id)initWithDictionary:(NSDictionary *)dic;

@end

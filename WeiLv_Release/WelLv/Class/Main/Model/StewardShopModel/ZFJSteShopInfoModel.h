//
//  ZFJSteShopInfoModel.h
//  WelLv
//
//  Created by WeiLv on 15/11/1.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFJSteShopInfoModel : NSObject
@property (nonatomic, copy) NSString * create_time;
@property (nonatomic, copy) NSString * shop_ID;
@property (nonatomic, copy) NSString * is_assistant;
@property (nonatomic, copy) NSString * is_delete;
@property (nonatomic, copy) NSString * store_avatar;
@property (nonatomic, copy) NSString * store_background;
@property (nonatomic, copy) NSString * store_description;
@property (nonatomic, copy) NSString * store_name;
@property (nonatomic, copy) NSString * user_id;

- (id)initWithDictionary:(NSDictionary *)dic;

@end

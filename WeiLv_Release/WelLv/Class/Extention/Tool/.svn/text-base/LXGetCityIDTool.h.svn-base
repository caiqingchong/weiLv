//
//  LXGetCityIDTool.h
//  WelLv
//
//  Created by 刘鑫 on 15/4/26.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GetedCityID)(NSString *city_id);
typedef void (^AddLocationCityIdAndName)(NSString * city_id, NSString * city_name);
@interface LXGetCityIDTool : NSObject

@property (nonatomic,strong)NSString *city_regionID;
@property (nonatomic,strong)NSString *guanjiaCityid;
@property (nonatomic, copy)GetedCityID city_block;
@property (nonatomic, copy) AddLocationCityIdAndName  city_id_name;

+ (LXGetCityIDTool*)sharedMyTools;

//城市id
-(void)getCity_id:(NSString *)cityName;

//出发地城市
-(void)getF_cityID;

//目的地城市
-(void)getT_cityID:(NSString *)t_cityName region_type:(NSString *)region_type;

- (void)returnCityIdWith:(GetedCityID)cityId;

- (void)return_city_id_name:(AddLocationCityIdAndName)city;


@end

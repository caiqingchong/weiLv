//
//  LXGuanJiaModel.h
//  WelLv
//
//  Created by 刘鑫 on 15/4/13.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXGuanJiaModel : NSObject


@property (nonatomic,copy)NSString *leftImageUrl;
@property (nonatomic,copy)NSString *nameStr;//管家名字
@property (nonatomic,copy)NSString *gjCityStr;//管家所属城市
@property (nonatomic,assign)int  NuberStr;//案例数
@property (nonatomic,copy)NSString *gradeStr;//评分
@property (nonatomic,copy)NSString *infoStr;
@property (nonatomic,copy)NSString *sex;
@property (nonatomic,copy)NSString *xingzuo;
@property (nonatomic,copy)NSString *age;
@property (nonatomic,copy)NSString *keeperID;
@property (nonatomic,copy)NSString *phone;
@property (nonatomic,copy)NSString * assistant_id;

@end

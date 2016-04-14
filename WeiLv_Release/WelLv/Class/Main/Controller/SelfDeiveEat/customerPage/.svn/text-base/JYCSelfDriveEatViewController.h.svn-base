//
//  JYCSelfDriveEatViewController.h
//  WelLv
//
//  Created by lyx on 15/10/28.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
typedef void(^poppBlock)(NSString *str,NSMutableArray *arr,NSString *type);

@interface JYCSelfDriveEatViewController : XCSuperObjectViewController<BMKLocationServiceDelegate>
{
    BMKLocationService* _locService;
   
}
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *searchStr;
@property(nonatomic,strong)BMKLocationService*locService;
@property(nonatomic,assign)double lati;
@property(nonatomic,assign)double logti;
@property(nonatomic,copy)NSString *city_name;
@property(nonatomic,copy)NSString *city2;
@property(nonatomic,copy)poppBlock Popblock;
@end

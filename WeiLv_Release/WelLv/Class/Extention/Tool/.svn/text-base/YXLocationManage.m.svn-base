//
//  YXLocationManage.m
//  WelLv
//
//  Created by lyx on 15/4/9.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "YXLocationManage.h"

@implementation YXLocationManage
+ (YXLocationManage *)shareManager
{
    static YXLocationManage *yxManager;
    if (yxManager == nil) {
        yxManager = [[YXLocationManage alloc]init];
    }
    return yxManager;
}

//- (id)init
//{
//    if (self = [super init]) {
//        self.locationManager = [[CLLocationManager alloc]init];
//        self.locationManager.delegate = self;
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//        self.locationManager.distanceFilter = 10;//设置距离过滤器
//        [self.locationManager requestAlwaysAuthorization];//始终允许访问位置信息
//        [self.locationManager requestWhenInUseAuthorization];
//        [self.locationManager startUpdatingLocation];//开始更新位置信息
//    }
//    return self;
//}


@end

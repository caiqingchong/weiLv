//
//  YXLocationManage.h
//  WelLv
//
//  Created by lyx on 15/4/9.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface YXLocationManage : NSObject <CLLocationManagerDelegate>

@property (nonatomic,copy)NSString *city;
@property (nonatomic, copy) NSString *province;
@property(nonatomic,assign)CLLocationCoordinate2D coordinate;
+ (YXLocationManage *)shareManager;
@end

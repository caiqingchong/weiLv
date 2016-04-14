//
//  ZFJChooseCityVC.h
//  WelLv
//
//  Created by 张发杰 on 15/6/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChooseCityBlock)(NSString * cityAddress);
typedef void(^SelectCityInfo)(NSString * cityName, NSString * cityId);

@interface ZFJChooseCityVC : UIViewController
@property (nonatomic, assign) BOOL dontNeedreServe;


@property (nonatomic,assign) BOOL isDestinationSelect;
- (id)initWithAddress:(ChooseCityBlock)cityAddress;
- (void)selectCity:(SelectCityInfo)city;

@end

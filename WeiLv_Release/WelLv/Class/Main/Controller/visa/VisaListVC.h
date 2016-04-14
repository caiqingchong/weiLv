//
//  VisaListVC.h
//  WelLv
//
//  Created by 张发杰 on 15/4/7.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"
@interface VisaListVC : XCSuperObjectViewController
@property (nonatomic, copy)NSString * liveAddress;
@property (nonatomic, strong) NSIndexPath * chooesIndexPath;

@property (nonatomic, copy) NSString * region_id;//地区ID；

@property (nonatomic, copy) NSString * country_id;//国家ID；

@property (nonatomic, copy) NSString * searchStr;

@property (nonatomic, assign)BOOL isNeedR;//
@end

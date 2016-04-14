//
//  HotCountryOrCityVC.h
//  WelLv
//
//  Created by 张发杰 on 15/8/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"

@interface HotCountryOrCityVC : XCSuperObjectViewController

@property (nonatomic, copy) NSString * titleStr;

@property (nonatomic, copy) NSString * listURLStr;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, strong) NSMutableArray * titleArray;

@end

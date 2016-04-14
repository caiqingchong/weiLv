//
//  ZFJTicketListVC.h
//  WelLv
//
//  Created by 张发杰 on 15/8/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"

@interface ZFJTicketListVC : XCSuperObjectViewController

@property (nonatomic, copy) NSString *  keyStr;
@property (nonatomic, copy) NSString *  valueStr;

@property (nonatomic, copy) NSString *  searchStr;

@property (nonatomic, assign) BOOL isCity;

@property (nonatomic, copy) NSString * provinceStr;


@end

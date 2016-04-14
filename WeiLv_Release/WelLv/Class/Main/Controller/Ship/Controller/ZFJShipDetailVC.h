//
//  ZFJShipDetailVC.h
//  WelLv
//
//  Created by 张发杰 on 15/5/19.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"
#import "YXTraveDetailModel.h"
#import <ShareSDK/ShareSDK.h>
@interface ZFJShipDetailVC : XCSuperObjectViewController
@property (nonatomic, copy) NSString *product_id;
//新添加的判断支付方式
@property (nonatomic, assign) WLOrderSource orderSource;
@property (nonatomic, copy) NSString * store_id;  //管家店铺ID

@end

//
//  ZFJDEStoreOrderDetailsVC.h
//  WelLv
//
//  Created by WeiLv on 15/11/10.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"

typedef void(^BackLastView)(NSString * msgStr);

@interface ZFJDEStoreOrderDetailsVC : XCSuperObjectViewController

@property (nonatomic, copy) NSString * orderIDStr;      //订单ID
@property (nonatomic, strong) NSString * order_status;  //订单状态
@property (nonatomic, copy) BackLastView backLastView;

@end

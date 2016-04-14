//
//  FillOrderViewController.h
//  FillOrder
//
//  Created by WeiLv on 16/1/13.
//  Copyright © 2016年 WeiLv. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TravelOrderDetailModel;
@interface FillOrderViewController : UIViewController

//订单模型
@property (nonatomic, strong)TravelOrderDetailModel *orderModel;
//余位
@property (nonatomic, assign)NSInteger surplusCount;

@property (nonatomic, copy)NSString * name;

@property (nonatomic,copy) NSString *adultPrice;

@property (nonatomic,copy) NSString *chidlPrice;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property(nonatomic,strong)NSString *shop_id;

@end

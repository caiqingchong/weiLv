//
//  DDViewController.h
//  WelLv
//
//  Created by liuxin on 15/11/6.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
typedef NS_ENUM(NSInteger, WLDEStoreOrderType) {
    WLDEStoreOrderTypeTabBarOder,
    WLDEStoreOrderTypeMyOrder
};
@interface DDViewController : XCSuperObjectViewController

@property (nonatomic, assign) WLDEStoreOrderType deOrderType;

@end

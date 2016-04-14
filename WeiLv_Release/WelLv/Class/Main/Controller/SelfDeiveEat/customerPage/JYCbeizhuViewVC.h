//
//  JYCbeizhuViewVC.h
//  WelLv
//
//  Created by lyx on 15/11/19.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
typedef void(^block)(NSString *str);
@interface JYCbeizhuViewVC : XCSuperObjectViewController
@property(nonatomic,strong)block chuBlock;
@end

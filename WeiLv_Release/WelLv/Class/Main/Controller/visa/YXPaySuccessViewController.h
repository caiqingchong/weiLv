//
//  YXPaySuccessViewController.h
//  WelLv
//
//  Created by lyx on 15/6/29.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"
#import "YXAutoEditVIew.h"

@interface YXPaySuccessViewController : XCSuperObjectViewController

@property (nonatomic,strong)NSString *productName;
@property (nonatomic,strong)NSString *beginDate;
@property (nonatomic,strong)NSString *number;
@property (nonatomic,strong)NSString *contactPerson;
@property (nonatomic,strong)NSString *phone;
@end

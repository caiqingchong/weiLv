//
//  ChangePasswordViewController.m
//  WelLv
//
//  Created by lyx on 15/4/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//


#import <UIKit/UIKit.h>
typedef void(^ViewHeight)(CGFloat height);
typedef void(^ChooseShoreTravelIndexPath)(NSIndexPath * shoreTravelIndexPath);

@interface ZFJShipItineraryView : UIView
@property (nonatomic, copy) ViewHeight height;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, copy) ChooseShoreTravelIndexPath  shoreTravelIndexPath;

- (instancetype)initWithFrame:(CGRect)frame withDataDic:(NSDictionary *)dataDic;
- (void)chooseShoreTravelIndex:(ChooseShoreTravelIndexPath)index;

@end

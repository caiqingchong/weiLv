//
//  JYCDishDetailVC.h
//  WelLv
//
//  Created by lyx on 15/11/17.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
#import "RestauantModel.h"
#import "JYCorderDishesCell.h"

@interface JYCDishDetailVC : XCSuperObjectViewController
@property(nonatomic,strong)RestauantModel *model;
@property(nonatomic,strong)JYCorderDishesCell *cell;
@property(nonatomic,strong)NSMutableArray *arr;
@end

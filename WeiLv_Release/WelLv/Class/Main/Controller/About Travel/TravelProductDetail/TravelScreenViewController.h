//
//  TravelScreenViewController.h
//  WelLv
//
//  Created by 张子乾 on 16/2/22.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
/**
 *关于首页跳转页面
 */

#import "XCSuperObjectViewController.h"

@interface TravelScreenViewController : XCSuperObjectViewController

//排序关键字
@property(nonatomic,copy)NSString * sortstr;
//城市ID
@property(nonatomic,copy)NSString * city_id;
@property(nonatomic,copy)NSString * Cityid;

//中类
@property(nonatomic,assign)NSInteger  rote_ID;

@property(nonatomic,assign)NSString * cityTitle;//标题
@property(nonatomic,copy)NSMutableDictionary * dic;//存放参数
@property(nonatomic,assign)NSInteger   category_id;//海岛假期
@property(nonatomic,copy)NSString * titles;//海岛假期

@property (nonatomic, copy)NSString *lastViewControllerTag; //上个控制器的tag值
@property (nonatomic, copy)NSString *productListTitle; //对应精品标题的列表
@property (nonatomic, copy)NSString *search_type;  //搜索类型

@property (nonatomic, copy)NSString *aroundGotoDestTitle;//周边景点跳转
@property (nonatomic, copy)NSString *route_type;



@end

//
//  ZFJHotelListVCViewController.h
//  WelLv
//
//  Created by zhangjie on 15/10/2.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"

@interface ZFJHotelListVC : XCSuperObjectViewController
 //城市名称
@property (nonatomic, strong) NSString * cityname;

//入住时间
@property (nonatomic, strong) NSString * arrivalDate;

//离开时间
@property (nonatomic, strong) NSString * departureDate;

//关键字
@property (nonatomic, strong) NSString * queryText;

//最低价格
@property (nonatomic, strong) NSString * lowRate;

//最高价格
@property (nonatomic, strong) NSString * highRate;

//星级
@property (nonatomic, strong) NSString * starRate;

/*筛选
 Defaul默认排序
 StarRankDesc推荐星级降序
 RateAsc价格升序
 RateDesc价格降序
 DistanceAsc距离升序
 */
@property (nonatomic, strong) NSString * sort;

//位置
@property (nonatomic, strong) NSString * queryType;

//品牌
@property (nonatomic, strong) NSString * brandId;


@end

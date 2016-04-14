//
//  TraveCalendarViewController.h
//  WelLv
//
//  Created by 刘鑫 on 15/4/24.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarLogic.h"
#import "YXTraveDetailModel.h"
#import "XCSuperObjectViewController.h"



//回掉代码块
typedef void (^CalendarBlock)(CalendarDayModel *model);
@interface TraveCalendarViewController : XCSuperObjectViewController
@property(nonatomic ,strong) UICollectionView* collectionView;//网格视图

@property(nonatomic ,strong) NSMutableArray *calendarMonth;//每个月份的中的daymodel容器数组
@property(nonatomic ,strong) NSMutableArray *assignArray;//指定的日期

@property(nonatomic ,strong) CalendarLogic *Logic;

@property (nonatomic, copy) CalendarBlock calendarblock;//回调
@property (nonatomic,copy)NSString *visaRegion;//签证领区

@property (nonatomic, strong) YXTraveDetailModel * traveModel;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *childprice;

@property (nonatomic,copy)NSString *realBeginDate;

//新添加的判断支付方式
@property (nonatomic, assign) WLOrderSource orderSource;
@property (nonatomic, copy) NSString * store_id;  //管家店铺ID
@property (nonatomic,copy)NSString *pay_way;//支付方式状态（立即支付、等待确认）
//- (void)setTrainToDay:(int)day ToDateforString:(NSString *)todate price:(int)aPrice;//火车初始化方法
@end

//
//  LXChooseDateViewController.h
//  WelLv
//
//  Created by 刘鑫 on 15/4/10.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarLogic.h"
#import "ZFJVisaModel.h"
#import "XCSuperObjectViewController.h"

//回掉代码块
typedef void (^CalendarBlock)(CalendarDayModel *model);

@interface LXChooseDateViewController : XCSuperObjectViewController

@property(nonatomic ,strong) UICollectionView* collectionView;//网格视图

@property(nonatomic ,strong) NSMutableArray *calendarMonth;//每个月份的中的daymodel容器数组
@property(nonatomic ,strong) NSMutableArray *assignArray;//指定的日期
@property(nonatomic,strong)NSString *shop_id;
@property(nonatomic,assign)WLOrderSource orderSouce;
@property(nonatomic ,strong) CalendarLogic *Logic;

@property (nonatomic, copy) CalendarBlock calendarblock;//回调
@property (nonatomic,copy)NSString *visaRegion;//签证领区

@property (nonatomic, strong) ZFJVisaModel * visaModel;


- (void)setTrainToDay:(int)day ToDateforString:(NSString *)todate price:(int)aPrice;//火车初始化方法

@end

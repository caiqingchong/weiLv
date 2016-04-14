//
//  GroupHomeViewController.m
//  WelLv
//
//  Created by James on 15/12/21.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "GroupHomeViewController.h"
#import "Color.h"

@interface GroupHomeViewController()
{
    int daynumber;//天数
    int optiondaynumber;//选择日期数量
    //    NSMutableArray *optiondayarray;//存放选择好的日期对象数组
}

@end

@implementation GroupHomeViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - 设置方法

//旅游度假初始化方法
- (void)setTravelToDay:(int)day ToDateforString:(NSString *)todate
{
    daynumber = day;
    optiondaynumber = 1;//选择一个后返回数据对象
    super.calendarMonth = [self getMonthArrayOfDayNumber:daynumber ToDateforString:todate];
    [super.collectionView reloadData];//刷新
}

#pragma mark - 逻辑代码初始化

//获取时间段内的天数数组
- (NSMutableArray *)getMonthArrayOfDayNumber:(int)day ToDateforString:(NSString *)todate
{
    
    NSDate *date = [NSDate date];
    
    NSDate *selectdate  = [NSDate date];
    
    if (todate) {
        
        selectdate = [selectdate dateFromString:todate];
        
    }
    
    super.Logic = [[CalendarLogic alloc]init];
    
    
    return [super.Logic reloadCalendarView:date selectDate:selectdate  needDays:day];
}



#pragma mark - 设置标题

- (void)setCalendartitle:(NSString *)calendartitle
{
    
    [self.navigationItem setTitle:calendartitle];
    
}


@end

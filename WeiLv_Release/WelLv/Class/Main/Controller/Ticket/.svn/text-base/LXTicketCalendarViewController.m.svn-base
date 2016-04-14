//
//  LXTicketCalendarViewController.m
//  WelLv
//
//  Created by 刘鑫 on 15/8/19.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
#define WEILVColor [UIColor colorWithRed:251/255.f green:131/255.f blue:10/255.f alpha:1.0]
#define BottomHeight 120
#define NAVBarH 60
#define CalendarViewHeight 6*60+65
#import "LXTicketCalendarViewController.h"
//UI
#import "CalendarMonthCollectionViewLayout.h"
#import "ShipCalendarMonthCollectionViewLayout.h"
#import "CalendarMonthHeaderView.h"
#import "LXTicketCalendarCell.h"
//#import "CalendarDayCell.h"
//#import "ShipCalendarDayCell.h"
//MODEL
#import "CalendarDayModel.h"

#import "YXOrderViewController.h"
//#import "LXShipCalendarModel.h"
//#import "LXShipProductModel.h"

#import "LXGetCityIDTool.h"
#import "LXTicketCalendarModel.h"

@interface LXTicketCalendarViewController ()
{
    NSMutableArray *_ticketModelArray;
    NSMutableArray *_ticketDateArray;
}

@property (nonatomic, strong) MBProgressHUD * hud;
@end

@implementation LXTicketCalendarViewController

static NSString *MonthHeader = @"MonthHeaderView";

static NSString *DayCell = @"DayCell";

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor=[UIColor whiteColor];
    
    self.title=@"门票日历";
    
    [self initData];
}

- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}

-(void)initData
{
    
    _ticketModelArray=[[NSMutableArray alloc] initWithCapacity:0];
    _ticketDateArray=[[NSMutableArray alloc] initWithCapacity:0];
    self.calendarMonth = [[NSMutableArray alloc]init];//每个月份的数组
    
    self.assignArray=[[NSMutableArray alloc] initWithCapacity:0];
    self.shipProductArray=[[NSMutableArray alloc] initWithCapacity:0];
    _getModel=[self getTodayModel];
    
    _currentMonth=[[[[_getModel toString] componentsSeparatedByString:@"-"] objectAtIndex:1] intValue];
    _currentYear=[[[[_getModel toString] componentsSeparatedByString:@"-"] objectAtIndex:0] intValue];
    _showYear=_currentYear;
    _showMonth=_currentMonth;
    DLog(@"今天--------%@",[_getModel toString]);
    NSString *endtime=[self getEndTime];
    NSDictionary *dic=@{@"goodid":self.goodId,@"starttime":[_getModel toString],@"endtime":endtime};
    [self sendRequest:dic aurl:M_TICKET_CALENDAR_URL aTag:1];
}

-(NSString *)getEndTime
{
    NSTimeInterval  oneDay = 24*60*60*90;  //90天的长度
    NSDate *endDate=[[NSDate date] initWithTimeIntervalSinceNow:oneDay];
    DLog(@"结束日期--%@",[self getDateWithDate:endDate]);
    return [self getDateWithDate:endDate];
}

#pragma mark 请求方法
-(void)sendRequest:(NSDictionary *)parameters aurl:(NSString *)url aTag:(int)tag
{
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    [self setProgressHud];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject)
    {
              [_hud hide:YES];

              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              
              DLog(@"日历--%@",dic);
              if ([[dic objectForKey:@"data"] isKindOfClass:[NSArray class]])
              {
                  NSMutableArray *arr=[[NSMutableArray alloc] initWithCapacity:0];
                  arr=[dic objectForKey:@"data"];
                  NSMutableArray *array=[[NSMutableArray alloc] initWithCapacity:0];

                  for (NSDictionary *dic1 in [dic objectForKey:@"data"])
                  {
                      LXTicketCalendarModel * model=[[LXTicketCalendarModel alloc] initWithDictionary:dic1];
                      [array addObject:model];
                  }
                  
                  [self getShipCalendarArray:array];
              }
              else
              {
                  [self setTrainToDay:100 ToDateforString:nil price:-2 beginDate:[_getModel toString]];
              }

            [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error)
          {
              
              DLog(@"Error: %@", error);
              [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
              
          }];
    
}

//数据加载完成之前显示转动的菊花圈
- (void)setProgressHud
{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"正在加载...";
    [self.view addSubview:_hud];
    [_hud show:YES];
}


#pragma mark -- 获取日历model
-(NSInteger)getShipCalendarArray:(NSMutableArray *)array
{
    self.shipCalendarModelArray=[[NSMutableArray alloc] initWithCapacity:0];
    self.shipCalendarArray=[[NSMutableArray alloc] initWithCapacity:0];
    self.shipCalendarModelArray=array;
    for (LXTicketCalendarModel *model in self.shipCalendarModelArray)
    {
        [self.shipCalendarArray addObject:[self judgeString:model.date]?model.date:@""];
        
    }

    [self setTrainToDay:90 ToDateforString:nil price:-2 beginDate:[_getModel toString]];
    return cellNumber;
}

- (void)setTrainToDay:(int)day ToDateforString:(NSString *)todate price:(int)aPrice beginDate:(NSString *)beginDate
{
    daynumber = day;
    optiondaynumber = 1;//选择两个后返回数据对象
    self.calendarMonth = [self getMonthArrayOfDayNumber:daynumber ToDateforString:todate beginDate:beginDate];
    
    NSMutableArray *monthArray = [self.calendarMonth objectAtIndex:0];
    cellNumber=monthArray.count;
    _showMonth=[[[beginDate componentsSeparatedByString:@"-"] objectAtIndex:1] intValue];
    _price=aPrice;
    [self initView];
    
    
    //DLog(@"qqq===%lu个月",self.calendarMonth.count);
    [self.collectionView reloadData];//刷新
}

#pragma mark - 逻辑代码初始化

//获取时间段内的天数数组
- (NSMutableArray *)getMonthArrayOfDayNumber:(int)day ToDateforString:(NSString *)todate beginDate:(NSString *)beginDate
{
    
    NSDate *date = [self getDateWithStr:beginDate];
    
    NSDate *selectdate  = [NSDate date];
    
    if (todate) {
        
        selectdate = [selectdate dateFromString:todate];
        
    }
    
    self.Logic = [[LXTacketCalendarLogic alloc]init];
    
    return [self.Logic reloadCalendarView:date selectDate:selectdate  needDays:day customDateArray:nil];
}


- (void)initView
{
    
    collectheight=windowContentHeight;
    
    if (!self.collectionView)
    {
        ShipCalendarMonthCollectionViewLayout *layout = [ShipCalendarMonthCollectionViewLayout new];
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, collectheight)collectionViewLayout:layout]; //初始化网格视图大小
        
        [self.collectionView registerClass:[LXTicketCalendarCell class] forCellWithReuseIdentifier:DayCell];//cell重用设置ID
        
        [self.collectionView registerClass:[CalendarMonthHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader];
        
        self.collectionView.bounces = NO;//将网格视图的下拉效果关闭
        
        self.collectionView.delegate = self;//实现网格视图的delegate
        
        self.collectionView.dataSource = self;//实现网格视图的dataSource
        
        self.collectionView.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:self.collectionView];
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0, 5, 130, 40);
        [btn setImage:[UIImage imageNamed:@"左不可选中"] forState:UIControlStateNormal];
        btn.tag=1;
        btn.adjustsImageWhenHighlighted = NO;//取消button的点击动画

        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame=CGRectMake(windowContentWidth-130, 5, 130, 40);
        [btn1 setImage:[UIImage imageNamed:@"右"] forState:UIControlStateNormal];
        btn1.tag=2;
        btn1.adjustsImageWhenHighlighted = NO;

        [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn1];
        
    }
    
    self.collectionView.frame=CGRectMake(0, 0, windowContentWidth, collectheight);
    if (_isShow==YES)
    {
        allCollectHeight=collectheight+self.shipProductArray.count*50+20;

        DLog(@"日历高度==%f",collectheight);

        _productView.frame=CGRectMake(0, collectheight, windowContentWidth, 50*self.shipProductArray.count+20);
    }
    else
    {
        DLog(@"111日历高度==%f",collectheight);
        allCollectHeight=collectheight;
        
    }

}


-(void)btnClick:(UIButton *)btn
{
    
    switch (btn.tag)
    {
        case 1:
        {
            if (_showMonth - 1 == _currentMonth) {
                [btn setImage:[UIImage imageNamed:@"左不可选中"] forState:UIControlStateNormal];
                btn.transform = CGAffineTransformMakeRotation(0);
                
            }

            
            if ((_showMonth>_currentMonth && _showYear==_currentYear) ||(_showYear>_currentYear))
            {
                _showMonth--;
                if (_showMonth<1)
                {
                    _showMonth=12;
                    _showYear--;
                }
                [self setTrainToDay:100 ToDateforString:nil price:-2 beginDate:[NSString stringWithFormat:@"%d-%d-1",_showYear,_showMonth]];
                
            }

        }
            break;
            
        case 2:
        {
            
            UIButton * btn1 = [self.view viewWithTag:1];
            [btn1 setImage:[UIImage imageNamed:@"右"] forState:UIControlStateNormal];
            btn1.transform = CGAffineTransformMakeRotation(M_PI);

 
            _showMonth++;
            if (_showMonth>12)
            {
                _showMonth=1;
                _showYear++;
            }
            
            [self setTrainToDay:100 ToDateforString:nil price:-2 beginDate:[NSString stringWithFormat:@"%d-%d-1",_showYear,_showMonth]];

        }
            break;
            
        default:
            break;
    }
}


#pragma mark --UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}


#pragma mark 字符串转NSDate
-(NSDate *)getDateWithStr:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}

#pragma mark --- NSDate转字符串
-(NSString *)getDateWithDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

#pragma mark ---时间戳转换成时间字符串
-(NSString *)getDateStr:(NSString *)date
{
    NSString *str=date;//时间戳
    NSTimeInterval time=[str doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    DLog(@"date:%@",detaildate);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    DLog(@"开始时间===%@",currentDateStr);
    return currentDateStr;
}

#pragma mark -- NSDate转换成时间戳
-(NSString *)getDateShiJianChuo:(NSDate *)date
{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeSp;
    DLog(@"时间戳=%@",timeSp);
}


#pragma mark - CollectionView代理方法

//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSMutableArray *monthArray = [self.calendarMonth objectAtIndex:section];
    DLog(@"monthArray=%lu,=%ld",monthArray.count,(long)section);

    return monthArray.count;
}


//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LXTicketCalendarCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DayCell forIndexPath:indexPath];
    
    NSMutableArray *monthArray = [self.calendarMonth objectAtIndex:indexPath.section];

    CalendarDayModel *model = [monthArray objectAtIndex:indexPath.row];
    
    if ([self.shipCalendarArray containsObject:[model toString]])
    {
        NSUInteger index1=[self.shipCalendarArray indexOfObject:[model toString]];
        DLog(@"------------%lu--%@",(unsigned long)index1,[model toString]);
        LXTicketCalendarModel *model1=[self.shipCalendarModelArray objectAtIndex:index1];
        cell.userInteractionEnabled=YES;
        model.price=[NSString stringWithFormat:@"￥%@",model1.sellPrice];
       // cell.model=model;
        
    }
    else
    {
        //这里注释掉model.price,是为解决从订单页面返回时 今天的价格显示－2的问题
        cell.userInteractionEnabled=NO;
       // model.price=[NSString stringWithFormat:@"%d",-2];
        //cell.model=model;
        
    }
    
    cell.model=model;
   
    
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        
        NSMutableArray *month_Array = [self.calendarMonth objectAtIndex:indexPath.section];
        CalendarDayModel *model = [month_Array objectAtIndex:15];
        
        CalendarMonthHeaderView *monthHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader forIndexPath:indexPath];
        monthHeader.masterLabel.text = [NSString stringWithFormat:@"%lu年 %lu月",(unsigned long)model.year,(unsigned long)model.month];//@"日期";
        monthHeader.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
        reusableview = monthHeader;
    }
    return reusableview;
    
}


//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    NSMutableArray *month_Array = [self.calendarMonth objectAtIndex:indexPath.section];
    CalendarDayModel *model = [month_Array objectAtIndex:indexPath.row];
    
    if (model.style == CellDayTypeFutur || model.style == CellDayTypeWeek ||model.style == CellDayTypeClick)
    {
        
        [self.Logic selectLogic:model];
        [self clickDay:model];
        
        [self.collectionView reloadData];
    }
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{

}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}



#pragma mark--获取点击日期和价格
-(void)clickDay:(CalendarDayModel *)model
{
    _nextBtn.backgroundColor=WEILVColor;
    _isChooseDate=YES;
    DLog(@"1星期 %@",[model getWeek]);
    DLog(@"2字符串 %@",[model toString]);
    DLog(@"3节日  %@",model.price);
    
    if ([[model toString] isEqualToString:[self getDateWithDate:[NSDate date]]])
    {
        NSUInteger index1=[self.shipCalendarArray indexOfObject:[model toString]];
        
        LXTicketCalendarModel *model1=[self.shipCalendarModelArray objectAtIndex:index1];

        NSString *currentTIme =  [self getdotateTime];
        NSString *aheadhour=[[[model1.aheadHour componentsSeparatedByString:@" "] objectAtIndex:1] stringByReplacingOccurrencesOfString:@":" withString:@""];
        DLog(@"------------%lu--%@--%@,当前时间-%@,截止时间=%@",(unsigned long)index1,[model toString],model1.aheadHour,currentTIme,aheadhour);
        if ([currentTIme integerValue]<[aheadhour integerValue])
        {
            YXOrderViewController *yxOrderVc=[[YXOrderViewController alloc] init];
            
            yxOrderVc.departureDate=[model toString];
            yxOrderVc.isTicket=YES;
            yxOrderVc.visaRegion=self.ticketModel.goods_name;
            yxOrderVc.ticketGoodsModel=self.ticketModel;
            yxOrderVc.product_name=self.product_name;
            [self.navigationController pushViewController:yxOrderVc animated:YES];
        }
        else
        {
            [[LXAlterView sharedMyTools] createTishi:@"当前日期门票已停止销售"];
        }
        
    }
    else
    {
        YXOrderViewController *yxOrderVc=[[YXOrderViewController alloc] init];
        
        yxOrderVc.departureDate=[model toString];
        yxOrderVc.isTicket=YES;
        yxOrderVc.visaRegion=self.ticketModel.goods_name;
        yxOrderVc.ticketGoodsModel=self.ticketModel;
        yxOrderVc.product_name=self.product_name;
        [self.navigationController pushViewController:yxOrderVc animated:YES];
    }
   
    
    
}



#pragma mark--今天的日期
-(CalendarDayModel *)getTodayModel
{
    NSDate *todate = [NSDate date];//今天
 
    
    NSString *date=[todate stringFromDate:todate];
    NSArray *array = [date componentsSeparatedByString:@"-"];
    
    CalendarDayModel *model=[[CalendarDayModel alloc] init];
    model.year=[[array objectAtIndex:0] integerValue];
    model.month=[[array objectAtIndex:1] integerValue];
    model.day=[[array objectAtIndex:2] integerValue];
    
    return model;
}

//获取当前时间(时，分)
-(NSString *)getdotateTime
{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"HHmm"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    DLog(@"locationString:%@",locationString);
    return locationString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end

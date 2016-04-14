//
//  TraveCalendarViewController.m
//  WelLv
//
//  Created by 刘鑫 on 15/4/24.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
#define WEILVColor [UIColor colorWithRed:251/255.f green:131/255.f blue:10/255.f alpha:1.0]
#define BottomHeight 120
#define BottomHeight_haveChildPrice 140
#define NAVBarH 60
#define LeaveWeek @"week"
#define LeaveDay  @"day"
#define LeaveWeekend @"weekend"
#define LeaveEveryDay @"everyday"

#import "TraveCalendarViewController.h"
//UI
#import "CalendarMonthCollectionViewLayout.h"
#import "CalendarMonthHeaderView.h"
#import "CalendarDayCell.h"
//MODEL
#import "CalendarDayModel.h"

#import "YXOrderViewController.h"
#import "LXCustomTraveModel.h"

@interface TraveCalendarViewController ()
<UICollectionViewDataSource,UICollectionViewDelegate,UITextViewDelegate>
{
    
    int daynumber;//天数
    int optiondaynumber;//选择日期数量
    NSTimer* timer;//定时器
    //int _price;
    CalendarDayModel *_getModel;
    UIView *_bottomView;
    UIButton *_topBtnInBottom;
    UIView *_maskView;
    
    UILabel *_adultLab;//成人数
    UILabel  *_aduPriceLabel;//成人价
    UILabel *_childrenLab;//儿童数
    UILabel  *_childPriceLabel;//儿童价
    
    UILabel *_showNumberLab;//底部显示已选人数
    UILabel *_showDateLab;//底部显示已选日期
    
    UIView *_showView;
    BOOL _isChooseDate;//是否已选择日期
    BOOL _isShow;//底部UI是否已经弹出
    NSString *_chooseDate;//已经选择的日期
    
    UIButton *_nextBtn;
    
    UIImageView *_bttomImage;
    BOOL _isHaveChildPrice;
    NSInteger cishu;
    NSInteger cishu1;
    NSInteger _todayCell;//今天的cell
    NSMutableArray *_canLeaveDay;//可以出发的日期
    NSInteger _canLeaveDayCell;
    NSString *_leaveType;
    NSInteger _dayValue;
    NSString *_beginDate;
    NSMutableArray *_customTraveModelArray;
    NSMutableArray *_customTraveDateModelArray;
    NSMutableArray *_canLeaveDayArray;
    NSUInteger _timeTableType;//1.只有循环班期  2。只有自定义班期  3.都有
    NSString *_rangeEndDate;//按循环方式计算的结束日期
    UILabel *_childrenLab1;
    UILabel  *_childCriterionLabel;
    
}
@property (nonatomic, strong) NSMutableDictionary * canReserveDayDic;

@property(nonatomic,copy)NSString *child_price;
@property(nonatomic,copy)NSString *adult_price;
@end

@implementation TraveCalendarViewController

static NSString *MonthHeader = @"MonthHeaderView";

//Cell单元格唯一标示
static NSString *DayCell = @"DayCell";
#pragma mark - 实例化执行
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //初始化数组
        [self initData];
    }
    return self;
}
#pragma mark - 初始化数据组
-(void)initData{
    
    self.calendarMonth = [[NSMutableArray alloc]init];//每个月份的数组
    
    self.assignArray=[[NSMutableArray alloc] initWithCapacity:0];
    _canLeaveDay=[NSMutableArray array];
    _customTraveModelArray=[NSMutableArray array];
    _customTraveDateModelArray=[NSMutableArray array];
    _canLeaveDayArray=[[NSMutableArray alloc] initWithCapacity:0];
    _getModel=[self getTodayModel];
    
    cishu=0;
    cishu1=0;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    //父类初始化
    [super viewDidLoad];
    
    
    //设置标题名称
    //self.title=@"选择团期和人数";
    
    //设置当前视图背景颜色
    self.view.backgroundColor=[UIColor whiteColor];
    self.adult_price=self.traveModel.adult_price;
    self.child_price=self.traveModel.child_price;
    //如果儿童价格不为空，表示有儿童价格,否则只有成人价格
    if ([self.traveModel.child_price intValue]==0)
    {
        _isHaveChildPrice=NO;
    }else
    {
        _isHaveChildPrice=YES;
        
    }
    
    
    //打印输出traveModel产品实体类相关信息
    DLog(@"自定义产品JSON数据:%@",self.traveModel.custom_json);
    DLog(@"自定义产品Time数据:%@",self.traveModel.timetable_custom);
    DLog(@"循环范围数据:%@",self.traveModel.timetable_range);
    DLog(@"循环方式数据:%@",self.traveModel.timetable);
    DLog(@"日历开始时间数据:%@",[self getDateStr:self.traveModel.js_datetime]);
    DLog(@"需提前预定天数:%@",self.traveModel.b_day);
    
    if(![self.traveModel.timetable_custom isEqual:[NSNull null]])
    {
        self.canReserveDayDic = [NSMutableDictionary dictionaryWithDictionary:[[WLSingletonClass defaultWLSingleton] wlJsonStringToDicOrArr:self.traveModel.custom_json]];
        
        //自定义班期
        for (int i=0; i<self.traveModel.timetable_custom.count; i++)
        {
            NSDictionary *dic=[self.traveModel.timetable_custom objectAtIndex:i];
            LXCustomTraveModel *customTraveModel = [[LXCustomTraveModel alloc] init];
            [customTraveModel setValuesForKeysWithDictionary:dic];
            [_customTraveModelArray addObject:customTraveModel];
            [_customTraveDateModelArray addObject:customTraveModel.date_time];
        }
            //数组重新排序
        _customTraveModelArray= [NSMutableArray arrayWithArray:[_customTraveModelArray sortedArrayUsingSelector:@selector(sortByAge:)]];
        for (id obj in _customTraveDateModelArray) {
            DLog(@"%@",obj);
        }
    }

    //判断循环方式
    if (self.traveModel.timetable_range.length>0 && self.traveModel.timetable.length>0 && _customTraveModelArray.count==0)
    {
        //只有循环班期
        _timeTableType=1;
    }else if (!_customTraveModelArray.count==0 && (self.traveModel.timetable_range.length==0 || self.traveModel.timetable.length==0))
    {
        //只有自定义班期
        _timeTableType=2;
    }
    else if (self.traveModel.timetable_range.length>0 && self.traveModel.timetable.length>0 && !_customTraveModelArray.count==0)
    {
        //都有
        _timeTableType=3;
    }
 
    //开始时间处理
    if ([YXTools  stringReturnNull:self.realBeginDate]==YES)
    {
        _beginDate=@"";
    }
    else
    {
        _beginDate=[self.realBeginDate stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
        
    }
    
    //计算循环范围
    [self setTraveDate:nil timetable_range:[self getTimeRange] timetable:nil b_day:nil customDateArray:_customTraveModelArray];
    
}

#pragma mark - 计算循环范围
-(void)setTraveDate:(NSString *)js_datetime//日历开始时间
    timetable_range:(NSString *)timetable_range //班期循环范围
          timetable:(NSString *)timetable //班期循环方式
              b_day:(NSString *)b_day //需要提前几天预订
    customDateArray:(NSMutableArray *)array
{
    //日历可用天数
    daynumber = [timetable_range intValue];
    optiondaynumber = 2;//选择两个后返回数据对象
    
    //计算多少个月
    if (daynumber<=0) {
        
        self.calendarMonth = [self getMonthArrayOfDayNumber:0 ToDateforString:nil beginDate:[self getDateWithDate:[NSDate date]] customDateArray:array];
    }else{
        self.calendarMonth = [self getMonthArrayOfDayNumber:daynumber ToDateforString:nil beginDate:_beginDate customDateArray:array];
    }
    
    //计算获取可以出发的日期
    [self getLeaveDay:self.traveModel.timetable];
    
    //获取今天的Cell
    [self getTodayCellRow];
    
    //初始化CollectionView
    [self initView];
    
    //日历刷新
    [self.collectionView reloadData];
}

#pragma mark - 初始化 CollectionView
- (void)initView{
    
    [self setTitle:@"选择日期"];
    
    CalendarMonthCollectionViewLayout *layout = [CalendarMonthCollectionViewLayout new];
    
    if (_isHaveChildPrice==YES)
    {
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64) collectionViewLayout:layout]; //初始化网格视图大小
    }
    else
    {
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64) collectionViewLayout:layout]; //初始化网格视图大小
    }
    
    [self.collectionView registerClass:[CalendarDayCell class] forCellWithReuseIdentifier:DayCell];//cell重用设置ID
    
    [self.collectionView registerClass:[CalendarMonthHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader];
    
    self.collectionView.delegate = self;//实现网格视图的delegate
    
    self.collectionView.dataSource = self;//实现网格视图的dataSource
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    
}

#pragma mark ---计算循环范围
-(NSString *)getTimeRange
{
    //循环范围类型
    //1  "timetable_range": "latest 30 days"
    //2  "timetable_range": "2015-03-04_2015-03-30"
    NSString *timeRange;
    switch (_timeTableType)
    {
        case 1:
        {
            //只有循环
            //有循环范围和循环类型
            NSRange searchRange = [self.traveModel.timetable_range rangeOfString:@"latest"];
            if (searchRange.location != NSNotFound)
            {
                
                NSArray *array = [self.traveModel.timetable_range componentsSeparatedByString:@" "];
                
                //先算出结束日期
                //持续天数
                NSString *lastDay=[NSString stringWithFormat:@"%d",[[array objectAtIndex:1] intValue]-1];
                NSString *endDate=[self getEndDate:self.traveModel.js_datetime last:lastDay];
                timeRange=[self getDateGap:endDate beginDate:_beginDate];
                
                
            }else
            {
                
                NSArray *array = [self.traveModel.timetable_range componentsSeparatedByString:@"_"];
                timeRange=[self getDateGap:[array objectAtIndex:1] beginDate:_beginDate];
            }
            
        }
            break;
        case 2:
        {
            //只有自定义
            LXCustomTraveModel *model=[[LXCustomTraveModel alloc] init];
            model=[_customTraveModelArray objectAtIndex:_customTraveModelArray.count-1];
            timeRange=[self getDateGap:model.date_time beginDate:_beginDate];
        }
            break;
            
        case 3:
        {
            //都有
            LXCustomTraveModel *model=[[LXCustomTraveModel alloc] init];
            model = [_customTraveModelArray objectAtIndex:_customTraveModelArray.count-1];
            
            NSRange searchRange = [self.traveModel.timetable_range rangeOfString:@"latest"];
            if (searchRange.location != NSNotFound)
            {
                
                NSArray *array = [self.traveModel.timetable_range componentsSeparatedByString:@" "];
                //先算出结束日期
                //持续天数
                NSString *lastDay=[NSString stringWithFormat:@"%d",[[array objectAtIndex:1] intValue]-1];
                NSString *endDate=[self getEndDate:self.traveModel.js_datetime last:lastDay];
                NSString *endDate1=model.date_time;
                _rangeEndDate=[endDate stringByReplacingOccurrencesOfString:@"-" withString:@""];
                NSDate *enddate=[[self getDateWithStr:endDate] laterDate:[self getDateWithStr:endDate1]];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                NSString *endendDate=[dateFormatter stringFromDate:enddate];
                timeRange=[self getDateGap:endendDate beginDate:_beginDate];
                
                
            }else
            {
                
                NSArray *array = [self.traveModel.timetable_range componentsSeparatedByString:@"_"];
                NSString *endDate=[array objectAtIndex:1];
                _rangeEndDate=[endDate stringByReplacingOccurrencesOfString:@"-" withString:@""];
                NSString *endDate1=model.date_time;
                NSDate *enddate=[[self getDateWithStr:endDate] laterDate:[self getDateWithStr:endDate1]];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                NSString *endendDate=[dateFormatter stringFromDate:enddate];
                timeRange=[self getDateGap:endendDate beginDate:_beginDate];

            }
        }
            break;
            
        default:
            break;
    }
    
    DLog(@"--%lu班期最终范围--%@",(unsigned long)_timeTableType,timeRange);
    return timeRange;
}

#pragma mark -- 计算日期开始时间
-(NSString *)getBeginDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *beginDateStr;
    NSDate *beginDate;
    
    NSDate *leaveDate=[NSDate dateWithTimeInterval:[self.traveModel.b_day intValue]*24*3600+86400 sinceDate:[NSDate date]];
    switch (_timeTableType)
    {
        case 1:
        {
            //只有循环班期
            beginDate=[[self getDate:self.traveModel.js_datetime] laterDate:leaveDate];
            
        }
            break;
        case 2:
        {
            //只有自定义
            LXCustomTraveModel *customTraveModel = [[LXCustomTraveModel alloc] init];
            customTraveModel=[_customTraveModelArray objectAtIndex:0];
            
            if ([self.traveModel.js_datetime intValue]==0)
            {
                DLog(@"========%@",[[NSDate date]  laterDate:[self getDateWithStr:customTraveModel.date_time]]);
                beginDate=[leaveDate laterDate:[self getDateWithStr:customTraveModel.date_time]];
            }else
            {
                beginDate=[[leaveDate laterDate:[self getDateWithStr:customTraveModel.date_time]] laterDate:[self getDate:self.traveModel.js_datetime]];
            }
        }
            break;
        case 3:
        {
            //都有
            LXCustomTraveModel *customTraveModel = [[LXCustomTraveModel alloc] init];
            customTraveModel=[_customTraveModelArray objectAtIndex:0];
            
            NSRange searchRange = [self.traveModel.timetable_range rangeOfString:@"latest"];
            if (searchRange.location != NSNotFound){
                if ([[self getTimestampWithStr:customTraveModel.date_time] integerValue]>[[self getDateWithTimestamp:leaveDate] integerValue] && [[self getTimestampWithStr:customTraveModel.date_time] integerValue]<[[self getTimestampWithStr:self.traveModel.js_datetime] integerValue]) {
                    
                    beginDate=[self getNSDateWithStr:customTraveModel.date_time];
                }else
                {
                    beginDate=[leaveDate laterDate:[self getDate:self.traveModel.js_datetime]];
                }
                
            }else{
                NSArray *array = [self.traveModel.timetable_range componentsSeparatedByString:@"_"];
                NSString *beginDate1=[array objectAtIndex:0];
                if ([[self getTimestampWithStr:customTraveModel.date_time] integerValue]>[[self getDateWithTimestamp:leaveDate] integerValue] && [[self getTimestampWithStr:customTraveModel.date_time] integerValue]<[[self getTimestampWithStr:self.traveModel.js_datetime] integerValue]) {
                    beginDate=[self getNSDateWithStr:customTraveModel.date_time];
                }else
                {
                    beginDate=[[leaveDate laterDate:[self getDate:self.traveModel.js_datetime]] laterDate:[self getDateWithStr:beginDate1]];
                }
            }
            
            
        }
            break;
            
        default:
            break;
    }
    
    beginDateStr=[dateFormatter stringFromDate:beginDate];
    DLog(@"%@-日期真正的开始时间==%@,需提前%@天预订",beginDate,beginDateStr,self.traveModel.b_day);
    return beginDateStr;
}

#pragma mark -- 计算日期结束时间
-(NSString *)getEndDate:(NSString *)date last:(NSString *)last
{
    NSString *str=date;//时间戳
    NSTimeInterval time=[str doubleValue]+[last integerValue]*24*3600;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    DLog(@"date:%@",detaildate);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    DLog(@"结束时间===%@",currentDateStr);
    return currentDateStr;
}

#pragma mark ---计算两个日期的差距(按天算)
-(NSString *)getDateGap:(NSString *)last beginDate:(NSString *)beginDateStr
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式,这里可以设置成自己需要的格式
    NSDate *lastDate =[dateFormat dateFromString:last];
    NSDate *beginDate=[dateFormat dateFromString:beginDateStr];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSDayCalendarUnit;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:beginDate toDate:lastDate options:0];
    NSInteger days = [comps day]+1;
    NSString *dayS=[NSString stringWithFormat:@"%ld",(long)days];
    return dayS;
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
#pragma mark ---时间戳转换成NSDate
-(NSDate *)getDate:(NSString *)date
{
    NSString *str=date;//时间戳
    NSTimeInterval time=[str doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    DLog(@"date:%@",detaildate);
    return detaildate;
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
#pragma mark NSDate转字符串
-(NSString *)getDateWithDate:(NSDate *)date
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式
    
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}

#pragma mark ---时间字符串转时间戳
-(NSString *)getTimestampWithStr:(NSString *)dateStr
{
    NSDate *date = [self getDateWithStr:dateStr];
    NSString *timeint=[NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
    return timeint;
}

#pragma mark ---NSDate转时间戳
-(NSString *)getDateWithTimestamp:(NSDate *)date
{
    NSString *timeint=[NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
    return timeint;
}

#pragma mark ---时间字符串转NSDate
-(NSDate *)getNSDateWithStr:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}



#pragma mark - 逻辑代码初始化

//获取时间段内的天数数组
- (NSMutableArray *)getMonthArrayOfDayNumber:(int)day ToDateforString:(NSString *)todate beginDate:(NSString *)benigDate customDateArray:(NSMutableArray *)array
{
    
    NSDate *date = [NSDate date];
    date=[date dateFromString:benigDate];
    
    NSDate *selectdate  = [NSDate date];
    
    if (todate) {
        
        selectdate = [selectdate dateFromString:todate];
        
    }
    
    self.Logic = [[CalendarLogic alloc]init];
    
    return [self.Logic reloadCalendarView:date selectDate:selectdate  needDays:day customDateArray:array];
}


-(void)chooseNumberAndInfo
{
    NSInteger labHeight = 25;
    
    //成人
    _adultLab=[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 80, labHeight)];
    _adultLab.backgroundColor=[UIColor whiteColor];
    _adultLab.textAlignment=1;
    _adultLab.font=[UIFont systemFontOfSize:15];
    _adultLab.text=@"0";
    _adultLab.userInteractionEnabled=YES;
    [_bottomView addSubview:_adultLab];
    
    UIButton *cutBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    cutBtn.frame=CGRectMake(0, 0, labHeight, labHeight);
    cutBtn.backgroundColor=WEILVColor;
    cutBtn.tag=1;
    [cutBtn setTitle:@"-" forState:UIControlStateNormal];
    [cutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cutBtn addTarget:self action:@selector(cutOrAdd:) forControlEvents:UIControlEventTouchUpInside];
    [_adultLab addSubview:cutBtn];
    
    UIButton *addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame=CGRectMake(ViewWidth(_adultLab)-labHeight, 0, labHeight, labHeight);
    addBtn.backgroundColor=WEILVColor;
    addBtn.tag=2;
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(cutOrAdd:) forControlEvents:UIControlEventTouchUpInside];
    [_adultLab addSubview:addBtn];
    
    UILabel *adultLab1=[[UILabel alloc] initWithFrame:CGRectMake(ViewWidth(_adultLab)+25, 10, 40, labHeight)];
    adultLab1.text=@"成人";
    adultLab1.textColor=[UIColor whiteColor];
    adultLab1.font=[UIFont systemFontOfSize:15];
    [_bottomView addSubview:adultLab1];
    
    //成人价
    _aduPriceLabel=[[UILabel alloc] initWithFrame:CGRectMake(ViewX(_adultLab), ViewHeight(_adultLab)+20, 200, 20)];
    _aduPriceLabel.font=[UIFont systemFontOfSize:14];
    _aduPriceLabel.textColor=[UIColor whiteColor];
    _aduPriceLabel.text=[NSString stringWithFormat:@"成人价：%d元/人",[self.traveModel.adult_price intValue]];
    [_bottomView addSubview:_aduPriceLabel];
    
    if (_isHaveChildPrice==YES)
    {
        //儿童
        _childrenLab=[[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth-150, 10, 80, labHeight)];
        _childrenLab.backgroundColor=[UIColor whiteColor];
        _childrenLab.textAlignment=1;
        _childrenLab.font=[UIFont systemFontOfSize:15];
        _childrenLab.text=@"0";
        _childrenLab.userInteractionEnabled=YES;
        [_bottomView addSubview:_childrenLab];
        
        UIButton *cutBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
        cutBtn1.frame=CGRectMake(0, 0, labHeight, labHeight);
        cutBtn1.backgroundColor=WEILVColor;
        cutBtn1.tag=3;
        [cutBtn1 setTitle:@"-" forState:UIControlStateNormal];
        [cutBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cutBtn1 addTarget:self action:@selector(cutOrAdd:) forControlEvents:UIControlEventTouchUpInside];
        [_childrenLab addSubview:cutBtn1];
        
        UIButton *addBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
        addBtn1.frame=CGRectMake(ViewWidth(_childrenLab)-labHeight, 0, labHeight, labHeight);
        addBtn1.backgroundColor=WEILVColor;
        addBtn1.tag=4;
        [addBtn1 setTitle:@"+" forState:UIControlStateNormal];
        [addBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addBtn1 addTarget:self action:@selector(cutOrAdd:) forControlEvents:UIControlEventTouchUpInside];
        [_childrenLab addSubview:addBtn1];
        
        _childrenLab1=[[UILabel alloc] initWithFrame:CGRectMake(ViewX(_childrenLab)+ViewWidth(_childrenLab)+4, 10, 50, labHeight)];
        _childrenLab1.text=@"儿童";
        _childrenLab1.textColor=[UIColor whiteColor];
        _childrenLab1.font=[UIFont systemFontOfSize:15];
        [_bottomView addSubview:_childrenLab1];
        
        
        //儿童价
        _childPriceLabel=[[UILabel alloc] initWithFrame:CGRectMake(ViewX(_childrenLab), ViewHeight(_adultLab)+20, 200, 20)];
        _childPriceLabel.font=[UIFont systemFontOfSize:14];
        _childPriceLabel.textColor=[UIColor whiteColor];
        _childPriceLabel.text=[NSString stringWithFormat:@"儿童价：%d元/人",[self.traveModel.child_price intValue]];
        [_bottomView addSubview:_childPriceLabel];
        
        //儿童标准
        _childCriterionLabel=[[UILabel alloc] initWithFrame:CGRectMake(ViewX(_adultLab), ViewHeight(_adultLab)+40, 200, 20)];
        _childCriterionLabel.font=[UIFont systemFontOfSize:14];
        _childCriterionLabel.textColor=[UIColor whiteColor];
        _childCriterionLabel.text=[NSString stringWithFormat:@"儿童标准：(2-12周岁)"];
        [_bottomView addSubview:_childCriterionLabel];
    }
    
    UIView *line=[[UIView alloc] init];
    if (_isHaveChildPrice==YES)
    {
        line.frame=CGRectMake(ViewX(_adultLab), ViewHeight(_aduPriceLabel)+80, windowContentWidth-ViewX(_adultLab)*2, 1);
    }
    else
    {
        line.frame=CGRectMake(ViewX(_adultLab), ViewHeight(_aduPriceLabel)+60, windowContentWidth-ViewX(_adultLab)*2, 1);
    }
    
    line.backgroundColor=[UIColor whiteColor];
    [_bottomView addSubview:line];
    
    UITextView *infoTextV=[[UITextView alloc] initWithFrame:CGRectMake(15, ViewY(line), windowContentWidth-40, 160)];
    infoTextV.text=@"如何预订：\n1.选择出游日期和出游人数\n2.填写您的姓名和手机号，申请人信息，提交订单\n3.等待微旅客服与您联系\n4.网上付款或前往当地门市付款";
    infoTextV.backgroundColor=[UIColor clearColor];
    infoTextV.textColor=[UIColor whiteColor];
    infoTextV.editable=YES;
    infoTextV.delegate=self;
    infoTextV.font=[UIFont systemFontOfSize:14];
    [_bottomView addSubview:infoTextV];
    
    
}

#pragma mark --UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}

#pragma mark -- 按钮点击方法都在这
-(void)cutOrAdd:(UIButton *)btn
{
    DLog(@"dddd");
    switch (btn.tag)
    {
        case 1:
        {
            //减少成人数
            if ([_adultLab.text intValue]>0) {
                _adultLab.text=[NSString stringWithFormat:@"%d",[_adultLab.text intValue]-1];
            }
        }
            break;
        case 2:
        {
            //增加成人数
            _adultLab.text=[NSString stringWithFormat:@"%d",[_adultLab.text intValue]+1];
        }
            break;
        case 3:
        {
            //减少儿童数
            if ([_childrenLab.text intValue]>0) {
                _childrenLab.text=[NSString stringWithFormat:@"%d",[_childrenLab.text intValue]-1];
            }
        }
            break;
        case 4:
        {
            //增加儿童数
            _childrenLab.text=[NSString stringWithFormat:@"%d",[_childrenLab.text intValue]+1];
        }
            break;
            
        case 5:
        {
            int totalPeople = [_childrenLab.text intValue]+[_adultLab.text intValue];
            //下一步
            if (_isChooseDate==YES && totalPeople>0)
            {
                NSString * aduprice;
                NSRange searchRange = [_aduPriceLabel.text rangeOfString:@"元/人"];
                if (searchRange.location != NSNotFound) {
                    aduprice=[_aduPriceLabel.text stringByReplacingOccurrencesOfString:@"成人价：" withString:@""];
                    aduprice=[aduprice stringByReplacingOccurrencesOfString:@"元/人" withString:@""];
                }
                
                NSString * childprice;
                NSRange searchRange1 = [_childPriceLabel.text rangeOfString:@"元/人"];
                if (searchRange1.location != NSNotFound) {
                    childprice=[_childPriceLabel.text stringByReplacingOccurrencesOfString:@"儿童价：" withString:@""];
                    childprice=[childprice stringByReplacingOccurrencesOfString:@"元/人" withString:@""];
                }
                //总价
                float totalPrice=[_adultLab.text intValue]*[aduprice floatValue]+[_childrenLab.text intValue]*[childprice floatValue];
                
                YXOrderViewController *yxOrderVc=[[YXOrderViewController alloc] init];
                yxOrderVc.visaRegion=self.traveModel.product_name;
                DLog(@"_____%@,,,___%@,,,,%f，，，self.traveModel.adult_price=%@,成人价=%@",_adultLab.text,_childrenLab.text,totalPrice,self.traveModel.adult_price,_aduPriceLabel.text);
                yxOrderVc.totalPrice=[NSString stringWithFormat:@"%f",totalPrice];
                yxOrderVc.departureDate=_chooseDate;
                yxOrderVc.adultNumber=_adultLab.text;
                yxOrderVc.childrenNumber=_childrenLab.text;
                yxOrderVc.isTrave=YES;
                
                yxOrderVc.traveModel = self.traveModel;
                [self.navigationController pushViewController:yxOrderVc animated:YES];
            }else
            {
                [[LXAlterView sharedMyTools] createTishi:@"请先选择团期和人数"];
            }
            
            
        }
            break;
            
            
        case 6:
        {
            //弹出底部UI
            if (_isShow==NO && _isChooseDate==YES)
            {
                [UIView animateWithDuration:0.3 animations:^{
                    _isShow=YES;
                    _bottomView.frame=CGRectMake(0, windowContentHeight-300-NAVBarH, windowContentWidth, 300);
                    
                    _topBtnInBottom.frame=CGRectMake(windowContentWidth-45, ViewY(_bottomView)-25, 50, 25);
                    
                    _bttomImage.frame=CGRectMake(windowContentWidth-30, ViewY(_bottomView)-15, 20, 10);
                    _bttomImage.image=[UIImage imageNamed:@"icon_calendar_down.png"];
                    
                    _showNumberLab.frame=CGRectMake(20, 0, ViewWidth(_showView)-30, 20);
                    if (_isHaveChildPrice==YES)
                    {
                        _showNumberLab.text=[NSString stringWithFormat:@"%@成人  %@儿童",_adultLab.text,_childrenLab.text];
                    }else
                    {
                        _showNumberLab.text=[NSString stringWithFormat:@"%@成人",_adultLab.text];
                    }
                    
                    
                    _showDateLab.alpha=1;
                    
                    
                } completion:^(BOOL finished) {
                    
                    
                    _maskView=[[UIView alloc] init];
                    _maskView.frame=CGRectMake(0, 0, windowContentWidth, windowContentHeight-300-NAVBarH);
                    _maskView.backgroundColor=[UIColor clearColor];
                    [self.view addSubview:_maskView];
                    
                    
                    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewClick)];
                    [_maskView addGestureRecognizer:tap];
                    
                }];
            }
            else
            {
                _isShow=NO;
                [self maskViewClick];
            }
        }
            
        default:
            break;
            
            
    }
    
    if (_isChooseDate==YES)
    {
        if (_isHaveChildPrice==YES)
        {
            _showNumberLab.text=[NSString stringWithFormat:@"%@成人  %@儿童",_adultLab.text,_childrenLab.text];
        }else
        {
            _showNumberLab.text=[NSString stringWithFormat:@"%@成人",_adultLab.text];
        }
    }
}



#pragma mark --  获取今天的cell
-(void)getTodayCellRow
{
    NSMutableArray *monthArray = [self.calendarMonth objectAtIndex:0];
    
    for (NSInteger i=0; i<monthArray.count; i++)
    {
        CalendarDayModel *model=[monthArray objectAtIndex:i];
        if ([_getModel isEqualTo:model]==YES)
        {
            _todayCell=i;
            DLog(@"今天的cell=%ld",(long)_todayCell);
        }
    }
    
}

#pragma mark  --  获取出发日期的cell
-(NSString *)getLeaveDayCell
{
    NSString *beginDateStr;
    NSArray *array=[_beginDate componentsSeparatedByString:@"-"];
    beginDateStr=[array objectAtIndex:2];
    DLog(@"dddd---%@",beginDateStr);
    return beginDateStr;
}

#pragma mark -- 根据循环方式获取出发日期
-(void)getLeaveDay:(NSString *)timeTable
{
    
    if ([[[timeTable objectFromJSONString] objectForKey:@"type"] isEqualToString:@"week"])
    {
        //按星期
        _leaveType=LeaveWeek;
        _canLeaveDay=[self getWeekDayWithStr:[[timeTable objectFromJSONString] objectForKey:@"value"]];;
        
    }else if([[[timeTable objectFromJSONString] objectForKey:@"type"] isEqualToString:@"day"])
    {
        //按日算
        if ([[[timeTable objectFromJSONString] objectForKey:@"value"] integerValue]==1)
        {
            _leaveType=LeaveEveryDay;
        }else
        {
            _leaveType=LeaveDay;
            _dayValue=[[[timeTable objectFromJSONString] objectForKey:@"value"] integerValue];
            //_dayValue=2;
        }
        
    }else if ([[[timeTable objectFromJSONString] objectForKey:@"type"] isEqualToString:@"everyday"])
    {
        //每天
        _leaveType=LeaveEveryDay;
        
    }else if ([[[timeTable objectFromJSONString] objectForKey:@"type"] isEqualToString:@"weekend"])
    {
        //周末
        _leaveType=LeaveWeekend;
        _canLeaveDay=[NSMutableArray arrayWithObjects:@"0",@"6", nil];
    }
    
}
//按星期
-(NSMutableArray *)getWeekDayWithStr:(NSString *)str
{
    NSArray *week=[str componentsSeparatedByString:@","];
    NSMutableArray *endWeekArray=[NSMutableArray array];
    for (NSString *weekDay in week)
    {
        DLog(@"---%lu",(unsigned long)weekDay.length);
        if (weekDay.length>0)
        {
            [endWeekArray addObject:weekDay];
        }
    }
    
    return endWeekArray;
}




#pragma mark - CollectionView代理方法
//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.calendarMonth.count;
}

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSMutableArray *monthArray = [self.calendarMonth objectAtIndex:section];
    return monthArray.count;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *remanentPeople;
    self.traveModel.adult_price = self.price;
    self.traveModel.child_price = self.childprice;
 
    
    CalendarDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DayCell forIndexPath:indexPath];
    cell.userInteractionEnabled=YES;
    
    NSMutableArray *monthArray = [self.calendarMonth objectAtIndex:indexPath.section];
    CalendarDayModel *model = [monthArray objectAtIndex:indexPath.row];
    
    
    NSString * datStr = model.day < 10 ? [NSString stringWithFormat:@"0%ld", model.day] : [NSString stringWithFormat:@"%ld", model.day];
    NSString * monthStr = model.month < 10 ? [NSString stringWithFormat:@"0%ld", model.month] : [NSString stringWithFormat:@"%ld", model.month];
    NSString * timeStr = [NSString stringWithFormat:@"%ld-%@-%@", model.year, monthStr, datStr];
    
    BOOL reserveDay = YES;
    if ([[self.canReserveDayDic objectForKey:timeStr] isKindOfClass:[NSDictionary class]] &&[[[self.canReserveDayDic objectForKey:timeStr] objectForKey:@"members"] integerValue] == 0) {
        DLog(@"%@", timeStr);
        reserveDay = NO;
    }
    
    DLog(@"timeStr == %@", timeStr);
    if (_todayCell==indexPath.row && indexPath.section==0)
    {
        
        cell.userInteractionEnabled=NO;
        
        model.price=[NSString stringWithFormat:@"%d",-1];
        cell.model=model;
    }
    if (_timeTableType==1 || _timeTableType==2)
    {
        if([_leaveType isEqualToString:LeaveWeek])
        {
            //按周几发团
            switch (_canLeaveDay.count)
            {
                case 1:
                {
                    if (indexPath.row%7==[[_canLeaveDay objectAtIndex:0] integerValue])
                    {
                        model.price=[NSString stringWithFormat:@"¥%.0f",[self.traveModel.adult_price floatValue]];
                       
                    }else
                    {
                        cell.userInteractionEnabled=NO;
                        model.price=[NSString stringWithFormat:@"%d",-2];
                       
                    }
                    
                    cell.model=model;
                }
                    break;
                    
                case 2:
                {
                    if (indexPath.row%7==[[_canLeaveDay objectAtIndex:0] integerValue] ||
                        indexPath.row%7==[[_canLeaveDay objectAtIndex:1] integerValue])
                    {
                        model.price=[NSString stringWithFormat:@"¥%.0f",[self.traveModel.adult_price floatValue]];
                    }else
                    {
                        cell.userInteractionEnabled=NO;
                        model.price=[NSString stringWithFormat:@"%d",-2];
                    }
                    
                    cell.model=model;
                }
                    break;
                    
                case 3:
                {
                    if (indexPath.row%7==[[_canLeaveDay objectAtIndex:0] integerValue] ||
                        indexPath.row%7==[[_canLeaveDay objectAtIndex:1] integerValue] ||
                        indexPath.row%7==[[_canLeaveDay objectAtIndex:2] integerValue])
                    {
                        model.price=[NSString stringWithFormat:@"¥%.0f",[self.traveModel.adult_price floatValue]];
                    }else
                    {
                        cell.userInteractionEnabled=NO;
                        model.price=[NSString stringWithFormat:@"%d",-2];
                    }
                    
                    cell.model=model;
                }
                    break;
                    
                case 4:
                {
                    if (indexPath.row%7==[[_canLeaveDay objectAtIndex:0] integerValue] ||
                        indexPath.row%7==[[_canLeaveDay objectAtIndex:1] integerValue] ||
                        indexPath.row%7==[[_canLeaveDay objectAtIndex:2] integerValue] ||
                        indexPath.row%7==[[_canLeaveDay objectAtIndex:3] integerValue])
                    {
                        model.price=[NSString stringWithFormat:@"¥%.0f",[self.traveModel.adult_price floatValue]];
                    }else
                    {
                        cell.userInteractionEnabled=NO;
                        model.price=[NSString stringWithFormat:@"%d",-2];
                    }
                    
                    cell.model=model;
                }
                    break;
                    
                case 5:
                {
                    if (indexPath.row%7==[[_canLeaveDay objectAtIndex:0] integerValue] ||
                        indexPath.row%7==[[_canLeaveDay objectAtIndex:1] integerValue] ||
                        indexPath.row%7==[[_canLeaveDay objectAtIndex:2] integerValue] ||
                        indexPath.row%7==[[_canLeaveDay objectAtIndex:3] integerValue] ||
                        indexPath.row%7==[[_canLeaveDay objectAtIndex:4] integerValue])
                    {
                        model.price=[NSString stringWithFormat:@"¥%.0f",[self.traveModel.adult_price floatValue]];
                    }else
                    {
                        cell.userInteractionEnabled=NO;
                        model.price=[NSString stringWithFormat:@"%d",-2];
                    }
                    
                    cell.model=model;
                }
                    break;
                    
                case 6:
                {
                    if (indexPath.row%7==[[_canLeaveDay objectAtIndex:0] integerValue] ||
                        indexPath.row%7==[[_canLeaveDay objectAtIndex:1] integerValue] ||
                        indexPath.row%7==[[_canLeaveDay objectAtIndex:2] integerValue] ||
                        indexPath.row%7==[[_canLeaveDay objectAtIndex:3] integerValue] ||
                        indexPath.row%7==[[_canLeaveDay objectAtIndex:4] integerValue] ||
                        indexPath.row%7==[[_canLeaveDay objectAtIndex:5] integerValue])
                    {
                        model.price=[NSString stringWithFormat:@"¥%.0f",[self.traveModel.adult_price floatValue]];
                    }else
                    {
                        cell.userInteractionEnabled=NO;
                        model.price=[NSString stringWithFormat:@"%d",-2];
                    }
                    
                    cell.model=model;
                }
                    break;
                    
                case 7:
                {
                    if (indexPath.row%7==[[_canLeaveDay objectAtIndex:0] integerValue] ||
                        indexPath.row%7==[[_canLeaveDay objectAtIndex:1] integerValue] ||
                        indexPath.row%7==[[_canLeaveDay objectAtIndex:2] integerValue] ||
                        indexPath.row%7==[[_canLeaveDay objectAtIndex:3] integerValue] ||
                        indexPath.row%7==[[_canLeaveDay objectAtIndex:4] integerValue] ||
                        indexPath.row%7==[[_canLeaveDay objectAtIndex:5] integerValue] ||
                        indexPath.row%7==[[_canLeaveDay objectAtIndex:6] integerValue])
                    {
                        model.price=[NSString stringWithFormat:@"¥%.0f",[self.traveModel.adult_price floatValue]];
                    }else
                    {
                        cell.userInteractionEnabled=NO;
                        model.price=[NSString stringWithFormat:@"%d",-2];
                    }
                    
                    cell.model=model;
                }
                    break;
                    
                    
                default:
                    break;
            }
            return cell;
        }
        if ([_leaveType isEqualToString:LeaveDay])
        {
            NSUInteger leaveday=[[self getLeaveDayCell] integerValue];
            DLog(@"tttttt==%lu",(unsigned long)leaveday);
            if ((indexPath.row-leaveday)%_dayValue==0)
            {
                model.price=[NSString stringWithFormat:@"¥%.0f",[self.traveModel.adult_price floatValue]];
            }
            else
            {
                cell.userInteractionEnabled=NO;
                model.price=[NSString stringWithFormat:@"%d",-2];
            }
            
            cell.model=model;
            return cell;
            
        }
        if ([_leaveType isEqualToString:LeaveEveryDay])
        {
            model.price=[NSString stringWithFormat:@"¥%.0f",[self.traveModel.adult_price floatValue]];
            cell.model=model;
            return cell;
            
        }
        if ([_leaveType isEqualToString:LeaveWeekend])
        {
            if (indexPath.row%7==[[_canLeaveDay objectAtIndex:0] integerValue] ||
                indexPath.row%7==[[_canLeaveDay objectAtIndex:1] integerValue])
            {
                model.price=[NSString stringWithFormat:@"¥%.0f",[self.traveModel.adult_price floatValue]];
            }else
            {
                cell.userInteractionEnabled=NO;
                model.price=[NSString stringWithFormat:@"%d",-2];
            }
            
            cell.model=model;
            return cell;
        }
        
    }
    //旅游度假->模块->产品->团期
    
    if ([[[model toString] stringByReplacingOccurrencesOfString:@"-" withString:@""] integerValue]<=[_rangeEndDate integerValue] && _timeTableType==3)
        
    {
        DLog(@"%@",[model toString]);
        if([_leaveType isEqualToString:LeaveWeek])
        {
            //按周几发团
            switch (_canLeaveDay.count)
            {
                case 1:
                {
                    if (indexPath.row%7==[[_canLeaveDay objectAtIndex:0] integerValue] && reserveDay)
                    {
                        
                        model.price=[NSString stringWithFormat:@"¥%.0f",[self.traveModel.adult_price floatValue]];
                    }else
                    {
                        cell.userInteractionEnabled=NO;
                        model.price=[NSString stringWithFormat:@"%d",-2];
                    }
                    
                    cell.model=model;
                }
                    break;
                    
                case 2:
                {
                    //表示周六、周日
                    if ((indexPath.row%7==[[_canLeaveDay objectAtIndex:0] integerValue] ||
                         indexPath.row%7==[[_canLeaveDay objectAtIndex:1] integerValue]) && reserveDay)
                    {
                        model.price=[NSString stringWithFormat:@"¥%.0f",[self.traveModel.adult_price floatValue]];
                    }else
                    {
                        cell.userInteractionEnabled=NO;
                        model.price=[NSString stringWithFormat:@"%d",-2];
                    }
                    
                    cell.model=model;
                }
                    break;
                    
                case 3:
                {
                    if ((indexPath.row%7==[[_canLeaveDay objectAtIndex:0] integerValue] ||
                         indexPath.row%7==[[_canLeaveDay objectAtIndex:1] integerValue] ||
                         indexPath.row%7==[[_canLeaveDay objectAtIndex:2] integerValue])&& reserveDay)
                    {
                        model.price=[NSString stringWithFormat:@"¥%.0f",[self.traveModel.adult_price floatValue]];
                    }else
                    {
                        cell.userInteractionEnabled=NO;
                        model.price=[NSString stringWithFormat:@"%d",-2];
                    }
                    
                    cell.model=model;
                }
                    break;
                    
                case 4:
                {
                    if ((indexPath.row%7==[[_canLeaveDay objectAtIndex:0] integerValue] ||
                         indexPath.row%7==[[_canLeaveDay objectAtIndex:1] integerValue] ||
                         indexPath.row%7==[[_canLeaveDay objectAtIndex:2] integerValue] ||
                         indexPath.row%7==[[_canLeaveDay objectAtIndex:3] integerValue]) && reserveDay)
                    {
                        model.price=[NSString stringWithFormat:@"¥%.0f",[self.traveModel.adult_price floatValue]];
                    }else
                    {
                        cell.userInteractionEnabled=NO;
                        model.price=[NSString stringWithFormat:@"%d",-2];
                    }
                    
                    cell.model=model;
                }
                    break;
                    
                case 5:
                {
                    if ((indexPath.row%7==[[_canLeaveDay objectAtIndex:0] integerValue] ||
                         indexPath.row%7==[[_canLeaveDay objectAtIndex:1] integerValue] ||
                         indexPath.row%7==[[_canLeaveDay objectAtIndex:2] integerValue] ||
                         indexPath.row%7==[[_canLeaveDay objectAtIndex:3] integerValue] ||
                         indexPath.row%7==[[_canLeaveDay objectAtIndex:4] integerValue]) && reserveDay)
                    {
                        model.price=[NSString stringWithFormat:@"¥%.0f",[self.traveModel.adult_price floatValue]];
                    }else
                    {
                        cell.userInteractionEnabled=NO;
                        model.price=[NSString stringWithFormat:@"%d",-2];
                    }
                    
                    cell.model=model;
                }
                    break;
                    
                case 6:
                {
                    if ((indexPath.row%7==[[_canLeaveDay objectAtIndex:0] integerValue] ||
                         indexPath.row%7==[[_canLeaveDay objectAtIndex:1] integerValue] ||
                         indexPath.row%7==[[_canLeaveDay objectAtIndex:2] integerValue] ||
                         indexPath.row%7==[[_canLeaveDay objectAtIndex:3] integerValue] ||
                         indexPath.row%7==[[_canLeaveDay objectAtIndex:4] integerValue] ||
                         indexPath.row%7==[[_canLeaveDay objectAtIndex:5] integerValue]) && reserveDay)
                    {
                        model.price=[NSString stringWithFormat:@"¥%.0f",[self.traveModel.adult_price floatValue]];
                    }else
                    {
                        cell.userInteractionEnabled=NO;
                        model.price=[NSString stringWithFormat:@"%d",-2];
                    }
                   
                    cell.model=model;
                }
                    break;
                    
                case 7:
                {
                    if ((indexPath.row%7==[[_canLeaveDay objectAtIndex:0] integerValue] ||
                         indexPath.row%7==[[_canLeaveDay objectAtIndex:1] integerValue] ||
                         indexPath.row%7==[[_canLeaveDay objectAtIndex:2] integerValue] ||
                         indexPath.row%7==[[_canLeaveDay objectAtIndex:3] integerValue] ||
                         indexPath.row%7==[[_canLeaveDay objectAtIndex:4] integerValue] ||
                         indexPath.row%7==[[_canLeaveDay objectAtIndex:5] integerValue] ||
                         indexPath.row%7==[[_canLeaveDay objectAtIndex:6] integerValue]) && reserveDay)
                    {
                        model.price=[NSString stringWithFormat:@"¥%.0f",[self.traveModel.adult_price floatValue]];
                    }else
                    {
                        cell.userInteractionEnabled=NO;
                        model.price=[NSString stringWithFormat:@"%d",-2];
                    }
                    
                    cell.model=model;
                }
                    break;
                    
                    
                default:
                    break;
            }
            
            //如果有自定义日期
            if ([_customTraveDateModelArray containsObject:[model toString]] && reserveDay)
            {
                
                for (LXCustomTraveModel *model1 in _customTraveModelArray)
                {
                    if ([model1.date_time isEqualToString:[model toString]])
                    {
                        if ([self judgeString:model1.members]&&[self judgeString:model1.order_members]) {
                            
                            remanentPeople=[NSString stringWithFormat:@"%ld",[model1.members integerValue]-[model1.order_members integerValue]];
                        }
                        if ([remanentPeople intValue]==0) {
                            model.price=[NSString stringWithFormat:@"%d",-2];
                            
                        }else{
                            model.price=[NSString stringWithFormat:@"¥%.0f",[model1.adult floatValue]];
                        }

                        
//                        model.price=[NSString stringWithFormat:@"¥%.0f",[model1.adult floatValue]];
//                        model.pepNum=self.traveModel.timetable_people;
                        cell.model=model;
                        cell.userInteractionEnabled=YES;
                    }
                }
                
            }
            
            return cell;
        }
        
        
        if ([_leaveType isEqualToString:LeaveDay] && reserveDay)
        {
            NSUInteger leaveday=[[self getLeaveDayCell] integerValue];
            DLog(@"tttttt==%lu",(unsigned long)leaveday);
            if ((indexPath.row-leaveday)%_dayValue==0)
            {
                model.price=[NSString stringWithFormat:@"¥%.0f",[self.traveModel.adult_price floatValue]];
            }
            else
            {
                cell.userInteractionEnabled=NO;
                model.price=[NSString stringWithFormat:@"%d",-2];
            }
            
            //如果有自定义日期
            if ([_customTraveDateModelArray containsObject:[model toString]] && reserveDay)
            {
                
                for (LXCustomTraveModel *model1 in _customTraveModelArray)
                {
                    if ([model1.date_time isEqualToString:[model toString]])
                    {
                        
                        if ([self judgeString:model1.members]&&[self judgeString:model1.order_members]) {
                            
                            remanentPeople=[NSString stringWithFormat:@"%ld",[model1.members integerValue]-[model1.order_members integerValue]];
                        }
                        if ([remanentPeople intValue]==0) {
                            model.price=[NSString stringWithFormat:@"%d",-2];
                            
                        }else{
                            model.price=[NSString stringWithFormat:@"¥%.0f",[model1.adult floatValue]];
                        }

                        
//                        model.price=[NSString stringWithFormat:@"¥%.0f",[model1.adult floatValue]];
//                        model.pepNum=self.traveModel.timetable_people;
                        cell.model=model;
                        cell.userInteractionEnabled=YES;
                    }
                }
                
            }

            
            cell.model=model;
            return cell;
            
        }
        
        if ([_leaveType isEqualToString:LeaveEveryDay] && reserveDay)
        {
            //判断余位是否为零
            if ([self getRadBit:model]==0)
            {
                cell.userInteractionEnabled=NO;
                model.price=[NSString stringWithFormat:@"%d",-2];
            }
            else
            {
                model.price=[NSString stringWithFormat:@"¥%.0f",[self.traveModel.adult_price floatValue]];
                
            }
            
            //如果有自定义日期
            if ([_customTraveDateModelArray containsObject:[model toString]] && reserveDay)
            {
                
                for (LXCustomTraveModel *model1 in _customTraveModelArray)
                {
                    if ([model1.date_time isEqualToString:[model toString]])
                    {
                        if ([self judgeString:model1.members]&&[self judgeString:model1.order_members]) {
                            
                            remanentPeople=[NSString stringWithFormat:@"%ld",[model1.members integerValue]-[model1.order_members integerValue]];
                        }
                        if ([remanentPeople intValue]==0) {
                            model.price=[NSString stringWithFormat:@"%d",-2];
                            
                        }else{
                            model.price=[NSString stringWithFormat:@"¥%.0f",[model1.adult floatValue]];
                        }

                        
                        
//                        model.price=[NSString stringWithFormat:@"¥%.0f",[model1.adult floatValue]];
//                        model.pepNum=self.traveModel.timetable_people;
                        cell.model=model;
                        cell.userInteractionEnabled=YES;
                    }
                }
                
            }

            cell.model=model;
            
            
            return cell;
            
        }
        
        if ([_leaveType isEqualToString:LeaveWeekend] && reserveDay)
        {
            if (indexPath.row%7==[[_canLeaveDay objectAtIndex:0] integerValue] ||
                indexPath.row%7==[[_canLeaveDay objectAtIndex:1] integerValue])
            {
                model.price=[NSString stringWithFormat:@"¥%.0f",[self.traveModel.adult_price floatValue]];
            }
            else
            {
                cell.userInteractionEnabled=NO;
                model.price=[NSString stringWithFormat:@"%d",-2];
            }
            
            //如果有自定义日期
            if ([_customTraveDateModelArray containsObject:[model toString]] && reserveDay)
            {
                
                for (LXCustomTraveModel *model1 in _customTraveModelArray)
                {
                    if ([model1.date_time isEqualToString:[model toString]])
                    {
                        if ([self judgeString:model1.members]&&[self judgeString:model1.order_members]) {
                            
                            remanentPeople=[NSString stringWithFormat:@"%ld",[model1.members integerValue]-[model1.order_members integerValue]];
                        }
                        if ([remanentPeople intValue]==0) {
                            model.price=[NSString stringWithFormat:@"%d",-2];
                            
                        }else{
                            model.price=[NSString stringWithFormat:@"¥%.0f",[model1.adult floatValue]];
                        }

                        
//                        model.price=[NSString stringWithFormat:@"¥%.0f",[model1.adult floatValue]];
//                        model.pepNum=self.traveModel.timetable_people;
                        cell.model=model;
                        cell.userInteractionEnabled=YES;
                    }
                }
                
            }

            cell.model=model;
            return cell;
        }
        
    }
//#pragma mark--这里
    if ([_customTraveDateModelArray containsObject:[model toString]] && reserveDay)
    {
        
        for (LXCustomTraveModel *model1 in _customTraveModelArray)
        {
            if ([model1.date_time isEqualToString:[model toString]])
            {
                if ([self judgeString:model1.members]&&[self judgeString:model1.order_members]) {
                    
                    remanentPeople=[NSString stringWithFormat:@"%ld",[model1.members integerValue]-[model1.order_members integerValue]];
                }
                if ([remanentPeople intValue]==0) {
                    model.price=[NSString stringWithFormat:@"%d",-2];
   
                }else{
                model.price=[NSString stringWithFormat:@"¥%.0f",[model1.adult floatValue]];
                }
                cell.model=model;
            }
        }
        
    }else
    {
        cell.userInteractionEnabled=NO;
        model.price=[NSString stringWithFormat:@"%d",-2];
        
        cell.model=model;
    }
    
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
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
    if (model.style == CellDayTypeFutur || model.style == CellDayTypeWeek ||model.style == CellDayTypeClick) {
        
        [self.Logic selectLogic:model];
         [self clickDay:model];
        cishu=0;
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



//定时器方法
- (void)onTimer{
    
    //[timer invalidate];//定时器无效
    
    //timer = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark--获取点击日期和价格 事件
-(void)clickDay:(CalendarDayModel *)model
{
    _nextBtn.backgroundColor=WEILVColor;
    _isChooseDate=YES;
    DLog(@"1星期 %@",[model getWeek]);
    DLog(@"2字符串 %@",[model toString]);
    DLog(@"3节日  成人价=%@,儿童价=%@",model.price,self.traveModel.child_price);
    NSString *remanentPeople;
    //如果点击的是自定义日期
    DLog(@"%@",[model toString]);
    if ([_customTraveDateModelArray containsObject:[model toString]])
    {
        for (LXCustomTraveModel *model1 in _customTraveModelArray)
        {
            
            DLog(@"%@",model1.date_time);
            
            DLog(@"%@",[model toString]);
            if ([model1.date_time isEqualToString:[model toString]])
            {
                DLog(@"%@--%@",model1.members,model1.order_members);
                if ([self judgeString:model1.members]&&[self judgeString:model1.order_members]) {
                   remanentPeople=[NSString stringWithFormat:@"%ld",[model1.members integerValue]-[model1.order_members integerValue]];
                }
                else
                {
                   remanentPeople=model1.members;
                }
                self.traveModel.adult_price=model1.adult;
                self.traveModel.child_price=model1.child;
                self.adult_price=model1.adult;
                self.child_price=model1.child;
            }
        }
    }else{
      remanentPeople=self.traveModel.timetable_people;
    }
    
    //NSLog(@"%@",remanentPeople);
//    if ([remanentPeople integerValue]>0) {
    
    YXOrderViewController *yxOrderVc=[[YXOrderViewController alloc] init];
    yxOrderVc.visaRegion=self.traveModel.product_name;
    yxOrderVc.childStandard=self.traveModel.child_standard;
    yxOrderVc.departureDate=[model toString];
    yxOrderVc.remanentPeople=remanentPeople;
    DLog(@"%@",yxOrderVc.remanentPeople);
    yxOrderVc.isTrave=YES;
    yxOrderVc.isRealTrave=YES;
    yxOrderVc.traveModel = self.traveModel;
        
        
    yxOrderVc.adult_price=self.adult_price;
    yxOrderVc.child_price=self.child_price;
        
        
    yxOrderVc.orderSource = self.orderSource;
    yxOrderVc.store_id = self.store_id;
    yxOrderVc.pay_way=self.pay_way;
    [self.navigationController pushViewController:yxOrderVc animated:YES];
//    }else{
//        [[LXAlterView sharedMyTools]createTishi:@"您选择的日期没有余位"];
//    }

}

#pragma mark - 获取参数当天余位
-(int)getRadBit:(CalendarDayModel *)model
{
    NSString *remanentPeople=@"";
    if ([_customTraveDateModelArray containsObject:[model toString]])
    {
        for (LXCustomTraveModel *model1 in _customTraveModelArray)
        {
            if ([model1.date_time isEqualToString:[model toString]])
            {
                if ([self judgeString:model1.members]&&[self judgeString:model1.order_members]) {
                    remanentPeople=[NSString stringWithFormat:@"%ld",[model1.members integerValue]-[model1.order_members integerValue]];
                }
                else
                {
                    remanentPeople=model1.members;
                }
            }
        }
    }
    else
    {
        remanentPeople=self.traveModel.timetable_people;
    }
    return [remanentPeople intValue];
}


-(void)bottomViewShow:(CalendarDayModel *)model
{
    [UIView animateWithDuration:0.3 animations:^{
        _isShow=YES;
        _bottomView.frame=CGRectMake(0, windowContentHeight-300-NAVBarH, windowContentWidth, 300);
        _topBtnInBottom.frame=CGRectMake(windowContentWidth-45, ViewY(_bottomView)-25, 50, 25);
        
        _bttomImage.frame=CGRectMake(windowContentWidth-30, ViewY(_bottomView)-15, 20, 10);
        _bttomImage.image=[UIImage imageNamed:@"icon_calendar_down.png"];
        
        _showNumberLab.frame=CGRectMake(20, 0, ViewWidth(_showView)-30, 20);
        if (_isHaveChildPrice==YES)
        {
            _showNumberLab.text=[NSString stringWithFormat:@"%@成人  %@儿童",_adultLab.text,_childrenLab.text];
        }else
        {
            _showNumberLab.text=[NSString stringWithFormat:@"%@成人",_adultLab.text];
        }
        
        _showDateLab.alpha=1;
        _showDateLab.text=[NSString stringWithFormat:@"已选团期：%@",[model toString]];
        
        _chooseDate=[model toString];
        
        if (!_maskView) {
            _maskView=[[UIView alloc] init];
            _maskView.frame=CGRectMake(0, 0, windowContentWidth, windowContentHeight-300-NAVBarH);
            _maskView.backgroundColor=[UIColor clearColor];
            [self.view addSubview:_maskView];
            
            
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewClick)];
            [_maskView addGestureRecognizer:tap];
        }
        
        
    } completion:^(BOOL finished) {
        
        
        
        
    }];
}

-(void)maskViewClick
{
    _isShow=NO;
    [UIView animateWithDuration:0.3 animations:^{
        if (_isHaveChildPrice==YES)
        {
            _bottomView.frame=CGRectMake(0, windowContentHeight-BottomHeight_haveChildPrice-NAVBarH, windowContentWidth, BottomHeight_haveChildPrice);
        }else
        {
            _bottomView.frame=CGRectMake(0, windowContentHeight-BottomHeight-NAVBarH, windowContentWidth, BottomHeight);
        }
        
        _topBtnInBottom.frame=CGRectMake(windowContentWidth-45, ViewY(_bottomView)-25, 50, 25);
        _bttomImage.frame=CGRectMake(windowContentWidth-30, ViewY(_bottomView)-15, 20, 10);
        _bttomImage.image=[UIImage imageNamed:@"icon_calendar_up.png"];
        
        [_maskView removeFromSuperview];
        _maskView=nil;
    } completion:^(BOOL finished) {
        
        
    }];
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

#pragma mark - 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

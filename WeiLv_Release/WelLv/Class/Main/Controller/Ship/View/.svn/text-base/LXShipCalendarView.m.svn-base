//
//  LXShipCalendarView.m
//  WelLv
//
//  Created by 刘鑫 on 15/5/21.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
#define WEILVColor [UIColor colorWithRed:251/255.f green:131/255.f blue:10/255.f alpha:1.0]
#define BottomHeight 120
#define NAVBarH 60
#define CalendarViewHeight 6*60+65
#import "LXShipCalendarView.h"
//UI
#import "CalendarMonthCollectionViewLayout.h"
#import "ShipCalendarMonthCollectionViewLayout.h"
#import "CalendarMonthHeaderView.h"
#import "CalendarDayCell.h"
#import "ShipCalendarDayCell.h"
//MODEL
#import "CalendarDayModel.h"

#import "YXOrderViewController.h"
#import "LXShipCalendarModel.h"
#import "LXShipProductModel.h"

#import "LXGetCityIDTool.h"

@implementation LXShipCalendarView


static NSString *MonthHeader = @"MonthHeaderView";

static NSString *DayCell = @"DayCell";


- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self initData];
    }
    return self;
}


#pragma mark -- 获取日历model
-(NSInteger)getShipCalendarArray:(NSMutableArray *)array
{
    self.shipCalendarModelArray=[[NSMutableArray alloc] initWithCapacity:0];
    self.shipCalendarArray=[[NSMutableArray alloc] initWithCapacity:0];
    self.shipCalendarModelArray=array;
    for (LXShipCalendarModel *model in self.shipCalendarModelArray)
    {
        
        [self.shipCalendarArray addObject:model.ymd];
        
    }
    self.shipCalendarArray = [NSMutableArray arrayWithArray:[self.shipCalendarArray sortedArrayUsingSelector:@selector(compare:)]];

    //DLog(@"----%@,-----%@",self.shipCalendarArray[0], self.shipCalendarArray[1]);
    
    if (array==nil || array.count==0)
    {
        [self setTrainToDay:100 ToDateforString:nil price:-2 beginDate:[_getModel toString]];
    }else
    {
       
        [self setTrainToDay:100 ToDateforString:nil price:-2 beginDate:[self.shipCalendarArray objectAtIndex:0]];
        
    }
    
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
    

    //NSLog(@"qqq===%lu个月",self.calendarMonth.count);
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
    
    self.Logic = [[CalendarLogic alloc]init];
    
    return [self.Logic reloadCalendarView:date selectDate:selectdate  needDays:day customDateArray:nil];
}


- (void)initView
{
    
    collectheight =CalendarViewHeight;
    if (cellNumber == 35)
    {
        collectheight=CalendarViewHeight-60;
    }else if (cellNumber== 42)
    {
        collectheight=CalendarViewHeight;
    }
    
    if (!self.collectionView)
    {
        ShipCalendarMonthCollectionViewLayout *layout = [ShipCalendarMonthCollectionViewLayout new];
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, collectheight)collectionViewLayout:layout]; //初始化网格视图大小
        
        [self.collectionView registerClass:[ShipCalendarDayCell class] forCellWithReuseIdentifier:DayCell];//cell重用设置ID
        
        [self.collectionView registerClass:[CalendarMonthHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader];
        
        self.collectionView.bounces = NO;//将网格视图的下拉效果关闭
        
        self.collectionView.delegate = self;//实现网格视图的delegate
        
        self.collectionView.dataSource = self;//实现网格视图的dataSource
        
        self.collectionView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.collectionView];
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0, 5, 130, 40);
        //[btn setBackgroundImage:[UIImage imageNamed:@"邮轮日历向左箭头.png"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"左不可选中"] forState:UIControlStateNormal];
        btn.tag=1;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame=CGRectMake(windowContentWidth-130, 5, 130, 40);
        //[btn1 setBackgroundImage:[UIImage imageNamed:@"邮轮日历向右箭头.png"] forState:UIControlStateNormal];
        [btn1 setImage:[UIImage imageNamed:@"右"] forState:UIControlStateNormal];
        btn1.tag=2;
        [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn1];

    }
    
    self.collectionView.frame=CGRectMake(0, 0, windowContentWidth, collectheight);
    if (_isShow==YES)
    {
        allCollectHeight=collectheight+self.shipProductArray.count*50+20;
        //[self createShipProductList];
        DLog(@"日历高度==%f",collectheight);
//        for (int i=0; i<self.shipProductArray.count; i++)
//        {
//            
//            if (i==self.shipProductArray.count-1)
//            {
//                DLog(@"mmmmm====%f",ViewY(_productView));
//                UIView *view=(UIView *)[self viewWithTag:1000+i];
//                view.frame=CGRectMake(0, collectheight+50*i, windowContentWidth, 70);
//            }else
//            {
//                _productView.frame=CGRectMake(0, collectheight+50*i, windowContentWidth, 50);
//                
//            }
//            
//        }
        _productView.frame=CGRectMake(0, collectheight, windowContentWidth, 50*self.shipProductArray.count+20);
    }else
    {
        DLog(@"111日历高度==%f",collectheight);
        allCollectHeight=collectheight;
       
    }
    
    if (self.calendarViewHeight)
    {
        self.calendarViewHeight(allCollectHeight);
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
            
            if ((_showMonth>_currentMonth && _showYear==_currentYear) ||
                (_showYear>_currentYear))
            {
                _showMonth--;
                if (_showMonth<1)
                {
                    _showMonth=12;
                    _showYear--;
                }
                
                [self setTrainToDay:100 ToDateforString:nil price:-2 beginDate:[NSString stringWithFormat:@"%d-%d-1",_showYear,_showMonth]];
            }
            //[self.collectionView reloadData];
        }
            break;
            
        case 2:
        {
            UIButton * btn1 = [self viewWithTag:1];
            [btn1 setImage:[UIImage imageNamed:@"右"] forState:UIControlStateNormal];
            btn1.transform = CGAffineTransformMakeRotation(M_PI);

            _showMonth++;
            if (_showMonth>12)
            {
                _showMonth=1;
                _showYear++;
            }
            
            [self setTrainToDay:100 ToDateforString:nil price:-2 beginDate:[NSString stringWithFormat:@"%d-%d-1",_showYear,_showMonth]];
            //[self.collectionView reloadData];
        }
            break;
            
        default:
            break;
    }
    
    if (_isShow == YES) {
        [self upBtnClick:nil];
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
    NSLog(@"date:%@",detaildate);
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

-(void)initData{
    
    self.calendarMonth = [[NSMutableArray alloc]init];//每个月份的数组
    
    self.assignArray=[[NSMutableArray alloc] initWithCapacity:0];
    self.shipProductArray=[[NSMutableArray alloc] initWithCapacity:0];
    _getModel=[self getTodayModel];
    
    _currentMonth=[[[[_getModel toString] componentsSeparatedByString:@"-"] objectAtIndex:1] intValue];
    _currentYear=[[[[_getModel toString] componentsSeparatedByString:@"-"] objectAtIndex:0] intValue];
    _showYear=_currentYear;
    _showMonth=_currentMonth;
    DLog(@"--------%@",[_getModel toString]);
    //[self setTrainToDay:100 ToDateforString:nil price:-2 beginDate:[NSString stringWithFormat:@"%d-%d-1",_showYear,_showMonth]];
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
    NSLog(@"monthArray=%lu,=%ld",monthArray.count,(long)section);
//    if (monthArray.count==35)
//    {
//        self.collectionView.frame=CGRectMake(0, 0, windowContentWidth, CalendarViewHeight);
//    }else
//    {
//        
//    }
    return monthArray.count;
}


//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShipCalendarDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DayCell forIndexPath:indexPath];
    
    NSMutableArray *monthArray = [self.calendarMonth objectAtIndex:indexPath.section];
    
    
    CalendarDayModel *model = [monthArray objectAtIndex:indexPath.row];
    
    
    if ([_getModel isEqualTo:model]==YES && indexPath.section==0)
    {
        DLog(@"------%ld",indexPath.row);
        //cell.userInteractionEnabled=NO;
        model.price=[NSString stringWithFormat:@"%d",-1];
        
    }
    
    if ([self.shipCalendarArray containsObject:[model toString]])
    {
        for (LXShipCalendarModel *model1 in self.shipCalendarModelArray)
        {
            if ([model1.ymd isEqualToString:[model toString]])
            {
                DLog(@"=-=-===%@,价格=%@",[model toString],model1.min_price);
                model.price=[NSString stringWithFormat:@"￥%@",model1.min_price];
                
            }
        }
        
    }
    else
    {
        //cell.userInteractionEnabled=NO;
        model.price=[NSString stringWithFormat:@"%d",-2];
        
    }
    
    cell.model=model;
    
    CalendarDayModel * todayModel = [self getTodayModel];
    if (model.year <= todayModel.year && model.month <= todayModel.month && model.day < todayModel.day) {
        cell.day_lab.textColor = [UIColor grayColor];
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
    //NSLog(@"index1=%lu",indexPath.row);
    NSMutableArray *month_Array = [self.calendarMonth objectAtIndex:indexPath.section];
    CalendarDayModel *model = [month_Array objectAtIndex:indexPath.row];
    
    CalendarDayModel * todayModel = [self getTodayModel];
    if (model.year <= todayModel.year && model.month <= todayModel.month && model.day <= todayModel.day) {
        return;
    }
    if (model.style == CellDayTypeFutur || model.style == CellDayTypeWeek ||model.style == CellDayTypeClick) {
        
        [self.Logic selectLogic:model];
        [self clickDay:model];
        //        if (self.calendarblock) {
        //
        //            self.calendarblock(model);//传递数组给上级
        //
        //            //timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
        //            //[self onTimer];
        //        }
        [self.collectionView reloadData];
    }
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"index=%lu",indexPath.row);
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
    NSLog(@"1星期 %@",[model getWeek]);
    NSLog(@"2字符串 %@",[model toString]);
    NSLog(@"3节日  %@",model.price);
    
    if ([model.price intValue]!=-2)
    {
        //有邮轮
        NSString *shijianchuo=[self  getDateShiJianChuo:[self getDateWithStr:[model toString]]];
        DLog(@"时间戳=%@",shijianchuo);
        [self sendRequestWithShijianchuo:shijianchuo];
        
    }
    
}

#pragma mark --- 请求邮轮日历产品
- (void)sendRequestWithShijianchuo:(NSString *)shijianchuo
{
    
    if (self.shipProductArray.count>0)
    {
        [_productView removeFromSuperview];
        [self.shipProductArray removeAllObjects];
    }
    NSString * str= [NSString stringWithFormat:@"%@?date=%@&city_id=%@", M_URL_SHIP_CALENDAR,shijianchuo, [[WLSingletonClass defaultWLSingleton] wlCityId]];
    NSLog(@"%@", str);
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        DLog(@"获取到的数据为：%@",dict);
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        if ([dict isKindOfClass:[NSArray class]]) {
            for (NSDictionary * dic in dict) {
                LXShipProductModel * model = [[LXShipProductModel alloc] initWithDictionary:dic];
                [self.shipProductArray addObject:model];
            }
            
            
            [self createShipProductList];
        }
       
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

#pragma mark -- 创建产品列表
-(void)createShipProductList
{
    _isShow=YES;
    allCollectHeight=collectheight+50*self.shipProductArray.count+20;
    
    _productView=[[UIView alloc] init];
    _productView.frame=CGRectMake(0, collectheight, windowContentWidth, 50*self.shipProductArray.count+20);
    _productView.backgroundColor=[UIColor whiteColor];
    _productView.hidden=NO;
    //_productView.tag=1000+i;
    _productView.userInteractionEnabled=YES;
    [self addSubview:_productView];
    
    for (int i=0; i<self.shipProductArray.count; i++)
    {
        LXShipProductModel *model=[self.shipProductArray objectAtIndex:i];
        
        UIView * productView1=[[UIView alloc] init];
        productView1.frame=CGRectMake(0, 50*i, windowContentWidth, 50);
        productView1.backgroundColor=[UIColor whiteColor];
        productView1.hidden=NO;
        //productView1.tag=1000+i;
        productView1.userInteractionEnabled=YES;
        [_productView addSubview:productView1];
        
        line=[[UIView alloc] initWithFrame:CGRectMake(0, 49.5, ViewWidth(productView1), 0.5)];
        line.backgroundColor=[UIColor grayColor];
        [productView1 addSubview:line];
        
        nameLab=[[UILabel alloc] init];
        nameLab.frame=CGRectMake(20, 10, windowContentWidth-180, 30);
        nameLab.text=model.product_name;
        nameLab.font=[UIFont systemFontOfSize:14];
        nameLab.textColor=[UIColor greenColor];
        [productView1 addSubview:nameLab];
        
        priceLab=[[UILabel alloc] init];
        priceLab.frame=CGRectMake(ViewX(nameLab)+ViewWidth(nameLab), 10, 100, 30);
        priceLab.attributedText = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=color:#FF9900;font-size:16px;>￥%@</span><span style=color:#999999;>起</span>", model.min_price] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        priceLab.adjustsFontSizeToFitWidth = YES;
        [productView1 addSubview:priceLab];
        
        //预订
        bookBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        bookBtn.frame=CGRectMake(ViewX(priceLab)+ViewWidth(priceLab), 10, 50, 30);
        bookBtn.backgroundColor=kColor(34, 184, 33);
        [bookBtn setTitle:@"预订" forState:UIControlStateNormal];
        [bookBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        bookBtn.layer.cornerRadius=2;
        bookBtn.tag=i+1;
        [bookBtn addTarget:self action:@selector(bookBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [productView1 addSubview:bookBtn];
        
        if (i==self.shipProductArray.count-1)
        {
            productView1.frame=CGRectMake(0, 50*i, windowContentWidth, 70);
            
            gone_upImage=[[UIImageView alloc] initWithFrame:CGRectMake((windowContentWidth-72)/2, 55, 72, 9)];
            gone_upImage.image=[UIImage imageNamed:@"icon_gone_up"];
            gone_upImage.userInteractionEnabled=YES;
            [productView1 addSubview:gone_upImage];
            
            gone_upBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            gone_upBtn.frame=CGRectMake(0, 50, ViewWidth(productView1), 20);
            [gone_upBtn addTarget:self action:@selector(upBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [productView1 addSubview:gone_upBtn];
            
        }
        
        
    }

    
    if (self.calendarViewHeight)
    {
        self.calendarViewHeight(allCollectHeight);
    }
    
}

-(void)upBtnClick:(UIButton *)btn
{
    allCollectHeight=collectheight;
//    for (int i=0; i<self.shipProductArray.count; i++) {
//        UIView *view=[self viewWithTag:i+1000];
//        [view removeFromSuperview];
//    }
    [_productView removeFromSuperview];
    _isShow=NO;
    if (self.calendarViewHeight)
    {
        self.calendarViewHeight(allCollectHeight);
    }
}

-(void)bookBtnClick:(UIButton *)btn
{
    LXShipProductModel *model=[self.shipProductArray objectAtIndex:btn.tag-1];
    if (self.blockProduct_id)
    {
        self.blockProduct_id(model.product_id);
    }
}

#pragma mark--今天的日期
-(CalendarDayModel *)getTodayModel
{
    NSDate *todate = [NSDate date];//今天
    //    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    //    NSDateComponents *comps_today= [calendar components:(NSYearCalendarUnit |
    //                                                         NSMonthCalendarUnit |
    //                                                         NSDayCalendarUnit |
    //                                                         NSWeekdayCalendarUnit) fromDate:todate];
    
    NSString *date=[todate stringFromDate:todate];
    NSArray *array = [date componentsSeparatedByString:@"-"];
    
    CalendarDayModel *model=[[CalendarDayModel alloc] init];
    model.year=[[array objectAtIndex:0] integerValue];
    model.month=[[array objectAtIndex:1] integerValue];
    model.day=[[array objectAtIndex:2] integerValue];
    
    return model;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

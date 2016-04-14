//
//  LXPlaneCalendarViewController.m
//  WelLv
//
//  Created by liuxin on 15/9/8.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
#define WEILVColor [UIColor colorWithRed:251/255.f green:131/255.f blue:10/255.f alpha:1.0]
#define BottomHeight 120
#define NAVBarH 60

#import "LXPlaneCalendarViewController.h"

//UI
#import "CalendarMonthCollectionViewLayout.h"
#import "CalendarMonthHeaderView.h"
#import "CalendarDayCell.h"
//MODEL
#import "CalendarDayModel.h"

#import "YXOrderViewController.h"

@interface LXPlaneCalendarViewController ()
<UICollectionViewDataSource,UICollectionViewDelegate,UITextViewDelegate>
{
    
    int daynumber;//天数
    int optiondaynumber;//选择日期数量
    NSTimer* timer;//定时器
    int _price;
    CalendarDayModel *_getModel;
    UIView *_bottomView;
    UIButton *_topBtnInBottom;
    UIView *_maskView;
    
    UILabel *_adultLab;//成人数
    UILabel *_childrenLab;//儿童数
    
    UILabel *_showNumberLab;//底部显示已选人数
    UILabel *_showDateLab;//底部显示已选日期
    
    UIView *_showView;
    BOOL _isChooseDate;//是否已选择日期
    BOOL _isShow;//底部UI是否已经弹出
    NSString *_chooseDate;//已经选择的日期
    
    UIButton *_nextBtn;
    
    UIImageView *_bttomImage;
    
}

@end

@implementation LXPlaneCalendarViewController
static NSString *MonthHeader = @"MonthHeaderView";

static NSString *DayCell = @"DayCell";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [self initData];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"选择团期和人数";
    self.view.backgroundColor=[UIColor whiteColor];
    
    
}
- (void)setTrainToDay:(int)day ToDateforString:(NSString *)todate price:(int)aPrice
{
    daynumber = day;
    optiondaynumber = 2;//选择两个后返回数据对象
    self.calendarMonth = [self getMonthArrayOfDayNumber:daynumber ToDateforString:todate];
    //    for (int i=0; i<10; i++)
    //    {
    //        CalendarDayModel *model=[[CalendarDayModel alloc] init];
    //        model.year=2015;
    //        model.month=04;
    //        model.day=9+i;
    //        model.price=100+i;
    //        [self.assignArray addObject:model];
    //    }
    _price=aPrice;
    [self initView];
    NSLog(@"qqq===%lu个月",self.calendarMonth.count);
    [self.collectionView reloadData];//刷新
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
    
    self.Logic = [[LXPlaneCalendarLogic alloc]init];
    
    return [self.Logic reloadCalendarView:date selectDate:selectdate  needDays:day customDateArray:nil];
}


- (void)initView{
    
    
    [self setTitle:@"选择日期"];
    
    CalendarMonthCollectionViewLayout *layout = [CalendarMonthCollectionViewLayout new];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64)collectionViewLayout:layout]; //初始化网格视图大小
    
    [self.collectionView registerClass:[CalendarDayCell class] forCellWithReuseIdentifier:DayCell];//cell重用设置ID
    
    [self.collectionView registerClass:[CalendarMonthHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader];
    
    //    self.collectionView.bounces = NO;//将网格视图的下拉效果关闭
    
    self.collectionView.delegate = self;//实现网格视图的delegate
    
    self.collectionView.dataSource = self;//实现网格视图的dataSource
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    
    
    //
    //    _bottomView= [[UIView alloc] initWithFrame:CGRectMake(0, windowContentHeight-BottomHeight-NAVBarH, windowContentWidth, BottomHeight)];
    //    _bottomView.backgroundColor=[UIColor colorWithWhite:0.1 alpha:0.9];
    //    [self.view addSubview:_bottomView];
    //
    //
    //    //底部右上角按钮
    //    _topBtnInBottom=[UIButton buttonWithType:UIButtonTypeCustom];
    //    _topBtnInBottom.frame=CGRectMake(windowContentWidth-45, ViewY(_bottomView)-25, 50, 25);
    //    _topBtnInBottom.backgroundColor=[UIColor colorWithWhite:0.1 alpha:0.9];
    //    [_topBtnInBottom addTarget:self action:@selector(cutOrAdd:) forControlEvents:UIControlEventTouchUpInside];
    //    _topBtnInBottom.tag=6;
    //    //[_topBtnInBottom setBackgroundImage:[UIImage imageNamed:@"icon_calendar_up.png"] forState:UIControlStateNormal];
    //    //[_topBtnInBottom  setImage:[UIImage imageNamed:@"icon_calendar_up.png"] forState:UIControlStateNormal];
    //    [self.view addSubview:_topBtnInBottom];
    //
    //    _bttomImage=[[UIImageView alloc] init];
    //    _bttomImage.frame=CGRectMake(windowContentWidth-30, ViewY(_bottomView)-15, 20, 10);
    //    _bttomImage.image=[UIImage imageNamed:@"icon_calendar_up.png"];
    //    [self.view addSubview:_bttomImage];
    //
    //
    //    //指定view的左上角为圆角
    //    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_topBtnInBottom.bounds byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(5, 5)];
    //    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //    maskLayer.frame = _topBtnInBottom.bounds;
    //    maskLayer.path = maskPath.CGPath;
    //    _topBtnInBottom.layer.mask = maskLayer;
    //
    //    //选择人数按钮
    //    [self chooseNumberAndInfo];
    //
    //    //底部UI
    //    _showView=[[UIView alloc] initWithFrame:CGRectMake(0, windowContentHeight-50-NAVBarH, windowContentWidth*2/3, 50)];
    //    _showView.backgroundColor= kColor(254, 204, 65);
    //    [self.view addSubview:_showView];
    //
    //    _nextBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //    _nextBtn.frame=CGRectMake(ViewWidth(_showView), ViewY(_showView), windowContentWidth/3, 50);
    //    _nextBtn.backgroundColor=[UIColor grayColor];
    //    _nextBtn.tag=5;
    //    [_nextBtn addTarget:self action:@selector(cutOrAdd:) forControlEvents:UIControlEventTouchUpInside];
    //    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    //    [self.view addSubview:_nextBtn];
    //
    //    _showNumberLab=[[UILabel alloc] initWithFrame:CGRectMake(20, (ViewHeight(_showView)-20)/2, ViewWidth(_showView)-30, 20)];
    //    _showNumberLab.font=[UIFont systemFontOfSize:14];
    //    _showNumberLab.textColor=[UIColor whiteColor];
    //    _showNumberLab.text=@"请选择团期和人数";
    //    [_showView addSubview:_showNumberLab];
    //
    //    _showDateLab=[[UILabel alloc] init];
    //    _showDateLab.frame=CGRectMake(20, 20, ViewWidth(_showView)-30, 20);
    //    _showDateLab.font=[UIFont systemFontOfSize:14];
    //    _showDateLab.textColor=[UIColor whiteColor];
    //    _showDateLab.alpha=0;
    //    [_showView addSubview:_showDateLab];
    
    
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
    
    UILabel *childrenLab1=[[UILabel alloc] initWithFrame:CGRectMake(ViewX(_childrenLab)+ViewWidth(_childrenLab)+4, 10, 50, labHeight)];
    childrenLab1.text=@"儿童";
    childrenLab1.textColor=[UIColor whiteColor];
    childrenLab1.font=[UIFont systemFontOfSize:15];
    [_bottomView addSubview:childrenLab1];
    
    
    //int totalPrice =([_adultLab.text intValue]+[_childrenLab.text intValue])*_price;
    //简介
    UILabel  *priceLabel=[[UILabel alloc] initWithFrame:CGRectMake(ViewX(_adultLab), ViewHeight(_adultLab)+20, windowContentWidth-ViewX(_adultLab)*2, 20)];
    priceLabel.font=[UIFont systemFontOfSize:14];
    priceLabel.textColor=[UIColor whiteColor];
    priceLabel.text=[NSString stringWithFormat:@"价格：%d元/人（儿童标准：0-12周岁）",_price];
    [_bottomView addSubview:priceLabel];
    
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(ViewX(_adultLab), ViewHeight(priceLabel)+60, windowContentWidth-ViewX(_adultLab)*2, 1)];
    line.backgroundColor=[UIColor whiteColor];
    [_bottomView addSubview:line];
    
    UITextView *infoTextV=[[UITextView alloc] initWithFrame:CGRectMake(15, ViewY(line), windowContentWidth-40, 160)];
    infoTextV.text=@"如何预订：\n1.选择出游日期和出游人数\n2.填写您的姓名和手机号，申请人信息，提交订单\n3.等待微旅客服与您联系，递交审核材料\n4.网上付款或前往当地门市付款，等待出签";
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
    NSLog(@"dddd");
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
                //总价
                int totalPrice=([_adultLab.text intValue]+[_childrenLab.text intValue])*_price;
                
                YXOrderViewController *yxOrderVc=[[YXOrderViewController alloc] init];
                yxOrderVc.visaRegion=self.visaModel.product_name;
                yxOrderVc.totalPrice=[NSString stringWithFormat:@"%d",totalPrice];
                yxOrderVc.departureDate=_chooseDate;
                yxOrderVc.adultNumber=_adultLab.text;
                yxOrderVc.childrenNumber=_childrenLab.text;
                yxOrderVc.visaModel = self.visaModel;
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
                    //[_topBtnInBottom setBackgroundImage:[UIImage imageNamed:@"icon_calendar_down.png"] forState:UIControlStateNormal];
                    //[_topBtnInBottom  setImage:[UIImage imageNamed:@"icon_calendar_down.png"] forState:UIControlStateNormal];
                    
                    _bttomImage.frame=CGRectMake(windowContentWidth-30, ViewY(_bottomView)-15, 20, 10);
                    _bttomImage.image=[UIImage imageNamed:@"icon_calendar_down.png"];
                    
                    _showNumberLab.frame=CGRectMake(20, 0, ViewWidth(_showView)-30, 20);
                    _showNumberLab.text=[NSString stringWithFormat:@"%@成人  %@儿童",_adultLab.text,_childrenLab.text];
                    
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
        _showNumberLab.text=[NSString stringWithFormat:@"%@成人  %@儿童",_adultLab.text,_childrenLab.text];
    }
}


-(void)initData{
    
    self.calendarMonth = [[NSMutableArray alloc]init];//每个月份的数组
    
    self.assignArray=[[NSMutableArray alloc] initWithCapacity:0];
    
    _getModel=[self getTodayModel];
    
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
    //NSLog(@"monthArray=%lu",monthArray.count);
    return monthArray.count;
}


//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DayCell forIndexPath:indexPath];
    
    NSMutableArray *monthArray = [self.calendarMonth objectAtIndex:indexPath.section];
    
    
    CalendarDayModel *model = [monthArray objectAtIndex:indexPath.row];
    
    
    
    if ([_getModel isEqualTo:model]==YES)
    {
        
        //cell.userInteractionEnabled=YES;
        model.price=[NSString stringWithFormat:@"%d",-1];
        
    }
    else
    {
        model.price=[NSString stringWithFormat:@"%d",-2];
        
    }
    
    
    //    for (CalendarDayModel *model2 in self.assignArray)
    //    {
    //
    //
    //        if ([model2 isEqualTo:model]==YES)
    //        {
    //            model.price=model2.price;
    //            //cell.model.price=model2.price;
    //            //NSLog(@"price=%d",model2.price);
    //            //NSLog(@"指定日期=%lu-%lu-%lu,%lu-%lu-%lu",model.year,model.month,model.day,model2.year,model2.month,(unsigned long)model2.day);
    //            cell.userInteractionEnabled=YES;
    //
    //
    //            break;
    //        }
    //        else
    //        {
    //            cell.userInteractionEnabled=NO;
    //
    //        }
    //
    //
    //    }
    
    
    
    cell.model=model;
    
    
    
    
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



//定时器方法
- (void)onTimer{
    
    //[timer invalidate];//定时器无效
    
    //timer = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark--获取点击日期和价格
-(void)clickDay:(CalendarDayModel *)model
{
    _nextBtn.backgroundColor=WEILVColor;
    _isChooseDate=YES;
    NSLog(@"1星期 %@",[model getWeek]);
    NSLog(@"2字符串 %@",[model toString]);
    NSLog(@"3节日  %@",model.price);
    //    [UIView animateWithDuration:0.3 animations:^{
    //        _isShow=YES;
    //        _bottomView.frame=CGRectMake(0, windowContentHeight-300-NAVBarH, windowContentWidth, 300);
    //        _topBtnInBottom.frame=CGRectMake(windowContentWidth-45, ViewY(_bottomView)-25, 50, 25);
    //        //[_topBtnInBottom setBackgroundImage:[UIImage imageNamed:@"icon_calendar_down.png"] forState:UIControlStateNormal];
    //        //[_topBtnInBottom  setImage:[UIImage imageNamed:@"icon_calendar_down.png"] forState:UIControlStateNormal];
    //
    //        _bttomImage.frame=CGRectMake(windowContentWidth-30, ViewY(_bottomView)-15, 20, 10);
    //        _bttomImage.image=[UIImage imageNamed:@"icon_calendar_down.png"];
    //
    //        _showNumberLab.frame=CGRectMake(20, 0, ViewWidth(_showView)-30, 20);
    //        _showNumberLab.text=[NSString stringWithFormat:@"%@成人  %@儿童",_adultLab.text,_childrenLab.text];
    //
    //        _showDateLab.alpha=1;
    //        _showDateLab.text=[NSString stringWithFormat:@"已选团期：%@",[model toString]];
    //
    //        _chooseDate=[model toString];
    //
    //
    //    } completion:^(BOOL finished) {
    //
    //
    //        _maskView=[[UIView alloc] init];
    //        _maskView.frame=CGRectMake(0, 0, windowContentWidth, windowContentHeight-300-NAVBarH);
    //        _maskView.backgroundColor=[UIColor clearColor];
    //        [self.view addSubview:_maskView];
    //
    //
    //        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewClick)];
    //        [_maskView addGestureRecognizer:tap];
    //
    //    }];
    
            if (self.calendarblock) {
    
                self.calendarblock(model);//传递数组给上级
            }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)maskViewClick
{
    _isShow=NO;
    [UIView animateWithDuration:0.3 animations:^{
        _bottomView.frame=CGRectMake(0, windowContentHeight-BottomHeight-NAVBarH, windowContentWidth, BottomHeight);
        _topBtnInBottom.frame=CGRectMake(windowContentWidth-45, ViewY(_bottomView)-25, 50, 25);
        //[_topBtnInBottom setBackgroundImage:[UIImage imageNamed:@"icon_calendar_up.png"] forState:UIControlStateNormal];
        //[_topBtnInBottom  setImage:[UIImage imageNamed:@"icon_calendar_up.png"] forState:UIControlStateNormal];
        _bttomImage.frame=CGRectMake(windowContentWidth-30, ViewY(_bottomView)-15, 20, 10);
        _bttomImage.image=[UIImage imageNamed:@"icon_calendar_up.png"];
        
    } completion:^(BOOL finished) {
        [_maskView removeFromSuperview];
        _maskView=nil;
    }];
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
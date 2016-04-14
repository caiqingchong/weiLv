//
//  TraveCalendarViewController.m
//  WelLv
//
//  Created by 刘鑫 on 15/4/24.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
#define WEILVColor [UIColor colorWithRed:251/255.f green:131/255.f blue:10/255.f alpha:1.0]

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

//底部视图高度
#define kBottomViewHeight kScreenHeight/(kScreenHeight/194)

#import "TravelChangeTravellerNumberView.h"
#import "TravelAllHeader.h"

//#define BottomHeight 120
#define BottomHeight_haveChildPrice 140
#define NAVBarH 60
#define LeaveWeek @"week"
#define LeaveDay  @"day"
#define LeaveWeekend @"weekend"
#define LeaveEveryDay @"everyday"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define CATDayLabelWidth  [UIScreen mainScreen].bounds.size.width/7
#define CATDayLabelHeight 15.0f
#define kHeaderBackViewHeight 25.0f
#define kTitleDistance 10.0f

#import "TraveCalendarViewController.h"
//UI
#import "TravelCalendarMonthCollectionViewLayout.h"
#import "TravelCollectionReusableView.h"
#import "TravelCalendarDayCell.h"

//MODEL
#import "CalendarDayModel.h"

#import "YXOrderViewController.h"
#import "LXCustomTraveModel.h"

#import "TravelChangeCountView.h"
#import "ChangeCountView.h"

//团期model
#import "TravelLoopDateModel.h"
#import "TravelChangeTravellerNumberView.h"
#import "TravelOrderDetailModel.h"

#import "AddCostTravelView.h"


@interface TraveCalendarViewController ()
<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextViewDelegate>
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
    //成人数
    NSInteger adultCount;
    //儿童数
    NSInteger childCount;
    //出团时间
    NSString *leaveTime;
    //剩余人数
    NSInteger surplusCount;
    //底部视图高度
    NSInteger bottomHeight;
    //儿童说明出现
    BOOL isActionOpen;
    //儿童说明弹出框高度
    CGFloat childActionLabelHeight;
    //儿童说明X
    NSInteger childActionLabelX;
    //儿童说明Y
    NSInteger childActionLabelY;
    //儿童说明文字大小
    NSInteger childActionTitleSize;
    //儿童说明无
    NSInteger childActionDetailNoneY;
    //出团时间
    NSString *dateStr;
    //尖X
    NSInteger tipX;
    //尖Y
    NSInteger tipY;
    //尖宽
    NSInteger tipWidth;
    //尖高
    NSInteger tipHeight;
    //滚动视图高度
    NSInteger collectionViewHeigh;
    
}
@property (nonatomic, strong) NSMutableDictionary * canReserveDayDic;

@property (nonatomic, strong) UILabel *actionLabel;

@property (nonatomic, strong) TravelChangeTravellerNumberView *bottomNumberView;

@property (nonatomic, strong) AddCostTravelView *addCostView;

//成人数
@property (nonatomic, strong) NSString *adultNumber;
//儿童数
@property (nonatomic, strong) NSString *childNumber;
//成人价格
@property (nonatomic, strong) NSString *adultPrice;
//儿童价格
@property (nonatomic, strong) NSString *childPriceNew;
//余位人数
@property (nonatomic, assign) NSInteger costNumber;
//团期日期数组
@property (nonatomic, strong) NSMutableArray *loopDateArray;
//儿童说明消失所需
@property (nonatomic, strong) UIView *actionBackView;
//儿童说明尖
@property (nonatomic, strong) UIImageView *tipImageView;
//第二跳黑线
@property (nonatomic, strong) UIView *secondBlackView;
//余位
@property (nonatomic, strong) UILabel *costCountLabel;

//轻拍手势
@property (nonatomic, strong) UITapGestureRecognizer *tapAllView;


@property (weak, nonatomic) UILabel *day1OfTheWeekLabel;
@property (weak, nonatomic) UILabel *day2OfTheWeekLabel;
@property (weak, nonatomic) UILabel *day3OfTheWeekLabel;
@property (weak, nonatomic) UILabel *day4OfTheWeekLabel;
@property (weak, nonatomic) UILabel *day5OfTheWeekLabel;
@property (weak, nonatomic) UILabel *day6OfTheWeekLabel;
@property (weak, nonatomic) UILabel *day7OfTheWeekLabel;

@property (nonatomic, strong) UIView *headerBackView;


@end

@implementation TraveCalendarViewController

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
    
    isActionOpen = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"选择团期和人数";
    self.view.backgroundColor=[UIColor whiteColor];
    
    //判断底部视图高度,并根据高度调节collectionView高度
    if (kScreenHeight == 480 || kScreenHeight == 568) {
        bottomHeight = 200;
        collectionViewHeigh = 200;
        childActionTitleSize = 14;
    } else if (kScreenHeight == 667) {
        bottomHeight = 224;
        collectionViewHeigh = 230;
        childActionTitleSize = 14;
    } else if (kScreenHeight == 736) {
        bottomHeight = 224;
        collectionViewHeigh = 230;
        childActionTitleSize = 15;
    }
    
    //根据model内容计算儿童说明高度
    if (self.orderModel.child_standard) {
        [self summaryLabelHeight];
    }
    
    DLog(@"成人价=%@,儿童价=%@",self.traveModel.adult_price,self.traveModel.child_price);
    if ([self.traveModel.child_price intValue]==0)
    {
        _isHaveChildPrice=NO;
    }else
    {
        _isHaveChildPrice=YES;
    }
    
    DLog(@"%@==pppp=%@,循环范围=%@，循环方式=%@,日历开始时间=%@,需提前预定天数=%@",self.traveModel.custom_json,self.traveModel.timetable_custom,self.traveModel.timetable_range,self.traveModel.timetable,[self getDateStr:self.traveModel.js_datetime],self.traveModel.b_day);
    
    self.canReserveDayDic = [NSMutableDictionary dictionaryWithDictionary:[[WLSingletonClass defaultWLSingleton] wlJsonStringToDicOrArr:self.traveModel.custom_json]];

#pragma mark - 获取团期数组
    self.loopDateArray = [NSMutableArray array];
    for (TravelLoopDateModel *model in self.loopArray) {
        [self.loopDateArray addObject:model.date_time];
    }
    //自定义班期
    for (int i=0; i<self.loopDateArray.count; i++)
    {
        NSDictionary *dic=[self.traveModel.timetable_custom objectAtIndex:i];
        LXCustomTraveModel *customTraveModel = [[LXCustomTraveModel alloc] init];
        [customTraveModel setValuesForKeysWithDictionary:dic];
        customTraveModel.date_time = self.loopDateArray[i];
        [_customTraveModelArray addObject:customTraveModel];
        [_customTraveDateModelArray addObject:customTraveModel.date_time];
    }
    
    //数组重新排序
    _customTraveModelArray= [NSMutableArray arrayWithArray:[_customTraveModelArray sortedArrayUsingSelector:@selector(sortByAge:)]];//自定义的日期选项
    //    }
    
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
    
    
    //开始时间
    if ([YXTools  stringReturnNull:self.realBeginDate]==YES) {
        _beginDate=@"";
    }else{
        
        _beginDate=[self.realBeginDate stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    }
    DLog(@"********%@--%@",_beginDate,self.realBeginDate);
#pragma mark - 团期循环开始时间
    _beginDate = [self.loopDateArray firstObject];
    //计算循环范围
    [self setTraveDate:nil timetable_range:[self getTimeRange] timetable:nil b_day:nil customDateArray:_customTraveModelArray];
    
    //添加修改人数视图方法
    [self addChangeTravellerNumberView];
    //初始人数
    adultCount = 1;
    childCount = 0;
    //余位人数
//    self.costNumber = 20;
    

}

#pragma mark ----------------------添加修改人数视图方法------------------------
//添加人数视图
- (void)addChangeTravellerNumberView {
    
//    #define kBottomViewHeight kScreenHeight/(kScreenHeight/194)
    
    //底部视图高度
    if (kScreenHeight == 480 || kScreenHeight == 568) {
        bottomHeight = 175;
    } else if (kScreenHeight == 667) {
        bottomHeight = 194;
    } else if (kScreenHeight == 736) {
        bottomHeight = 194;
    }
    
    
    self.bottomNumberView = [[TravelChangeTravellerNumberView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - bottomHeight, [UIScreen mainScreen].bounds.size.width, bottomHeight)];
    
    [self.bottomNumberView.nextStepButton addTarget:self action:@selector(gotoNextPage:) forControlEvents:(UIControlEventTouchUpInside)];
    self.bottomNumberView.childNumberBackView.userInteractionEnabled = YES;
    self.bottomNumberView.adultNumberbackView.userInteractionEnabled = YES;
    [self getAdultNumber];
    
    self.bottomNumberView.adultPriceLabel.text = [NSString stringWithFormat:@"成人价 ¥%@/人",self.orderModel.adult_price];
    self.bottomNumberView.childPriceLabel.text = [NSString stringWithFormat:@"儿童价 ¥%@/人",self.orderModel.child_price];
    
//    self.bottomNumberView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.bottomNumberView];
    
}

#pragma mark ----------------------底部控件方法实现--------------------------
//底部控件添加方法
- (void)getAdultNumber {
    //成人加法
    UITapGestureRecognizer *addTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addNumber:)];
    [self.bottomNumberView.adultNumberbackView.addView addGestureRecognizer:addTap];
    
    self.bottomNumberView.userInteractionEnabled = YES;
    self.bottomNumberView.adultNumberbackView.userInteractionEnabled = YES;
    self.bottomNumberView.adultNumberbackView.addView.userInteractionEnabled = YES;
    
    [self.bottomNumberView.adultNumberbackView.addView addGestureRecognizer:addTap];
    //成人减法
    UITapGestureRecognizer *minusTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(minusNumber:)];
    
    self.bottomNumberView.userInteractionEnabled = YES;
    self.bottomNumberView.adultNumberbackView.userInteractionEnabled = YES;
    self.bottomNumberView.adultNumberbackView.minusView.userInteractionEnabled = YES;
    
    [self.bottomNumberView.adultNumberbackView.minusView addGestureRecognizer:minusTap];
    
    //儿童加法
    UITapGestureRecognizer *addChildTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addChildNumber:)];
    self.bottomNumberView.userInteractionEnabled = YES;
    self.bottomNumberView.childNumberBackView.userInteractionEnabled = YES;
    self.bottomNumberView.childNumberBackView.addView.userInteractionEnabled = YES;
    [self.bottomNumberView.childNumberBackView.addView addGestureRecognizer:addChildTap];
    
    //儿童减法
    UITapGestureRecognizer *minusChildTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(minusChildNumber:)];
    self.bottomNumberView.userInteractionEnabled = YES;
    self.bottomNumberView.childNumberBackView.userInteractionEnabled = YES;
    self.bottomNumberView.childNumberBackView.minusView.userInteractionEnabled = YES;
    [self.bottomNumberView.childNumberBackView.minusView addGestureRecognizer:minusChildTap];
    
    //儿童说明
    UITapGestureRecognizer *childActionTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(childrenAction:)];
    UITapGestureRecognizer *childLableTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(childrenAction:)];
    self.bottomNumberView.userInteractionEnabled = YES;
    self.bottomNumberView.childLabel.userInteractionEnabled = YES;
    self.bottomNumberView.childNumberBackView.userInteractionEnabled = YES;
    self.bottomNumberView.childActionButton.userInteractionEnabled = YES;
    
    [self.bottomNumberView.childLabel addGestureRecognizer:childLableTap];
    [self.bottomNumberView.childActionButton addGestureRecognizer:childActionTap];
    //儿童添加弹出儿童说明方法
    
}



//加法
- (void)addNumber:(UITapGestureRecognizer *)tap {
    //加的个数小于最小余位
    if (leaveTime) {
        NSUInteger maxCost = surplusCount;
        if (adultCount < maxCost) {
            adultCount++;
            NSLog(@"%d",adultCount);
            self.bottomNumberView.adultNumberbackView.countLable.text = [NSString stringWithFormat:@"%d",adultCount];
            self.bottomNumberView.adultNumberbackView.minusView.image = [UIImage imageNamed:@"-0"];
        }
    } else {
        [[LXAlterView sharedMyTools] createTishi:@"请选择出发日期"];
    }
    
}

//减法
- (void)minusNumber:(UITapGestureRecognizer *)tap {
    if (leaveTime) {
        if (adultCount > 0) {
            adultCount--;
            NSLog(@"%d",adultCount);
            self.bottomNumberView.adultNumberbackView.countLable.text = [NSString stringWithFormat:@"%d",adultCount];
        }
        if (adultCount == 0){
            self.bottomNumberView.adultNumberbackView.minusView.image = [UIImage imageNamed:@"--灰色"];
        }
    } else {
        [[LXAlterView sharedMyTools] createTishi:@"请选择出发日期"];
    }
    
}

//儿童数增加
- (void)addChildNumber:(UITapGestureRecognizer *)tap {
    if (leaveTime) {
    NSUInteger maxCost = surplusCount;
    if (childCount < maxCost) {
        childCount++;
        NSLog(@"%d",childCount);
        self.bottomNumberView.childNumberBackView.countLable.text = [NSString stringWithFormat:@"%d",childCount];
        [self.bottomNumberView.childNumberBackView.minusView setImage:[UIImage imageNamed:@"-0"]];
        }
    } else {
        [[LXAlterView sharedMyTools] createTishi:@"请选择出发日期"];
    }
}

//儿童数减少
- (void)minusChildNumber:(UITapGestureRecognizer *)tap {
    if (leaveTime) {
        if (childCount > 0) {
            childCount--;
            NSLog(@"%d",childCount);
            self.bottomNumberView.childNumberBackView.countLable.text = [NSString stringWithFormat:@"%d",childCount];
        }
        if(childCount == 0){
            self.bottomNumberView.childNumberBackView.minusView.image = [UIImage imageNamed:@"--灰色"];
        }
    } else {
        [[LXAlterView sharedMyTools] createTishi:@"请选择出发日期"];
    }
    
    
}

#pragma mark -----------------------儿童说明弹出方法---------------------------
- (void)childrenAction:(UITapGestureRecognizer *)tap {
    
    if (kScreenHeight == 480 || kScreenHeight == 568) {
        childActionLabelY = 355 - childActionLabelHeight;
        childActionDetailNoneY = 450 - 20;
        tipX = kScreenWidth/3*2-10;
        tipY = 355;
        tipWidth = 10;
        tipHeight = 10;
    } else if (kScreenHeight == 667) {
        childActionLabelY = 455 - childActionLabelHeight;
        childActionDetailNoneY = 505 - 20;
        tipX = kScreenWidth/3*2-6;
        tipY = 455;
        tipWidth = 10;
        tipHeight = 10;
    } else if (kScreenHeight == 736) {
        childActionLabelY = 525 - childActionLabelHeight;
        childActionDetailNoneY = 545 - 20;
        tipX = kScreenWidth/3*2-13;
        tipY = 525;
        tipWidth = 10;
        tipHeight = 10;
    }
    
    
if (leaveTime) {
    
    if (isActionOpen){
        
        self.actionLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/3, childActionLabelY, kScreenWidth/3*2, childActionLabelHeight)];
        _actionLabel.backgroundColor = UIColorFromRGB(0xffc778);
        self.actionLabel.layer.borderColor = UIColorFromRGB(0xff9600).CGColor;
        self.actionLabel.layer.borderWidth = 1.0;

        //转换显示的内容
        NSString *actionStr = self.orderModel.child_standard;
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithData:[actionStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        NSMutableAttributedString *resutlAtt = [[NSMutableAttributedString alloc]initWithAttributedString:attrStr];
        NSString *testStr = resutlAtt.string;
        NSString *test = [self filterHTML:testStr];
        _actionLabel.text = test;
        
        _actionLabel.font = [UIFont systemFontOfSize:childActionTitleSize];
        _actionLabel.numberOfLines = 0;
        _actionLabel.textColor = [UIColor whiteColor];
        _actionLabel.layer.masksToBounds = YES;
        _actionLabel.layer.cornerRadius = 4;
        [self.view addSubview:_actionLabel];
        
        _tipImageView = [[UIImageView alloc]initWithFrame:CGRectMake(tipX, tipY, tipWidth, tipHeight)];
        _tipImageView.image = [UIImage imageNamed:@"尖角"];
        [self.view addSubview:_tipImageView];
        
        self.actionBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
        self.tapAllView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewDismiss:)];
        [self.actionBackView addGestureRecognizer:self.tapAllView];
        [self.view addSubview:self.actionBackView];
        
        
    } else {
        [_actionLabel removeFromSuperview];
        [_tipImageView removeFromSuperview];
        
    }
    isActionOpen = !isActionOpen;
    } else {
    [[LXAlterView sharedMyTools] createTishi:@"请选择出发日期"];
    }
    
}

//遍历字符串去除字符串中的html字符
- (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}

- (void)viewDismiss:(UITapGestureRecognizer *)tap {
    [self.actionBackView removeFromSuperview];
    [self.actionLabel removeFromSuperview];
    [self.tipImageView removeFromSuperview];
    

    isActionOpen = !isActionOpen;
}

//计算儿童说明内容的高度
- (void) summaryLabelHeight {
    NSString *childAction = self.orderModel.child_standard;
    CGSize contextSize = CGSizeMake(kScreenWidth/3*2, 0);
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:childActionTitleSize]};
    CGRect summaryRect = [childAction boundingRectWithSize:contextSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    childActionLabelHeight = summaryRect.size.height;
}




#pragma mark ----------------------跳转到填写订单页面---------------------
- (void)gotoNextPage:(UIButton *)sender {
    
    if (leaveTime) {
        FillOrderViewController *fillVC = [[FillOrderViewController alloc]init];
        //成人数目
        self.orderModel.adule = adultCount;
        //儿童数目
        self.orderModel.child = childCount;
        //发团时间
        self.orderModel.f_time = leaveTime;
        fillVC.orderModel = self.orderModel;
        fillVC.orderModel.f_time = dateStr;
        fillVC.surplusCount = surplusCount;
        fillVC.adultPrice = self.orderModel.adult_price;
        fillVC.chidlPrice = self.orderModel.child_price;
        
        [self.navigationController pushViewController:fillVC animated:YES];
    } else {
        
        [[LXAlterView sharedMyTools] createTishi:@"请选择出发日期"];
    }
}



#pragma mark ---计算循环范围
-(NSString *)getTimeRange
{
    
    //循环范围类型
    //1  "timetable_range": "latest 30 days"
    //2  "timetable_range": "2015-03-04_2015-03-30"
    NSString *timeRange;
    //只有自定义
    LXCustomTraveModel *model=[[LXCustomTraveModel alloc] init];
    model=[_customTraveModelArray objectAtIndex:_customTraveModelArray.count-1];
    timeRange=[self getDateGap:model.date_time beginDate:_beginDate];
#pragma mark -------------------------团期范围---------------------------------
    
    
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
    
    //只有自定义
    LXCustomTraveModel *customTraveModel = [[LXCustomTraveModel alloc] init];
    customTraveModel=[_customTraveModelArray objectAtIndex:0];
    if ([self.traveModel.js_datetime intValue]==0)
    {
        DLog(@"========%@",[[NSDate date]  laterDate:[self getDateWithStr:customTraveModel.date_time]]);
        beginDate=[leaveDate laterDate:[self getDateWithStr:customTraveModel.date_time]];
    }else{
        
        beginDate=[[leaveDate laterDate:[self getDateWithStr:customTraveModel.date_time]] laterDate:[self getDate:self.traveModel.js_datetime]];
        
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
    NSLog(@"date:%@",detaildate);
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
    NSLog(@"date:%@",detaildate);
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
    NSLog(@"date:%@",detaildate);
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

-(void)setTraveDate:(NSString *)js_datetime//日历开始时间
    timetable_range:(NSString *)timetable_range //班期循环范围
          timetable:(NSString *)timetable //班期循环方式
              b_day:(NSString *)b_day //需要提前几天预订
    customDateArray:(NSMutableArray *)array
{
    daynumber = [timetable_range intValue];
    optiondaynumber = 2;//选择两个后返回数据对象
    if (daynumber<=0) {
        
        self.calendarMonth = [self getMonthArrayOfDayNumber:0 ToDateforString:nil beginDate:[self getDateWithDate:[NSDate date]] customDateArray:array];
    }else{
        self.calendarMonth = [self getMonthArrayOfDayNumber:daynumber ToDateforString:nil beginDate:_beginDate customDateArray:array];
    }
    [self getLeaveDay:self.traveModel.timetable];//根据循环方式获取出发日期
    [self getTodayCellRow];//获取今天的cell
    [self initView];
    [self.collectionView reloadData];//刷新
}
#pragma mark - 逻辑代码初始化

#pragma mark - 获取时间段内的天数数组
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


- (void)initView{
    
    
    [self setTitle:@"选择日期"];
    
    TravelCalendarMonthCollectionViewLayout *layout = [TravelCalendarMonthCollectionViewLayout new];
    
    if (_isHaveChildPrice==YES)
    {
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64) collectionViewLayout:layout]; //初始化网格视图大小
    }
    else
    {
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64) collectionViewLayout:layout]; //初始化网格视图大小
    }
    
    [self.collectionView registerClass:[TravelCalendarDayCell class] forCellWithReuseIdentifier:DayCell];//cell重用设置ID，用于显示具体的日期
    
    [self.collectionView registerClass:[TravelCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader];//用于显示 星期一,二、三、四.....日
    
    //    self.collectionView.bounces = NO;//将网格视图的下拉效果关闭
    
    self.collectionView.delegate = self;//实现网格视图的delegate
    
    self.collectionView.dataSource = self;//实现网格视图的dataSource
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    
    self.collectionView.frame = CGRectMake(0, 25, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - collectionViewHeigh);
    
    
    
#pragma mark -------------------把日历添加到视图-------------------------
    [self.view addSubview:self.collectionView];
    [self addWeekNameView];
}


- (void)addWeekNameView {
    
    CGFloat xOffset = 0.0f;
    CGFloat yOffset = 2.0f;
    
    //添加顶部背景
    self.headerBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kHeaderBackViewHeight)];
    self.headerBackView.backgroundColor = UIColorFromRGB(0x96a2ac);
    [self.view addSubview:self.headerBackView];
    
    
    //一，二，三，四，五，六，日
    //    UILabel *dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, CATDayLabelWidth, CATDayLabelHeight)];
    UILabel *dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, CATDayLabelWidth, CATDayLabelHeight)];
    
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    //    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.5f]];
    dayOfTheWeekLabel.font = [UIFont systemFontOfSize:12.5f];
    self.day1OfTheWeekLabel = dayOfTheWeekLabel;
    self.day1OfTheWeekLabel.textAlignment = NSTextAlignmentCenter;
    self.day1OfTheWeekLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.day1OfTheWeekLabel];
    
    xOffset += CATDayLabelWidth;
    //    xOffset += CATDayLabelWidth;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, CATDayLabelWidth, CATDayLabelHeight)];
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    //    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.5f]];
    dayOfTheWeekLabel.font = [UIFont systemFontOfSize:12.5f];
    self.day2OfTheWeekLabel = dayOfTheWeekLabel;
    self.day2OfTheWeekLabel.textAlignment=NSTextAlignmentCenter;
    self.day2OfTheWeekLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:self.day2OfTheWeekLabel];
    
    xOffset += CATDayLabelWidth;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, CATDayLabelWidth, CATDayLabelHeight)];
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    //    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.5f]];
    dayOfTheWeekLabel.font = [UIFont systemFontOfSize:12.5f];
    self.day3OfTheWeekLabel = dayOfTheWeekLabel;
    self.day3OfTheWeekLabel.textAlignment=NSTextAlignmentCenter;
    self.day3OfTheWeekLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.day3OfTheWeekLabel];
    
    xOffset += CATDayLabelWidth;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, CATDayLabelWidth, CATDayLabelHeight)];
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    //    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.5f]];
    dayOfTheWeekLabel.font = [UIFont systemFontOfSize:12.5f];
    self.day4OfTheWeekLabel = dayOfTheWeekLabel;
    self.day4OfTheWeekLabel.textAlignment=NSTextAlignmentCenter;
    self.day4OfTheWeekLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.day4OfTheWeekLabel];
    
    xOffset += CATDayLabelWidth;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, CATDayLabelWidth, CATDayLabelHeight)];
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    //    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.5f]];
    dayOfTheWeekLabel.font = [UIFont systemFontOfSize:12.5f];
    self.day5OfTheWeekLabel = dayOfTheWeekLabel;
    self.day5OfTheWeekLabel.textAlignment=NSTextAlignmentCenter;
    self.day5OfTheWeekLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.day5OfTheWeekLabel];
    
    xOffset += CATDayLabelWidth;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, CATDayLabelWidth, CATDayLabelHeight)];
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    //    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.5f]];
    dayOfTheWeekLabel.font = [UIFont systemFontOfSize:12.5f];
    self.day6OfTheWeekLabel = dayOfTheWeekLabel;
    self.day6OfTheWeekLabel.textAlignment=NSTextAlignmentCenter;
    self.day6OfTheWeekLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.day6OfTheWeekLabel];
    
    xOffset += CATDayLabelWidth;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, CATDayLabelWidth, CATDayLabelHeight)];
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    //    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.5f]];
    dayOfTheWeekLabel.font = [UIFont systemFontOfSize:12.5f];
    self.day7OfTheWeekLabel = dayOfTheWeekLabel;
    self.day7OfTheWeekLabel.textAlignment=NSTextAlignmentCenter;
    self.day7OfTheWeekLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.day7OfTheWeekLabel];
    
    [self updateWithDayNames:@[@"日", @"一", @"二", @"三", @"四", @"五", @"六"]];

}

//设置 @"日", @"一", @"二", @"三", @"四", @"五", @"六"
- (void)updateWithDayNames:(NSArray *)dayNames
{
    for (int i = 0 ; i < dayNames.count; i++) {
        switch (i) {
            case 0:
                self.day1OfTheWeekLabel.text = dayNames[i];
                break;
                
            case 1:
                self.day2OfTheWeekLabel.text = dayNames[i];
                break;
                
            case 2:
                self.day3OfTheWeekLabel.text = dayNames[i];
                break;
                
            case 3:
                self.day4OfTheWeekLabel.text = dayNames[i];
                break;
                
            case 4:
                self.day5OfTheWeekLabel.text = dayNames[i];
                break;
                
            case 5:
                self.day6OfTheWeekLabel.text = dayNames[i];
                break;
                
            case 6:
                self.day7OfTheWeekLabel.text = dayNames[i];
                break;
                
            default:
                break;
        }
    }
}


#pragma mark --UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
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
    

    self.traveModel.child_price = self.orderModel.adult_price;
    self.traveModel.adult_price = self.orderModel.adult_price;
    
    TravelCalendarDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DayCell forIndexPath:indexPath];
    cell.userInteractionEnabled=YES;
    
    NSMutableArray *monthArray = [self.calendarMonth objectAtIndex:indexPath.section];
    
    CalendarDayModel *model = [monthArray objectAtIndex:indexPath.row];//获取某一天
    
    NSString * datStr = model.day < 10 ? [NSString stringWithFormat:@"0%ld", model.day] : [NSString stringWithFormat:@"%ld", model.day];
    NSString * monthStr = model.month < 10 ? [NSString stringWithFormat:@"0%ld", model.month] : [NSString stringWithFormat:@"%ld", model.month];
    NSString * timeStr = [NSString stringWithFormat:@"%ld-%@-%@", model.year, monthStr, datStr];
    
    BOOL reserveDay = YES;
    
    if ([[self.canReserveDayDic objectForKey:timeStr] isKindOfClass:[NSDictionary class]] &&[[[self.canReserveDayDic objectForKey:timeStr] objectForKey:@"members"] integerValue] == 0) {
        NSLog(@"%@", timeStr);
        reserveDay = NO;
    }
    NSLog(@"%lu-%lu-%lu",(unsigned long)model.year,(unsigned long)model.month,(unsigned long)model.day);
    DLog(@"timeStr == %@", timeStr);
    
    _timeTableType = 3;
    
    if (_todayCell==indexPath.row && indexPath.section==0)
    {
        cell.userInteractionEnabled=NO;
        model.price=[NSString stringWithFormat:@"%d",-1];
        cell.model=model;
    }

    
#pragma mark -------------价格赋值方法---------------
    if ([[[model toString] stringByReplacingOccurrencesOfString:@"-" withString:@""] integerValue]<=[_rangeEndDate integerValue] && _timeTableType==3)
    {
        if([_leaveType isEqualToString:LeaveWeek])
        {
            //按周几发团
            switch (_canLeaveDay.count)
            {
                case 1:
                {
                    if (indexPath.row%7==[[_canLeaveDay objectAtIndex:0] integerValue] && reserveDay)
                    {
                        self.traveModel.adult_price = self.orderModel.adult_price;
                        model.price=[NSString stringWithFormat:@"￥%d",[self.orderModel.adult_price integerValue]];
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
                    if ((indexPath.row%7==[[_canLeaveDay objectAtIndex:0] integerValue] ||
                         indexPath.row%7==[[_canLeaveDay objectAtIndex:1] integerValue]) && reserveDay)
                    {
                        self.traveModel.adult_price = self.orderModel.adult_price;
//                        model.price=[NSString stringWithFormat:@"￥%@",self.orderModel.adult_price];
                        model.price=[NSString stringWithFormat:@"￥%d",[self.orderModel.adult_price integerValue]];
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
                        self.traveModel.adult_price = self.orderModel.adult_price;
//                        model.price=[NSString stringWithFormat:@"￥%@",self.orderModel.adult_price];
                        model.price=[NSString stringWithFormat:@"￥%d",[self.orderModel.adult_price integerValue]];
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
                        self.traveModel.adult_price = self.orderModel.adult_price;
//                        model.price=[NSString stringWithFormat:@"￥%@",self.orderModel.adult_price];
                        model.price=[NSString stringWithFormat:@"￥%d",[self.orderModel.adult_price integerValue]];
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
                        self.traveModel.adult_price = self.orderModel.adult_price;
//                        model.price=[NSString stringWithFormat:@"￥%@",self.orderModel.adult_price];
                        model.price=[NSString stringWithFormat:@"￥%d",[self.orderModel.adult_price integerValue]];
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
                        self.traveModel.adult_price = self.orderModel.adult_price;
                        model.price=[NSString stringWithFormat:@"￥%d",[self.orderModel.adult_price integerValue]];
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
                        self.traveModel.adult_price = self.orderModel.adult_price;
                        model.price=[NSString stringWithFormat:@"￥%d",[self.orderModel.adult_price integerValue]];
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
                        self.traveModel.adult_price = self.orderModel.adult_price;
//                        model.price=[NSString stringWithFormat:@"￥%@",self.orderModel.adult_price];
                        model.price=[NSString stringWithFormat:@"￥%d",[self.orderModel.adult_price integerValue]];
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
                self.traveModel.adult_price = self.orderModel.adult_price;
//                model.price=[NSString stringWithFormat:@"￥%@",self.orderModel.adult_price];
                model.price=[NSString stringWithFormat:@"￥%d",[self.orderModel.adult_price integerValue]];
                
            }
            else
            {
                cell.userInteractionEnabled=NO;
                model.price=[NSString stringWithFormat:@"%d",-2];
            }
            cell.model=model;
            return cell;
            
        }
        if ([_leaveType isEqualToString:LeaveEveryDay] && reserveDay)
        {
            self.traveModel.adult_price = self.orderModel.adult_price;
//            model.price=[NSString stringWithFormat:@"￥%@",self.orderModel.adult_price];
            model.price=[NSString stringWithFormat:@"￥%d",[self.orderModel.adult_price integerValue]];
            cell.model=model;
            return cell;
            
        }
        if ([_leaveType isEqualToString:LeaveWeekend] && reserveDay)
        {
            if (indexPath.row%7==[[_canLeaveDay objectAtIndex:0] integerValue] ||
                indexPath.row%7==[[_canLeaveDay objectAtIndex:1] integerValue])
            {
                self.traveModel.adult_price = self.orderModel.adult_price;
//                model.price=[NSString stringWithFormat:@"￥%@",self.orderModel.adult_price];
                model.price=[NSString stringWithFormat:@"￥%d",[self.orderModel.adult_price integerValue]];
            }
            else
            {
                cell.userInteractionEnabled=NO;
                model.price=[NSString stringWithFormat:@"%d",-2];
            }
            cell.model=model;
            return cell;
        }
        
    }
    
    
    if ([_customTraveDateModelArray containsObject:[model toString]] && reserveDay)
    {
        for (LXCustomTraveModel *model1 in _customTraveModelArray)
        {
            if ([model1.date_time isEqualToString:[model toString]])
            {
                self.traveModel.adult_price = self.orderModel.adult_price;
//                model.price=[NSString stringWithFormat:@"￥%@",self.orderModel.adult_price];
                model.price=[NSString stringWithFormat:@"￥%d",[self.orderModel.adult_price integerValue]];
                cell.model=model;
            }
        }
        
    }else
    {
        cell.userInteractionEnabled=NO;
        model.price=[NSString stringWithFormat:@"%d",-2];
        cell.model=model;
    }
//    cell.model.price = self.orderModel.adult_price;
    
    return cell;
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        NSMutableArray *month_Array = [self.calendarMonth objectAtIndex:indexPath.section];
        CalendarDayModel *model = [month_Array objectAtIndex:15];
        
        TravelCollectionReusableView *monthHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader forIndexPath:indexPath];
        monthHeader.masterLabel.text = [NSString stringWithFormat:@"%lu年 %lu月",(unsigned long)model.year,(unsigned long)model.month];//@"日期";
        monthHeader.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
        reusableview = monthHeader;
    }
    return reusableview;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize size = CGSizeMake(kScreenWidth, 30);
    return size;
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

        cishu=0;
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
    
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark------------------------------传值-----------------
#pragma mark--获取点击日期和价格
-(void)clickDay:(CalendarDayModel *)model
{
    _nextBtn.backgroundColor=WEILVColor;
    _isChooseDate=YES;
    NSLog(@"1星期 %@",[model getWeek]);
#pragma mark ------------日期-----------------
    NSLog(@"2字符串 %@",[model toString]);
    //新添加
    leaveTime = [model toString];
//    NSLog(@"3节日  成人价=%@,儿童价=%@",model.price,self.traveModel.child_price);
       NSString *remanentPeople;
    //如果点击的是自定义日期
    if ([_customTraveDateModelArray containsObject:[model toString]])
    {
        
        for (LXCustomTraveModel *model1 in _customTraveModelArray)
        {
            if ([model1.date_time isEqualToString:[model toString]])
            {
                remanentPeople=model1.members;
                self.traveModel.adult_price=model1.adult;
                self.traveModel.adult_price = self.orderModel.adult_price;
                model1.adult = self.orderModel.adult_price;
                self.traveModel.child_price=model1.child;

            }
        }
    }else{
        
        remanentPeople=self.traveModel.timetable_people;
    }
    
    YXOrderViewController *yxOrderVc=[[YXOrderViewController alloc] init];
    yxOrderVc.visaRegion=self.traveModel.product_name;
    //DLog(@"_____%@,,,___%@,,,,%f，，，self.traveModel.adult_price=%@,成人价=%@",_adultLab.text,_childrenLab.text,totalPrice,self.traveModel.adult_price,_aduPriceLabel.text);
    //yxOrderVc.totalPrice=[NSString stringWithFormat:@"%f",totalPrice];
    yxOrderVc.departureDate=[model toString];
    yxOrderVc.remanentPeople=remanentPeople;
    yxOrderVc.isTrave=YES;
    yxOrderVc.isRealTrave=YES;
    yxOrderVc.traveModel = self.traveModel;
    yxOrderVc.orderSource = self.orderSource;
    yxOrderVc.store_id = self.store_id;
    
    //[self.bottomView removeFromSuperview];
    //    [self.navigationController pushViewController:yxOrderVc animated:YES];
    
    
    //获取数组位置
    NSInteger loction = [self.loopDateArray indexOfObject:leaveTime];
    TravelLoopDateModel *model2 = self.loopArray[loction];
    surplusCount = [model2.stock integerValue];
    dateStr = model2.date_time;

    //下一步按钮Y
    NSInteger NextButtonY;
    //下一步按钮高度
    NSInteger NextButtonHeight;
 

    if (kScreenHeight < 569) {
        NextButtonY = 117;
        NextButtonHeight = 40;
        bottomHeight = 220;
    
    } else if (kScreenHeight == 667){
        NextButtonY = 110;
        NextButtonHeight = 40;
        bottomHeight = 214;

    } else if (kScreenHeight == 736){
        NextButtonY = 110;
        NextButtonHeight = 40;
        bottomHeight = 214;
    }

    
    
    //点击之后底部视图变化
    self.bottomNumberView.frame = CGRectMake(0, kScreenHeight - bottomHeight, kScreenWidth, bottomHeight);
    self.bottomNumberView.nextStepButton.frame = CGRectMake(0, NextButtonY, kScreenWidth, NextButtonHeight);
    self.collectionView.frame = CGRectMake(0, 25, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - bottomHeight-25);
    
    //添加第二条黑线
    self.secondBlackView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.bottomNumberView.childPriceLabel.frame) + 12, kScreenWidth - 10, 0.5)];
    self.secondBlackView.backgroundColor = BgViewColor;
    [self.bottomNumberView addSubview:self.secondBlackView];
    
    //添加余位
    self.costCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_secondBlackView.frame) + 8, kScreenWidth - 10, 20)];
    self.costCountLabel.text = [NSString stringWithFormat:@"余位: %d",surplusCount];
    self.costCountLabel.font = [UIFont systemFontOfSize:16];
    [self.bottomNumberView addSubview:self.costCountLabel];
    
    
}



#pragma mark--今天的日期
- (CalendarDayModel *)getTodayModel
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

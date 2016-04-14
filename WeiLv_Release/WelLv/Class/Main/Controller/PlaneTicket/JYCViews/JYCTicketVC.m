
//  JYCTicketVC.m
//  WelLv
//
//  Created by lyx on 15/9/8.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//http://202.104.102.2/api/flightApi/getFlightList?s_city=%E9%83%91%E5%B7%9E&e_city=%E4%B8%8A%E6%B5%B7&sd=2015-09-29
#define LeftBeginX 10
#import "JYCTicketVC.h"
#import "YXTools.h"
#import "baseModel.h"
#import "headerView.h"
#import "cablistModel.h"

#import "JYCCell.h"
#import "ZFJChooseDateView.h"
#import "LXPlaneTicketOrderViewController.h"
#import "JYCBackTicketVC.h"
#import "LXPlaneCalendarViewController.h"
#import "JYCTools.h"
#import "QXBModelTool.h"
#define M_VIEW_WIDTH(view) view.frame.size.width

#define M_VIEW_HEIGHT(view) view.frame.size.height


#define M_WINDOW_HEIGHT  ([[UIScreen mainScreen] bounds].size.height)
#define M_WINDOW_WIDTH  ([[UIScreen mainScreen] bounds].size.width)

@interface JYCTicketVC ()<UITableViewDataSource,UITableViewDelegate>
{
    AFHTTPRequestOperationManager *_manager;
    NSMutableArray *_companyArr;
    NSMutableArray *_ticketInfomationArr;
    NSMutableArray *_baseArr;
    NSMutableArray *_cabListArr;
    UITableView *_tableView;
    NSMutableArray *_arr;
    UIView *_botomView;
    UIButton *startTimeBtn;
    UILabel *startLabel;
    UIButton *ticketBtn;
    UILabel *ticketLabel;
    UILabel *comLabel;
    NSString *_bTitle;//向下个页面传值
    NSString *_goUrl;
    NSString *_backUrl;//向下个页面传值

    BOOL Up;//升降
   
    UIView *_footView;
    ZFJChooseDateView * view;
    NSString *currentStr;//当前日期对应的字符串

}
@property(nonatomic,strong)NSMutableArray *companyArr;
@property(nonatomic,strong)NSMutableArray *ticketInfomationArr;
@property(nonatomic,strong)NSMutableArray *baseArr;
@property(nonatomic,strong)NSMutableArray *cabListArr;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *flags;
@property(nonatomic,strong)NSMutableArray *arr2;
@property(nonatomic,strong)NSMutableArray *arr;

@property (nonatomic, strong) NSMutableArray * superHeaderArr;
@property (nonatomic, strong) NSMutableArray * superCellArr;
@property (nonatomic, strong) UIView * chooseCompanyView;
@property (nonatomic, strong) UIView * burlView;
@property (nonatomic, copy) NSString * companyStr;
@property (nonatomic, strong) UILabel * templabel;
@property (nonatomic, strong) NSString * goUrl;
@property (nonatomic, copy) NSString * backUrl;//向下个页面传值
@property (nonatomic, copy) NSString * bTitle;//向下个页面传值

@property (nonatomic, strong) UILabel * zeroLabel;

@property (nonatomic, strong) MBProgressHUD * hud;//设置菊花
@end

@implementation JYCTicketVC

- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
   
    [self initView];
    if (self.isSingle) {
        self.title=[NSString stringWithFormat:@"%@ - %@",self.startCity,self.endCity];
        NSString *urlString=[NSString stringWithFormat:@"%@s_city=%@&e_city=%@&sd=%@",PlaneTicketUrl,self.startCity,self.endCity,self.startTime];
        NSLog(@"%@",urlString);
      NSString *url=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self loadDataWith:url];
    }else if(self.isSingle==NO)
    {
        self.title=[NSString stringWithFormat:@"%@ - %@(去程)",self.startCity,self.endCity];
        self.bTitle=[NSString stringWithFormat:@"%@ - %@(返程)",self.endCity,self.startCity];
        NSString *urlString1=[NSString stringWithFormat:@"%@s_city=%@&e_city=%@&sd=%@",PlaneTicketUrl,self.startCity,self.endCity,self.startTime];
        NSString *url1=[urlString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self loadDataWith:url1];
    
    }
    _footView=[[UIView alloc]init];
    _footView.backgroundColor=[UIColor clearColor];
    self.view.backgroundColor=[UIColor whiteColor];
    _companyArr=[[NSMutableArray alloc]init];
    _ticketInfomationArr=[[NSMutableArray alloc]init];
    _baseArr=[[NSMutableArray alloc]init];
    _cabListArr=[[NSMutableArray alloc]init];
    _arr=[[NSMutableArray alloc]init];

    
    
    [self createBotomViewBtn];
}
-(void)initView
{
    UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame =CGRectMake(20,10,25,30);
    but.backgroundColor = [UIColor whiteColor];
    //[but setImage:[UIImage imageNamed:@"calendar"] forState:UIControlStateNormal];
   // but.imageView.image=[UIImage imageNamed:@"calendar"];
    [but setBackgroundImage:[UIImage imageNamed:@"calendar"] forState:UIControlStateNormal];
    //[but setTitle:@"" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(butClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    view = [[ZFJChooseDateView alloc] initWithFrame:CGRectMake(64, 0, M_WINDOW_WIDTH - 64, 50)];
       //刚进入页面时
    NSDate *date=[NSDate date];
    //当天date对应的日期字符串
    currentStr=[LXTools getDateStrWithDate:date];
    if ([self.startTime isEqualToString:currentStr]) {
       NSString * _date=[self.startTime substringWithRange:NSMakeRange(5, 5)];//09-24;
        view.middleLabel.text=[NSString stringWithFormat:@"%@\n%@",_date,self.singleWeek];
        view.leftLabel.text=@"暂无";
        NSString *tomStr=[JYCTools getTomStrWithCurrentStr:self.startTime];
        NSString *str2=[tomStr substringWithRange:NSMakeRange(5, 5)];
        int week=(int)self.receiveWeek;//从首页接收过来的星期转化为int型
        NSString *tomWeek=[JYCTools getWeekStringFromInteger:++week];//第二天的周几
        
        view.rightLabel.text=[NSString stringWithFormat:@"%@\n%@",str2,tomWeek];

    }else {
        
         NSString * _date=[self.startTime substringWithRange:NSMakeRange(5, 5)];
        view.middleLabel.text=[NSString stringWithFormat:@"%@\n%@",_date,self.singleWeek];
        NSLog(@"%@",view.middleLabel.text);
        NSString *yesStr=[JYCTools getYesStrWithCurrenStr:self.startTime];
        //NSLog(@"%@",self.startTime);
        NSString *str1=[yesStr substringWithRange:NSMakeRange(5, 5)];
        int week1=(int)self.receiveWeek;
        NSString *yesWeek=[JYCTools getWeekStringFromInteger:--week1];//昨天的周几
        view.leftLabel.text=[NSString stringWithFormat:@"%@\n%@",str1,yesWeek];
        NSString *tomStr=[JYCTools getTomStrWithCurrentStr:self.startTime];
        NSString *str2=[tomStr substringWithRange:NSMakeRange(5, 5)];
        int week2=(int)self.receiveWeek;
        NSString *tomWeek=[JYCTools getWeekStringFromInteger:++week2];
        view.rightLabel.text=[NSString stringWithFormat:@"%@\n%@",str2,tomWeek];
        
    }
    

     [view chooseViewIndex:^(NSInteger index) {
        if (index == 1) {
            if ([view.leftLabel.text isEqualToString:@"暂无"]) {
                
                [[LXAlterView sharedMyTools]createTishi:@"请选择出发日期"];

            } else {
            view.rightLabel.text=view.middleLabel.text;
            view.middleLabel.text=view.leftLabel.text;
           
            NSString *_year=[self.startTime substringWithRange:NSMakeRange(0, 5)];//2015-;
            NSString *midleTime=[NSString stringWithFormat:@"%@%@",_year,view.middleLabel.text];//保存一下
            NSString *midleWeek=[view.middleLabel.text substringWithRange:NSMakeRange(6,2)];
            int b=[JYCTools getWeekFromWeekStr:midleWeek];
            
            NSString *yesStr=[JYCTools getYesStrWithCurrenStr:[midleTime substringWithRange:NSMakeRange(0, 10)]];
                if ([yesStr isEqualToString:currentStr]) {
                     view.leftLabel.text=@"暂无";
                     return;
                }
            NSString *str2=[yesStr substringWithRange:NSMakeRange(5, 5)];
            
            NSString *tomWeek=[JYCTools getWeekStringFromInteger:--b];
            view.leftLabel.text=[NSString stringWithFormat:@"%@\n%@",str2,tomWeek];
            
        }
           NSString *_year=[self.startTime substringWithRange:NSMakeRange(0, 5)];//2015-;
           NSString *urlString=[NSString stringWithFormat:@"%@s_city=%@&e_city=%@&sd=%@",PlaneTicketUrl,self.startCity,self.endCity,[NSString stringWithFormat:@"%@%@",_year,[view.middleLabel.text substringWithRange:NSMakeRange(0,5)]]];
            NSString *url=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [self loadDataWith:url];
            comLabel.text=@"航空公司";
            self.companyStr=@"不限";
            self.zeroLabel.textColor = [UIColor orangeColor];
            self.templabel.textColor = [UIColor blackColor];
            self.templabel = self.zeroLabel;


        } else if(index == 2) {
            
        } else if (index == 3) {
            
            view.leftLabel.text=view.middleLabel.text;
            view.middleLabel.text=view.rightLabel.text;
            NSString *_year=[self.startTime substringWithRange:NSMakeRange(0, 5)];//2015-;
           
            NSString *midleTime=[NSString stringWithFormat:@"%@%@",_year,view.middleLabel.text];//保存一下
            NSString *midleWeek=[view.middleLabel.text substringWithRange:NSMakeRange(6,2)];
            int b=[JYCTools getWeekFromWeekStr:midleWeek];
            
            NSString *tomStr=[JYCTools getTomStrWithCurrentStr:[midleTime substringWithRange:NSMakeRange(0, 10)]];
            NSString *str2=[tomStr substringWithRange:NSMakeRange(5, 5)];
            
            NSString *tomWeek=[JYCTools getWeekStringFromInteger:++b];
            view.rightLabel.text=[NSString stringWithFormat:@"%@\n%@",str2,tomWeek];
            
            NSString *urlString=[NSString stringWithFormat:@"%@s_city=%@&e_city=%@&sd=%@",PlaneTicketUrl,self.startCity,self.endCity,[NSString stringWithFormat:@"%@%@",_year,[view.middleLabel.text substringWithRange:NSMakeRange(0,5)]]];
            NSString *url=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
           
            [self loadDataWith:url];
            comLabel.text=@"航空公司";
            self.companyStr=@"不限";
            self.zeroLabel.textColor = [UIColor orangeColor];
            self.templabel.textColor = [UIColor blackColor];
            self.templabel = self.zeroLabel;

        }
    
    }];
       [self.view addSubview:view];

    UIView *botomLine=[[UIView alloc]initWithFrame:CGRectMake(0,50,windowContentWidth,1)];
    botomLine.backgroundColor=bordColor;
    [self.view addSubview:botomLine];
    

    if (!self.tableView) {
        //如果没有再创建  懒加载
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,51, windowContentWidth,windowContentHeight-64-100) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerNib:[UINib nibWithNibName:@"JYCCell" bundle:nil] forCellReuseIdentifier:@"JYCCell"];
        [self.tableView reloadData];
        self.tableView.bounces=NO;
        [self.view addSubview:self.tableView];
        //[self.tableView sendSubviewToBack:_botomView];
    }
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }

    
    _botomView=[[UIView alloc]initWithFrame:CGRectMake(0, ControllerViewHeight-50, windowContentWidth, 50)];
    _botomView.backgroundColor=[UIColor colorWithWhite:0.2 alpha:0.8];
    
    [self.view addSubview:_botomView];
   
}
-(void)createBotomViewBtn{
    startTimeBtn=[YXTools allocButton:nil textColor:nil nom_bg:[UIImage imageNamed:@"时间"] hei_bg:nil frame:CGRectMake(40, 3, 20, 20)];
    //startTime.backgroundColor=[UIColor redColor];
    //startTimeBtn.tag=101;
    [startTimeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_botomView addSubview:startTimeBtn];
    startLabel=[YXTools allocLabel:@"起飞时间" font:systemFont(13) textColor:[UIColor whiteColor] frame:CGRectMake(ViewX(startTimeBtn)-20, ViewBelow(startTimeBtn)+3, 60, 50-ViewHeight(startTimeBtn)-3*2) textAlignment:1];
    startLabel.userInteractionEnabled=YES;
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame =CGRectMake(ViewX(startTimeBtn)-20, 3,70, 50);
    btn1.tag=101;
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
   // btn1.backgroundColor=[UIColor redColor];
    [_botomView addSubview:startLabel];
    [_botomView addSubview:btn1];
    ticketBtn=[YXTools allocButton:nil textColor:nil nom_bg:[UIImage imageNamed:@"票价"] hei_bg:nil frame:CGRectMake(ViewRight(startTimeBtn)+(windowContentWidth-40*2-20*3)/2, 3, 20, 20)];
    
    //ticketBtn.tag=102;
    [ticketBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_botomView addSubview:ticketBtn];
    ticketLabel=[YXTools allocLabel:@"票价" font:systemFont(13) textColor:[UIColor whiteColor] frame:CGRectMake(ViewX(ticketBtn)-20, ViewBelow(ticketBtn)+3,60, 50-ViewHeight(ticketBtn)-3*2) textAlignment:1];
    [_botomView addSubview:ticketLabel];
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame =CGRectMake(ViewX(ticketBtn)-20, 3,70, 50);
    btn2.tag=102;
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_botomView addSubview:btn2];
    UIButton *comBtn=[YXTools allocButton:nil textColor:nil nom_bg:[UIImage imageNamed:@"航空公司"] hei_bg:nil frame:CGRectMake(ViewRight(ticketBtn)+(windowContentWidth-40*2-20*3)/2, 3, 20, 20)];
        //comBtn.tag=103;
    [comBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_botomView addSubview:comBtn];
    comLabel=[YXTools allocLabel:@"航空公司" font:systemFont(13) textColor:[UIColor whiteColor] frame:CGRectMake(ViewX(comBtn)-20, ViewBelow(comBtn)+3,60,50-ViewHeight(ticketBtn)-3*2) textAlignment:1];
    [_botomView addSubview:comLabel];
    UIButton *btn3=[UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame =CGRectMake(ViewX(comBtn)-20, 3,70, 50);
    btn3.tag=103;
    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_botomView addSubview:btn3];
    
}

-(void)loadDataWith:(NSString *)url
{
//    [[XCLoadMsg sharedLoadMsg:self] hideAll];
//    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
     [self setProgressHud1];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    __weak typeof(self)weakSelf =self;
    self.superHeaderArr = [NSMutableArray array];
    self.superCellArr = [NSMutableArray array];
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [_hud hide:YES];
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
         if ([dict[@"state"]integerValue]==1) {
            NSDictionary *dict2=dict[@"data"];
            
            weakSelf.companyArr=dict2[@"al"];
            weakSelf.ticketInfomationArr=dict2[@"d"];
             
            for (id obj in weakSelf.ticketInfomationArr) {
                NSDictionary *baseDict=obj[@"Base"];
                
                baseModel *bmodel=[[baseModel alloc]init];
                [bmodel setValuesForKeysWithDictionary:baseDict];
//                [QXBModelTool createJsonModelWithDictionary:[baseDict     objectForKey:@"e_airport"]modelName:@"airport"];
                
                [weakSelf.baseArr addObject:bmodel];
                
                
                _arr=obj[@"CabList"];
                
                NSMutableArray * tempArr = [NSMutableArray array];
                for (NSDictionary *cablistDict in _arr) {
                    cablistModel *cModel=[[cablistModel alloc]init];
                    [cModel setValuesForKeysWithDictionary:cablistDict];
                    [tempArr addObject:cModel];
                }
                [weakSelf.cabListArr addObject:tempArr];
              }
        
            [weakSelf.superHeaderArr addObjectsFromArray:weakSelf.baseArr];
            [weakSelf.superCellArr addObjectsFromArray:weakSelf.cabListArr];
        
        }else {
            [[LXAlterView sharedMyTools]createTishi:@"您请求的航班没有数据"];
        }
      
      [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];

        self.flags = [NSMutableArray array];
        for (int i = 0; i < self.baseArr.count; i++) {
            [self.flags addObject:@YES];
        }
       [self.tableView reloadData];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_hud hide:YES];
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
        [self loadDataWith:url];
        }];

        NSLog(@"下载失败");
    }];

}

#pragma mark --tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return self.baseArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray * arr = self.cabListArr[section];
    
    NSInteger rowNum = [[self.flags objectAtIndex:section] boolValue] ? 0 : arr.count-1;
    return rowNum;

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    headerView *hview;
    if (hview==nil) {
      hview = [[headerView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, 90)];
        hview.tag=section;
    }
        hview.fold = [[self.flags objectAtIndex:section] boolValue];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    
    UIView *singleTapView = [tap view];
    singleTapView.tag = section;
   [hview addGestureRecognizer:tap];
    baseModel *model=self.baseArr[section];
    
    [hview showDataWithModel:model section:section];
    
    
    hview.backgroundColor=[UIColor whiteColor];

    hview.clickHandler = ^(headerView *view, BOOL isFold) {

        [self.flags replaceObjectAtIndex:section withObject:@(isFold)];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    return hview;
}

- (void)tapGesture:(id)sender
{
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
    
    [self setProgressHud2];
    if (self.isSingle) {
        LXPlaneTicketOrderViewController *lxOrderVc=[[LXPlaneTicketOrderViewController alloc] init];
        //这里应该传arr
        NSMutableArray *chuArr=[[NSMutableArray alloc]init];//传值数组
        
        baseModel *bmodel=self.baseArr[[singleTap view].tag];
        [chuArr addObject:bmodel];
        
        NSArray * arr = self.cabListArr[[singleTap view].tag];
        cablistModel *cmodel = arr[0];
        [chuArr addObject:cmodel];
        //验票
        
        NSDictionary *parameters = @{@"flightno":bmodel.FlightNo,@"s":bmodel.s_airport[@"city_code"],@"e":bmodel.e_airport[@"city_code"],@"sd":[bmodel.OffTime substringWithRange:NSMakeRange(0,10)],@"cabin":cmodel.Cabin,@"fare":cmodel.Fare,@"ischd":@"0",@"isspe":cmodel.IsSpe,@"istehui":cmodel.IsTeHui,@"userrate":cmodel.UserRate,@"stime":[bmodel.OffTime substringWithRange:NSMakeRange(11,5)],@"iskx":cmodel.IsKx,@"kxsiteid":cmodel.KxSiteID,@"kxspvalue":cmodel.KxSpValue};
       
        
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [_manager POST:CheckFlightPriceUrl parameters:parameters
               success:^(AFHTTPRequestOperation *operation,id responseObject) {
                   
                   NSString *html = operation.responseString;
                   NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
                   NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
                   //NSLog(@"%@++",dict);
                   NSDictionary *dict2=dict[@"data"];
                   //NSLog(@"%@",dict2[@"canbook"]);
                   if ([[dict objectForKey:@"state"] integerValue]==1&&[dict2[@"canbook"]isEqual:@"true"]&&[dict2[@"c"]isEqualToString:@"0000"]){
                       
                       lxOrderVc.planeInfoArray=chuArr;
                       [self.navigationController pushViewController:lxOrderVc animated:YES];
                       [_hud hide:YES];
                       
                   }else{
                       [_hud hide:YES];
                       [[LXAlterView sharedMyTools] createTishi:@"验票失败，请重新选择"];
                   }
                   
               }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                   //[[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
                   [[LXAlterView sharedMyTools] createTishi:@"网络请求失败，请稍后重试"];
                   [_hud hide:YES];
                   
               }];
    }else if(self.isSingle==NO)
    {
        JYCBackTicketVC *BackVC=[[JYCBackTicketVC alloc]init];
        NSMutableArray *chuArr=[[NSMutableArray alloc]init];//传值数组
        
        baseModel *bmodel=self.baseArr[[singleTap view].tag];
        [chuArr addObject:bmodel];
        
        NSArray * arr = self.cabListArr[[singleTap view].tag];
        cablistModel *cmodel = arr[0];
        [chuArr addObject:cmodel];
        
        NSDictionary *parameters = @{@"flightno":bmodel.FlightNo,@"s":bmodel.s_airport[@"city_code"],@"e":bmodel.e_airport[@"city_code"],@"sd":[bmodel.OffTime substringWithRange:NSMakeRange(0,10)],@"cabin":cmodel.Cabin,@"fare":cmodel.Fare,@"ischd":@"0",@"isspe":cmodel.IsSpe,@"istehui":cmodel.IsTeHui,@"userrate":cmodel.UserRate,@"stime":[bmodel.OffTime substringWithRange:NSMakeRange(11,5)],@"iskx":cmodel.IsKx,@"kxsiteid":cmodel.KxSiteID,@"kxspvalue":cmodel.KxSpValue};
        //NSLog(@"jyc---%@",parameters);
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [_manager POST:CheckFlightPriceUrl parameters:parameters
               success:^(AFHTTPRequestOperation *operation,id responseObject) {
                   
                   NSString *html = operation.responseString;
                   NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
                   NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
                   //NSLog(@"%--@++",dict);
                   NSDictionary *dict2=dict[@"data"];
                   if ([[dict objectForKey:@"state"]integerValue]==1&&[dict2[@"canbook"]isEqual:@"true"]&&[dict2[@"c"]isEqualToString:@"0000"]) {
                       [_hud hide:YES];
                       BackVC.receiveArr=chuArr;//下个页面接收一下到时候和返回页面的数组一起传给订单页面
                       // BackVC.backUrl=self.backUrl;在下个页面拼接，这里不传了
                       BackVC.backTime=self.backTime;
                       BackVC.backTittle=self.bTitle;
                       BackVC.startCity=self.startCity;
                       BackVC.endCity=self.endCity;
                       BackVC.backReceiveWeek=self.backReceiveWeek;
                       BackVC.backWeek=self.backWeek;
                       [self.navigationController pushViewController:BackVC animated:YES];
                       
                   }else{
                       [_hud hide:YES];
                       [[LXAlterView sharedMyTools] createTishi:@"验票失败，请重新选择"];
                   }
                   
               }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                   //[[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
                   [[LXAlterView sharedMyTools] createTishi:@"网络请求失败，请稍后重试"];
                   [_hud hide:YES];
                   
               }];
    }


    

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
        return 90;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    JYCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JYCCell" forIndexPath:indexPath];
    NSArray * arr = self.cabListArr[indexPath.section];
    if (indexPath.row<arr.count-1) {
        cablistModel *model = arr[indexPath.row+1];
        [cell showDataWithModel:model indexPath:indexPath];
    }
    
    
    
 
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   [self setProgressHud2];
    if (self.isSingle) {
        LXPlaneTicketOrderViewController *lxOrderVc=[[LXPlaneTicketOrderViewController alloc] init];
        //这里应该传arr
        NSMutableArray *chuArr=[[NSMutableArray alloc]init];//传值数组

        baseModel *bmodel=self.baseArr[indexPath.section];
        [chuArr addObject:bmodel];
        
        NSArray * arr = self.cabListArr[indexPath.section];
        cablistModel *cmodel = arr[indexPath.row+1];
        [chuArr addObject:cmodel];
        //验票
        NSDictionary *parameters = @{@"flightno":bmodel.FlightNo,@"s":bmodel.s_airport[@"city_code"],@"e":bmodel.e_airport[@"city_code"],@"sd":[bmodel.OffTime substringWithRange:NSMakeRange(0,10)],@"cabin":cmodel.Cabin,@"fare":cmodel.Fare,@"ischd":@"0",@"isspe":cmodel.IsSpe,@"istehui":cmodel.IsTeHui,@"userrate":cmodel.UserRate,@"stime":[bmodel.OffTime substringWithRange:NSMakeRange(11,5)],@"iskx":cmodel.IsKx,@"kxsiteid":cmodel.KxSiteID,@"kxspvalue":cmodel.KxSpValue};

       
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [_manager POST:CheckFlightPriceUrl parameters:parameters
              success:^(AFHTTPRequestOperation *operation,id responseObject) {
    
                  NSString *html = operation.responseString;
                  NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
                  NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
                  //NSLog(@"%@++",dict);
                  NSDictionary *dict2=dict[@"data"];
                  //NSLog(@"%@",dict2[@"canbook"]);
                  if ([[dict objectForKey:@"state"] integerValue]==1&&[dict2[@"canbook"]isEqual:@"true"]&&[dict2[@"c"]isEqualToString:@"0000"]){
                    
                          lxOrderVc.planeInfoArray=chuArr;
                          [self.navigationController pushViewController:lxOrderVc animated:YES];
                          [_hud hide:YES];

                    }else{
                      [_hud hide:YES];
                      [[LXAlterView sharedMyTools] createTishi:@"验票失败，请重新选择"];
                  }
       
              }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                  //[[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
                  [[LXAlterView sharedMyTools] createTishi:@"网络请求失败，请稍后重试"];
                  [_hud hide:YES];
                  
              }];
        }else if(self.isSingle==NO)
    {
        JYCBackTicketVC *BackVC=[[JYCBackTicketVC alloc]init];
        NSMutableArray *chuArr=[[NSMutableArray alloc]init];//传值数组
        
        baseModel *bmodel=self.baseArr[indexPath.section];
        [chuArr addObject:bmodel];
        
        NSArray * arr = self.cabListArr[indexPath.section];
        cablistModel *cmodel = arr[indexPath.row+1];
        [chuArr addObject:cmodel];

        NSDictionary *parameters = @{@"flightno":bmodel.FlightNo,@"s":bmodel.s_airport[@"city_code"],@"e":bmodel.e_airport[@"city_code"],@"sd":[bmodel.OffTime substringWithRange:NSMakeRange(0,10)],@"cabin":cmodel.Cabin,@"fare":cmodel.Fare,@"ischd":@"0",@"isspe":cmodel.IsSpe,@"istehui":cmodel.IsTeHui,@"userrate":cmodel.UserRate,@"stime":[bmodel.OffTime substringWithRange:NSMakeRange(11,5)],@"iskx":cmodel.IsKx,@"kxsiteid":cmodel.KxSiteID,@"kxspvalue":cmodel.KxSpValue};
        //NSLog(@"jyc---%@",parameters);
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [_manager POST:CheckFlightPriceUrl parameters:parameters
               success:^(AFHTTPRequestOperation *operation,id responseObject) {
                   
                   NSString *html = operation.responseString;
                   NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
                   NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
                   //NSLog(@"%--@++",dict);
                   NSDictionary *dict2=dict[@"data"];
                   if ([[dict objectForKey:@"state"]integerValue]==1&&[dict2[@"canbook"]isEqual:@"true"]&&[dict2[@"c"]isEqualToString:@"0000"]) {
                       [_hud hide:YES];
                       BackVC.receiveArr=chuArr;//下个页面接收一下到时候和返回页面的数组一起传给订单页面
                       // BackVC.backUrl=self.backUrl;在下个页面拼接，这里不传了
                       BackVC.backTime=self.backTime;
                       BackVC.backTittle=self.bTitle;
                       BackVC.startCity=self.startCity;
                       BackVC.endCity=self.endCity;
                       BackVC.backReceiveWeek=self.backReceiveWeek;
                       BackVC.backWeek=self.backWeek;
                       [self.navigationController pushViewController:BackVC animated:YES];
                       
                   }else{
                       [_hud hide:YES];
                       [[LXAlterView sharedMyTools] createTishi:@"验票失败，请重新选择"];
                   }
                   
               }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                   //[[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
                   [[LXAlterView sharedMyTools] createTishi:@"网络请求失败，请稍后重试"];
                   [_hud hide:YES];
                   
               }];
         }
}


#pragma mark --btnClick
-(void)btnClick:(UIButton *)btn
{
    
    if (btn.tag==101) {
        
        [startTimeBtn setBackgroundImage:Up?[UIImage imageNamed:@"从低到高j"]:[UIImage imageNamed:@"从高到低j"] forState:UIControlStateNormal];
        startLabel.text=Up ? @"从早到晚":@"从晚到早";
        
        [ticketBtn setBackgroundImage:[UIImage imageNamed:@"票价"] forState:UIControlStateNormal];
         ticketLabel.text=@"票价";
        [self.baseArr removeAllObjects];
        [self.cabListArr removeAllObjects];
        [self.baseArr addObjectsFromArray:self.superHeaderArr ];
        [self.cabListArr addObjectsFromArray:self.superCellArr];
        
         if ([startLabel.text isEqualToString:@"从晚到早"]) {
            self.baseArr = (NSMutableArray *)[[self.baseArr reverseObjectEnumerator] allObjects];
            self.cabListArr = (NSMutableArray *)[[self.cabListArr reverseObjectEnumerator] allObjects];
            
        }
        
        [self.tableView reloadData];
        Up=!Up;

        
    }else if(btn.tag==102)
    {
        
        [ticketBtn setBackgroundImage:Up?[UIImage imageNamed:@"从高到低j"]:[UIImage imageNamed:@"从低到高j"] forState:UIControlStateNormal];
        ticketLabel.text=Up ? @"由高到低":@"由低到高";
        [startTimeBtn setBackgroundImage:[UIImage imageNamed:@"时间"] forState:UIControlStateNormal];
        startLabel.text=@"起飞时间";
        if (self.baseArr.count>0) {
            
        
        if ([ticketLabel.text isEqualToString:@"由低到高"]) {
            
            [self.baseArr removeAllObjects];
            [self.cabListArr removeAllObjects];
            [self.baseArr addObjectsFromArray:self.superHeaderArr ];
            [self.cabListArr addObjectsFromArray:self.superCellArr];
            
            BOOL isSWap = YES;
            for (int i = 0; i < self.baseArr.count - 1 ; i++) {
                isSWap = NO;
                
                for (int j = 0; j < self.baseArr.count - 1 - i; j++) {
                    baseModel * headerModel_1 = [self.baseArr objectAtIndex:j];
                    baseModel * headerModel_2 = [self.baseArr objectAtIndex:j + 1];
                    if ([headerModel_1.MinFare intValue] > [headerModel_2.MinFare intValue] ) {
                        isSWap = YES;
                        [self.baseArr exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
                        [self.cabListArr exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
                    }
                }
                
            }
            
        } else {
            [self.baseArr removeAllObjects];
            [self.cabListArr removeAllObjects];
            [self.baseArr addObjectsFromArray:self.superHeaderArr ];
            [self.cabListArr addObjectsFromArray:self.superCellArr];

            BOOL isSWap = YES;
            for (int i = 0; i < self.baseArr.count - 1 ; i++) {
                isSWap = NO;
                
                for (int j = 0; j < self.baseArr.count - 1 - i; j++) {
                    baseModel * headerModel_1 = [self.baseArr objectAtIndex:j];
                    baseModel * headerModel_2 = [self.baseArr objectAtIndex:j + 1];
                    if ([headerModel_1.MinFare intValue] < [headerModel_2.MinFare intValue] ) {
                        isSWap = YES;
                        [self.baseArr exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
                        [self.cabListArr exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
                    }
                }
                
            }
            
        }
    }
        [self.tableView reloadData];

        Up=!Up;
    }else if(btn.tag==103){
        [startTimeBtn setBackgroundImage:[UIImage imageNamed:@"时间"] forState:UIControlStateNormal];
        startLabel.text=@"起飞时间";
        [ticketBtn setBackgroundImage:[UIImage imageNamed:@"票价"] forState:UIControlStateNormal];
        ticketLabel.text=@"票价";
        if (self.chooseCompanyView) {
            [UIView animateWithDuration:1 animations:^{
                self.burlView.hidden = NO;
                self.chooseCompanyView.hidden = NO;
            }];
            return;
        }
        
        
        self.chooseCompanyView = [[UIView alloc] initWithFrame:CGRectMake(0, ControllerViewHeight - 50 - (self.companyArr.count + 2) * 40, windowContentWidth, (self.companyArr.count + 2) * 40)];
        self.chooseCompanyView.backgroundColor = [UIColor grayColor];
        UIView * backButView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 40)];
        backButView.backgroundColor = [UIColor whiteColor];
        [self.chooseCompanyView addSubview:backButView];
        
        UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 15, ViewHeight(self.chooseCompanyView) - 40)];
        leftView.backgroundColor = [UIColor whiteColor];
        [self.chooseCompanyView addSubview:leftView];
        
        for (int i = 0; i < self.companyArr.count + 2; i++) {
            if (i == 0) {
                UIButton * cancelBut = [UIButton buttonWithType:UIButtonTypeCustom];
                cancelBut.frame = CGRectMake(20, 5, 40, 30);
                [cancelBut setTitle:@"取消" forState:UIControlStateNormal];
                [cancelBut setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                [cancelBut addTarget:self action:@selector(cancelView:) forControlEvents:UIControlEventTouchUpInside];
                [self.chooseCompanyView addSubview:cancelBut];
                
                UIButton * confirmBut = [UIButton buttonWithType:UIButtonTypeCustom];
                confirmBut.frame = CGRectMake(windowContentWidth - 20 - 40, 5, 40, 30);
                [confirmBut setTitle:@"确定" forState:UIControlStateNormal];
                [confirmBut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                [confirmBut addTarget:self action:@selector(confirmView:) forControlEvents:UIControlEventTouchUpInside];
                [self.chooseCompanyView addSubview:confirmBut];
                
            } else {
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, i * 40, windowContentWidth - 15, 39.5)];
                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
                [label addGestureRecognizer:tap];
                label.userInteractionEnabled = YES;
                label.font = [UIFont systemFontOfSize:16];
                if (i == 1) {
                    label.text = @"不限";
                    label.textColor = [UIColor orangeColor];
                    self.templabel = label;
                    self.companyStr = @"不限";
                    self.zeroLabel = label;
                } else {
                    label.text = [[self.companyArr objectAtIndex:i - 2] objectForKey:@"name"];
                    
                }
                label.backgroundColor = [UIColor whiteColor];
                [self.chooseCompanyView addSubview:label];
            }
        }
        self.burlView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ViewY(_chooseCompanyView))];
        self.burlView.backgroundColor = [UIColor blackColor];
        _burlView.alpha = 0.5;
        [self.view addSubview:self.chooseCompanyView];
        [self.view addSubview:_burlView];
        
    

    }
}
- (void)cancelView:(UIButton *)button {
    self.chooseCompanyView.hidden = YES;
    self.burlView.hidden = YES;
}
- (void)confirmView:(UIButton *)button {
    self.chooseCompanyView.hidden = YES;
    self.burlView.hidden = YES;
    
    comLabel.text=self.companyStr;

    [self.baseArr removeAllObjects];
    [self.cabListArr removeAllObjects];
    if ([self.companyStr isEqualToString:@"不限"]) {
        [self.baseArr addObjectsFromArray:self.superHeaderArr];
        [self.cabListArr addObjectsFromArray:self.superCellArr ];
        [self.tableView reloadData];
        
        return;
    }
    for (int i = 0; i < self.superHeaderArr.count; i++ ) {
        baseModel * headerModel = [self.superHeaderArr objectAtIndex:i];
        if ([headerModel.CarrinerName isEqualToString:self.companyStr]) {
            [self.baseArr addObject:headerModel];
            [self.cabListArr addObject:[self.superCellArr objectAtIndex:i]];
        }
    }
    self.tableView.tableFooterView=_footView;
    [self.tableView reloadData];
}

- (void)tapView:(UITapGestureRecognizer *)tap {
    self.templabel.textColor = [UIColor blackColor];
    UILabel * label = (UILabel *)tap.view;
    label.textColor = [UIColor orangeColor];
    self.templabel = label;
    self.companyStr = label.text;
}
//点击日历的响应
-(void)butClick
{
    LXPlaneCalendarViewController *lxplaneCal=[[LXPlaneCalendarViewController alloc] init];
    [lxplaneCal setTrainToDay:365 ToDateforString:nil price:100];
    lxplaneCal.calendarblock= ^ (CalendarDayModel *model){
        if ([[model toString] isEqualToString:currentStr]) {
            NSString *date=[[model toString]substringWithRange:NSMakeRange(5, 5)];//显示的日期
            view.middleLabel.text=[NSString stringWithFormat:@"%@\n%@",date,[model getWeek]];
            view.leftLabel.text=@"暂无";
            NSString *tomStr=[JYCTools getTomStrWithCurrentStr:[model toString]];
            NSString *str2=[tomStr substringWithRange:NSMakeRange(5,5)];
            int week=(int)model.week;//从日历传过来的星期转化为int型
            NSString *tomWeek=[JYCTools getWeekStringFromInteger:++week];//第二天的周几
            
            view.rightLabel.text=[NSString stringWithFormat:@"%@\n%@",str2,tomWeek];
            NSString *urlString=[NSString stringWithFormat:@"%@s_city=%@&e_city=%@&sd=%@",PlaneTicketUrl,self.startCity,self.endCity,[NSString stringWithFormat:@"%@%@",[[model toString]substringWithRange:NSMakeRange(0,5)],[view.middleLabel.text substringWithRange:NSMakeRange(0,5)]]];
            NSString *url=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [self loadDataWith:url];
            comLabel.text=@"航空公司";
            self.companyStr=@"不限";
            self.templabel.textColor = [UIColor blackColor];
            self.zeroLabel.textColor = [UIColor orangeColor];
            self.templabel = self.zeroLabel;
        }else {
            
            NSString *date=[[model toString]substringWithRange:NSMakeRange(5, 5)];
            view.middleLabel.text=[NSString stringWithFormat:@"%@\n%@",date,[model getWeek]];
            NSString *yesStr=[JYCTools getYesStrWithCurrenStr:[model toString]];
            //NSLog(@"%@",self.startTime);
            NSString *str1=[yesStr substringWithRange:NSMakeRange(5, 5)];
            int week1=(int)model.week;
            NSString *yesWeek=[JYCTools getWeekStringFromInteger:--week1];//昨天的周几
            view.leftLabel.text=[NSString stringWithFormat:@"%@\n%@",str1,yesWeek];
            NSString *tomStr=[JYCTools getTomStrWithCurrentStr:[model toString]];
            NSString *str2=[tomStr substringWithRange:NSMakeRange(5, 5)];
            int week2=(int)model.week;
            NSString *tomWeek=[JYCTools getWeekStringFromInteger:++week2];
            view.rightLabel.text=[NSString stringWithFormat:@"%@\n%@",str2,tomWeek];
            
            NSString *urlString=[NSString stringWithFormat:@"%@s_city=%@&e_city=%@&sd=%@",PlaneTicketUrl,self.startCity,self.endCity,[NSString stringWithFormat:@"%@%@",[[model toString]substringWithRange:NSMakeRange(0,5)],[view.middleLabel.text substringWithRange:NSMakeRange(0,5)]]];
            NSString *url=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [self loadDataWith:url];
            comLabel.text=@"航空公司";
            self.companyStr=@"不限";
            self.zeroLabel.textColor = [UIColor orangeColor];
            self.templabel.textColor = [UIColor blackColor];
            self.templabel = self.zeroLabel;

        }

    };
    [self.navigationController pushViewController:lxplaneCal animated:YES];
}



//数据加载完成之前显示转动的菊花圈
- (void)setProgressHud1
{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"请稍等，正在为您查询航班信息...";
    
    [self.view addSubview:_hud];
    [_hud show:YES];
}
- (void)setProgressHud2
{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"价格验证中，请稍候...";
    
    [self.view addSubview:_hud];
    [_hud show:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

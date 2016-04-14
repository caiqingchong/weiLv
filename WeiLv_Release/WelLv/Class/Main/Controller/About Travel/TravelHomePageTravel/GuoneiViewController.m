//
//  GuoneiViewController.m
//  WelLv
//
//  Created by 赵冉 on 16/1/14.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "GuoneiViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "GuoneiyouTableViewCell.h"
#import "GuoneiyouModel.h"
#import "ZongheVc.h"
#import "ShaixuanVc.h"
#import "ProductDetailViewController.h"
#import "MainIconAndTitleVIew.h"
#import "TravelAllHeader.h"
#import "Desmodel.h"
#define M_LEFT_WIDTH 15
#define M_TOP_WIDTH 10
#define M_GAP_WIDTH 10
#define M_CELL_HEIGHT 90
#define M_PRICELABEL_HEIGHT 25



#define PAGECOUNT 10//页数个数

@interface GuoneiViewController ()<UITableViewDataSource,UITableViewDelegate,Zonghedelegate,Shaixuandlegate>{
    
    int page; //刷新页数
}
@property(nonatomic,strong)UITableView * tablevc;
@property(nonatomic,strong)UIView * LowView;//底部试图
@property(nonatomic,strong)NSMutableArray * Datasource;//数据源
@property(nonatomic,strong)UIImageView *blackImageView;
@property(nonatomic,strong)NSMutableArray *destinationSource;//数据源
@end

@implementation GuoneiViewController

-(NSMutableArray *)destinationSource
{

    if (_destinationSource == nil) {
        _destinationSource = [NSMutableArray array];
    }
    return _destinationSource;
}
-(UIImageView *)blackImageView
{

    if (_blackImageView == nil) {
        static int Height = 67 / 2+50;
        static int distance = 50;
        static int y = 80;
        switch ((int)windowContentHeight) {
            case 667:
                Height = 80 / 2 + 80;
                distance = 60;
                y = 100;
                break;
            case 736:
                Height = 132 / 2 + 120;
                distance = 80;
                y = 150;
                break;
            default:
                break;
        }
        _blackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(distance,y, windowContentWidth-2*distance, windowContentHeight - Height - 64-y)];

        _blackImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:_blackImageView];
    }
    return _blackImageView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.blackImageView.hidden = YES;
    _city_id=[[WLSingletonClass defaultWLSingleton] wlCityId];
     NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"line"];
    self.navigationItem.title = _cityTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    _Datasource = [NSMutableArray array];
    _dic = [NSMutableDictionary dictionary];
    page = 1;//首页

    [self getdata];//获取目的地数据
    [self createTablevc];
    [self createLowview];
  

}
#pragma mark -- 创建tablevc
- (void)createTablevc{
    
    static int Height = 67 / 2;
    switch ((int)windowContentHeight) {
        case 667:
            Height = 80 / 2;
            break;
        case 736:
            Height = 132 / 2;
            break;
        default:
            break;
    }

    self.tablevc = [[UITableView alloc] initWithFrame:CGRectMake(0,0, windowContentWidth, windowContentHeight - Height - 64)];
    self.tablevc.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tablevc.dataSource = self;
    self.tablevc.delegate = self;
    self.tablevc.rowHeight = 90;
    self.tablevc.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tablevc];
   
    [self refresh];
    
}
#pragma mark -- 刷新控件(1个参数)
- (void)refresh{
    page = 0;
     NSMutableArray *imageAray=[NSMutableArray array];
    self.tablevc.separatorStyle=UITableViewCellSeparatorStyleNone;
    for (int i=0; i<2; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"单独-logo%d.png", i+2]];
        [imageAray addObject:image];
    }
    //-----------下拉刷新
    __weak GuoneiViewController *weakSelf = self;
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [_tablevc addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [_tablevc addGifFooterWithRefreshingBlock:^{
        [weakSelf loadLastData];
    }];
    // 设置普通状态的动画图片
    [self.tablevc.gifHeader setImages:imageAray forState:MJRefreshHeaderStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self.tablevc.gifHeader setImages:imageAray forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self.tablevc.gifHeader setImages:imageAray forState:MJRefreshHeaderStateRefreshing];
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    // 马上进入刷新状态
    [self.tablevc.gifHeader beginRefreshing];
    

}
#pragma mark --- 下拉刷新
-(void)loadNewData
{

    if (self.lastViewControllerTag) {
        [self GetdataWithUrl:SHAIXUAN andPage:1];
     } else {
    
    if (_sortstr == nil && _dic.count == 0&&_category_id == 0&&_titles == nil) {
      [self loadDataWithUrl:GUINEILINE andPage:1];
    }
    else
    {
       if ([_cityTitle isEqualToString:@"海岛假期"]&&_dic.count == 0&&_sortstr.length==0) {
            [self loadDataWithUrl:GUINEILINE andPage:1];
       }
       else if ([_cityTitle isEqualToString:@"踏青登山"]&&_dic.count == 0&&_sortstr.length==0) {
            [self loadDataWithUrl:GUINEILINE andPage:1];
        }
        
        if (_dic.count > 0||_sortstr.length != 0) {
            [self GetdataWithUrl:GUINEILINE andPage:1];
        }
        
    }
    }
    
}

#pragma mark --- 加载更多
-(void)loadLastData
{
    if (self.lastViewControllerTag) {
        
        if (self.Datasource.count < page * PAGECOUNT) {
            [self.tablevc.footer endRefreshing];
            [[LXAlterView sharedMyTools]createTishi:@"没有更多消息了....亲"];
        }
        else
        {
            page++;
            [self GetdataWithUrl:GUINEILINE andPage:page];
        }
        
        
    }else {
    
    if (_sortstr == nil && _dic.count == 0) {
        
        if (self.Datasource.count < page * PAGECOUNT) {
            [self.tablevc.footer endRefreshing];
            [[LXAlterView sharedMyTools]createTishi:@"没有更多消息了....亲"];
        }
        else
        {
        page++;
          [self loadDataWithUrl:GUINEILINE andPage:page];
        }
        
    }
    else{
        
        if (_dic.count == 0) {
            if (self.Datasource.count < page * PAGECOUNT) {
                [self.tablevc.footer endRefreshing];
                [[LXAlterView sharedMyTools]createTishi:@"没有更多消息了....亲"];
            }
            else
            {
                page++;
                [_tablevc reloadData];
               
                [self GetdataWithUrl:GUINEILINE andPage:page];
            }
         }
         if (_sortstr == nil) {
            if (self.Datasource.count < page * PAGECOUNT) {
                [self.tablevc.footer endRefreshing];
                [[LXAlterView sharedMyTools]createTishi:@"没有更多消息了....亲"];
            }
            else
            {
                page++;
               // [_tablevc reloadData];
                [self GetdataWithUrl:GUINEILINE andPage:page];
            }
            
        }
        
    }
    }
}
#pragma mark --- 加载数据
/**
 *  加载数据
 */
- (void)loadDataWithUrl:(NSString *)urlStr andPage:(NSInteger)pages
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary * paramer = [NSMutableDictionary dictionary];
    [paramer setObject:_city_id forKey:@"city_id"];
    [paramer setObject:[NSString stringWithFormat:@"%ld",(long)_rote_ID] forKey:@"route_type"];
    [paramer setObject:@(pages) forKey:@"offset"];
    
    if ([[WLSingletonClass defaultWLSingleton]wlUserType]==WLMemberTypeSteward)
    {
        NSString *assistant_id =  [WLSingletonClass defaultWLSingleton].modelSteawrd.uid;
        [paramer setObject:assistant_id forKey:@"assistant_id"];
        
    }
    if ([_cityTitle isEqualToString:@"踏青登山"]) {
      [paramer setObject:@"踏青-山" forKey:@"title"];
    }
    else if ([_cityTitle isEqualToString:@"海岛假期"])
    {
    [paramer setObject:@"60" forKey:@"category_id"];
    }
    
    if ([self.lastViewControllerTag isEqualToString:@"100"])
    {
        [paramer removeAllObjects];
        if ([[WLSingletonClass defaultWLSingleton]wlUserType]==WLMemberTypeSteward)
        {
            NSString *assistant_id =  [WLSingletonClass defaultWLSingleton].modelSteawrd.uid;
            [paramer setObject:assistant_id forKey:@"assistant_id"];
            
        }
        [paramer setObject:_city_id forKey:@"city_id"];
        [paramer setObject:@(pages) forKey:@"offset"];
        [paramer setObject:self.productListTitle forKey:@"title"];
        [paramer setObject:self.search_type forKey:@"search_type"];
        [paramer setObject:[NSString stringWithFormat:@"%ld",(long)_rote_ID] forKey:@"route_type"];
        
    } else if ([self.lastViewControllerTag isEqualToString:@"200"])
    {
        [paramer removeAllObjects];
        if ([[WLSingletonClass defaultWLSingleton]wlUserType]==WLMemberTypeSteward)
        {
            NSString *assistant_id =  [WLSingletonClass defaultWLSingleton].modelSteawrd.uid;
            [paramer setObject:assistant_id forKey:@"assistant_id"];
            
        }
        
        
        [paramer setObject:@(pages) forKey:@"offset"];
        [paramer setObject:self.productListTitle forKey:@"title"];
        [paramer setObject:self.search_type forKey:@"search_type"];
        //        [paramer setObject:_city_id forKey:@"city_id"];
    } else if ([self.lastViewControllerTag isEqualToString:@"300"]) {
        
        [paramer removeAllObjects];
        if ([[WLSingletonClass defaultWLSingleton]wlUserType]==WLMemberTypeSteward)
        {
            NSString *assistant_id =  [WLSingletonClass defaultWLSingleton].modelSteawrd.uid;
            [paramer setObject:assistant_id forKey:@"assistant_id"];
            
        }
        
        
        [paramer setObject:@(pages) forKey:@"offset"];
        [paramer setObject:_city_id forKey:@"city_id"];
        [paramer setObject:self.productListTitle forKey:@"title"];
        [paramer setObject:self.search_type forKey:@"search_type"];
        [paramer setObject:[NSString stringWithFormat:@"%ld",(long)_rote_ID] forKey:@"route_type"];
    } else if ([self.lastViewControllerTag isEqualToString:@"首页轮播图"]) {
        
        [paramer removeAllObjects];
        if ([[WLSingletonClass defaultWLSingleton]wlUserType]==WLMemberTypeSteward)
        {
            NSString *assistant_id =  [WLSingletonClass defaultWLSingleton].modelSteawrd.uid;
            [paramer setObject:assistant_id forKey:@"assistant_id"];
            
        }
        
        
        [paramer setObject:@(pages) forKey:@"offset"];
        [paramer setObject:_city_id forKey:@"city_id"];
        [paramer setObject:[NSString stringWithFormat:@"%ld",(long)_rote_ID] forKey:@"route_type"];
        [paramer setObject:self.t_city forKey:@"t_city"];
        [paramer setObject:self.t_country forKey:@"t_country"];
        [paramer setObject:self.t_province forKey:@"t_city"];
       
    }
   
    NSString *url=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [manager POST:url parameters:paramer success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *code =[NSString stringWithFormat:@"%@",dic[@"status"]] ;
        DLog(@"%@",dic);
        if ([code isEqualToString:@"1"]) {
            [self showTableView];
            [self.tablevc.header endRefreshing];
            [self.tablevc.footer endRefreshing];
            NSArray * arr = dic[@"data"];
            if (pages == 1) {
                [_Datasource removeAllObjects];
            }
            
            for (NSDictionary * dic in arr) {
                GuoneiyouModel * model = [[GuoneiyouModel alloc]init];
                model.adult_price = dic[@"adult_price"];
                //返佣金额：只保留小数点后两位:
                model.gj_adult_rebate = [NSString stringWithFormat:@"%0.2f",[dic[@"gj_adult_rebate"]floatValue]];
                model.product_name = dic[@"product_name"];
                model.thumb = dic[@"thumb"];
                model.timetable_range = dic[@"timetable_range"];
                model.product_id = dic[@"product_id"];
                model.timeTableArr = dic[@"timetables"];
                model.pay_way = dic[@"pay_way"];
                model.parent_pay_way = [self judgeString:dic[@"parent_pay_way"]]?dic[@"parent_pay_way"]:@"";
                [_Datasource addObject:model];
            }
            self.tablevc.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            [self.tablevc reloadData];
        }
        else
        {
            [self.tablevc.header endRefreshing];
            [self.tablevc.footer endRefreshing];
            
            if (self.Datasource.count == 0 &&pages == 1) {
            [self zxdView];
           
        }
        
      [self.tablevc reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tablevc.header endRefreshing];
        [self.tablevc.footer endRefreshing];
        
        self.blackImageView.hidden = NO;
        self.tablevc.hidden = YES;
        self.blackImageView.image = [UIImage imageNamed:@"暂无网络"];
        self.blackImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(refreshPageContent:)];
        [self.blackImageView addGestureRecognizer:tap];
        
        self.tablevc.separatorStyle=UITableViewCellSeparatorStyleNone;
        [self.tablevc reloadData];
    }];
}

#pragma mark---- 点击刷新图片方法 ----
- (void)refreshPageContent:(UITapGestureRecognizer *)tap {
    NSLog(@"++++++++++++");
    [self loadNewData];
}
#pragma mark -- 多参数筛选
- (void)GetdataWithUrl:(NSString *)urlStr andPage:(NSInteger)pages
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary * paramer = [NSMutableDictionary dictionary];
    
    if (_dic.count > 0) {
      [paramer addEntriesFromDictionary:_dic];
    }
    else if (_sortstr)
    {
     [paramer setObject:_sortstr forKey:@"sort"];
    }
    
    if ([_cityTitle isEqualToString:@"海岛假期"]) {
         [paramer setObject:@"60" forKey:@"category_id"];
    }

    if ([_cityTitle isEqualToString:@"踏青登山"]) {
        [paramer setObject:@"踏青-山" forKey:@"title"];
    }
    

    if ([[WLSingletonClass defaultWLSingleton]wlUserType]==WLMemberTypeSteward)
    {
        NSString *assistant_id =  [WLSingletonClass defaultWLSingleton].modelSteawrd.uid;
        [paramer setObject:assistant_id forKey:@"assistant_id"];
        
    }

    
    [paramer setObject:_city_id forKey:@"city_id"];
    [paramer setObject:[NSString stringWithFormat:@"%ld",(long)_rote_ID] forKey:@"route_type"];

    
    if ([self.lastViewControllerTag isEqualToString:@"100"])
    {
        
        [paramer removeAllObjects];
        if ([[WLSingletonClass defaultWLSingleton]wlUserType]==WLMemberTypeSteward)
        {
            NSString *assistant_id =  [WLSingletonClass defaultWLSingleton].modelSteawrd.uid;
            [paramer setObject:assistant_id forKey:@"assistant_id"];
            
        }
        
        if (_dic.count > 0) {
            [paramer addEntriesFromDictionary:_dic];
        }
        else if (_sortstr)
        {
            [paramer setObject:_sortstr forKey:@"sort"];
        }
        
        [paramer setObject:_city_id forKey:@"city_id"];
        [paramer setObject:self.productListTitle forKey:@"title"];
        [paramer setObject:self.search_type forKey:@"search_type"];
        [paramer setObject:[NSString stringWithFormat:@"%ld",(long)_rote_ID] forKey:@"route_type"];
     } else if ([self.lastViewControllerTag isEqualToString:@"200"])
    {
        [paramer removeAllObjects];
        //_rote_ID = -11;


        if (_dic.count > 0) {
            [paramer addEntriesFromDictionary:_dic];
        }
        else if (_sortstr)
        {
            [paramer setObject:_sortstr forKey:@"sort"];
        }
        
        if ([[WLSingletonClass defaultWLSingleton]wlUserType]==WLMemberTypeSteward)
        {
            NSString *assistant_id =  [WLSingletonClass defaultWLSingleton].modelSteawrd.uid;
            [paramer setObject:assistant_id forKey:@"assistant_id"];
            
        }
        
        [paramer setObject:self.productListTitle forKey:@"title"];
        [paramer setObject:self.search_type forKey:@"search_type"];
        

        
    } else if ([self.lastViewControllerTag isEqualToString:@"300"]) {
        [paramer removeAllObjects];
        if (_dic.count > 0) {
            [paramer addEntriesFromDictionary:_dic];
        }
        else if (_sortstr)
        {
            [paramer setObject:_sortstr forKey:@"sort"];
        }
        

        if ([[WLSingletonClass defaultWLSingleton]wlUserType]==WLMemberTypeSteward)
        {
            NSString *assistant_id =  [WLSingletonClass defaultWLSingleton].modelSteawrd.uid;
            [paramer setObject:assistant_id forKey:@"assistant_id"];
            
        }

        [paramer setObject:_city_id forKey:@"city_id"];
        [paramer setObject:self.productListTitle forKey:@"title"];
        [paramer setObject:self.search_type forKey:@"search_type"];
        [paramer setObject:[NSString stringWithFormat:@"%ld",(long)_rote_ID] forKey:@"route_type"];
    
    } else if ([self.lastViewControllerTag isEqualToString:@"首页轮播图"]) {

        [paramer removeAllObjects];
        
        if (_dic.count > 0) {
            [paramer addEntriesFromDictionary:_dic];
        }
        else if (_sortstr)
        {
            [paramer setObject:_sortstr forKey:@"sort"];
        }
        
        if ([[WLSingletonClass defaultWLSingleton]wlUserType]==WLMemberTypeSteward)
        {
            NSString *assistant_id =  [WLSingletonClass defaultWLSingleton].modelSteawrd.uid;
            [paramer setObject:assistant_id forKey:@"assistant_id"];
            
        }
        
        [paramer setObject:_city_id forKey:@"city_id"];
        [paramer setObject:[NSString stringWithFormat:@"%ld",(long)_rote_ID] forKey:@"route_type"];
        [paramer setObject:self.t_city forKey:@"t_city"];
        [paramer setObject:self.t_country forKey:@"t_country"];
        [paramer setObject:self.t_province forKey:@"t_province"];
        
    }
     [paramer setObject:@(pages) forKey:@"offset"];
    
    
    DLog(@"%@------%@",urlStr,paramer);
    
    [manager POST:urlStr parameters:paramer success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        DLog(@"%@",dic);
        NSString *code =[NSString stringWithFormat:@"%@",dic[@"status"]] ;
        if ([code isEqualToString:@"1"]) {
            [self showTableView];
            [self.tablevc.header endRefreshing];
            [self.tablevc.footer endRefreshing];
            NSArray * arr = dic[@"data"];
            if (pages == 1) {
                [_Datasource removeAllObjects];
            }
             for (NSDictionary * dic in arr) {
                GuoneiyouModel * model = [[GuoneiyouModel alloc]init];
                 model.adult_price = dic[@"adult_price"];
                 model.gj_adult_rebate = dic[@"gj_adult_rebate"];
                 model.product_name = dic[@"product_name"];
                 model.thumb = dic[@"thumb"];
                 model.timetable_range = dic[@"timetable_range"];
                 model.product_id = dic[@"product_id"];
                 model.timeTableArr = dic[@"timetables"];
                 [_Datasource addObject:model];
            }
            [self.tablevc reloadData];
        }else if ([code isEqualToString:@"0"]){
            [self.tablevc.header endRefreshing];
            [self.tablevc.footer endRefreshing];
            [self zxdView];
        }else
        {
            [self.tablevc.header endRefreshing];
            [self.tablevc.footer endRefreshing];
            if (pages == 1) {
                [self zxdView];
            }
            //[[LXAlterView sharedMyTools]createTishi:@"暂无相关产品"];
            [self.tablevc reloadData];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        DLog(@"%@",error.description);
        [self.tablevc.header endRefreshing];
        [self.tablevc.footer endRefreshing];
        self.blackImageView.hidden = NO;
        self.tablevc.hidden = YES;
        self.blackImageView.image = [UIImage imageNamed:@"暂无网络"];
        self.blackImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(refreshPageContent:)];
        [self.blackImageView addGestureRecognizer:tap];
        [self.tablevc reloadData];
        
    }];
    
}

#pragma mark -- 创建底部试图
- (void)createLowview{
    
    self.LowView = [[UIView alloc] initWithFrame:CGRectMake(0, windowContentHeight - windowContentHeight / 16.67-64, windowContentWidth, windowContentHeight / 16.67)];
//    self.LowView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.75];
    self.LowView.backgroundColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1.0];
//    self.LowView.alpha = 0.8;
    [self.view addSubview:_LowView];
    //中间白线
    UILabel * lableline = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 2, 10, 1, windowContentHeight / 16.67 - 20)];
    lableline.backgroundColor = [UIColor whiteColor];
    [_LowView addSubview:lableline];
    //左右按钮：综合，筛选
    UIButton * Leftbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth / 2, windowContentHeight / 16.67)];
    [Leftbutton setTitle:@"  综合" forState:UIControlStateNormal];
    [Leftbutton addTarget:self action:@selector(OnleftbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [Leftbutton setImage:[UIImage imageNamed:@"综合"] forState:UIControlStateNormal];
    [_LowView addSubview:Leftbutton];
    
    UIButton * Rightbutton = [[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth / 2, 0 , windowContentWidth / 2, windowContentHeight / 16.67)];
    [Rightbutton setTitle:@"  筛选" forState:UIControlStateNormal];
    [Rightbutton addTarget:self action:@selector(OnrightbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [Rightbutton setImage:[UIImage imageNamed:@"筛选"] forState:UIControlStateNormal];
    [_LowView addSubview:Rightbutton];
    
}
#pragma mark  -左右按钮：综合，筛选点击时间
- (void)OnleftbuttonClick{
    ZongheVc * zonghevc = [[ZongheVc alloc]init];
    zonghevc.delegate = self;
    [self.view addSubview:zonghevc];
}
- (void)OnrightbuttonClick{
    
    if (self.destinationSource.count > 0) {
        ShaixuanVc * shaixuanvc = [[ShaixuanVc alloc]initWithCityID:_city_id andRouteType:[NSString stringWithFormat:@"%ld",_rote_ID]andDestination:self.destinationSource];
        shaixuanvc.delegate = self;
        
        [self.view addSubview:shaixuanvc];
    }
    else
    {
    [[LXAlterView sharedMyTools]createTishi:@"暂无相关数据!"];
    }
}

#pragma mark --  获取目的地数据
- (void)getdata
{
    [self.destinationSource removeAllObjects];
    AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    DLog(@"%@",DESTIONATUION);
    NSDictionary * parameters = @{@"route_type":[NSString stringWithFormat:@"%ld",_rote_ID],@"city_id":_city_id};
    [manger POST:DESTIONATUION parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dictroot = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        DLog(@"%@",dictroot);
        if ([dictroot[@"status"] intValue] == 1) {
            NSArray * array = dictroot[@"data"];
            for (NSDictionary * dict in array) {
                Desmodel * desmodel =[[Desmodel alloc]init];
                desmodel.region_name = dict[@"region_name"];
                desmodel.region_id = dict[@"region_id"];
                [self.destinationSource addObject:desmodel];
            }
        } else {
            //[self zxdView];
        }
        
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        self.blackImageView.hidden = NO;
//        self.tablevc.hidden = YES;
//        self.blackImageView.image = [UIImage imageNamed:@"暂无网络"];
//        self.blackImageView.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(refreshPageContent:)];
//        [self.blackImageView addGestureRecognizer:tap];
    }];
    
}


#pragma mark  -综合回调传值
- (void)Returnstr:(NSString *)str{
    _sortstr = str;
    [_dic removeAllObjects];
    [self refresh];
}

#pragma mark  -筛选回调传值
- (void)ReturnShaixuanstr:(NSMutableDictionary *)dict{
    _sortstr = nil;
    _dic = dict;
    [self loadNewData];
}

#pragma mark - 实现tablevc的协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _Datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GuoneiyouTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[GuoneiyouTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    GuoneiyouModel * model = _Datasource[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.isShowReturnPrice = [[WLSingletonClass defaultWLSingleton]wlUserType]==WLMemberTypeSteward?YES:NO;


    [cell config:model];
    
    NSMutableArray *dateArray = [NSMutableArray array];
    for (NSDictionary *dateDic in model.timeTableArr) {
        NSString *dateStr = dateDic[@"date_time"];
        NSString *litteDateStr = [dateStr substringFromIndex:5];
//        NSLog(@"%@",litteDateStr);
        [dateArray addObject:litteDateStr];
    }
    
    if (dateArray.count == 1) {
        cell.Datalable.text = [NSString stringWithFormat:@" %@出发",[dateArray firstObject]];
    } else if(dateArray.count > 1){
        cell.Datalable.text = [NSString stringWithFormat:@" %@、%@...出发",[dateArray firstObject],dateArray[1]];
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GuoneiyouModel *model = _Datasource[indexPath.row];
    ProductDetailViewController * productdetail = [[ProductDetailViewController alloc]init];
    productdetail.productID = model.product_id;
    productdetail.gj_commission = model.gj_adult_rebate;

    [self.navigationController pushViewController:productdetail animated:YES];
}

-(void)zxdView
{
    self.blackImageView.hidden = NO;
    self.blackImageView.image = [UIImage imageNamed:@"暂无相关数据-1"];
    self.tablevc.hidden = YES;

}

-(void)showTableView
{

    self.blackImageView.hidden = YES;
    self.tablevc.hidden = NO;

}

@end



//
//  TravelScreenViewController.m
//  WelLv
//
//  Created by 张子乾 on 16/2/22.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "TravelScreenViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "GuoneiyouTableViewCell.h"
#import "GuoneiyouModel.h"
#import "ZongheVc.h"
#import "ShaixuanVc.h"
#import "ProductDetailViewController.h"
#import "MainIconAndTitleVIew.h"
#import "TravelAllHeader.h"
#define M_LEFT_WIDTH 15
#define M_TOP_WIDTH 10
#define M_GAP_WIDTH 10
#define M_CELL_HEIGHT 90
#define M_PRICELABEL_HEIGHT 25

#define PAGECOUNT 10//页数个数


@interface TravelScreenViewController ()<UITableViewDataSource,UITableViewDelegate,Zonghedelegate,Shaixuandlegate>{
    
    int page; //刷新页数
}
@property(nonatomic,strong)UITableView * tablevc;
@property(nonatomic,strong)UIView * LowView;//底部试图
@property(nonatomic,strong)NSMutableArray * Datasource;//数据源

@property (nonatomic, strong) NSMutableDictionary *paramerDic;

@end

@implementation TravelScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _city_id=[[WLSingletonClass defaultWLSingleton] wlCityId];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"line"];
    self.navigationItem.title = _cityTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    _Datasource = [NSMutableArray array];
    _dic = [NSMutableDictionary dictionary];
    page = 1;//首页
    
    
    
    self.navigationItem.title = self.productListTitle;
    
    self.paramerDic = [NSMutableDictionary dictionary];
    
    
    [self createTablevc];
//    [self createLowview];
    
    
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
    
    
    self.tablevc = [[UITableView alloc] initWithFrame:CGRectMake(0,0, windowContentWidth, windowContentHeight - Height)];
    self.tablevc.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tablevc.dataSource = self;
    self.tablevc.delegate = self;
    self.tablevc.rowHeight = 90;
    [self.view addSubview:_tablevc];
    

    [self refresh];
    
    
}



#pragma mark -- 刷新控件(1个参数)
- (void)refresh{
    NSMutableArray *imageAray=[NSMutableArray array];
    self.tablevc.separatorStyle=UITableViewCellSeparatorStyleNone;
    for (int i=0; i<2; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"单独-logo%d.png", i+2]];
        [imageAray addObject:image];
    }
    
    //-----------下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [_tablevc addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
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
    if ([self.lastViewControllerTag isEqualToString:@"100"])
    {
        [self.paramerDic setObject:self.productListTitle forKey:@"title"];
        [self.paramerDic setObject:self.search_type forKey:@"search_type"];
        
        [self GetdataWithUrl:SHAIXUAN andPage:1];
        
    } else if ([self.lastViewControllerTag isEqualToString:@"200"])
    {
        [self.paramerDic setObject:self.productListTitle forKey:@"title"];
        [self.paramerDic setObject:self.search_type forKey:@"search_type"];
        [self.paramerDic setObject:_city_id forKey:@"city_id"];
        
        [self GetdataWithUrl:SHAIXUAN andPage:1];
    }
    
}


#pragma mark --- 加载更多


-(void)loadLastData

{
    
    if (_sortstr == nil && _dic.count == 0) {
        
        if (self.Datasource.count < page * PAGECOUNT) {
            [self.tablevc.footer endRefreshing];
            [[LXAlterView sharedMyTools]createTishi:@"没有更多消息了....亲"];
        }
        else
        {
            //page++;
            
            [_tablevc reloadData];
            
            [self loadWithUrl:WENQUAN andPage:1];
        }
        
        
    }else{
        
        if (_dic.count == 0) {
            if (self.Datasource.count < page * PAGECOUNT) {
                [self.tablevc.footer endRefreshing];
                [[LXAlterView sharedMyTools]createTishi:@"没有更多消息了....亲"];
            }
            else
            {
                //page++;
                [_tablevc reloadData];
                NSString *roteID = [NSString stringWithFormat:@"%ld",_rote_ID];
                NSString *assistant_id = nil;
                
                if ([[WLSingletonClass defaultWLSingleton]wlUserType]==WLMemberTypeSteward)
                {
                    assistant_id =  [WLSingletonClass defaultWLSingleton].modelSteawrd.uid;
                    
                }
                else
                {
                    assistant_id = nil;
                }
                [self loadDataWithUrl:SORTLINE(_city_id, _sortstr,roteID,assistant_id) andPage:1];
                //[self loadDataWithUrl:SORTLINE(_city_id, _sortstr, roteID) andPage:1];

            }
            
            
        }
        
        if (_sortstr == nil) {
            if (self.Datasource.count < page * PAGECOUNT) {
                [self.tablevc.footer endRefreshing];
                [[LXAlterView sharedMyTools]createTishi:@"没有更多消息了....亲"];
            }
            else
            {
                //page++;
                [_tablevc reloadData];
                //[self loadDataWithUrl:SHAIXUAN andPage:page];
                [self GetdataWithUrl:SHAIXUAN andPage:1];
            }
            
        }
        
        
    }
}


#pragma mark -- 创建底部试图

- (void)createLowview{
    //    static int Height = 67 / 2;
    //    static int Image1Left = 106 / 2;
    //    static int Image1Top = 22 / 2;
    //    static int Image1Right = 14 / 2;
    //
    //
    //    switch ((int)windowContentHeight) {
    //        case 667:
    //            Height = 80 / 2;
    //            break;
    //        case 736:
    //            Height = 132 / 2;
    //            break;
    //        default:
    //            break;
    //    }
    //
    //
    self.LowView = [[UIView alloc] initWithFrame:CGRectMake(0, windowContentHeight - windowContentHeight / 16.67-64, windowContentWidth, windowContentHeight / 16.67)];
    self.LowView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.75];
    self.LowView.alpha = 0.8;
    [self.view addSubview:_LowView];
    //中间白线
    UILabel * lableline = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 2, 10, 1, windowContentHeight / 16.67 - 20)];
    lableline.backgroundColor = [UIColor whiteColor];
    [_LowView addSubview:lableline];
    //左右按钮：综合，筛选
    UIButton * Leftbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth / 2, windowContentHeight / 16.67)];
    [Leftbutton setTitle:@"综合" forState:UIControlStateNormal];
    [Leftbutton addTarget:self action:@selector(OnleftbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [Leftbutton setImage:[UIImage imageNamed:@"综合"] forState:UIControlStateNormal];
    [_LowView addSubview:Leftbutton];
    
    UIButton * Rightbutton = [[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth / 2, 0 , windowContentWidth / 2, windowContentHeight / 16.67)];
    [Rightbutton setTitle:@"筛选" forState:UIControlStateNormal];
    [Rightbutton addTarget:self action:@selector(OnrightbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [Rightbutton setImage:[UIImage imageNamed:@"筛选"] forState:UIControlStateNormal];
    [_LowView addSubview:Rightbutton];
    
    
}
//左右按钮：综合，筛选点击时间
- (void)OnleftbuttonClick{
    ZongheVc * zonghevc = [[ZongheVc alloc]init];
    zonghevc.delegate = self;
    [self.view addSubview:zonghevc];
    
    
}
- (void)OnrightbuttonClick{
    ShaixuanVc * shaixuanvc = [[ShaixuanVc alloc]init];
    shaixuanvc.delegate = self;
    [self.view addSubview:shaixuanvc];
    
}

//  综合回调传值
- (void)Returnstr:(NSString *)str{
    _sortstr = str;
    [_dic removeAllObjects];
    [self refresh];
    
}
//  筛选回调传值

- (void)ReturnShaixuanstr:(NSMutableDictionary *)dict{
    _sortstr = nil;
    _dic = dict;
    
    [self refresh];
    
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
    
    
    [cell config:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GuoneiyouModel * model = _Datasource[indexPath.row];
    ProductDetailViewController * productdetail = [[ProductDetailViewController alloc]init];
    productdetail.productID = model.product_id;
    productdetail.gj_commission = model.gj_adult_rebate;
    [self.navigationController pushViewController:productdetail animated:YES];
}

#pragma mark --- 加载数据
/**
 *  加载数据
 */
- (void)loadDataWithUrl:(NSString *)urlStr andPage:(NSInteger)page
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //发送请求
    // __weak ZFJHotelListVC * listVC = self;
    
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",urlStr);
        NSString *code =[NSString stringWithFormat:@"%@",dic[@"status"]] ;
        
        if ([code isEqualToString:@"1"]) {
            [self.tablevc.header endRefreshing];
            [self.tablevc.footer endRefreshing];
            NSArray * arr = dic[@"data"];
            [_Datasource removeAllObjects];
            for (NSDictionary * dic in arr) {
                GuoneiyouModel * model = [[GuoneiyouModel alloc]init];
                model.adult_price = dic[@"adult_price"];
                model.gj_adult_rebate = dic[@"gj_adult_rebate"];
                model.product_name = dic[@"product_name"];
                model.thumb = dic[@"thumb"];
                model.timetable_range = dic[@"timetable_range"];
                model.product_id = dic[@"product_id"];
                [_Datasource addObject:model];
            }
            self.tablevc.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            [self.tablevc reloadData];
        }
        else
        {
            [self.tablevc.header endRefreshing];
            [self.tablevc.footer endRefreshing];
            [[LXAlterView sharedMyTools]createTishi:[dic valueForKey:@"msg"]];
            
            [self.tablevc reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tablevc.header endRefreshing];
        [self.tablevc.footer endRefreshing];
        [[LXAlterView sharedMyTools]createTishi:@"请求失败,请检查网络!"];
        self.tablevc.separatorStyle=UITableViewCellSeparatorStyleNone;
        [self.tablevc reloadData];
    }];
}

#pragma mark -- 多参数搜索
- (void)GetdataWithUrl:(NSString *)urlStr andPage:(NSInteger)page
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary * paramer = [NSMutableDictionary dictionary];
    [paramer addEntriesFromDictionary:_dic];
    [paramer setObject:_city_id forKey:@"city_id"];
    [paramer setObject:[NSString stringWithFormat:@"%ld",(long)_rote_ID] forKey:@"route_type"];
    
    
    [manager POST:urlStr parameters:self.paramerDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *code =[NSString stringWithFormat:@"%@",dic[@"status"]] ;
        if ([code isEqualToString:@"1"]) {
            
            [self.tablevc.header endRefreshing];
            [self.tablevc.footer endRefreshing];
            NSArray * arr = dic[@"data"];
            [_Datasource removeAllObjects];
            for (NSDictionary * dic in arr) {
                GuoneiyouModel * model = [[GuoneiyouModel alloc]init];
                model.adult_price = dic[@"adult_price"];
                model.gj_adult_rebate = dic[@"gj_adult_rebate"];
                model.product_name = dic[@"product_name"];
                model.thumb = dic[@"thumb"];
                model.timetable_range = dic[@"timetable_range"];
                model.product_id = dic[@"product_id"];
                [_Datasource addObject:model];
            }
            [self.tablevc reloadData];
        }
        else
        {
            [self.tablevc.header endRefreshing];
            [self.tablevc.footer endRefreshing];
            [[LXAlterView sharedMyTools]createTishi:[dic valueForKey:@"msg"]];
            [self.tablevc reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tablevc.header endRefreshing];
        [self.tablevc.footer endRefreshing];
        [[LXAlterView sharedMyTools]createTishi:@"请求失败,请检查网络!"];
        [self.tablevc reloadData];
    }];
    
    
}

- (void)pushDatawithUrl:(NSString *)urlStr andPage:(NSInteger)page{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"city_id":_city_id,@"route_type":@"-11",@"category_id":@"60"};
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *code =[NSString stringWithFormat:@"%@",dic[@"status"]] ;
        if ([code isEqualToString:@"1"]) {
            [self.tablevc.header endRefreshing];
            [self.tablevc.footer endRefreshing];
            [_Datasource removeAllObjects];
            NSArray * arr = dic[@"data"];
            for (NSDictionary * dic in arr) {
                GuoneiyouModel * model = [[GuoneiyouModel alloc]init];
                model.adult_price = dic[@"adult_price"];
                model.gj_adult_rebate = dic[@"gj_adult_rebate"];
                model.product_name = dic[@"product_name"];
                model.thumb = dic[@"thumb"];
                model.timetable_range = dic[@"timetable_range"];
                [_Datasource addObject:model];
            }
            [self.tablevc reloadData];
        }
        else
        {
            [self.tablevc.header endRefreshing];
            [self.tablevc.footer endRefreshing];
            [[LXAlterView sharedMyTools]createTishi:[dic valueForKey:@"msg"]];
            [self.tablevc reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tablevc.header endRefreshing];
        [self.tablevc.footer endRefreshing];
        [[LXAlterView sharedMyTools]createTishi:@"请求失败,请检查网络!"];
        [self.tablevc reloadData];
    }];
    
    
}


- (void)loadWithUrl:(NSString *)urlStr andPage:(NSInteger)page
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //发送请求
    // __weak ZFJHotelListVC * listVC = self;
    NSDictionary * pardict =  @{@"city_id":_city_id,@"route_type":@"-11",@"title":_titles};
    [manager POST:urlStr parameters:pardict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *code =[NSString stringWithFormat:@"%@",dic[@"status"]] ;
        if ([code isEqualToString:@"1"]) {
            [self.tablevc.header endRefreshing];
            [self.tablevc.footer endRefreshing];
            NSArray * arr = dic[@"data"];
            [_Datasource removeAllObjects];
            for (NSDictionary * dic in arr) {
                GuoneiyouModel * model = [[GuoneiyouModel alloc]init];
                model.adult_price = dic[@"adult_price"];
                model.gj_adult_rebate = dic[@"gj_adult_rebate"];
                model.product_name = dic[@"product_name"];
                model.thumb = dic[@"thumb"];
                model.timetable_range = dic[@"timetable_range"];
                model.product_id = dic[@"product_id"];
                [_Datasource addObject:model];
            }
            [self.tablevc reloadData];
        }
        else
        {
            [self.tablevc.header endRefreshing];
            [self.tablevc.footer endRefreshing];
            [[LXAlterView sharedMyTools]createTishi:[dic valueForKey:@"msg"]];
            [self.tablevc reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tablevc.header endRefreshing];
        [self.tablevc.footer endRefreshing];
        [[LXAlterView sharedMyTools]createTishi:@"请求失败,请检查网络!"];
        [self.tablevc reloadData];
    }];
}


@end

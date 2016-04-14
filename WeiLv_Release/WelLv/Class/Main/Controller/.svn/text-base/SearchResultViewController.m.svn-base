
//
//  SearchResultViewController.m
//  WelLv
//
//  Created by lyx on 15/4/8.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "SearchResultViewController.h"
#import "LXTopSiftView.h"
#import "LXTraveModel.h"
#import "LXTraveCellTableViewCell.h"
#import "YXDetailTraveViewController.h"
#import "YXLocationManage.h"
#import "LXGetCityIDTool.h"

#define Order_desc @"desc"
#define Order_asc  @"asc"

@interface SearchResultViewController ()
{
    NSInteger _mudidiType;//目的地的类型1(周边，港澳台)，2（国内）,3(出境，境外参团),4一日游
    NSInteger _offset;//偏移量
    NSInteger _currentPage;
    LXTopSiftView * _siftView;
    //NSString *_route_type;//5一日游，6周边游，7国内游，8出境游，9港澳台，10境外参团
    NSMutableArray *_siftTypeArray;
    NSString *_t_city_id;
    NSString *_t_route_type;//目的地类型
    NSString *_order_type;//排序方式
}
@property(nonatomic,copy)NSString *titleName;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *traveListArray;

@end

@implementation SearchResultViewController
@synthesize resultText = _resultText;

- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [_siftView tapMask];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _traveListArray=[[NSMutableArray alloc] initWithCapacity:0];
    _currentPage=0;
    _offset=0;
    
    [self initData];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)initData
{

//    NavSearchView *searchView = [[NavSearchView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth-60, 30) Feature:@"景区/地区/关键字"];
//    searchView.searchBar.text = self.resultText;
//    searchView.delegate = self;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchView];
    _t_city_id=0;
    _t_route_type=@"0";
    _order_type=@"";
    if (self.resultText.length>0)
    {
        NSString *firstStr= [self.resultText substringToIndex:1];
        DLog(@"first=%@-----%@",firstStr,self.resultText);
        if ([firstStr isEqualToString:@"一"])
        {
            _route_type=@"5";
            _mudidiType=4;
            self.title=@"一日游";
            _siftTypeArray=[[NSMutableArray alloc] initWithObjects:@"销量",@"筛选", nil];
        }
       else if ([firstStr isEqualToString:@"周"])
        {
            _route_type=@"6";
            _mudidiType=1;
            self.title=@"周边游";
            _siftTypeArray=[[NSMutableArray alloc] initWithObjects:@"销量",@"筛选", nil];
            DLog(@"当前省份=%@,当前城市=%@",[YXLocationManage shareManager].province,[YXLocationManage shareManager].city);
            
        }
       else if ([firstStr isEqualToString:@"国"])
        {
            _route_type=@"7";
            _mudidiType=3;
            self.title=@"国内游";
            _siftTypeArray=[[NSMutableArray alloc] initWithObjects:@"销量",@"目的地",@"筛选", nil];
        }
       else if ([firstStr isEqualToString:@"出"])
        {
            _route_type=@"8";
            _mudidiType=2;
            self.title=@"出境游";
            _siftTypeArray=[[NSMutableArray alloc] initWithObjects:@"销量",@"目的地",@"筛选", nil];
        }
        else if ([firstStr isEqualToString:@"港"])
        {
            _route_type=@"9";
            _mudidiType=5;
            self.title=@"港澳台";
            _siftTypeArray=[[NSMutableArray alloc] initWithObjects:@"销量",@"目的地",@"筛选", nil];
        }
       else if ([firstStr isEqualToString:@"境"])
        {
            _route_type=@"10";
            _mudidiType=2;
            self.title=@"境外参团";
            _siftTypeArray=[[NSMutableArray alloc] initWithObjects:@"销量",@"目的地",@"筛选", nil];
        }
       else if ([firstStr isEqualToString:@"热"])
       {
           _route_type=@"6";
           _mudidiType=1;
           //self.title=@"周边游";
           _siftTypeArray=[[NSMutableArray alloc] initWithObjects:@"销量",@"筛选", nil];
           DLog(@"当前省份=%@,当前城市=%@",[YXLocationManage shareManager].province,[YXLocationManage shareManager].city);
           
       }
        else
        {
            _route_type=@"5";
            _mudidiType=4;
            self.title=@"一日游";
            _siftTypeArray=[[NSMutableArray alloc] initWithObjects:@"销量",@"目的地",@"筛选", nil];
        }

    }
    
        
}

- (void)initView
{
    if (self.isFromSpring==NO)
    {
        NSString *assistant_id=@"";
        if ([[[LXUserTool alloc] getKeeper] rangeOfString:@"null"].location!=NSNotFound) {
            assistant_id=@"0";
        }
        else
        {
            assistant_id=[[LXUserTool alloc] getKeeper];
        }
        
        //顶部筛选框
        _siftView=[[LXTopSiftView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 50) nameArray:_siftTypeArray InfoArray:nil mudidiType:_mudidiType];
        
        [_siftView returnSifyIDBlock:^(NSString *siftTypeID) {
            DLog(@"筛选类型=%@,=%@",siftTypeID,[LXGetCityIDTool sharedMyTools].city_regionID);
            //根据价格。目的地。主题等筛选
            [_traveListArray removeAllObjects];
            NSString *offset1=[NSString stringWithFormat:@"%d",0];
            NSDictionary *dic=nil;
            NSString *url=nil;
            if ([siftTypeID isEqualToString:@"销量"])
            {
                dic=@{@"offset":offset1,@"limit":@"10",@"order_field":@"real_sell_count",@"route_type":_route_type,@"city_id":[[WLSingletonClass defaultWLSingleton] wlCityId],@"assistant_id":assistant_id};
                url=ListTraveUrl;
                [self sendRequest:dic aurl:url aTag:1];
                
            }else if ([siftTypeID isEqualToString:@"价格由高到低"])
            {
                _order_type=Order_desc;
            dic=@{@"offset":offset1,@"limit":@"20",@"order_field":@"sell_price",@"order_type":_order_type,@"route_type":_route_type,@"city_id":[[WLSingletonClass defaultWLSingleton] wlCityId],@"assistant_id":assistant_id};
                url=ListTraveUrl;
                [self sendRequest:dic aurl:url aTag:1];
            }
            else if ([siftTypeID isEqualToString:@"价格由低到高"])
            {
                _order_type=Order_asc;
             dic=@{@"offset":offset1,@"limit":@"20",@"order_field":@"sell_price",@"order_type":_order_type,@"route_type":_route_type,@"city_id":[[WLSingletonClass defaultWLSingleton] wlCityId],@"assistant_id":assistant_id};
                url=ListTraveUrl;
                [self sendRequest:dic aurl:url aTag:1];
            }else
            {
                [_traveListArray removeAllObjects];
                DLog(@"测试中===%@,==城市=%@",[LXGetCityIDTool sharedMyTools].city_regionID,siftTypeID);
                _currentPage=1;
                if ([siftTypeID isEqualToString:@"三亚"]    ||
                    [siftTypeID isEqualToString:@"厦门"]    ||
                    [siftTypeID isEqualToString:@"桂林"]    ||
                    [siftTypeID isEqualToString:@"北京"]    ||
                    [siftTypeID isEqualToString:@"西安"]    ||
                    [siftTypeID isEqualToString:@"哈尔滨"]   ||
                    [siftTypeID isEqualToString:@"海口"]    ||
                    [siftTypeID isEqualToString:@"香港"]    ||
                    [siftTypeID isEqualToString:@"澳门"]    ||
                    [siftTypeID isEqualToString:@"台湾"]) {
                    [self getT_cityID:siftTypeID region_type:@"3"];
                }
                else if (_mudidiType==3 || _mudidiType==5)
                {
                    //国内游
                    [self getT_cityID:siftTypeID region_type:@"2"];
                }else
                {
                    //出境
                    [self getT_cityID:siftTypeID region_type:@"1"];
                }
                
                
            }
            
            
        } infoBlock:^(NSString *siftInfoID,NSString *days) {
            DLog(@"选择的价格=%@",siftInfoID);
            [_traveListArray removeAllObjects];
            
    
            if(![siftInfoID isEqualToString:@"1"]&&![days isEqualToString:@"1"])
            {
                if ([siftInfoID isEqualToString:@"2万以上"]&&![days isEqualToString:@"1"])
                {
                    
                    NSString *day=[days stringByReplacingOccurrencesOfString:@"天" withString:@""];
                    DLog(@"选择的天数=%@",day);
                    NSArray *daysArray=[day componentsSeparatedByString:@"-"];
                    
                    
                    NSString *offset1=[NSString stringWithFormat:@"%d",0];
                    NSDictionary *dic=nil;
                    NSString *url=nil;
                    dic=@{@"offset":offset1,@"limit":@"10",@"s_price":@"20000",@"route_type":_route_type,@"s_days":[daysArray objectAtIndex:0],@"e_days":[daysArray objectAtIndex:1],@"city_id":[[WLSingletonClass defaultWLSingleton] wlCityId],@"assistant_id":assistant_id};
                    DLog(@"%@",dic);
                    url=ListTraveUrl;
                    [self sendRequest:dic aurl:url aTag:1];
                }else{
                
                NSArray *priceArray=[siftInfoID componentsSeparatedByString:@"-"];
                NSString *offset1=[NSString stringWithFormat:@"%d",0];
                
                NSString *day=[days stringByReplacingOccurrencesOfString:@"天" withString:@""];
                DLog(@"选择的天数=%@",day);
                NSArray *daysArray=[day componentsSeparatedByString:@"-"];
                NSDictionary *dic=nil;
                NSString *url=nil;
                dic=@{@"offset":offset1,@"limit":@"10",@"s_price":[priceArray objectAtIndex:0],@"e_price":[priceArray objectAtIndex:1],@"s_days":[daysArray objectAtIndex:0],@"e_days":[daysArray objectAtIndex:1],@"route_type":_route_type,@"city_id":[[WLSingletonClass defaultWLSingleton] wlCityId],@"assistant_id":assistant_id};
                DLog(@"%@",dic);
                url=ListTraveUrl;
                [self sendRequest:dic aurl:url aTag:1];
                }
            }else if ([siftInfoID isEqualToString:@"1"]&&![days isEqualToString:@"1"])
            {
                NSString *day=[days stringByReplacingOccurrencesOfString:@"天" withString:@""];
                DLog(@"选择的天数=%@",day);
                NSArray *daysArray=[day componentsSeparatedByString:@"-"];
                NSString *offset1=[NSString stringWithFormat:@"%d",0];
                NSDictionary *dic=nil;
                NSString *url=nil;
                dic=@{@"offset":offset1,@"limit":@"10",@"s_days":[daysArray objectAtIndex:0],@"e_days":[daysArray objectAtIndex:1],@"route_type":_route_type,@"city_id":[[WLSingletonClass defaultWLSingleton] wlCityId],@"assistant_id":assistant_id};
                DLog(@"%@",dic);
                url=ListTraveUrl;
                [self sendRequest:dic aurl:url aTag:1];
            }else if (![siftInfoID isEqualToString:@"1"]&&[days isEqualToString:@"1"])
            {
                
                if ([siftInfoID isEqualToString:@"2万以上"]&&[days isEqualToString:@"1"]) {
                    
                    
                    NSString *offset1=[NSString stringWithFormat:@"%d",0];
                    NSDictionary *dic=nil;
                    NSString *url=nil;
                    dic=@{@"offset":offset1,@"limit":@"10",@"s_price":@"20000",@"route_type":_route_type,@"city_id":[[WLSingletonClass defaultWLSingleton] wlCityId],@"assistant_id":assistant_id};
                    DLog(@"%@",dic);
                    url=ListTraveUrl;
                    [self sendRequest:dic aurl:url aTag:1];
                }else{
                
                NSArray *priceArray=[siftInfoID componentsSeparatedByString:@"-"];
                NSString *offset1=[NSString stringWithFormat:@"%d",0];
                NSDictionary *dic=nil;
                NSString *url=nil;
                dic=@{@"offset":offset1,@"limit":@"10",@"s_price":[priceArray objectAtIndex:0],@"e_price":[priceArray objectAtIndex:1],@"route_type":_route_type,@"city_id":[[WLSingletonClass defaultWLSingleton] wlCityId],@"assistant_id":assistant_id};
                DLog(@"%@",dic);
                url=ListTraveUrl;
                [self sendRequest:dic aurl:url aTag:1];
            }
            }
            
            
//        } dayblock:^(NSString *days) {
//            
//            [_traveListArray removeAllObjects];
//            NSString *day=[days stringByReplacingOccurrencesOfString:@"天" withString:@""];
//            DLog(@"选择的天数=%@",day);
//            NSArray *daysArray=[day componentsSeparatedByString:@"-"];
//            NSString *offset1=[NSString stringWithFormat:@"%d",0];
//            NSDictionary *dic=nil;
//            NSString *url=nil;
//            dic=@{@"offset":offset1,@"limit":@"10",@"s_days":[daysArray objectAtIndex:0],@"e_days":[daysArray objectAtIndex:1],@"route_type":_route_type,@"city_id":[[WLSingletonClass defaultWLSingleton] wlCityId],@"assistant_id":assistant_id};
//            DLog(@"%@",dic);
//            url=ListTraveUrl;
//            [self sendRequest:dic aurl:url aTag:1];
//            
            
        }];
        
        [self.view addSubview:_siftView];

    }
    
    if (self.tableView == nil) {
        
        self.tableView = [[UITableView alloc] init];
        if (self.isFromSpring==NO)
        {
            self.tableView.frame=CGRectMake(0, 50, windowContentWidth, windowContentHeight-64);
        }else
        {
            self.tableView.frame=CGRectMake(0, 0, windowContentWidth, windowContentHeight-64);
        }
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:self.tableView];
    
    
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [self.tableView setSeparatorInset:UIEdgeInsetsZero];
            
        }
        
        if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [self.tableView setLayoutMargins:UIEdgeInsetsZero];
            
        }
    }
    
    NSMutableArray *imageAray=[NSMutableArray array];
    for (int i=0; i<2; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"单独-logo%d.png", i+2]];
        [imageAray addObject:image];
    }
    //-----------下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    
    __weak SearchResultViewController *visaListVC = self;
    [_tableView addGifHeaderWithRefreshingBlock:^{
        [visaListVC.traveListArray removeAllObjects];
        [visaListVC loadNewData];
    }];
    // 设置普通状态的动画图片
    [self.tableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self.tableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self.tableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateRefreshing];
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
    // 马上进入刷新状态
    [self.tableView.gifHeader beginRefreshing];
    
    //加载更多
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadLastData)];
    
}
#pragma mark 获取目的地id
-(void)getT_cityID:(NSString *)t_cityName region_type:(NSString *)region_type
{
    
    NSString *assistant_id=@"";
    if ([[[LXUserTool alloc] getKeeper] rangeOfString:@"null"].location!=NSNotFound) {
        assistant_id=@"0";
    }
    else
    {
        assistant_id=[[LXUserTool alloc] getKeeper];
    }
    
    _t_route_type=region_type;
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    NSDictionary *dic=@{@"region_name":t_cityName,@"region_type":region_type};
    DLog(@"dic===%@",dic);
    NSString *url=GetCityIDUrl;
    //[self sendRequest:dic aurl:url aTag:1];
    //__block NSString *city_regionID=nil;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dic
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              
              //旅游列表(无搜索条件)
              DLog(@"Success: dic=%@--%@",dic, [dic objectForKey:@"msg"]);
              if ([[dic objectForKey:@"status"] integerValue]==1)
              {
                  NSArray *array=[dic objectForKey:@"data"];
                  NSDictionary *dict1=[[NSDictionary alloc] init];
                  //DLog(@"data=%@",array);
                  //NSArray *sellersArray=[NSArray array];
                  //for (int i=0; i<array.count; i++)
                  //{
                      
                      dict1=[array objectAtIndex:0];
                      
                      _t_city_id=[dict1 objectForKey:@"region_id"];
                      
                      //self.city_regionID=city_regionID;
                      if ([region_type isEqualToString:@"3"])
                      {
                          //根据目的地城市筛选
                          NSDictionary * dic=@{@"offset":@"0",@"limit":@"10",@"route_type":_route_type,@"t_city":_t_city_id,@"city_id":[[WLSingletonClass defaultWLSingleton] wlCityId],@"assistant_id":assistant_id};
                          NSString * url=ListTraveUrl;
                          [self sendRequest:dic aurl:url aTag:1];
                      }
                      else if ([region_type isEqualToString:@"2"])
                      {
                          //根据目的地省份筛选
                          NSDictionary * dic=@{@"offset":@"0",@"limit":@"10",@"route_type":_route_type,@"t_province":_t_city_id,@"city_id":[[WLSingletonClass defaultWLSingleton] wlCityId],@"assistant_id":assistant_id};
                          NSString * url=ListTraveUrl;
                          [self sendRequest:dic aurl:url aTag:1];
                      }
                      else
                      {
                          //根据目的地国家筛选
                          NSDictionary * dic=@{@"offset":@"0",@"limit":@"10",@"route_type":_route_type,@"t_country":_t_city_id,@"city_id":[[WLSingletonClass defaultWLSingleton] wlCityId],@"assistant_id":assistant_id};
                          NSString * url=ListTraveUrl;
                          [self sendRequest:dic aurl:url aTag:1];
                      }
                      
                  
                  //}
                  
                  //[self.tableView reloadData];
              }
              else
              {
                  [[LXAlterView sharedMyTools] createTishi:@"暂无数据"];
                  DLog(@"注册失败");
              }
              
              [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
              [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
//              [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
//                  NSDictionary *parameterDic=@{@"offset":@"0",@"limit":@"10"};
//                  [self sendRequest:parameterDic aUrl:@"http://m.weilv100.com:1025/api/assistant/lists" aTag:1];
//              }];
          }];
    
}

-(void)loadNewData
{
    NSString *assistant_id=@"";
    if ([[[LXUserTool alloc] getKeeper] rangeOfString:@"null"].location!=NSNotFound) {
        assistant_id=@"0";
    }
    else
    {
        assistant_id=[[LXUserTool alloc] getKeeper];
    }
    _currentPage=1;
    if (self.isFromSpring==NO)
    {
        NSString *offset1=[NSString stringWithFormat:@"%d",0];
        NSDictionary *dic;
        if ([[WLSingletonClass defaultWLSingleton] wlCityId])
        {
            if ([_t_route_type intValue]==2)
            {
                 dic=@{@"offset":@"0",@"limit":@"10",@"order_type":_order_type,@"route_type":_route_type,@"t_province":_t_city_id,@"city_id":[[WLSingletonClass defaultWLSingleton] wlCityId],@"assistant_id":assistant_id};
                
            }
            else if([_t_route_type intValue]==1){
                dic=@{@"offset":@"0",@"limit":@"10",@"order_type":_order_type,@"route_type":_route_type,@"t_country":_t_city_id,@"city_id":[[WLSingletonClass defaultWLSingleton] wlCityId],@"assistant_id":assistant_id};
            }else
            {
                dic=@{@"offset":offset1,@"limit":@"10",@"route_type":_route_type,@"city_id":[[WLSingletonClass defaultWLSingleton] wlCityId],@"assistant_id":assistant_id};
                
            }
            DLog(@"dic==%@",dic);
        }
        else
        {
            dic=@{@"offset":offset1,@"limit":@"10",@"route_type":_route_type};
        }
        
        NSString *url=ListTraveUrl;
        [self sendRequest:dic aurl:url aTag:1];
    }
    else{
        //特惠游
        NSString *offset1=[NSString stringWithFormat:@"%d",0];
        NSDictionary *dic=@{@"category_id":@"67",@"offset":offset1,@"limit":@"1000",@"assistant_id":assistant_id};
        //NSDictionary *dic=@{@"city_id":@"149",@"offset":offset1,@"limit":@"50"};
        NSString *url=ListTraveUrl;
        [self sendRequest:dic aurl:url aTag:1];
    }
    
    
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.tableView.header endRefreshing];
}

//加载更多
- (void)loadLastData
{
    NSString *assistant_id=@"";
    if ([[[LXUserTool alloc] getKeeper] rangeOfString:@"null"].location!=NSNotFound) {
        assistant_id=@"0";
    }
    else
    {
        assistant_id=[[LXUserTool alloc] getKeeper];
    }
    if (self.isFromSpring==NO)
    {
        _offset=_currentPage*10;
        NSString *offset1=[NSString stringWithFormat:@"%ld",(long)_offset];
        if ([_t_route_type isEqualToString:@"0"]) {
            
            NSDictionary *dic;
            if ([[WLSingletonClass defaultWLSingleton] wlCityId])
            {
                dic=@{@"offset":offset1,@"limit":@"10",@"order_type":_order_type,@"route_type":_route_type,@"city_id":[[WLSingletonClass defaultWLSingleton] wlCityId],@"assistant_id":assistant_id};
            }
            else
            {
                dic=@{@"offset":offset1,@"limit":@"10",@"order_type":_order_type,@"route_type":_route_type,@"assistant_id":assistant_id};
            }
            
            
            NSString *url=ListTraveUrl;
            [self sendRequest:dic aurl:url aTag:1];
        }
        else if ([_t_route_type isEqualToString:@"2"])
        {
            
            //根据目的地省份筛选
            NSDictionary * dic=@{@"offset":offset1,@"limit":@"10",@"order_type":_order_type,@"route_type":_route_type,@"t_province":_t_city_id,@"city_id":[[WLSingletonClass defaultWLSingleton] wlCityId],@"assistant_id":assistant_id};
            NSString * url=ListTraveUrl;
            [self sendRequest:dic aurl:url aTag:1];
        }
        else
        {
            //根据目的地国家筛选
            NSDictionary * dic=@{@"offset":offset1,@"limit":@"10",@"order_type":_order_type,@"route_type":_route_type,@"t_country":_t_city_id,@"city_id":[[WLSingletonClass defaultWLSingleton] wlCityId],@"assistant_id":assistant_id};
            NSString * url=ListTraveUrl;
            [self sendRequest:dic aurl:url aTag:1];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表格
            [self.tableView reloadData];
            
            // 拿到当前的上拉刷新控件，变为没有更多数据的状态 [_tableView.footer noticeNoMoreData]

            [self.tableView.footer endRefreshing];
            _currentPage++;
        });
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表格
            [self.tableView reloadData];
            
            // 拿到当前的上拉刷新控件，变为没有更多数据的状态 [_tableView.footer noticeNoMoreData]
            [self.tableView.footer noticeNoMoreData];
            _currentPage++;
        });
    }
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark NavSearchViewDelegate
- (void)beginSearch:(NSString *)text
{
    
}


#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _traveListArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier0 = @"cell";
    //UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier0];
    
    LXTraveCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier0];
    if (!cell)
    {
        cell = [[LXTraveCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier0];
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
      if (_traveListArray.count>0)
    {
        LXTraveModel *model=[_traveListArray objectAtIndex:indexPath.row];
        cell.item=model;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LXTraveModel *model=[_traveListArray objectAtIndex:indexPath.row];
    YXDetailTraveViewController *yxDetailVc=[[YXDetailTraveViewController alloc] init];
    yxDetailVc.productId=model.traveID;
    yxDetailVc.productPrice=model.price;
    [self.navigationController pushViewController:yxDetailVc animated:YES];
}

#pragma mark 分割线左边对齐
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}


-(void)sendRequest:(NSDictionary *)parameters aurl:(NSString *)url aTag:(int)tag
{
    //DLog(@"URL == %@ \n parameter == %@", url, parameters);
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              if(tag==1)
              {
                  //旅游列表(无搜索条件)
                  DLog(@"Success: %@---msg=%@", dic,[dic objectForKey:@"msg"]);
                  if ([[dic objectForKey:@"status"] integerValue]==1)
                  {
                      NSArray *array=[dic objectForKey:@"data"];
                      NSDictionary *dict1=[[NSDictionary alloc] init];
                      //DLog(@"data=%@",array);
                      //NSArray *sellersArray=[NSArray array];
                      for (int i=0; i<array.count; i++)
                      {
                          
                          dict1=[array objectAtIndex:i];
                          LXTraveModel *model=[[LXTraveModel alloc] init];
                          if (![YXTools stringReturnNull:[dict1 objectForKey:@"thumb"]]) {
                              if ([[dict1 objectForKey:@"thumb"] hasPrefix:@"https://"]||[[dict1 objectForKey:@"thumb"] hasPrefix:@"http://"]) {
                                  model.leftImage = [dict1 objectForKey:@"thumb"];
                              }else{
                                  model.leftImage=[NSString stringWithFormat:@"%@/upload/thumb/%@",WLHTTP,[dict1 objectForKey:@"thumb"]];
                              }
                          }
                          model.name=[dict1 objectForKey:@"product_name"];
                          model.price=[dict1 objectForKey:@"sell_price"];
                          model.info=[dict1 objectForKey:@"feature"];
                          model.traveID=[dict1 objectForKey:@"id"];
                          model.gj_commission=[dict1 objectForKey:@"gj_commission"];
                          model.admin_id=[dict1 objectForKey:@"admin_id"];
                          model.lastest=[dict1 objectForKey:@"lastest"];
                          [_traveListArray addObject:model];
 
                      }
                      
                      
                  }
                  else
                  {
                      [[LXAlterView sharedMyTools] createTishi:@"暂无数据"];
                      
                  }
                  [self.tableView reloadData];
                  [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
                }
              
              if (_tableView.contentSize.height < ControllerViewHeight) {
                  [_tableView removeFooter];
              }
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
              
          }];
    
}



@end

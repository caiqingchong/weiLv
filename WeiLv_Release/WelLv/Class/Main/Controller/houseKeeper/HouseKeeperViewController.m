//
//  HouseKeeperViewController.m
//  WelLv
//
//  Created by lyx on 15/4/7.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#define BannerHegit 150*HeightScale
#define Limite @"10"

#import "HouseKeeperViewController.h"
#import "YXBannerView.h"
#import "LXGuanJiaModel.h"
#import "LXGuanJiaTableViewCell.h"
#import "NavSearchView.h"
#import "YXHouseDetailViewController.h"
#import "LXUserTool.h"
#import "LXUserDefault.h"
#import "LXGetCityIDTool.h"
#import "LXAdvertModel.h"
@interface HouseKeeperViewController ()
<EScrollerViewDelegate,UITableViewDataSource,UITableViewDelegate,NavSearchViewDelegate>
{
    YXBannerView *_headerView;
    NSMutableArray *_webSiteArr;
    UITableView *_keeperTab;//管家列表
    NSMutableArray *_keeperAraay;
    NSMutableArray *_adArray;//广告数组
    NavSearchView *searchView;
    BOOL _isShou;
    UIView *_maskView;
    NSString *_sexState;
    UIView *_siftView;
    UIImageView *_imageView;
    UIButton *_nanBtn;
    UIButton *_nvBtn;
    UIView *_line;
    UIView *_line1;
    UIButton *_topBtn;
    UIView *_topMaskView;
    
    int _offset;//偏移量
    int _currentPage;
    int _totalPage;
    int _chooseBtn;//1案例数，2评级
    NSString *_gender;//1男，2女
    
    BOOL _isOrder_count;//按案例数筛选
    BOOL _isLevel;//按评分筛选
    
    NSString *_order_count;
    NSString *_level;
    UIButton *_allBtn;
}


@end

@implementation HouseKeeperViewController

- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"管家";
    // Do any additional setup after loading the view.
    /*
    DLog(@"iPhone=%f,比例=%f,BannerHegit=%f,homePath=%@,keeper=%@,pwd=%@",windowContentWidth,HeightScale,BannerHegit,GetHomePath,[[LXUserTool alloc] getKeeper],[[LXUserTool alloc] getPwd]);
    NSString *isFirstRun=[LXUserDefault getObject:@"ISFISRT"];
    if (!isFirstRun)
    {
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        //第一次运行
        [LXUserDefault setObject:@"1" InfoKey:@"ISFISRT"];
        _imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
        _imageView.image=[UIImage imageNamed:@"管家1"];
        _imageView.userInteractionEnabled=YES;
        [window addSubview:_imageView];
        
        UIButton *selectBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        selectBtn.frame=CGRectMake((windowContentWidth-280)/2, windowContentHeight-60-64, 280, 55);
        [selectBtn setBackgroundImage:[UIImage imageNamed:@"绑定"] forState:UIControlStateNormal];
        [selectBtn addTarget:self action:@selector(chooseKeeper) forControlEvents:UIControlEventTouchUpInside];
        [_imageView addSubview:selectBtn];
    }
    else
    {
        [self initNav];
        [self initData];
        [self initTable];
        [self initScrollView];
    }
    */
    [self initNav];
    [self initData];
    [self initTable];
    [self initScrollView];
}
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:YES];
//     [self chooseKeeper];
//}
-(void)chooseKeeper
{
   // [_imageView removeFromSuperview];
    
    [self initNav];
    [self initData];
    [self initTable];
    [self initScrollView];
    
}

- (void)initNav
{
    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame=CGRectMake(0, 0, 23, 23);
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    
    
    
//    searchView = [[NavSearchView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth-140, 25) Feature:@"管家姓名/电话"];
//    searchView.delegate = self;
//    self.navigationItem.titleView = searchView;
    //[self.navigationController.navigationBar addSubview:searchView];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchView];
    
}
-(void)searchBtnClick
{
    SearchViewController *seachVc=[[SearchViewController alloc] init];
    seachVc.searchType=4;
    [self.navigationController pushViewController:seachVc animated:YES];
}

-(void)initData
{
    _adArray =[[NSMutableArray alloc]init];
    _keeperAraay=[NSMutableArray array];
    _sexState=@"全部";
    _chooseBtn=0;
    _offset=0;
    _currentPage=1;
    _isLevel=NO;
    _isOrder_count=NO;
    _order_count=@"desc";
    _level=@"desc";
    _gender=nil;
    
    
    //NSDictionary *parameterDic=@{@"offset":@"0",@"limit":@"10",@"gender":@"1"};
    //[self sendRequest:parameterDic aUrl:@"http://m.weilv100.com:1025/api/assistant/lists" aTag:1];
    //[self send];
}

#pragma mark 请求数据-post
-(void)sendRequest:(NSDictionary *)parameters aUrl:(NSString *)url aTag:(NSUInteger)tag
{
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    if (tag==1)
    {
        DLog(@"删除管家数据");
        [_keeperAraay removeAllObjects];
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters
     
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              
              
              //DLog(@"Success: %@", responseObject);
              if (tag==1 || tag==3) {
                  
                  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                  //NSLog(@"==%@", dic);
                  if ([[dic objectForKey:@"status"] integerValue]==1)
                  {
                      
                      NSArray *array=[dic objectForKey:@"data"];
                      NSDictionary *dict1=[[NSDictionary alloc] init];
                      //DLog(@"data=%@",array);
                      NSArray *sellersArray=[NSArray array];
                      for (int i=0; i<array.count; i++)
                      {
                          
                          dict1=[array objectAtIndex:i];
                          LXGuanJiaModel *model=[[LXGuanJiaModel alloc] init];
                          model.leftImageUrl=[NSString stringWithFormat:@"%@/%@",WLHTTP,[dict1 objectForKey:@"avatar"]];
                          model.nameStr=[dict1 objectForKey:@"name"];
                          model.xingzuo=[dict1 objectForKey:@"horoscope"];//星座
                          sellersArray=[dict1 objectForKey:@"sellers"];//管家所属旅行社
                          if (sellersArray.count==0)
                          {
                              model.gjCityStr=nil;
                          }
                          model.NuberStr=[[dict1 objectForKey:@"order_count"] intValue];//订单数，案例数
                          model.gradeStr=[dict1 objectForKey:@"level"];//评分
                          model.sex=[dict1 objectForKey:@"gender"];
                          if ([dict1 objectForKey:@"birth_date"] == nil || [[dict1 objectForKey:@"birth_date"] isEqual:[NSNull null]])
                          {
                              model.age=nil;
                          }else
                          {
                              model.age=[self getAge:[dict1 objectForKey:@"birth_date"]];
                          }
                          
                          model.infoStr=[dict1 objectForKey:@"advantage"];
                          model.keeperID=[dict1 objectForKey:@"id"];
                          model.phone=[dict1 objectForKey:@"mobile"];
                          //DLog(@"管家姓名：%@",model.nameStr);
                          [_keeperAraay addObject:model];
                          
                      }
                      
                      [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
                      [_keeperTab reloadData];
                      
                  }
                  else
                  {
                      [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
                      [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
                      
                      [_keeperTab reloadData];
                  }

              }
              else if (tag==2){
                  
                  
                  NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                  DLog(@"管家===%@",array);
                  if (array != nil) {
                      for (int i=0; i<array.count; i++) {
                          LXAdvertModel *detailModel = [[LXAdvertModel alloc] init];
                          NSDictionary *dic=[array objectAtIndex:i];
                          [detailModel setValuesForKeysWithDictionary:dic];
                          [_adArray addObject:detailModel];
                      }
                      
                     [self initScrollView];
                      //[_keeperTab reloadData];
                  }
                  
//                  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//                  manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//                  [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject)
//                   {
//                       [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
//                       _adArray=[NSMutableArray array];
//                       [_adArray removeAllObjects];
//                       NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                       NSLog(@"管家广告===%@",responseObject);
//                       if (array != nil) {
//                           for (int i=0; i<array.count; i++) {
//                               LXAdvertModel *detailModel = [[LXAdvertModel alloc] init];
//                               NSDictionary *dic=[array objectAtIndex:i];
//                               [detailModel setValuesForKeysWithDictionary:dic];
//                               [_adArray addObject:detailModel];
//                           }
//                       }
//                   }failure:^(AFHTTPRequestOperation *operation,NSError *error){
//                       //         [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
//                       //         [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
//                       //             [self loadData];
//                       //         }];
//                   }];
//
              }
              
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
              [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
                  NSDictionary *parameterDic=@{@"offset":@"0",@"limit":@"10"};
                  [self sendRequest:parameterDic aUrl:getHouseListUrl aTag:1];
                  
                  
              }];
             
          }];
    
    
}

#pragma mark --- 获取日期间隔（计算管家年龄）
-(NSString *)getAge:(NSString *)birth_date
{
    if ([birth_date isEqualToString:@"0000-00-00"])
    {
        return @"0";
    }else
    {
        //创建日期格式化对象
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        //创建了两个日期对象
        NSDate *date1=[dateFormatter dateFromString:birth_date];
        NSDate *date2=[NSDate date];
        //NSDate *date=[NSDate date];
        //NSString *curdate=[dateFormatter stringFromDate:date];
        
        //取两个日期对象的时间间隔：
        //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
        NSTimeInterval time=[date2 timeIntervalSinceDate:date1];
        
        int days=((int)time)/(3600*24);
        int age = days/365;
        NSString *ageStr=[NSString stringWithFormat:@"%d",age];
        return ageStr;
    }
    
}

//滑动轮播图
- (void)initScrollView
{
//    NSString *jsonStr = [NSString stringWithContentsOfURL:[NSURL URLWithString:homeBannerUrl] encoding:NSUTF8StringEncoding error:nil];
//    NSDictionary *data2 = [jsonStr objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
//    NSMutableArray *arr = [NSMutableArray  array];
//    _webSiteArr = [NSMutableArray array];
//    NSArray *arr1 = [data2 objectForKey:@"Data"];
//    for (int i = 0; i< arr1.count; i++)
//    {
//        NSDictionary *dic = [arr1 objectAtIndex:i];
//        [arr addObject:[dic objectForKey:@"ImgUrl"]];
//        [_webSiteArr addObject:[dic objectForKey:@"SiteUrl"]];
//    }
//    NSArray *temp = [[NSUserDefaults standardUserDefaults] objectForKey:ImageLink];
//    //获取的数据不为空，并且与上次获取的不一样的情况下将链接存到本地（如果为空则直接读取本地；如果不为空并且有新的变动，则将新的url地址存到本地）
//    if (![temp isEqualToArray:arr] && arr.count > 0)
//    {
//        [[NSUserDefaults standardUserDefaults] setObject:arr forKey:ImageLink];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
    //NSArray *arr = [NSArray  array];
    // arr = [NSArray arrayWithObjects:@"banner1",@"banner2",@"banner3", nil];
    
    NSMutableArray *arr = [NSMutableArray  array];
    for (int i=0; i<_adArray.count; i++){
        LXAdvertModel *model=[_adArray objectAtIndex:i];
        NSString *imageUrl=[NSString stringWithFormat:@"%@%@",WLHTTP,model.src];
        [arr addObject:imageUrl];
    }
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, BannerHegit)];
    headerView.backgroundColor = [UIColor clearColor];
    if (_headerView != nil)
    {
        [_headerView removeFromSuperview];
    }
    
    _headerView = [[YXBannerView alloc] initWithFrameRect:headerView.frame ImageArray:arr];
    _headerView.delegate = self;
    //[self.view addSubview:_headerView];
    
    _keeperTab.tableHeaderView=_headerView;
}


#pragma mark EscrollViewDelegate
-(void)EScrollerViewDidClicked:(NSUInteger)index
{
    if (_adArray.count>0) {
        LXAdvertModel *model=[_adArray objectAtIndex:index-1];
        if ([model.link hasPrefix:@"https://"] || [model.link hasPrefix:@"http://"]) {
            NSString *url=[model.link stringByReplacingOccurrencesOfString:@"android" withString:@"ios"];
            DLog(@"点击了-%@",url);
            LXSpecialViewController *specialVc=[[LXSpecialViewController alloc] init];
            specialVc.loadUrl=url;
            specialVc.title=model.title;
            [self.navigationController pushViewController:specialVc animated:YES];
        }else{
            DLog(@"没有连接");
        }
        
    }else{
        NSLog(@"_____________%lu",(unsigned long)index);
    }
}

-(void)initTable
{

    
    
    
    _maskView=[[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(_headerView)+44, windowContentWidth, 0)];
    _maskView.backgroundColor=[UIColor colorWithWhite:0.2 alpha:0.9];
    _maskView.userInteractionEnabled=YES;
    [self.view addSubview:_maskView];
    
    _allBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    _allBtn.frame=CGRectMake(0, 0, windowContentWidth, 40);
    [_allBtn setTitle:@"全部" forState:UIControlStateNormal];
    [_allBtn setBackgroundColor:[UIColor whiteColor]];
    [_allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_allBtn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _allBtn.tag=15;
    _allBtn.alpha=0;
    [_maskView addSubview:_allBtn];
    
    _line=[[UIView alloc] initWithFrame:CGRectMake(0, 40, windowContentWidth, 0.5)];
    _line.backgroundColor=TableLineColor;
    _line.alpha=0;
    [_maskView addSubview:_line];
    
    
    _nanBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    _nanBtn.frame=CGRectMake(0, ViewHeight(_allBtn)+0.5, windowContentWidth, 40);
    [_nanBtn setTitle:@"男" forState:UIControlStateNormal];
    [_nanBtn setBackgroundColor:[UIColor whiteColor]];
    [_nanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_nanBtn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _nanBtn.tag=13;
    _nanBtn.alpha=0;
    [_maskView addSubview:_nanBtn];
    
    _line1=[[UIView alloc] initWithFrame:CGRectMake(0, 40*2+0.5, windowContentWidth, 0.5)];
    _line1.backgroundColor=TableLineColor;
    _line1.alpha=0;
    [_maskView addSubview:_line1];
    
    _nvBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    _nvBtn.frame=CGRectMake(0, ViewY(_nanBtn)+ViewHeight(_nanBtn)+0.5, windowContentWidth, 40);
    [_nvBtn setTitle:@"女" forState:UIControlStateNormal];
    [_nvBtn setBackgroundColor:[UIColor whiteColor]];
    [_nvBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_nvBtn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _nvBtn.tag=14;
    _nvBtn.alpha=0;
    [_maskView addSubview:_nvBtn];
    
    _keeperTab=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64) style:UITableViewStylePlain];
    _keeperTab.tableFooterView=[[UIView alloc] init];
    _keeperTab.delegate=self;
    _keeperTab.dataSource=self;
    //_keeperTab.tableHeaderView=_headerView;
    
    [self.view addSubview:_keeperTab];
    [self.view sendSubviewToBack:_keeperTab];
    
    
   
    NSMutableArray *imageAray=[NSMutableArray array];
    for (int i=0; i<2; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"单独-logo%d.png", i+2]];
        [imageAray addObject:image];
    }
    
    
    //-----------下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [_keeperTab addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置普通状态的动画图片
    [_keeperTab.gifHeader setImages:imageAray forState:MJRefreshHeaderStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [_keeperTab.gifHeader setImages:imageAray forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [_keeperTab.gifHeader setImages:imageAray forState:MJRefreshHeaderStateRefreshing];
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
    // 马上进入刷新状态
    [_keeperTab.gifHeader beginRefreshing];
    
    //----------上拉加载更多
    [_keeperTab addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadLastData)];
    
    if ([_keeperTab respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [_keeperTab setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([_keeperTab respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [_keeperTab setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    
}

#pragma mark 下拉刷新和加载更多
-(void)loadNewData
{
    _currentPage=1;
    _offset=0;
    NSDictionary *parameterDic;
    if (_gender==nil) {
        if (_chooseBtn==0) {
            parameterDic=@{@"offset":@"0",@"limit":Limite,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
        }else if (_chooseBtn==1) {
            parameterDic=@{@"offset":@"0",@"limit":Limite,@"order_count":_order_count,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
        }else if (_chooseBtn==2)
        {
            parameterDic=@{@"offset":@"0",@"limit":Limite,@"level":_level,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
        }
        
        
    }else{
        if (_chooseBtn==0) {
            parameterDic=@{@"offset":@"0",@"limit":Limite,@"gender":_gender,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
        }else if (_chooseBtn==1) {
            parameterDic=@{@"offset":@"0",@"limit":Limite,@"order_count":_order_count,@"gender":_gender,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
        }else if (_chooseBtn==2)
        {
            parameterDic=@{@"offset":@"0",@"limit":Limite,@"level":_level,@"gender":_gender,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
        }

//        parameterDic=@{@"offset":@"0",@"limit":Limite,@"order_count":_order_count,@"level":_level,@"gender":_gender,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
    }
    DLog("111parameter=%@",parameterDic);
    [self sendRequest:parameterDic aUrl:getHouseListUrl aTag:1];
    
    [self sendRequest:nil aUrl:AdvertUrl(@"76", [[WLSingletonClass defaultWLSingleton] wlCityId]) aTag:2];
    
    sleep(0.5);
    // 拿到当前的下拉刷新控件，结束刷新状态
    [_keeperTab.header endRefreshing];
    
}

-(void)loadLastData
{
    _offset=_currentPage*[Limite intValue];
    NSString *offset1=[NSString stringWithFormat:@"%ld",(long)_offset];
    NSDictionary *parameterDic;
    if (_gender==nil)
    {
        if (_chooseBtn==0) {
            
            parameterDic=@{@"offset":offset1,@"limit":Limite,@"order_count":_order_count,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
            
        }else if (_chooseBtn==1) {
            //parameterDic=@{@"offset":offset1,@"limit":Limite,@"order_count":_order_count,@"level":_level,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
            
            parameterDic=@{@"offset":offset1,@"limit":Limite,@"order_count":_order_count,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
            
        }else if (_chooseBtn==2)
        {
            
            parameterDic=@{@"offset":offset1,@"limit":Limite,@"level":_level,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
            
        }
        
    }
    else
    {
      
        if (_chooseBtn==0) {
            
            parameterDic=@{@"offset":offset1,@"limit":Limite,@"gender":_gender,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
            
        }else if (_chooseBtn==1) {
            //parameterDic=@{@"offset":offset1,@"limit":Limite,@"order_count":_order_count,@"level":_level,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
            
            parameterDic=@{@"offset":offset1,@"limit":Limite,@"order_count":_order_count,@"gender":_gender,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
            
        }else if (_chooseBtn==2)
        {
            
            parameterDic=@{@"offset":offset1,@"limit":Limite,@"level":_level,@"gender":_gender,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
            
        }

        //parameterDic=@{@"offset":offset1,@"limit":Limite,@"order_count":_order_count,@"level":_level,@"gender":_gender,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
        //_currentPage=0;
//        parameterDic=@{@"offset":offset1,@"limit":Limite,@"gender":_gender,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
    }
    DLog("parameter=%@",parameterDic);
    [self sendRequest:parameterDic aUrl:getHouseListUrl aTag:3];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 拿到当前的上拉刷新控件，变为没有更多数据的状态 [_tableView.footer noticeNoMoreData]
        //[_keeperTab.footer endRefreshing];
        [_keeperTab.footer endRefreshing];
    });
    _currentPage++;
    
}

#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_keeperTab)
    {
        return _keeperAraay.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==_keeperTab)
    {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==_keeperTab)
    {
        return 44;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //NSLog(@"labelSize.width==%f",cell.frame.size.height);
    if (tableView==_keeperTab)
    {
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        return ViewHeight(cell);
    }
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
        //    if (tableView==_keeperTab)
        //    {
        DLog(@"33333");
        _siftView=[[UIView alloc] init];
        _siftView.frame=CGRectMake(0, 0, windowContentWidth, 44);
        _siftView.backgroundColor=[UIColor whiteColor];
        
        
        UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, 43.5, windowContentWidth, 0.5)];
        line.backgroundColor=TableLineColor;
        [_siftView addSubview:line];
        
        for (int i=1; i<3; i++)
        {
            UIView *line1=[[UIView alloc] initWithFrame:CGRectMake(windowContentWidth/3*i, 7, 0.5, 30)];
            line1.backgroundColor=[UIColor orangeColor];
            [_siftView addSubview:line1];
        }
        
        
        NSMutableArray *nameArray=[[NSMutableArray alloc] initWithObjects:@"案例",@"评分", nil];
        for (int i=0; i<3; i++)
        {
            
            
            _topBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            _topBtn.frame=CGRectMake(windowContentWidth/3*i, 7, windowContentWidth/3-1, 30);
            
            if (i==2)
            {
                UIImageView *litileImage=[[UIImageView alloc] init];
                litileImage.frame=CGRectMake(((windowContentWidth/3)-20)+windowContentWidth/3*i, 30, 5, 5);
                litileImage.image=[UIImage imageNamed:@"矩形-3.png"];
                [_siftView addSubview:litileImage];
                [_topBtn setTitle:_sexState forState:UIControlStateNormal];
                
                if (_chooseBtn==3) {
                    
                    
                    UIButton *button3=(UIButton *)[_siftView viewWithTag:10];
                    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    UIButton *button4=(UIButton *)[_siftView viewWithTag:11];
                    [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    
                }
            }
            else
            {
                [_topBtn setTitle:[nameArray objectAtIndex:i] forState:UIControlStateNormal];
            }
            _topBtn.titleLabel.font=[UIFont systemFontOfSize:15];
            
            if (_chooseBtn==0)
            {
                [_topBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
            }else
            {
                if (i==0) {
                    
                    if (_chooseBtn==1)
                    {
                        
                        
                        [_topBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                    }else
                    {
                        [_topBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    }
                    
                }
                else if (i==1)
                {
                    
                    if (_chooseBtn==2)
                    {
                        [_topBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                    }else
                    {
                        [_topBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    }
                    
                }
                else
                {
                    [_topBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }
            }
            
            [_topBtn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            _topBtn.tag=i+10;
            [_siftView addSubview:_topBtn];
            
        }
        
        
        return _siftView;
        
    }
    



//- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section ==1) {
//        return @"周边特色";
//    }
//    if (section == 2) {
//        return @"热门线路";
//    }
//    return nil;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView==_keeperTab)
    {
        static NSString *CellIdentifier1 = @"cellIdentifier1";
        LXGuanJiaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            cell = [[LXGuanJiaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
            //单元格的选择风格，选择时单元格不出现蓝条
           // cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if (_keeperAraay.count>0) {
            LXGuanJiaModel *model=[_keeperAraay objectAtIndex:indexPath.row];
            //[cell setIntroductionText:model.infoStr];
            [cell returnTextCGRectText:model.infoStr textFont:13];
            cell.item=model;
        }
       
        
        return cell;
    }
    
    return nil;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"_________%lu",indexPath.row);
    if (tableView==_keeperTab)
    {
        LXGuanJiaModel *guanjiaModel=[_keeperAraay objectAtIndex:indexPath.row];
        YXHouseDetailViewController *houseKeepervc=[[YXHouseDetailViewController alloc] init];
        houseKeepervc.houseID=guanjiaModel.keeperID;
        houseKeepervc.houseName=guanjiaModel.nameStr;
        [self.navigationController pushViewController:houseKeepervc animated:YES];
        
    }
    
    
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


-(void)topBtnClick:(UIButton *)bttn
{
    switch (bttn.tag) {
        case 10:
        {
            UIButton *button=(UIButton *)[_siftView viewWithTag:11];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _currentPage=1;
            //按案例数排序
            _chooseBtn=1;
            if (_isOrder_count==NO)
            {
                _isOrder_count=YES;
                _order_count=@"asc";
                // _level=@"asc";
                
                
            }else if(_isOrder_count==YES)
            {
                _isOrder_count=NO;
                _order_count=@"desc";
                //_level=@"desc";
                
            }
            
            NSDictionary *parameterDic;
            if (_gender==nil) {
                // parameterDic=@{@"offset":@"0",@"limit":@"10",@"order_count":_order_count,@"level":_level,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
                parameterDic=@{@"offset":@"0",@"limit":@"10",@"order_count":_order_count,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
            }else
            {
                //parameterDic=@{@"offset":@"0",@"limit":@"10",@"order_count":_order_count,@"level":_level,@"gender":_gender,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
                parameterDic=@{@"offset":@"0",@"limit":@"10",@"order_count":_order_count,@"gender":_gender,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
            }
            [self sendRequest:parameterDic aUrl:getHouseListUrl aTag:1];
            DLog(@"按案例数排序");
            
        }
            break;
            
        case 11:
        {
            UIButton *button=(UIButton *)[_siftView viewWithTag:10];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            _currentPage=1;
            //按评分排序
            DLog(@"按评分排序");
            _chooseBtn=2;
            if (_isLevel==NO)
            {
                _isLevel=YES;
                //_order_count=@"asc";
                _level=@"asc";
                
                
            }else
            {
                _isLevel=NO;
                //_order_count=@"desc";
                _level=@"desc";
                
            }
            
            
            NSDictionary *parameterDic;
            if (_gender==nil) {
                //parameterDic=@{@"offset":@"0",@"limit":@"10",@"order_count":_order_count,@"level":_level,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
                parameterDic=@{@"offset":@"0",@"limit":@"10",@"level":_level,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
            }else{
                //parameterDic=@{@"offset":@"0",@"limit":@"10",@"order_count":_order_count,@"level":_level,@"gender":_gender,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
                parameterDic=@{@"offset":@"0",@"limit":@"10",@"level":_level,@"gender":_gender,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
                NSLog(@"%@",parameterDic);
            }
            [self sendRequest:parameterDic aUrl:getHouseListUrl aTag:1];
            
            
        }
            break;
            
        case 12:
        {
            //选择男女
            
            if (_isShou==NO)
            {
                [self selectSexShow];
                
            }else if(_isShou==YES)
            {
                
                [self selectSexClose];
                
            }
            
        }
            break;
            
        case 13:
        {
            _chooseBtn=3;
            _currentPage=1;
            _sexState=@"男";
            _gender=@"1";
            NSDictionary *parameterDic=@{@"offset":@"0",@"limit":@"50",@"gender":_gender,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
            [self sendRequest:parameterDic aUrl:getHouseListUrl aTag:1];
            [self selectSexClose];
        }
            break;
            
        case 14:
        {
            _chooseBtn=3;
            _currentPage=1;
            _sexState=@"女";
            _gender=@"2";
            NSDictionary *parameterDic=@{@"offset":@"0",@"limit":@"50",@"gender":_gender,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
            [self sendRequest:parameterDic aUrl:getHouseListUrl aTag:1];
            [self selectSexClose];
        }
            break;
            
        case 15:
        {
            _chooseBtn=3;
            _currentPage=1;
            _sexState=@"全部";
            _gender=nil;
            NSDictionary *parameterDic=@{@"offset":@"0",@"limit":@"50",@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
            [self sendRequest:parameterDic aUrl:getHouseListUrl aTag:1];
            [self selectSexClose];
        }
            break;
            
        default:
            break;
    }
    
}

-(void)selectSexShow
{
    
    //获取table滑动的位置
    CGPoint point = [_keeperTab contentOffset];
    if (point.y<ViewHeight(_headerView))
    {
        _maskView.frame=CGRectMake(0, ViewHeight(_keeperTab.tableHeaderView)+44-point.y, windowContentWidth, 0);
    }else{
        _maskView.frame=CGRectMake(0, 44, windowContentWidth, 0);
        
    }
    
    _isShou=YES;
    _keeperTab.scrollEnabled=NO;
    [UIView animateWithDuration:0.3 animations:^{
        if (point.y<ViewHeight(_headerView))
        {
            _maskView.frame=CGRectMake(0, ViewHeight(_keeperTab.tableHeaderView)+44-point.y, windowContentWidth, ViewHeight(_keeperTab));
        }
        else
        {
            _maskView.frame=CGRectMake(0, 44, windowContentWidth, ViewHeight(_keeperTab));
            
        }
        
        _nanBtn.alpha=1;
        _nvBtn.alpha=1;
        _line.alpha=1;
        _line1.alpha=1;
        _allBtn.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)selectSexClose
{
    //获取table滑动的位置
    CGPoint point = [_keeperTab contentOffset];
    _isShou=NO;
    _keeperTab.scrollEnabled=YES;
    [UIView animateWithDuration:0.3 animations:^{
        if (point.y<ViewHeight(_headerView)) {
            _maskView.frame=CGRectMake(0, ViewHeight(_keeperTab.tableHeaderView)+44-point.y, windowContentWidth, 0);
        }else
        {
            _maskView.frame=CGRectMake(0, 44, windowContentWidth, 0);
        }
        _nanBtn.alpha=0;
        _nvBtn.alpha=0;
        _line.alpha=0;
        _line1.alpha=0;
        _allBtn.alpha=0;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----- 搜索管家
-(void)beginSearch:(NSString *)text
{
    NSDictionary *parameterDic=@{@"offset":@"0",@"limit":@"10",@"keywords":text,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
    [self sendRequest:parameterDic aUrl:getHouseListUrl aTag:1];
    
    //[_keeperTab reloadData];
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

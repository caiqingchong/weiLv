//
//  LXTraveListViewController.m
//  WelLv
//
//  Created by lx on 15/8/4.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#define Order_desc @"desc"
#define Order_asc  @"asc"

#import "LXTraveListViewController.h"
#import "LXTraveModel.h"
#import "YXDetailTraveViewController.h"
#import "LXTraveCellTableViewCell.h"
#import "LXGetCityIDTool.h"
#import "LXTraveSiftView.h"
#import "ProductDetailViewController.h"

@interface LXTraveListViewController ()
<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_traveListTable;
    //NSInteger _offset;//偏移量
    NSInteger _currentPage;
    
}

@property (nonatomic,strong)NSMutableArray *traveListArray;

/**
 *  排序方式,按销量排序
 */
@property (nonatomic,copy)NSString *order_type;

@property (nonatomic,copy)NSString *offset;
@property (nonatomic,copy)NSString *limit;
@property (nonatomic,copy)NSString *route_type;//旅游类型
@property (nonatomic,copy)NSString *order_field;//排序类型（销量，价格）


@property (nonatomic,copy)NSString *s_price;//价格下限
@property (nonatomic,copy)NSString *e_price;//价格上限
@property (nonatomic,copy)NSString *s_days;//天数下限
@property (nonatomic,copy)NSString *e_days;//天数上限

@property (nonatomic,strong)LXTraveSiftView *traveSiftView;

@end

@implementation LXTraveListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initView];
}

- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [self.traveSiftView All_Hidden_Yes];
}

-(void)initData
{
    if ([self.traveType intValue]==5) {
        self.title=@"一日游";
    }
    if ([self.traveType intValue]==6) {
        self.title=@"周边游";
    }
    if ([self.traveType intValue]==7) {
        self.title=@"国内游";
    }
    if ([self.traveType intValue]==8) {
        self.title=@"出境游";
    }
    if ([self.traveType intValue]==9) {
        self.title=@"港澳台";
    }if ([self.traveType intValue]==10) {
        self.title=@"境外参团";
    }
    
    self.view.backgroundColor=[UIColor whiteColor];
    _traveListArray=[[NSMutableArray alloc] initWithCapacity:0];
    _offset=@"0";
    _limit=@"10";
    _city_id=[[WLSingletonClass defaultWLSingleton] wlCityId];
    _route_type=self.traveType;
}

-(void)initView
{
    
    self.traveSiftView=[[LXTraveSiftView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 50) traveType:[self.traveType intValue]];
    [self.view addSubview:self.traveSiftView];
    
    [self.traveSiftView returnCompositeBlock:^(NSString *compositeInfo) {
        DLog(@"返回综合---%@",compositeInfo);
        if ([compositeInfo isEqualToString:@"综合"]) {
            [self initData];
          
        }else if ([compositeInfo isEqualToString:@"销量"])
        {
            [self initData];
            _order_field=@"real_sell_count";
            
        }else if ([compositeInfo isEqualToString:@"价格从低到高"])
        {
            [self initData];
            _order_field=@"sell_price";
            _order_type=Order_asc;
           
        }else if ([compositeInfo isEqualToString:@"价格从高到低"])
        {
            [self initData];
            _order_field=@"sell_price";
            _order_type=Order_desc;
        }
        [self sendRequest:nil offset:_offset limit:_limit route_type:_route_type order_type:_order_type order_field:_order_field city_id:_city_id t_city:_t_city t_province:_t_province t_country:_t_country s_price:_s_price e_price:_e_price s_days:_s_days e_days:_e_days aurl:ListTraveUrl aTag:1];
        
    } infoBlock:^(NSString *priceBlock, NSString *dayBlock, NSString *destinationBlock) {
        DLog(@"回调（%@，%@，%@）",priceBlock,dayBlock,destinationBlock);
        [_traveListArray removeAllObjects];
        if (priceBlock) {
            if ([priceBlock isEqualToString:@"2万以上"]) {
                _s_price=@"20000";
            }else{
                NSArray *priceArray=[priceBlock componentsSeparatedByString:@"-"];
                _s_price=[priceArray objectAtIndex:0];
                _e_price=[priceArray objectAtIndex:1];
            }
        }else{
            _s_price=nil;
            _e_price=nil;
        }
        
        if (dayBlock) {
            NSString *day=[dayBlock stringByReplacingOccurrencesOfString:@"天" withString:@""];
           
            NSArray *daysArray=[day componentsSeparatedByString:@"-"];
            _s_days=[daysArray objectAtIndex:0];
            _e_days=[daysArray objectAtIndex:1];
        }else{
            _s_days=nil;
            _e_days=nil;
        }
        
        if (destinationBlock) {
            //先获取城市id
            if ([self.traveType intValue]==7 || [self.traveType intValue]==9) {
                //国内
                if ([destinationBlock isEqualToString:@"北京"] ||
                    [destinationBlock isEqualToString:@"天津"] ||
                    [destinationBlock isEqualToString:@"上海"] ||
                    [destinationBlock isEqualToString:@"重庆"] ||
                    [destinationBlock isEqualToString:@"香港"] ||
                    [destinationBlock isEqualToString:@"澳门"] ||
                    [destinationBlock isEqualToString:@"台湾"] ) {
                    //市
                    [self getT_cityID:destinationBlock region_type:@"3"];
                }else
                {
                    //省
                    [self getT_cityID:destinationBlock region_type:@"2"];
                }
                
            }else if ([self.traveType intValue]==8|| [self.traveType intValue]==10||[self.traveType intValue]==0){
                //国家
                DLog(@"%@",destinationBlock);
                [self getT_cityID:destinationBlock region_type:@"1"];
                
            }
            
        }else
        {
            _t_city=nil;
            _t_country=nil;
            _t_province=nil;
            [self sendRequest:nil offset:_offset limit:_limit route_type:_route_type order_type:_order_type order_field:_order_field city_id:_city_id t_city:_t_city t_province:_t_province t_country:_t_country s_price:_s_price e_price:_e_price s_days:_s_days e_days:_e_days aurl:ListTraveUrl aTag:1];
        }
        
    }];
        
   
    
    if (_traveListTable == nil) {
        
        _traveListTable = [[UITableView alloc] init];
        if (self.isFromSpring==NO)
        {
            _traveListTable.frame=CGRectMake(0, 50, windowContentWidth, windowContentHeight-64-50);
        }else
        {
            _traveListTable.frame=CGRectMake(0, 0, windowContentWidth, windowContentHeight-64-50);
        }
        _traveListTable.dataSource = self;
        _traveListTable.delegate = self;
        _traveListTable.backgroundColor = [UIColor clearColor];
        _traveListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_traveListTable];
        
        
        if ([_traveListTable respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [_traveListTable setSeparatorInset:UIEdgeInsetsZero];
            
        }
        
        if ([_traveListTable respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [_traveListTable setLayoutMargins:UIEdgeInsetsZero];
            
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
    
    __weak LXTraveListViewController *visaListVC = self;
    [_traveListTable addGifHeaderWithRefreshingBlock:^{
        [visaListVC.traveListArray removeAllObjects];
        [visaListVC loadNewData];
    }];
    // 设置普通状态的动画图片
    [_traveListTable.gifHeader setImages:imageAray forState:MJRefreshHeaderStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [_traveListTable.gifHeader setImages:imageAray forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [_traveListTable.gifHeader setImages:imageAray forState:MJRefreshHeaderStateRefreshing];
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
    // 马上进入刷新状态
    [_traveListTable.gifHeader beginRefreshing];
    [_traveListTable.footer setState:MJRefreshFooterStateIdle];
    //加载更多
    [_traveListTable addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadLastData)];
}

#pragma mark -
#pragma mark 刷新数据
-(void)loadNewData
{
    _currentPage=1;
    if (self.isFromSpring==NO)
    {
        _offset=@"0";
        [self sendRequest:nil offset:_offset limit:_limit route_type:_route_type order_type:_order_type order_field:_order_field city_id:_city_id t_city:_t_city t_province:_t_province t_country:_t_country s_price:_s_price e_price:_e_price s_days:_s_days e_days:_e_days aurl:ListTraveUrl aTag:1];
    }
    else{
        //特惠游
        NSString *offset1=[NSString stringWithFormat:@"%d",0];
        NSDictionary *dic=@{@"category_id":@"67",@"offset":offset1,@"limit":@"1000"};

        [self sendRequest:dic offset:nil limit:nil route_type:nil order_type:nil order_field:nil city_id:nil t_city:nil t_province:nil t_country:nil s_price:nil e_price:nil s_days:nil e_days:nil aurl:ListTraveUrl aTag:1];
    }
    
    
    // 拿到当前的下拉刷新控件，结束刷新状态
    [_traveListTable.header endRefreshing];
    
}

#pragma mark -
#pragma mark 加载更多
-(void)loadLastData
{
    if (self.isFromSpring==NO)
    {
       
        _offset=[NSString stringWithFormat:@"%ld",_currentPage*10];
        [self sendRequest:nil offset:_offset limit:_limit route_type:_route_type order_type:_order_type order_field:_order_field city_id:_city_id t_city:_t_city t_province:_t_province t_country:_t_country s_price:_s_price e_price:_e_price s_days:_s_days e_days:_e_days aurl:ListTraveUrl aTag:1];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表格
            [_traveListTable reloadData];
            
            // 拿到当前的上拉刷新控件，变为没有更多数据的状态 [_tableView.footer noticeNoMoreData]
            [_traveListTable.footer endRefreshing];
            _currentPage++;
        });
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表格
            [_traveListTable reloadData];
            
            // 拿到当前的上拉刷新控件，变为没有更多数据的状态 [_tableView.footer noticeNoMoreData]
            [_traveListTable.footer noticeNoMoreData];
            _currentPage++;
        });
    }
}

#pragma mark -
#pragma mark 获取数据
-(void)sendRequest:(NSDictionary *)aparameters
            offset:(NSString *)aoffset
             limit:(NSString *)alimit
        route_type:(NSString *)aroute_type//旅游类型
        order_type:(NSString *)aorder_type//排序方式
       order_field:(NSString *)aorder_field//排序类型（销量，价格）
           city_id:(NSString *)acity_id
            t_city:(NSString *)at_city//目的地城市
        t_province:(NSString *)at_province//目的地省
         t_country:(NSString *)at_country//目的地国家
           s_price:(NSString *)as_price//价格下限
           e_price:(NSString *)ae_price//价格上限
            s_days:(NSString *)as_days//天数下限
            e_days:(NSString *)ae_days//天数上限
              aurl:(NSString *)url
              aTag:(int)tag
{
    NSDictionary *postDic;
    if (aparameters==nil) {

        aroute_type  = !aroute_type?@"" :aroute_type;
        aorder_type  = !aorder_type?@"" :aorder_type;
        aorder_field = !aorder_field?@"":aorder_field;
        at_city      = !at_city?@""     :at_city;
        at_province  = !at_province?@"" :at_province;
        at_country   = !at_country?@""  :at_country;
        as_price     = !as_price?@""    :as_price;
        ae_price     = !ae_price?@""    :ae_price;
        as_days      = !as_days?@""     :as_days;
        ae_days      = !ae_days?@""     :ae_days;
        
        
            NSString *assistant_id=@"";
            if ([[[LXUserTool alloc] getKeeper] rangeOfString:@"null"].location!=NSNotFound) {
                assistant_id=@"0";
            }
            else
            {
                assistant_id=[[LXUserTool alloc] getKeeper];
            }
        postDic=@{@"offset":aoffset,@"limit":alimit,@"order_type":aorder_type,@"route_type":aroute_type,@"order_field":aorder_field,@"t_city":at_city,@"t_province":at_province,@"t_country":at_country,@"city_id":acity_id,@"s_price":as_price,@"e_price":ae_price,@"s_days":as_days,@"e_days":ae_days,@"assistant_id":assistant_id};
    }else
    {
        postDic=aparameters;
    }
    DLog(@"传送的数据--%@",postDic);

    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];//
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSLog(@"%@",url);
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:postDic
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              DLog(@"%@",operation);
              DLog(@"%@",dic);
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
                  [_traveListTable reloadData];
                  [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              }
              
              if (_traveListTable.contentSize.height < ControllerViewHeight) {
                  [_traveListTable removeFooter];
              }
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
              
          }];
    
}

#pragma mark 获取目的地id
-(void)getT_cityID:(NSString *)t_cityName region_type:(NSString *)region_type
{
    //_t_route_type=region_type;
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    NSDictionary *dic=@{@"region_name":t_cityName,@"region_type":region_type};
    //DLog(@"dic===%@",dic);
    NSString *url=GetCityIDUrl;
    //[self sendRequest:dic aurl:url aTag:1];
    //__block NSString *city_regionID=nil;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dic
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              
              //旅游列表(无搜索条件)
              //DLog(@"Success: dic=%@--%@",dic, [dic objectForKey:@"msg"]);
              if ([[dic objectForKey:@"status"] integerValue]==1)
              {
                  NSArray *array=[dic objectForKey:@"data"];
                  NSDictionary *dict1=[[NSDictionary alloc] init];
                  
                  dict1=[array objectAtIndex:0];

                  if ([region_type isEqualToString:@"3"])
                  {
                      //根据目的地城市筛选

                      _t_city=[dict1 objectForKey:@"region_id"];
                  }
                  else if ([region_type isEqualToString:@"2"])
                  {
                      //根据目的地省份筛选

                      _t_province=[dict1 objectForKey:@"region_id"];
                  }
                  else
                  {
                      //根据目的地国家筛选

                      _t_country=[dict1 objectForKey:@"region_id"];
                  }
                  
                  [self sendRequest:nil offset:_offset limit:_limit route_type:_route_type order_type:_order_type order_field:_order_field city_id:_city_id t_city:_t_city t_province:_t_province t_country:_t_country s_price:_s_price e_price:_e_price s_days:_s_days e_days:_e_days aurl:ListTraveUrl aTag:1];
                  
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
             
          }];
    
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
//    YXDetailTraveViewController *yxDetailVc=[[YXDetailTraveViewController alloc] init];
//    yxDetailVc.productId=model.traveID;
//    yxDetailVc.productPrice=model.price;
//    yxDetailVc.realBeginDate=model.lastest;
//    [self.navigationController pushViewController:yxDetailVc animated:YES];
    ProductDetailViewController *productVC = [[ProductDetailViewController alloc]init];
    productVC.productID = model.traveID;
    productVC.gj_commission = model.gj_commission;
    [self.navigationController pushViewController:productVC animated:YES];
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

//
//  TravelNewSearchResultViewController.m
//  WelLv
//
//  Created by 张子乾 on 16/2/22.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "TravelNewSearchResultViewController.h"
#import "LXTraveCellTableViewCell.h"
#import "LXTraveModel.h"
#import "YXDetailTraveViewController.h"
#import "LXGetCityIDTool.h"
#import "ProductDetailViewController.h"


@interface TravelNewSearchResultViewController ()
<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_traveListTab;
    NSMutableArray *_traveListArray;
    NSInteger _offset;//偏移量
    NSInteger _currentPage;
}


@end

@implementation TravelNewSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    // self.title=@"旅游产品";
    [self initData];
    [self initView];
}

-(void)initData
{
    _traveListArray=[NSMutableArray array];
    _currentPage=0;
    _offset=0;
}

-(void)initView
{
    if (_traveListTab == nil) {
        
        _traveListTab = [[UITableView alloc] init];
        _traveListTab.frame=CGRectMake(0, 0, windowContentWidth, windowContentHeight - 64);
        _traveListTab.dataSource = self;
        _traveListTab.delegate = self;
        
        _traveListTab.backgroundColor = [UIColor clearColor];
        _traveListTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_traveListTab];
        
        
        if ([_traveListTab respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [_traveListTab setSeparatorInset:UIEdgeInsetsZero];
            
        }
        if ([_traveListTab respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [_traveListTab setLayoutMargins:UIEdgeInsetsZero];
            
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
    
    __weak TravelNewSearchResultViewController *visaListVC = self;
    [_traveListTab addGifHeaderWithRefreshingBlock:^{
        //[visaListVC.traveListArray removeAllObjects];
        [visaListVC loadNewData];
    }];
    // 设置普通状态的动画图片
    [_traveListTab.gifHeader setImages:imageAray forState:MJRefreshHeaderStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [_traveListTab.gifHeader setImages:imageAray forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [_traveListTab.gifHeader setImages:imageAray forState:MJRefreshHeaderStateRefreshing];
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
    // 马上进入刷新状态
    //[_traveListTab.gifHeader beginRefreshing];
    
    //加载更多
    [_traveListTab addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadLastData)];
    
    [self loadNewData];
    
}

#pragma mark -- 刷新列表
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
    [_traveListArray removeAllObjects];
    _currentPage=1;
    NSString *offset1=[NSString stringWithFormat:@"%d",0];
    NSDictionary *dic = [[NSDictionary alloc] init];
    self.keywords = [self judgeReturnString:self.keywords withReplaceString:@""];
    if ([self.area isEqualToString:@"country"]) {
        dic=@{@"offset":offset1,@"limit":@"10",@"product_name":self.keywords,@"city_id":@"",@"assistant_id":assistant_id};
    }else{
        dic=@{@"offset":offset1,@"limit":@"10",@"product_name":self.keywords,@"city_id":[[WLSingletonClass defaultWLSingleton] wlCityId],@"assistant_id":assistant_id};
    }
    // NSDictionary *dic=@{@"offset":offset1,@"limit":@"10",@"product_name":self.keywords,@"city_id":[LXGetCityIDTool sharedMyTools].city_regionID};
//    NSString *url=ListTraveUrl;
    
    dic=@{@"title":self.keywords,@"city_id":[[WLSingletonClass defaultWLSingleton] wlCityId],@"search_type":self.search_type};
    
    
    [self sendRequest:dic aurl:SHAIXUAN aTag:1];
    
    // 拿到当前的下拉刷新控件，结束刷新状态
    [_traveListTab.header endRefreshing];
}

#pragma mark -- 加载更多
-(void)loadLastData
{
    NSString *assistant_id=@"";
    if ([[[LXUserTool alloc] getKeeper] rangeOfString:@"null"].location!=NSNotFound) {
        assistant_id=@"0";
    }
    else
    {
        assistant_id=[[LXUserTool alloc] getKeeper];
    }
    
    _offset=_currentPage*10;
    NSString *offset1=[NSString stringWithFormat:@"%ld",(long)_offset];
    NSDictionary *dic = [[NSDictionary alloc] init];
    if ([self.area isEqualToString:@"country"]) {
        dic=@{@"offset":offset1,@"limit":@"10",@"product_name":self.keywords,@"city_id":@"",@"assistant_id":assistant_id};
    }else{
        dic=@{@"offset":offset1,@"limit":@"10",@"product_name":self.keywords,@"city_id":[[WLSingletonClass defaultWLSingleton] wlCityId],@"assistant_id":assistant_id};
    }
    // NSDictionary *dic=@{@"offset":offset1,@"limit":@"10",@"product_name":self.keywords,@"city_id":[LXGetCityIDTool sharedMyTools].city_regionID};
    NSString *url=ListTraveUrl;
    [self sendRequest:dic aurl:url aTag:1];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_traveListTab reloadData];
        
        // 拿到当前的上拉刷新控件，变为没有更多数据的状态 [_tableView.footer noticeNoMoreData]
        
        [_traveListTab.footer endRefreshing];
        _currentPage++;
    });
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
    static NSString *CellIdentifier0 = @"cellIdentifier0";
    LXTraveCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier0];
    if (cell == nil)
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


-(void)sendRequest:(NSDictionary *)parameters aurl:(NSString *)url aTag:(int)tag
{
    
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
//                  DLog(@"Success: %@---msg=%@", dic,[dic objectForKey:@"msg"]);
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
                          
                          if ([dict1 objectForKey:@"thumb"] != nil&&!([[dict1 objectForKey:@"thumb"] isEqual:[NSNull null]]))
                          {
                              model.leftImage = dict1[@"thumb"];
                          }
                          model.name=[dict1 objectForKey:@"product_name"];
                          model.price=[dict1 objectForKey:@"adult_price"];
                          model.info=[dict1 objectForKey:@"feature"];
                          model.traveID= dict1[@"product_id"];
                          model.gj_commission=[dict1 objectForKey:@"gj_commission"];
                          model.lastest=[dict1 objectForKey:@"lastest"];
                          [_traveListArray addObject:model];
                          
                      }
                      
                      
                  }
                  else
                  {
                      [[LXAlterView sharedMyTools] createTishi:@"暂无数据"];
                      //[_traveListTab removeFromSuperview];
                      
                  }
                  
                  
                  if (_traveListArray.count>0)
                  {
                      [_traveListTab reloadData];
                      
                  }
                  else
                  {
                      UIImageView *bgView=[[UIImageView alloc] init];
                      bgView.frame=CGRectMake((windowContentWidth-200)/2, (windowContentHeight-200-64-100)/2, 200, 200);
                      bgView.backgroundColor = [UIColor whiteColor];
                      bgView.image=[UIImage imageNamed:@"没找到相关内容.png"];
                      [self.view addSubview:bgView];
                  }
                  
                  [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              }
              if (_traveListTab.contentSize.height < ControllerViewHeight) {
                  [_traveListTab removeFooter];
              }
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
              
          }];
    
}

- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
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

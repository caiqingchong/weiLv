//
//  LXSTListViewController.m
//  WelLv
//
//  Created by 刘鑫 on 15/8/17.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
#define Order_desc @"desc"
#define Order_asc  @"asc"
#import "LXSTListViewController.h"
#import "LXSTListModel.h"
#import "LXSTListCell.h"
#import "LXSTModel.h"
//#import "YXDetailTraveViewController.h"
#import "LXSTDetailViewController.h"

@interface LXSTListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView *_compositeTable;
    UITableView *_typeTable;
    UIView *_topView;
    UIView *_maskView;
    NSArray *_compositeArr;
    NSArray *_typeArr;
    
    NSInteger _currentPage;
    UIButton *_compositeBtn;
    UIButton *_typeBtn;
}
@property(nonatomic,strong)UIButton *typeBtn;
@property(nonatomic,strong)UIButton *compositeBtn;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *listArray;

@property (nonatomic,copy)NSString *offset;
@property (nonatomic,copy)NSString *limit;
@property (nonatomic,copy)NSString *d_name;
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *order_field;//排序类型（销量，价格）
@property (nonatomic,copy)NSString *type_name;

/**
 *  排序方式,按销量排序，升序或者降序
 */
@property (nonatomic,copy)NSString *order_type;
@end

@implementation LXSTListViewController

- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"游学列表";
    [self initData];
    [self initView];
    [self initTopView];
    self.view.backgroundColor=[UIColor whiteColor];
    
    
}

-(void)initData
{
    _listArray=[[NSMutableArray alloc] initWithCapacity:0];
    
}

-(void)initTopView
{
    
    _topView = [[UIView alloc] init];
    _topView.frame=CGRectMake(0, 0, windowContentWidth, 40);
    _topView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_topView];
    
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(windowContentWidth/2, 10, 0.5, 20)];
    line.backgroundColor=[UIColor orangeColor];
    [_topView addSubview:line];
    
    UIView *line1=[[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(_topView), windowContentWidth , 0.5)];
    line1.backgroundColor=TableLineColor;
    [_topView addSubview:line1];
    
    self.compositeBtn=[YXTools allocButton:@"综合" textColor:[UIColor grayColor] nom_bg:nil hei_bg:nil frame:CGRectMake(0, 0, windowContentWidth/2, ViewHeight(_topView))];
    self.compositeBtn.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    self.compositeBtn.tag=20;
    [self.compositeBtn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:self.compositeBtn];
    
    self.typeBtn=[YXTools allocButton:@"类型" textColor:[UIColor grayColor] nom_bg:nil hei_bg:nil frame:CGRectMake(windowContentWidth/2, 0, windowContentWidth/2, ViewHeight(_topView))];
    self.typeBtn.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    self.typeBtn.tag=21;
    [self.typeBtn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:self.typeBtn];
    
    
    _maskView=[[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(_topView), windowContentWidth, windowContentHeight-ViewHeight(_topView))];
    _maskView.backgroundColor=[UIColor colorWithWhite:0.2 alpha:0.7];
    _maskView.hidden=YES;
    _maskView.userInteractionEnabled=YES;
    [self.view addSubview:_maskView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(allHidden_Yes)];
    [_maskView addGestureRecognizer:tap];
    
    _compositeArr=@[@"综合",@"销量"];
    _compositeTable = [[UITableView alloc] initWithFrame:CGRectMake(0, ViewHeight(_topView), windowContentWidth, _compositeArr.count*40)];
    //_compositeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _compositeTable.delegate = self;
    _compositeTable.dataSource = self;
    _compositeTable.hidden=YES;
    [self.view addSubview:_compositeTable];
    
    _typeArr=@[@"全部",@"素质游学",@"高端访学",@"英语突破",@"名校体验",@"亲子游学",@"体育运动",@"艺术研学",@"研究访学",@"带薪实习",@"国际志愿者"];
    _typeTable = [[UITableView alloc] initWithFrame:CGRectMake(0, ViewHeight(_topView), windowContentWidth, _typeArr.count*40)];
    if (_typeArr.count*40>(ControllerViewHeight-40)) {
        _typeTable.frame=CGRectMake(0, ViewHeight(_topView), windowContentWidth, _typeArr.count*40-ViewHeight(_topView));
    }
    //_typeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _typeTable.delegate = self;
    _typeTable.dataSource = self;
    _typeTable.hidden=YES;
    [self.view addSubview:_typeTable];
    
}

-(void)topBtnClick:(UIButton *)btn
{
    
    if (btn.tag==20) {
        if (_compositeTable.hidden==YES) {
            [self compositeTable_Hidden_NO];
        }else{
            [self allHidden_Yes];
        }
    }else if (btn.tag==21) {
        
        if (_typeTable.hidden==YES) {
            [self typeTable_Hidden_NO];
        }else{
            [self allHidden_Yes];
        }
    }
   
}

-(void)allHidden_Yes
{
    
    _maskView.hidden=YES;
    _compositeTable.hidden=YES;
    _typeTable.hidden=YES;
}

-(void)compositeTable_Hidden_NO
{
    _compositeTable.hidden=NO;
    _maskView.hidden=NO;
    _typeTable.hidden=YES;
}

-(void)typeTable_Hidden_NO
{
    _typeTable.hidden=NO;
    _maskView.hidden=NO;
    _compositeTable.hidden=YES;
}



-(void)initView
{
    
    
    if (_tableView==nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, windowContentWidth, windowContentHeight - NavHeight-ViewHeight(_topView))];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
            
        }
        
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
            
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
    
    __weak LXSTListViewController *listVC = self;
    [_tableView addGifHeaderWithRefreshingBlock:^{
        [listVC.listArray removeAllObjects];
        [listVC loadNewData];
    }];
    // 设置普通状态的动画图片
    [_tableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [_tableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [_tableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateRefreshing];
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
    // 马上进入刷新状态
    [_tableView.gifHeader beginRefreshing];
    
    //加载更多
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadLastData)];


}
-(void)loadNewData
{
    _currentPage=1;
    _offset=@"0";
    _limit=@"10";
    if (self.sourceType==HotCity) {
        _d_name=self.city_name;
        
    }
    
    if (self.sourceType==Theme1) {
        _type_name=self.themeType;
    }
//    if (self.sourceType==Search) {
//        <#statements#>
//    }
    
    [self sendRequest:nil offset:_offset limit:_limit order_type:_order_type order_field:_order_field  dName:_d_name type:_type type_name:_type_name keywords:self.keywords url:StudyTourUrl aTag:1];
    
    // 拿到当前的下拉刷新控件，结束刷新状态
    [_tableView.header endRefreshing];
}

-(void)loadLastData
{
    _offset=[NSString stringWithFormat:@"%ld",_currentPage*10];
     [self sendRequest:nil offset:_offset limit:_limit order_type:_order_type order_field:_order_field  dName:_d_name type:_type type_name:_type_name keywords:self.keywords url:StudyTourUrl aTag:1];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_tableView reloadData];
        
        // 拿到当前的上拉刷新控件，变为没有更多数据的状态 [_tableView.footer noticeNoMoreData]
        [_tableView.footer endRefreshing];
        _currentPage++;
    });
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_compositeTable) {
        return _compositeArr.count;
    }else if (tableView==_typeTable){
        return _typeArr.count;
    }
    return _listArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_compositeTable || tableView == _typeTable) {
        return 40;
    }
    return 95;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_compositeTable) {
        static NSString *CellIdentifier1 = @"cellIdentifier1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
            //单元格的选择风格，选择时单元格不出现蓝条
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
           // cell.imageView.image=[UIImage imageNamed:[_compositeArr objectAtIndex:indexPath.row]];
            cell.textLabel.text=[_compositeArr objectAtIndex:indexPath.row];
            cell.textLabel.font=[UIFont systemFontOfSize:13];
        }
        
        return cell;
    }else if (tableView==_typeTable){
        static NSString *CellIdentifier1 = @"cellIdentifier1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
            //单元格的选择风格，选择时单元格不出现蓝条
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text=[_typeArr objectAtIndex:indexPath.row];
            cell.textLabel.font=[UIFont systemFontOfSize:13];
        }
        
        return cell;
    }else{
        static NSString *CellIdentifier1 = @"cellIdentifier1";
        LXSTListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        
        if (cell == nil)
        {
            cell = [[LXSTListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
            //单元格的选择风格，选择时单元格不出现蓝条
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        if (_listArray.count>0) {
            LXSTListModel *model=[_listArray objectAtIndex:indexPath.row];
            cell.model=model;
        }
        
        
        return cell;
    }
    
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_compositeTable) {
        [self.compositeBtn setTitle:[_compositeArr objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        if (indexPath.row==0) {
            _order_field=@"";
        }else{
            //_order_field=@"real_sell_count";
            //修改字段
            _order_field=@"sell_count";
        }
        [self allHidden_Yes];
        [_listArray removeAllObjects];
        [self sendRequest:nil offset:_offset limit:_limit order_type:_order_type order_field:_order_field  dName:_d_name type:_type type_name:_type_name keywords:self.keywords url:StudyTourUrl aTag:1];
        
    }else if (tableView==_typeTable){
        [self.typeBtn setTitle:[_typeArr objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        if (indexPath.row==0) {
            _order_field=@"";
            _type=nil;
        }else{
            _type=[NSString stringWithFormat:@"%ld",indexPath.row];
            
        }
        [self allHidden_Yes];
        [_listArray removeAllObjects];
        [self loadNewData];
    }else{
        LXSTListModel *model=[_listArray objectAtIndex:indexPath.row];
        LXSTDetailViewController *yxDetailVc=[[LXSTDetailViewController alloc] init];
        yxDetailVc.productId=model.st_id;
        yxDetailVc.productPrice=model.camper_price;
        yxDetailVc.realBeginDate=model.setoff_date;
        yxDetailVc.commissionStr = model.camper_rebate;
        
        [self.navigationController pushViewController:yxDetailVc animated:YES];
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

#pragma mark 请求方法
-(void)sendRequest:(NSDictionary *)aparameters
            offset:(NSString *)aoffset
             limit:(NSString *)alimit
        order_type:(NSString *)aorder_type//排序方式
       order_field:(NSString *)aorder_field//排序类型（销量，价格）
             dName:(NSString *)a_dName
              type:(NSString *)aType
         type_name:(NSString *)atype_name
          keywords:(NSString *)keywords
               url:(NSString *)url
              aTag:(int)tag
{
    
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    
    NSString *assistant_id=@"";
    if ([[[LXUserTool alloc] getKeeper] rangeOfString:@"null"].location!=NSNotFound) {
        assistant_id=@"0";
    }
    else
    {
        assistant_id=[[LXUserTool alloc] getKeeper];
    }

    
    NSDictionary *postDic;
    if (aparameters==nil) {
        
        
        aorder_type  = !aorder_type?@"" :aorder_type;
        aorder_field = !aorder_field?@"":aorder_field;
        a_dName      = !a_dName?@"":a_dName;
        //aType        = !aType?@"":aType;
        atype_name        = !atype_name?@"":atype_name;
        keywords        = !keywords?@"":keywords;
        if (!aType) {
            postDic=@{@"offset":aoffset,
                      @"limit":alimit,
                      @"order_type":aorder_type,
                      @"order_field":aorder_field,
                      @"d_name":a_dName,
                      @"type_name":atype_name,
                      @"yoosure_name":keywords,
                      //@"type":aType
                      @"assistant_id":assistant_id,
                      };
        }else{
            postDic=@{@"offset":aoffset,
                      @"limit":alimit,
                      @"order_type":aorder_type,
                      @"order_field":aorder_field,
                      @"d_name":a_dName,
                      @"type_name":atype_name,
                      @"type":aType,
                      @"yoosure_name":keywords,
                      @"assistant_id":assistant_id,
                      };
        }
        
        
        //postDic=@{@"offset":aoffset,@"limit":alimit,@"type_name":atype_name};
        
    }else
    {
        postDic=aparameters;
    }
    DLog(@"传送的数据--%@,url=%@",postDic,url);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:postDic
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              DLog(@"列表dic===%@",dic);
              if ([[dic objectForKey:@"status"] intValue]==1) {
                  _tableView.footer.hidden=NO;
                  //数据为数组和字典两种形式，需要判断数据类型
                  if([[dic objectForKey:@"data"] isKindOfClass:[NSArray class]])
                  {
                      
                      NSArray *adArr=[dic objectForKey:@"data"];
                      
                      if([adArr count])
                      {
                          for (NSDictionary *dic1 in adArr)
                          {
                              LXSTListModel *model=[[LXSTListModel alloc] initWithDictionary:dic1];
                              model.st_id=[dic1 objectForKey:@"id"];
                              [_listArray addObject:model];
                          }
                      }
                      else
                      {
                          _tableView.footer.hidden=YES;
                          [[LXAlterView sharedMyTools] createTishi:@"暂无数据"];
                      }
                  }
                  else
                  {
                      
                      NSDictionary *dataDict = [dic objectForKey:@"data"];
                      
                      if([dataDict count])
                      {
                          
                          NSArray *dataKeys = [dataDict allKeys];
                          
                          for(int i = 0; i < dataKeys.count; i++)
                          {
                              
                              NSDictionary *subDict = [dataDict objectForKey:[dataKeys objectAtIndex:i]];
                              
                              LXSTListModel *model=[[LXSTListModel alloc] initWithDictionary:subDict];
                              model.st_id=[subDict objectForKey:@"id"];
                              [_listArray addObject:model];
                          }
                      }
                      else
                      {
                          _tableView.footer.hidden=YES;
                          [[LXAlterView sharedMyTools] createTishi:@"暂无数据"];
                      }
                  }
                  
              }
              else
              {
                  _tableView.footer.hidden=YES;
                  [[LXAlterView sharedMyTools] createTishi:@"暂无数据"];
              }
              [_tableView reloadData];
              [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              DLog(@"Error: %@", error);
              [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
              [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              
          }];
    
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

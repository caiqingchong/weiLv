//
//  DestinationJTGViewController.m
//  WelLv
//
//  Created by 赵阳 on 16/2/14.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "DestinationJTGViewController.h"
#import "ClassificationTableViewCell.h"
#import "ContentTableViewCell.h"
#import "ProductDetailViewController.h"
#import "ZFJShipDetailVC.h"
#import "ZFJChooseCityVC.h"

#define tableViewHeight  - [[UIApplication sharedApplication] statusBarFrame].size.height - self.navigationController.navigationBar.frame.size.height

@interface DestinationJTGViewController ()<UITableViewDataSource, UITableViewDelegate>



{
    //区头背景视图
    UIView *_headerBackView;
    
    //区头图片
    UIImageView *_headerImage;
    
    //左边选中标记线
    UIView *_lineView;
    
    //左边tableview的cell的选中记录
    NSInteger _indexForCell;
    
    //左边tableview的
    NSInteger _indexForSection;
    
    NSInteger _headerIndex;
    
    //区分“目的地参团旅游”和“目的地参团游轮”
    NSInteger _type;
    
    //区域 ID
    NSInteger _areaId;
    
    //存放所有数据的字典
    NSDictionary *_dataDict;
    
}


//每次上拉刷新返回的页数
@property (nonatomic, assign) NSInteger pageCount;

//加载菊花
@property (nonatomic, strong) MBProgressHUD * hud;

@end



@implementation DestinationJTGViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //    self.navigationItem.title = @"目的地参团";
    
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    titleButton
    
    
    
    titleButton.frame = CGRectMake(0, 0, 140, 40);
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleButton setTitle:@"目的地参团" forState:UIControlStateNormal];
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(10, 125, 0, 5);
    titleButton.imageEdgeInsets = edgeInsets;
    [titleButton setImage:[UIImage imageNamed:@"目的地参团角标"] forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    
    //    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    //    view.backgroundColor = [UIColor redColor];
    //    self.navigationItem.titleView = view;
    
    
    _dataDict = [NSDictionary dictionary];
    
    _indexForSection = 999;
    
    _type = 1;
    
    //如果不是从搜索页跳转进来
    if(!self.isSearched){
        
        //        UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        //
        //        searchBtn.frame=CGRectMake(0, 0, 24, 24.5);
        //
        //        [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        //
        //        [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
        //
        //        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:searchBtn];
        //
        //        _type = 1;
        
    }else{
        
        
        _type = self.searchType - 6;
    }
    
    
    
    //加载页面
    [self greatTableView];
    
    //加载下拉刷新，上拉加载更多控件
    [self addRefreshing];
    
    //加载数据
    //    [self loadData];
    
    
    
}

//目的地选择页面
- (void)titleButtonClick:(UIButton*)sender{
    
    
    __weak __typeof(self)weakSelf = self;
    
    ZFJChooseCityVC * chooseCityVC = [[ZFJChooseCityVC alloc] initWithAddress:^(NSString *cityAddress)
                                      {
                                          UIButton *button = (UIButton*)weakSelf.navigationItem.titleView;
                                          if ([cityAddress isEqualToString:@"    全国城市"]) {
                                              [button setTitle:@"目的地参团" forState:UIControlStateNormal];
                                              UIEdgeInsets edgeInsets = UIEdgeInsetsMake(10, 125, 0, 5);
                                              button.imageEdgeInsets = edgeInsets;
                                              weakSelf.isSearched = NO;
                                              
                                          }else{
                                              
                                              [button setTitle:cityAddress forState:UIControlStateNormal];
                                              weakSelf.isSearched = YES;
                                              CGSize size = [weakSelf contentSizeWithString:cityAddress fontSize:18 andMaxSize:CGSizeMake(200, 100)];
                                              UIEdgeInsets edgeInsets = UIEdgeInsetsMake(10, size.width + 55, 0, 5);
                                              button.imageEdgeInsets = edgeInsets;
                                              //                                          DLog(@"%@",NSStringFromCGSize(size));
                                              weakSelf.keyword = cityAddress;
                                          }
                                          [weakSelf loadData];
                                          
                                      }];
    chooseCityVC.isDestinationSelect = YES;
    chooseCityVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:chooseCityVC animated:YES completion:NULL];
    
}

//右上角搜索按钮
-(void)searchBtnClick
{
    SearchViewController *seachVc=[[SearchViewController alloc] init];
    
    //搜索类型
    seachVc.searchType=7;
    
    [self.navigationController pushViewController:seachVc animated:YES];
    
}
- (void)addRefreshing {
    
    NSMutableArray *imageAray=[NSMutableArray array];
    
    for (int i=0; i<2; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"单独-logo%d.png", i+2]];
        
        [imageAray addObject:image];
        
    }
    //-----------下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    
    __weak DestinationJTGViewController * listVC = self;
    
    [self.contentTabelView addGifHeaderWithRefreshingBlock:^{
        
        //        [[XCLoadMsg sharedLoadMsg:listVC] hideAll];
        //
        //        [[XCLoadMsg sharedLoadMsg:listVC] showActivityLoading:listVC.view];
        
        [listVC setProgressHud];
        
        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        listVC.pageCount = 1;
        
        [listVC loadData];
        
        //        });
        
    }];
    
    // 设置普通状态的动画图片
    [self.contentTabelView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self.contentTabelView.gifHeader setImages:imageAray forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self.contentTabelView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateRefreshing];
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
    // 马上进入刷新状态
    [self.contentTabelView.gifHeader beginRefreshing];
    
    [self.contentTabelView.footer setState:MJRefreshFooterStateIdle];
    
    [self.contentTabelView addLegendFooterWithRefreshingBlock:^{
        
        //        [[XCLoadMsg sharedLoadMsg:listVC] hideAll];
        //
        //        [[XCLoadMsg sharedLoadMsg:listVC] showActivityLoading:listVC.view];
        
        [listVC setProgressHud];
        
        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //上拉加载更多，每次上拉 page++
        listVC.pageCount = listVC.pageCount ++;
        
        [listVC loadData];
        
        //        });
        
    }];
    
    if ([self.contentTabelView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.contentTabelView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.contentTabelView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.contentTabelView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

- (void)loadData{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url;
    
    if(!self.isSearched){
        
        //如果地区 ID存在
        if(_areaId){
            
            //调取地区接口
            url = DESTINATION_TYPE_DETAIL_URL(_type, _areaId, [[[LXUserTool sharedUserTool]getKeeper] intValue], (long)self.pageCount);
            
        }else{
            //调取“目的地旅游”和“目的地游轮”区头接口，返回全部“旅游”或者“游轮”数据
            url = DESTINATION_TYPE_ALL_URL(_type,[[[LXUserTool sharedUserTool]getKeeper] intValue],(long)self.pageCount);
            
        }
        
    }else{
        
        //搜索后，带有搜索地址的接口，返回该城市地区的数据
        //        DLog(@"%@",self.keyword);
        url = [DESTINATION_SEARCH_URL(_type,[[[LXUserTool sharedUserTool]getKeeper] intValue],self.keyword) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //        DLog(@"%@",url);
        
    }
    
    __weak typeof(self) weakSelf = self;
    __weak DestinationJTGViewController * listVC = self;
    
    [manager POST:url
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject){
              
              [_hud hide:YES];
              
              //              [[XCLoadMsg sharedLoadMsg:listVC] hideActivityLoading];
              listVC.classificationTabelView.alpha = 1.0;
              
              NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              
              
              _dataDict = dict;
              
              DLog(@"%@",dict);
              
              
              if ([[[_dataDict objectForKey:@"data"] objectForKey:@"list_travel"] count] < 10) {
                  
                  listVC.contentTabelView.footer.hidden = YES;
              }
              else{
                  listVC.contentTabelView.footer.hidden = NO;
              }
              
              
              
              if (self.isSearched) {
                  
                  if ([[[_dataDict objectForKey:@"data"] objectForKey:@"list_cruise"] count] == 0) {
                      
                      
                      _type = 1;
                      //                      DLog(@"----");
                  }
                  
                  if ([[[_dataDict objectForKey:@"data"] objectForKey:@"list_travel"] count] == 0) {
                      
                      _type = 2;
                      //                      DLog(@"++++++");
                  }
                  
                  if ([[[_dataDict objectForKey:@"data"] objectForKey:@"list_cruise"] count] == 0 || [[[_dataDict objectForKey:@"data"] objectForKey:@"list_travel"] count] == 0) {
                      
                      listVC.classificationTabelView.hidden = YES;
                      listVC.contentTabelView.frame = CGRectMake(0, 0, windowContentWidth, ControllerViewHeight);
                  }
                  
              }else{
                  
                  listVC.classificationTabelView.hidden = NO;
                  CGFloat originX = 0.0;
                  
                  if (windowContentHeight == 480)
                  {
                      //iPhone4
                      if(!self.isSearched){
                          
                          originX = 62.0;
                      }
                      
                  }
                  else if(windowContentHeight == 568)
                  {
                      //iPhone5,iPhone5s,
                      if(!self.isSearched){
                          
                          originX = 62.0;
                      }
                      
                  }
                  else if (windowContentHeight == 667)
                  {
                      //iPhone6
                      if(!self.isSearched){
                          
                          originX = 80.0;
                      }
                      
                  }
                  else{
                      
                      //iPhone6p
                      if(!self.isSearched){
                          
                          originX = 86.0;
                      }
                  }
                  
                  listVC.contentTabelView.frame = CGRectMake(originX, 0, windowContentWidth - originX, ControllerViewHeight);
                  
              }
              [weakSelf.classificationTabelView reloadData];
              
              [weakSelf.contentTabelView reloadData];
              
              
              
              [listVC.contentTabelView.header endRefreshing];
              
              [listVC.contentTabelView.footer endRefreshing];
              
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error){
              
              [_hud hide:YES];
              
              DLog(@"%@",error);
              listVC.classificationTabelView.alpha = 1.0;
              
              [listVC.contentTabelView.header endRefreshing];
              
              [listVC.contentTabelView.footer endRefreshing];
              
              //              [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              
              //              [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
              //
              //                  [listVC loadData];
              //
              //              }];
              
              DLog(@"%@", error.localizedDescription);
          }];
}

//数据加载完成之前显示转动的菊花圈
- (void)setProgressHud
{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    _hud.frame = self.view.bounds;
    
    _hud.minSize = CGSizeMake(100, 100);
    
    _hud.mode = MBProgressHUDModeIndeterminate;
    
    _hud.labelText = @"正在加载...";
    
    [self.view addSubview:_hud];
    
    [_hud show:YES];
    
}

- (void)greatTableView{
    
    //创建左边的命令机制的TableView
    if (windowContentHeight == 480)
    {
        //iPhone4
        self.classificationTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 62, ControllerViewHeight) style:UITableViewStylePlain];
        
    }
    else if(windowContentHeight == 568)
    {
        //iPhone5,iPhone5s
        self.classificationTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 62, ControllerViewHeight) style:UITableViewStylePlain];
        
    }
    else if (windowContentHeight == 667)
    {
        //iPhone6
        self.classificationTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 80, ControllerViewHeight) style:UITableViewStylePlain];
        
    }
    else{
        
        //iPhone6p
        self.classificationTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 86, ControllerViewHeight) style:UITableViewStylePlain];
    }
    
    //是搜索跳转过来的隐藏(isSearched = YES)
    if(self.isSearched){
        
        self.classificationTabelView.hidden = YES;
    }
    
    self.classificationTabelView.alpha = 0;
    
    self.classificationTabelView.dataSource = self;
    
    self.classificationTabelView.delegate = self;
    
    self.classificationTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //隐藏右侧滚动条
    self.classificationTabelView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.classificationTabelView];
    
    
    //创建右边内容详情的TableView
    CGFloat originX = 0.0;
    
    if (windowContentHeight == 480)
    {
        //iPhone4
        if(!self.isSearched){
            
            originX = 62.0;
        }
        
    }
    else if(windowContentHeight == 568)
    {
        //iPhone5,iPhone5s,
        if(!self.isSearched){
            
            originX = 62.0;
        }
        
    }
    else if (windowContentHeight == 667)
    {
        //iPhone6
        if(!self.isSearched){
            
            originX = 80.0;
        }
        
    }
    else{
        
        //iPhone6p
        if(!self.isSearched){
            
            originX = 86.0;
        }
    }
    
    self.contentTabelView = [[UITableView alloc]initWithFrame:CGRectMake(originX, 0, windowContentWidth - originX, ControllerViewHeight) style:UITableViewStylePlain];
    
    self.contentTabelView.dataSource = self;
    
    self.contentTabelView.delegate = self;
    
    self.contentTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.contentTabelView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.contentTabelView];
    
}

//计算内容尺寸
- (CGSize)contentSizeWithString:(NSString *)string fontSize:(CGFloat)fontSize andMaxSize:(CGSize)rectSize {
    
    CGSize contentSize = [string boundingRectWithSize:rectSize options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName, nil] context:nil].size;
    
    return contentSize;
}

#pragma mark  TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.classificationTabelView == tableView) {
        
        if (self.isSearched) {
            
            return 0;
        }
        NSInteger sectionCount;
        
        switch (section) {
                
            case 0:
                
                sectionCount = [[[[_dataDict objectForKey:@"data"] objectForKey:@"destination_area"] objectForKey:@"travel"] count];
                
                return sectionCount;
                
                break;
                
            case 1 :
                
                sectionCount = [[[[_dataDict objectForKey:@"data"] objectForKey:@"destination_area"] objectForKey:@"cruise"] count];
                
                return sectionCount;
                
                break;
                
            default:
                
                break;
        }
        return sectionCount;
        
    }
    else{
        
        //        DLog(@"%ld",[[[_dataDict objectForKey:@"data"] objectForKey:@"list_travel"] count]);
        if (!self.isSearched) {
            if (_type == 1) {
                return [[[_dataDict objectForKey:@"data"] objectForKey:@"list_travel"] count];
            }else{
                
                return [[[_dataDict objectForKey:@"data"] objectForKey:@"list_cruise"] count];
            }
            
        }else{
            
            if ([[[_dataDict objectForKey:@"data"] objectForKey:@"list_travel"] count] == 0) {
                
                return [[[_dataDict objectForKey:@"data"] objectForKey:@"list_cruise"] count];
                
            }else{
                
                return [[[_dataDict objectForKey:@"data"] objectForKey:@"list_travel"] count];
            }
            
        }
        
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.classificationTabelView == tableView) {
        
        static NSString * cellIdentifier = @"Cell";
        
        ClassificationTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (!cell) {
            
            cell = [[ClassificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        switch (indexPath.section) {//哪一个分区
            case 0:{
                
                NSString *infoStr = [[[[_dataDict objectForKey:@"data"] objectForKey:@"destination_area"] objectForKey:@"travel"] objectAtIndex:indexPath.row];
                
                NSArray *infos = [infoStr componentsSeparatedByString:@":"];
                
                cell.tag = [[infos objectAtIndex:0] integerValue];
                
                cell.titleLabel.text = [infos objectAtIndex:1];
            }
                
                break;
                
            case 1:{
                
                NSString *infoStr = [[[[_dataDict objectForKey:@"data"] objectForKey:@"destination_area"] objectForKey:@"cruise"] objectAtIndex:indexPath.row];
                
                NSArray *infos = [infoStr componentsSeparatedByString:@":"];
                
                cell.tag = [[infos objectAtIndex:0] integerValue];
                
                cell.titleLabel.text = [infos objectAtIndex:1];
            }
                
                break;
                
            default:
                
                break;
                
        }
        
        if (_indexForSection == indexPath.section) {
            
            if (_indexForCell == indexPath.row) {
                
                cell.backgroundColor = [UIColor whiteColor];
                
                cell.lineView.backgroundColor = UIColorFromRGB(0xeef2f6);
                
            } else {
                
                cell.backgroundColor = UIColorFromRGB(0xeef2f6);
                
                cell.lineView.backgroundColor = UIColorFromRGB(0xeef2f6);
            }
            
        }
        
        
        return cell;
    }
    else{
        
        static NSString * cellIdentifier = @"Cell";
        
        ContentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell) {
            
            cell = [[ContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        //        DLog(@"%@",_dataDict);
        
        cell.payWayLabel.hidden = YES;
        
        NSString *rebate;
        
        if(_type == 1){
            
            cell.tag = [[[[[_dataDict objectForKey:@"data"] objectForKey:@"list_travel"] objectAtIndex:indexPath.row] objectForKey:@"product_id"] integerValue];
            
            cell.titleLabel.text = [[[[_dataDict objectForKey:@"data"] objectForKey:@"list_travel"] objectAtIndex:indexPath.row] objectForKey:@"product_name"];
            
            NSURL *imageUrl = [NSURL URLWithString:[[[[_dataDict objectForKey:@"data"] objectForKey:@"list_travel"] objectAtIndex:indexPath.row] objectForKey:@"thumb"]];
            
            [cell.cellImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"默认图1"]];
            
            rebate = [NSString stringWithFormat:@"¥ %.2f", [[[[[_dataDict objectForKey:@"data"] objectForKey:@"list_travel"] objectAtIndex:indexPath.row] objectForKey:@"gj_adult_rebate"] floatValue]];
            
            NSString *regionName = [[[[_dataDict objectForKey:@"data"] objectForKey:@"list_travel"] objectAtIndex:indexPath.row] objectForKey:@"region_name"];
            
            NSString *countryName = [[[[_dataDict objectForKey:@"data"] objectForKey:@"list_travel"] objectAtIndex:indexPath.row] objectForKey:@"country_name"];
            
            if(![regionName isKindOfClass:[NSNull class]]){
                
                cell.addressLabel.text = [NSString stringWithFormat:@"%@   参团", regionName];
                
            }else{
                
                cell.addressLabel.text = [NSString stringWithFormat:@"%@   参团", countryName];
            }
            
            
//            if ([[[[[_dataDict objectForKey:@"data"] objectForKey:@"list_travel"] objectAtIndex:indexPath.row] objectForKey:@"pay_way"] isEqualToString:@"1"]) {
//                
//                cell.payWayLabel.text = @"直接支付";
//            }else{
//                cell.payWayLabel.text = @"确认后支付";
//            }
           
            
            cell.expensesLabel.text = [NSString stringWithFormat:@"¥ %@起", [[[[_dataDict objectForKey:@"data"] objectForKey:@"list_travel"] objectAtIndex:indexPath.row] objectForKey:@"sell_price"]];
        }
        
        if(_type == 2){
            
            NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WLHTTP, [[[[_dataDict objectForKey:@"data"] objectForKey:@"list_cruise"] objectAtIndex:indexPath.row] objectForKey:@"picture"]]];
            
            [cell.cellImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"默认图1"]];
            
            rebate = [NSString stringWithFormat:@"¥ %.2f", [[[[[_dataDict objectForKey:@"data"] objectForKey:@"list_cruise"] objectAtIndex:indexPath.row] objectForKey:@"gj_rebate"] floatValue]];
            
            cell.addressLabel.text = [NSString stringWithFormat:@"%@   参团", [[[[_dataDict objectForKey:@"data"] objectForKey:@"list_cruise"] objectAtIndex:indexPath.row] objectForKey:@"name"]];
            
            cell.expensesLabel.text = [NSString stringWithFormat:@"¥ %@起", [[[[_dataDict objectForKey:@"data"] objectForKey:@"list_cruise"] objectAtIndex:indexPath.row] objectForKey:@"min_price"]];
            
            cell.tag = [[[[[_dataDict objectForKey:@"data"] objectForKey:@"list_cruise"] objectAtIndex:indexPath.row] objectForKey:@"product_id"] integerValue];
            
            cell.titleLabel.text = [[[[_dataDict objectForKey:@"data"] objectForKey:@"list_cruise"] objectAtIndex:indexPath.row] objectForKey:@"product_name"];
            
//            if ([[[[[_dataDict objectForKey:@"data"] objectForKey:@"list_cruise"] objectAtIndex:indexPath.row] objectForKey:@"pay_way"] isEqualToString:@"1"]) {
//                
//                cell.payWayLabel.text = @"直接支付";
//            }else{
//                cell.payWayLabel.text = @"确认后支付";
//            }
        }
        //管家显示返佣信息
        if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward) {
            
            cell.commissionLabel.hidden = NO;
            
            cell.commissionAmountLabel.hidden = NO;
            
            CGFloat amountWidth = [self contentSizeWithString:rebate fontSize:10.0 andMaxSize:CGSizeMake(cell.frame.size.width - CGRectGetMaxX(cell.cellImageView.frame) - 15 * 2 - 30, 12)].width;
            
            
            DLog(@"%f",amountWidth);
            
            
            cell.commissionAmountLabel.frame = CGRectMake(cell.frame.size.width - 15 - amountWidth, 30, amountWidth, 12);
            
            cell.commissionAmountLabel.text = rebate;
            cell.commissionLabel.frame = CGRectMake(cell.commissionAmountLabel.frame.origin.x - 30, 30, 25, 12);
            
        }        //会员及未登陆不显示返佣信息
        else {
            
            cell.commissionLabel.hidden = YES;
            
            cell.commissionAmountLabel.hidden = YES;
            
        }
        
        
        
        
        
        return cell;
        
    }
}

#pragma mark  TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.classificationTabelView == tableView) {
        
        ClassificationTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        _type = indexPath.section ? 2 : 1;
        //        DLog(@"%ld",_type);
        
        _areaId = cell.tag;
        
        _indexForCell = indexPath.row;
        
        _indexForSection = indexPath.section;
        
        _headerIndex = 999;
        
        [self loadData];
        
    }
    else{
        
        ContentTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if(_type == 1){
            
            ProductDetailViewController *productDetailController = [[ProductDetailViewController alloc] init];
            
            productDetailController.productID = [NSString stringWithFormat:@"%li", cell.tag];
            
            productDetailController.gj_commission = [[[[_dataDict objectForKey:@"data"] objectForKey:@"list_travel"] objectAtIndex:indexPath.row] objectForKey:@"gj_adult_rebate"];
            
            [self.navigationController pushViewController:productDetailController animated:YES];
        }
        
        if(_type == 2){
            
            ZFJShipDetailVC *shipDetailController = [[ZFJShipDetailVC alloc] init];
            
            shipDetailController.product_id = [NSString stringWithFormat:@"%li", cell.tag];
            
            [self.navigationController pushViewController:shipDetailController animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.classificationTabelView == tableView) {
        
        if (windowContentHeight == 480)
        {
            //iPhone4
            return 50;
            
        }
        else if(windowContentHeight == 568)
        {
            //iPhone5,iPhone5s,
            return 50;
            
        }
        else if (windowContentHeight == 667)
        {
            //iPhone6
            return 60;
            
        }
        else{
            
            //iPhone6p
            return 60;
            
        }
        
        
    }
    else{
        
        return 0;
        
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if(tableView == self.classificationTabelView){
        
        
        return [[[[_dataDict objectForKey:@"data"] objectForKey:@"destination_area"] allKeys] count];
        
        
    }else{
        
        return 1;
    }
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    _headerBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SelfViewHeight, SelfViewWidth)];
    
    UIView *sideLine = [[UIView alloc] init];
    
    [_headerBackView addSubview:sideLine];
    
    
    _headerImage = [[UIImageView alloc]init];
    
    
    UIButton *headerViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    headerViewBtn.tag = section;
    
    [headerViewBtn addTarget:self action:@selector(headerViewBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    headerViewBtn.frame = CGRectMake(0, 0, SelfViewHeight, SelfViewWidth);
    
    [_headerBackView addSubview:headerViewBtn];
    
    
    if (windowContentHeight == 480)
    {
        //iPhone4
        switch (section) {
                
            case 0:
                
                _headerImage.frame = CGRectMake(19, 10, 24, 30);
                
                _headerImage.image = [UIImage imageNamed:@"旅游"];
                
                break;
                
            case 1 :
                
                _headerImage.frame = CGRectMake(15, 15, 34, 20);
                
                _headerImage.image = [UIImage imageNamed:@"轮船@2x"];
                
                break;
                
            default:
                
                break;
        }
        
        sideLine.frame = CGRectMake(0, 0, 3, 50);
        
    }
    else if(windowContentHeight == 568)
    {
        //iPhone5,iPhone5s,
        switch (section) {
                
            case 0:
                
                _headerImage.frame = CGRectMake(19, 10, 24, 30);
                
                _headerImage.image = [UIImage imageNamed:@"旅游"];
                
                break;
                
            case 1 :
                
                _headerImage.frame = CGRectMake(15, 15, 34, 20);
                
                _headerImage.image = [UIImage imageNamed:@"轮船@2x"];
                
                break;
                
            default:
                
                break;
        }
        
        sideLine.frame = CGRectMake(0, 0, 3, 50);
        
    }
    else if (windowContentHeight == 667)
    {
        //iPhone6
        switch (section) {
                
            case 0:
                
                _headerImage.frame = CGRectMake(26, 12, 28, 36);
                
                _headerImage.image = [UIImage imageNamed:@"旅游"];
                
                break;
                
            case 1 :
                
                _headerImage.frame = CGRectMake(20, 18, 40, 24);
                
                _headerImage.image = [UIImage imageNamed:@"轮船@2x"];
                
                break;
                
            default:
                
                break;
        }
        
        sideLine.frame = CGRectMake(0, 0, 3, 60);
        
    }
    else{
        
        //iPhone6p
        switch (section) {
                
            case 0:
                
                _headerImage.frame = CGRectMake(29, 12, 28, 36);
                
                _headerImage.image = [UIImage imageNamed:@"旅游"];
                
                break;
                
            case 1 :
                
                _headerImage.frame = CGRectMake(23, 18, 40, 24);
                
                _headerImage.image = [UIImage imageNamed:@"轮船@2x"];
                
                break;
                
            default:
                
                break;
        }
        
        sideLine.frame = CGRectMake(0, 0, 3, 60);
        
    }
    
    
    if(_headerIndex == section){
        
        _headerBackView.backgroundColor = [UIColor whiteColor];
        
        sideLine.backgroundColor = UIColorFromRGB(0xff9966);
        
        if(_headerIndex == 0){
            
            _headerImage.image = [UIImage imageNamed:@"旅游-点击"];
        }
        
        if(_headerIndex == 1){
            
            _headerImage.image = [UIImage imageNamed:@"点击邮轮"];
        }
        
    }else{
        
        _headerBackView.backgroundColor = UIColorFromRGB(0xeef2f6);
    }
    
    
    [_headerBackView addSubview:_headerImage];
    
    return _headerBackView;
}

- (void)headerViewBtn:btn{
    
    _indexForSection = 999;
    
    UIButton *headerBtn = (UIButton *)btn;
    
    _type = headerBtn.tag + 1;
    
    //    DLog(@"%ld",_type);
    
    _areaId = 0;
    
    _headerIndex = headerBtn.tag;
    
    [self loadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.classificationTabelView == tableView) {
        
        if (windowContentHeight == 480)
        {
            //iPhone4
            return 50;
            
        }
        else if(windowContentHeight == 568)
        {
            //iPhone5,iPhone5s,
            return 50;
            
        }
        else if (windowContentHeight == 667)
        {
            //iPhone6
            return 60;
            
        }
        else{
            
            //iPhone6p
            return 60;
            
        }
        
    }
    else{
        
        return 80;
        
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

//
//  ZFJSteShopOrderVC.m
//  WelLv
//
//  Created by WeiLv on 15/10/24.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJSteShopOrderVC.h"
#import "ZFJSteShopOrderCell.h"
#import "ZFJFilterView.h"
#import "WXUtil.h"
#import "ZFJSteShopOrderModel.h"
#import "ZFJFilterDetailView.h"
#import "MyOrderDetailViewController.h"
#import "DetailOrideViewController.h"
#define M_FILTER_VIEW_HEIGHT 45
@interface ZFJSteShopOrderVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) ZFJFilterDetailView * filterProductView;
@property (nonatomic, strong) ZFJFilterDetailView * filterOrderStatus;
@property (nonatomic, copy) NSString * order_status;
@property (nonatomic, copy) NSString * pay_status;
@property (nonatomic, copy) NSString * product_category;
@property (nonatomic, assign) NSInteger offsetNum;

@end

@implementation ZFJSteShopOrderVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"分销订单";
    self.view.backgroundColor = kColor(240, 246, 251);
    [self customFilterView];
    [self customTabelView];
    self.product_category = @"";
    self.pay_status = @"";
    self.order_status = @"";
    self.offsetNum = 1;
    
    [self addRefreshing];
}

- (void)customFilterView
{
    ZFJFilterView * fitlerView = [[ZFJFilterView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, M_FILTER_VIEW_HEIGHT) withTitleArray:@[@"类目", @"状态"]];
    
    __weak ZFJSteShopOrderVC * weakSelf = self;
    
    [fitlerView chooseFilterNoReturn:^(NSInteger oneFilter)
     {
        if (oneFilter == 0)
        {
            //获取类目标签
            UILabel *textLabel1=(UILabel *)[fitlerView viewWithTag:100];
           
            
            weakSelf.filterOrderStatus.hidden = YES;
            
            if (!weakSelf.filterProductView)
            {
                weakSelf.filterProductView = [[ZFJFilterDetailView alloc] initWithFrame:CGRectMake(0, M_FILTER_VIEW_HEIGHT, windowContentWidth, ControllerViewHeight) style:ZFJFilterDetailStyleOneListChangeColor];
                weakSelf.filterProductView.titleArr = @[@"全部",@"签证", @"邮轮", @"一日游",@"周边游",@"国内游",@"出境游",@"港澳台",@"境外参团", @"游学",];

                [weakSelf.view addSubview:_filterProductView];
            }
            else
            {
                weakSelf.filterProductView.hidden = !weakSelf.filterProductView.hidden;
            }
            [weakSelf.filterProductView selectFilterViewIndexPath:^(NSIndexPath *indexPath)
             {
                fitlerView.goBackColor = YES;
                switch (indexPath.row)
                 {
                    case 0:
                    {
                        //全部
                        weakSelf.product_category = @"";
                        self.offsetNum = 1;
                        textLabel1.text=@"全部";
                        textLabel1.textColor=[UIColor orangeColor];
                    }
                        break;
                     case 1:
                     {
                         //签证
                         self.offsetNum = 1;
                         weakSelf.product_category = @"2";
                         textLabel1.text=@"签证";
                         textLabel1.textColor=[UIColor orangeColor];
                     }
                         break;

                     case 10:
                     {
                         //门票
                         self.offsetNum = 1;
                         weakSelf.product_category = @"-1";
                         textLabel1.text=@"门票";
                         textLabel1.textColor=[UIColor orangeColor];
                     }
                         break;

                    case 3:
                    {
                        //一日游
                        self.offsetNum = 1;
                        weakSelf.product_category = @"5";
                        textLabel1.text=@"一日游";
                        textLabel1.textColor=[UIColor orangeColor];
                    }
                        break;
                    case 4:
                    {
                        //周边游
                        self.offsetNum = 1;
                        weakSelf.product_category = @"6,-11";
                        textLabel1.text=@"周边游";
                        textLabel1.textColor=[UIColor orangeColor];

                    }
                        break;
                    case 5:
                    {
                        //国内游
                        self.offsetNum = 1;
                        weakSelf.product_category = @"7,-12";
                        textLabel1.text=@"国内游";
                        textLabel1.textColor=[UIColor orangeColor];

                    }
                        break;
                    case 6:
                    {
                        //出境游
                        self.offsetNum = 1;
                        weakSelf.product_category = @"8,-13";
                        textLabel1.text=@"出境游";
                        textLabel1.textColor=[UIColor orangeColor];
                    }
                        break;
                    case 7:
                    {
                        //港澳台
                        self.offsetNum = 1;
                        weakSelf.product_category = @"9,-14";
                        textLabel1.text=@"港澳台";
                        textLabel1.textColor=[UIColor orangeColor];
                    }
                        break;
                    case 8:
                    {
                        //境外参团
                        self.offsetNum = 1;
                        weakSelf.product_category = @"10,-15";
                        textLabel1.text=@"境外参团";
                        textLabel1.textColor=[UIColor orangeColor];
                    }
                        break;
                    case 2:
                    {
                        //邮轮
                        self.offsetNum = 1;
                        weakSelf.product_category = @"3,-5";
                        textLabel1.text=@"邮轮";
                        textLabel1.textColor=[UIColor orangeColor];
                    }
                        break;
                    case 9:
                    {
                        //游学
                        self.offsetNum = 1;
                        weakSelf.product_category = @"-2";
                        textLabel1.text=@"游学";
                        textLabel1.textColor=[UIColor orangeColor];
                    }
                        break;
                     case 11:
                     {
                         self.offsetNum = 1;
                         weakSelf.product_category = @"2";
                         textLabel1.text=@"签证";
                         textLabel1.textColor=[UIColor orangeColor];
                     }
                         break;
                    default:
                        break;
                }
                [weakSelf addRefreshing];

            }];
            [weakSelf.filterProductView selectHiddenView:^(UIView *view)
            {
                fitlerView.goBackColor = YES;
                
            }];
        }
        else if (oneFilter == 1)
        {
            //获取类目标签
            UILabel *textLabel2=(UILabel *)[fitlerView viewWithTag:101];
            
            weakSelf.filterProductView.hidden = YES;
            
            if (!weakSelf.filterOrderStatus)
            {
                weakSelf.filterOrderStatus = [[ZFJFilterDetailView alloc] initWithFrame:CGRectMake(0, M_FILTER_VIEW_HEIGHT, windowContentWidth, ControllerViewHeight) style:ZFJFilterDetailStyleOneListChangeColor];
                weakSelf.filterOrderStatus.titleArr = @[@"全部", @"待确认", @"待付款", @"已付款",@"已完成", @"已取消"];
                [weakSelf.view addSubview:_filterOrderStatus];
            }
            else
            {
                weakSelf.filterOrderStatus.hidden = !weakSelf.filterOrderStatus.hidden;
            }
            [weakSelf.filterOrderStatus selectFilterViewIndexPath:^(NSIndexPath *indexPath)
            {
                fitlerView.goBackColor = YES;
                switch (indexPath.row) {
                    case 0:
                    {
                        weakSelf.pay_status = @"";
                        weakSelf.order_status = @"";
                        self.offsetNum = 1;
                        textLabel2.text=@"全部";
                        textLabel2.textColor=[UIColor orangeColor];
                    }
                        break;
                    case 1:
                    {
                        weakSelf.pay_status = @"0";
                        weakSelf.order_status = @"90,91,92";
                        self.offsetNum = 1;
                        textLabel2.text = @"待确认";
                        textLabel2.textColor =[UIColor orangeColor];

                    }
                        break;
                    case 2:
                    {
                        weakSelf.pay_status = @"0";
                        weakSelf.order_status = @"0";
                        self.offsetNum = 1;
                        textLabel2.text=@"待付款";
                        textLabel2.textColor=[UIColor orangeColor];

                    }
                        break;
                    case 3:
                    {
                        weakSelf.pay_status = @"1";
                        weakSelf.order_status = @"0,1";
                        self.offsetNum = 1;
                        textLabel2.text=@"已付款";
                        textLabel2.textColor=[UIColor orangeColor];
                    }
                        break;
                    case 4:
                    {
                        weakSelf.pay_status = @"1";
                        weakSelf.order_status = @"2";
                        self.offsetNum = 1;
                        textLabel2.text = @"已完成";
                        textLabel2.textColor =[UIColor orangeColor];
                        
                    }
                        break;
                    case 5:
                    {
                        weakSelf.pay_status = @"";
                        weakSelf.order_status = @"11";
                        self.offsetNum = 1;
                        textLabel2.text = @"已取消";
                        textLabel2.textColor =[UIColor orangeColor];
                        
                    }
                        break;

                    default:
                        break;
                }
                [weakSelf addRefreshing];
            }];
            [weakSelf.filterOrderStatus selectHiddenView:^(UIView *view)
             {
                fitlerView.goBackColor = YES;
            }];
        }
        
    }];
    [self.view addSubview:fitlerView];
}
#pragma mark --- 刷新
/**
 *   加载刷新控件
 */
- (void)addRefreshing
{
    NSMutableArray *imageAray=[NSMutableArray array];
    for (int i=0; i<2; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"单独-logo%d.png", i+2]];
        [imageAray addObject:image];
    }
    //-----------下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    
    __weak ZFJSteShopOrderVC * weakSelf = self;
    [self.tableView addGifHeaderWithRefreshingBlock:^{
        [[XCLoadMsg sharedLoadMsg:weakSelf] hideAll];
        [[XCLoadMsg sharedLoadMsg:weakSelf] showActivityLoading:weakSelf.view];
        //[weakSelf setProgressHud];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.dataArr removeAllObjects];
            weakSelf.offsetNum = 1;
            [weakSelf loadData];
            
        });
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
    
    
    [self.tableView.footer setState:MJRefreshFooterStateIdle];
    
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [[XCLoadMsg sharedLoadMsg:weakSelf] hideAll];
        [[XCLoadMsg sharedLoadMsg:weakSelf] showActivityLoading:weakSelf.view];
        //[weakSelf setProgressHud];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (weakSelf.dataArr.count < weakSelf.offsetNum * 10) {
                [[LXAlterView sharedMyTools] createTishi:@"暂无更多数据"];
                [weakSelf.tableView.footer endRefreshing];
                [[XCLoadMsg sharedLoadMsg:weakSelf] hideActivityLoading];
                return;
            }

            weakSelf.offsetNum = weakSelf.offsetNum + 1;
            [weakSelf loadData];
            [weakSelf.tableView.footer endRefreshing];
            
        });
        
    }];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

- (void)customTabelView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, M_FILTER_VIEW_HEIGHT, windowContentWidth, ControllerViewHeight - M_FILTER_VIEW_HEIGHT)];
    self.tableView.backgroundColor = kColor(240, 246, 251);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 120;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark --- UITabelViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"Cell";
    ZFJSteShopOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZFJSteShopOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    ZFJSteShopOrderModel * model = [self.dataArr objectAtIndex:indexPath.row];
    cell.modelOrder = model;
    cell.partnerLab.hidden = YES;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZFJSteShopOrderModel * model = [self.dataArr objectAtIndex:indexPath.row];
    if([model.product_category integerValue] == -11 || [model.product_category integerValue] == -12 || [model.product_category integerValue] == -13 || [model.product_category integerValue] == -14 || [model.product_category integerValue] == -15 || [model.product_category integerValue] == 5 || [model.product_category integerValue] == 6 || [model.product_category integerValue] == 7 || [model.product_category integerValue] == 8 || [model.product_category integerValue] == 9 || [model.product_category integerValue] == 10){
        DetailOrideViewController *mydetail = [[DetailOrideViewController alloc] init];
        
        mydetail.order_id = model.order_id;
        mydetail.cat_id = model.product_category;
        mydetail.member_id = model.member_id;
        mydetail.frontPageFlag = @"100";
        
        if ([[WLSingletonClass defaultWLSingleton] wlUserType]==WLMemberTypeSteward) {
            mydetail.hideArrowFlag = @"300";
        }
        
        
        [self.navigationController pushViewController:mydetail animated:YES];
        
    }else{
        
        MyOrderDetailViewController *vc=[[MyOrderDetailViewController alloc]init];
        
        vc.order_id = model.order_id;
        vc.cat_id = model.product_category;
        vc.member_id = model.member_id;
        vc.oneDayTime=model.setoff_time;
        vc.pepleNum=model.people_num;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark --- 加载数据

- (void)loadData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *md5str = [NSString stringWithFormat:@"~0;id<zOD.{ll@]JKi(:%@",[[LXUserTool alloc] getUid]];
    md5str = [WXUtil md5:md5str];
    
    NSString *offset = [NSString stringWithFormat:@"%ld",self.offsetNum];
    
    
    
//    NSMutableDictionary *parameters = @{@"is_assistant_member":@"1",
//                                 @"member_id":[[WLSingletonClass defaultWLSingleton] wlUserID],
//                                 @"wltoken":md5str,
//                                 @"pagenums":@"10",
//                                 @"by":@"create_time",
//                                 @"offset":offset,
//                                 @"where":[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:@{@"product_category":self.product_category}]
//                                 };
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"1" forKey:@"is_assistant_member"];
    [parameters setValue:[[WLSingletonClass defaultWLSingleton] wlUserID] forKey:@"member_id"];
    [parameters setValue:md5str forKey:@"wltoken"];
    [parameters setValue:@"10" forKey:@"pagenums"];
    [parameters setValue:@"create_time" forKey:@"by"];
    [parameters setValue:offset forKey:@"offset"];
    [parameters setValue:[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:@{@"product_category":self.product_category}] forKey:@"where"];
    
    if (![self.pay_status isEqualToString:@""]) {
        [parameters setValue:self.pay_status forKey:@"pay_status"];
    }
    if (![self.order_status isEqualToString:@""]) {
        [parameters setValue:self.order_status forKey:@"order_status"];
    }


    
    DLog(@"parameters = %@", parameters);
    //接口
    NSString *url= M_SS_URL_ORDER_LIST;
    DLog(@"%@",url);
    //发送请求
    __weak ZFJSteShopOrderVC * weakSelf = self;
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        DLog(@"JSON: %@", dic);
        [[XCLoadMsg sharedLoadMsg:weakSelf] hideActivityLoading];

        if ([dic isKindOfClass:[NSArray class]])
        {
            for (NSDictionary * orderDic in dic)
            {
                ZFJSteShopOrderModel * model = [[ZFJSteShopOrderModel alloc] initWithDictionary:orderDic];
                [self.dataArr addObject:model];
            }
            [weakSelf.tableView.header endRefreshing];
            [weakSelf.tableView.footer endRefreshing];
            [weakSelf.tableView reloadData];
        }
        if (weakSelf.tableView.contentSize.height < ControllerViewHeight)
        {
            [weakSelf.tableView removeFooter];
        }
        if (weakSelf.dataArr.count == 0) {
            [[LXAlterView sharedMyTools] createTishi:@"暂无相关数据"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
        DLog(@"ERROR: %@", error);
        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
            [weakSelf loadData];
        }];
        
    }];

}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}
@end

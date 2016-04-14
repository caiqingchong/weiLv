//
//  DDViewController.m
//  WelLv
//
//  Created by liuxin on 15/11/6.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "DDViewController.h"
#import "ZFJSteShopOrderCell.h"
#import "ZFJDEStoreOrderDetailsVC.h"
#import "orderModel.h"
#import "WXUtil.h"

@interface DDViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, copy) NSDictionary * dataDic;
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, copy) NSString * orderStatus;

@end

@implementation DDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.deOrderType == WLDEStoreOrderTypeMyOrder) {
        self.navigationItem.title = @"我卖出的产品";
    }
    self.view.backgroundColor = kColor(240, 246, 251);
    self.orderStatus = @"0";
    [self customTableVIew];
    [self addRefresh];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(segmentControlAction:) name:@"de_order_segmented_control" object:nil];
}

- (void)segmentControlAction:(NSNotification *)sender {
    UISegmentedControl * segmentedC = [sender object];
    switch (segmentedC.selectedSegmentIndex) {
        case 0:
        {
            //未处理  0
            NSLog(@"未处理");
            self.orderStatus = @"0";
            [self.tableView.header beginRefreshing];
        }
            break;
        case 1:
        {
            self.orderStatus = @"1";
            [self.tableView.header beginRefreshing];
        }
            break;
        default:
            break;
    }
}

#pragma mark --- UITableView

- (void)customTableVIew {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight - self.tabBarController.tabBar.frame.size.height)];
    if (self.deOrderType == WLDEStoreOrderTypeMyOrder) {
        self.tableView.frame = CGRectMake(0, 0, windowContentWidth, ControllerViewHeight);
    }
    self.tableView.backgroundColor = kColor(240, 246, 251);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 120;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark --- Refresh
/*
 * 刷新
 */
- (void)addRefresh {
    NSMutableArray *zxdImageArray = [NSMutableArray array];
    for (int i=0; i<2; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"单独-logo%d.png", i+2]];
        [zxdImageArray addObject:image];
    }
    //下拉刷新
    //设置回调(一旦进入刷新状态,就调用target的action,也就是调用self的loadNewData方法)
    __weak typeof(self)WeakSelf = self;
    [self.tableView addGifHeaderWithRefreshingBlock:^{
        [WeakSelf.dataArr removeAllObjects];
        WeakSelf.pageNum = 0;
        [WeakSelf loadData];
    }];
    //设置普通状态的动画图片
    [self.tableView.gifHeader setImages:zxdImageArray forState:MJRefreshHeaderStateIdle];
    //设置即将刷新状态的动画图片(一松开就会刷新的状态)
    [self.tableView.gifHeader setImages:zxdImageArray forState:MJRefreshHeaderStatePulling];
    //设置正在刷新准柜台的动画图片
    [self.tableView.gifHeader setImages:zxdImageArray forState:MJRefreshHeaderStateRefreshing];
    //在这里即将刷新和正在刷新用的是一样的动画图片
    //马上进入刷新状态
    [self.tableView.gifHeader beginRefreshing];
    //加载更多
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

- (void)loadMoreData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.pageNum = self.pageNum + 1;
        [self loadData];
    });
}


#pragma mark --- UITableDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"Cell";
    ZFJSteShopOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZFJSteShopOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    orderModel * model = [self.dataArr objectAtIndex:indexPath.row];
    cell.modelDEOrder = model;
    cell.payStatus.hidden = YES;
    return cell;
}

#pragma mark --- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZFJDEStoreOrderDetailsVC * vc = [[ZFJDEStoreOrderDetailsVC alloc] init];
    orderModel * model = self.dataArr[indexPath.row];
    vc.orderIDStr = model.driving_order_id;
    vc.order_status = model.order_status;
    WS(ws);
    vc.backLastView = ^(NSString * backStr){
        [ws addRefresh];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --- 加载数据

- (void)loadData {
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];

    NSString *url = M_URL_DE_ORDER_LIST;
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString *member_Id = [[WLSingletonClass defaultWLSingleton] wlUserID];
    NSArray * orderStatusArr = nil;
    if (self.deOrderType == WLDEStoreOrderTypeMyOrder) {
        orderStatusArr = @[@"1", @"10"];
    } else {
        if ([self.orderStatus isEqualToString:@"0"]) {
            orderStatusArr = @[@"0"];
        } else {
            orderStatusArr = @[@"1"];
            /*
             '0' => '等待商家接单',
             '1' => '商家已接单',
             '2' => '商家拒单',
             '3' => '订单超时', //在规定时间内消费的
             '4' => '订单取消',
             '5' => '自动取消（4小时未付款，来自系统）',
             '6' => '退款中', //
             '7' => '退款成功',
             '8' => '退款失败', 
             '9' => '商户撤单', 
             '10' => '已核销' //会员显示，交易成功,
            */
        }

    }
    NSDictionary * dic = @{ @"operation_type":@"provider",
                            @"order_status":orderStatusArr,
                            @"model_id": [[WLSingletonClass defaultWLSingleton] wlProductTypeCatId:WLProductTypeDriveEat],
                            @"p":[NSString stringWithFormat:@"%ld", self.pageNum]};
    NSString *token1 = [token stringByAppendingString:member_Id];
    NSDictionary *zxdDict1 = @{@"member_id":member_Id,
                               @"wltoken":[WXUtil md5:token1],
                               @"datajson":[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:dic]};
    //NSLog(@"%@", zxdDict1);
    WS(weakSelf);
    AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
    zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [zxdManager POST:url parameters:zxdDict1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dict[@"msg"]);
        NSLog(@"%@", dict);
        [[XCLoadMsg sharedLoadMsg:weakSelf] hideAll];
        if ([dict isKindOfClass:[NSDictionary class]] && [[dict objectForKey:@"state"] integerValue] == 1 && [[dict objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
            weakSelf.dataDic = [dict objectForKey:@"data"];
            if ([[[dict objectForKey:@"data"] objectForKey:@"lists"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * modelDic in [[dict objectForKey:@"data"] objectForKey:@"lists"]) {
                    orderModel * model = [[orderModel alloc] initWithDictionary:modelDic];
                    [weakSelf.dataArr addObject:model];
                }
            }
            
        } else {
            
        }
        [weakSelf.tableView reloadData];
        if (weakSelf.tableView.contentSize.height < ControllerViewHeight) {
            [weakSelf.tableView removeFooter];
        }
        [weakSelf.tableView.header endRefreshing];
        [weakSelf.tableView.footer endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error === %@", error);
        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
        [[XCLoadMsg sharedLoadMsg:weakSelf] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:weakSelf] showErrorMsgInView:weakSelf.view evn:^{
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

- (void)dealloc {
    [XCLoadMsg removeLoadMsg:self];
}
@end

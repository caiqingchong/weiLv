//
//  SeladViewController.m
//  WelLv
//
//  Created by liuxin on 15/11/24.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "SeladViewController.h"
#import "WXUtil.h"
#import "orderModel.h"
#import "ZFJSteShopOrderCell.h"
#import "ZFJDEStoreOrderDetailsVC.h"

@interface SeladViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, copy) NSDictionary * dataDic;
@property (nonatomic, assign) NSInteger pageNum;

@end

@implementation SeladViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor =BgViewColor;
    [self creatTableView];
    [self addRefresh];
}

-(void)creatTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight)];
    self.tableView.backgroundColor = kColor(240, 246, 251);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 120;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

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
        [WeakSelf zxdDownLoad];
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
        [self zxdDownLoad];
    });
}

#pragma mark --- 下载数据
-(void)zxdDownLoad {
    NSString *url =[NSString stringWithFormat:@"%@/api/orderApi/orderList",WLHTTP]; 
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString *member_Id = [[WLSingletonClass defaultWLSingleton] wlUserID];
    NSDictionary * dic = @{ @"operation_type":@"provider",
                            @"order_status":@[@"1",@"10"],
                            @"model_id": @"-11",
                            @"p":[NSString stringWithFormat:@"%ld", self.pageNum]};
    NSString *token1 = [token stringByAppendingString:member_Id];
    NSDictionary *zxdDict1 = @{@"member_id":member_Id,
                               @"wltoken":[WXUtil md5:token1],
                               @"datajson":[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:dic]};
    NSLog(@"%@", zxdDict1);
    WS(weakSelf);
    AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
    zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [zxdManager POST:url parameters:zxdDict1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dict[@"msg"]);
        NSLog(@"%@", dict);
        if ([dict isKindOfClass:[NSDictionary class]] && [[dict objectForKey:@"state"] integerValue] == 1 && [[dict objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
            weakSelf.dataDic = [dict objectForKey:@"data"];
            if ([[[dict objectForKey:@"data"] objectForKey:@"lists"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * modelDic in [[dict objectForKey:@"data"] objectForKey:@"lists"]) {
                    orderModel * model = [[orderModel alloc] initWithDictionary:modelDic];
                    [weakSelf.dataArr addObject:model];
                }
                [weakSelf.tableView reloadData];
            }
           
        } else {
            
        }
        if (weakSelf.tableView.contentSize.height < ControllerViewHeight) {
            [weakSelf.tableView removeFooter];
        }
        [self.tableView.header endRefreshing];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertfail = [[UIAlertView alloc] initWithTitle:@"提示" message:@"下载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertfail show];
        return ;

    }];
}

#pragma mark --- UItableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIdentifier = @"Cell";
    ZFJSteShopOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZFJSteShopOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    orderModel * model = [self.dataArr objectAtIndex:indexPath.row];
    cell.modelDEOrder = model;
    [cell.thumbImage sd_setImageWithURL:[NSURL URLWithString:[self judgeImageURL:[self.dataDic objectForKey:@"logo"]]] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    return cell;
    
}

#pragma mark --- UITableViewDelegate 

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZFJDEStoreOrderDetailsVC * vc = [[ZFJDEStoreOrderDetailsVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --- 懒加载

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end

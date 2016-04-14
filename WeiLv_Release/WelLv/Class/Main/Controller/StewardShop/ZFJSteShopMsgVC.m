//
//  ZFJSteShopMsgVC.m
//  WelLv
//
//  Created by WeiLv on 15/10/24.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJSteShopMsgVC.h"
#import "ZFJSteShopMsgCell.h"
#import "ZFJSteShopMsgModel.h"

#define Limite @"10"
@interface ZFJSteShopMsgVC ()<UITableViewDataSource, UITableViewDelegate>
{

    int _offset;//偏移量
    int _currentPage;
}
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, copy) NSString * dealWithType;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, assign) NSInteger offsetNum;
@property (nonatomic, copy) NSString * msgUserID;
@property (nonatomic,copy)  NSString *apply_id;
@property (nonatomic, copy) void(^Refresh)();

@end

@implementation ZFJSteShopMsgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"部落消息";
    [self customTableView];
    self.offsetNum = 1;
    [self loadData];
}
- (void)customTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 60;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
    NSMutableArray *imageAray=[NSMutableArray array];
    for (int i=0; i<2; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"单独-logo%d.png", i+2]];
        [imageAray addObject:image];
    }
    //-----------下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
  //  [ self.tableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadMoreBotm)];
    
    // 设置普通状态的动画图片
    [ self.tableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [ self.tableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [ self.tableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateRefreshing];
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
    // 马上进入刷新状态
    [ self.tableView.gifHeader beginRefreshing];
    
    //----------上拉加载更多
 //   [ self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreHeader)];
    
    if ([ self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [ self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([ self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [ self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}
#pragma mark - 下拉刷新 盒加载更多
-(void)loadMoreBotm
{
    _currentPage = 1;
    _offset = 0;
    /**
     *  NSDictionary *parameters = @{@"assistant_id":[[WLSingletonClass defaultWLSingleton] wlUserID],
     @"offset":[NSString stringWithFormat:@"%ld", self.offsetNum],
     @"limit":@"20"};
     */
    //接口
    NSString *url= M_SS_URL_SHOP_MSG;
    NSDictionary *parameterDic;
    parameterDic = @{@"assistant_id":[[WLSingletonClass defaultWLSingleton] wlUserID],
                     @"offset":[NSString stringWithFormat:@"%ld", self.offsetNum],
                     @"limit":@"20"};
    
    [self setRequest:parameterDic url:url tag:1];
    sleep(0.5);
     // 拿到当前的下拉刷新控件，结束刷新状态
    [self.tableView.header endRefreshing];
}
#pragma mark - 请求数据
-(void)setRequest:(NSDictionary *)parmerts url:(NSString *)url tag:(NSInteger)tag
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //发送请求
    __weak ZFJSteShopMsgVC * weakSelf = self;
    [manager POST:url parameters:parmerts success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@",  dic);
        [self.dataArr removeAllObjects]; //清空数组
        if ([dic isKindOfClass:[NSDictionary class]] && [[dic objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary * msgDic in [dic objectForKey:@"data"]) {
                ZFJSteShopMsgModel * model = [[ZFJSteShopMsgModel alloc] initWithDictionary:msgDic];
                self.apply_id = model.apply_id;
                [self.dataArr addObject:model];
            }
            [weakSelf.tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR: %@", error);
        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
            [weakSelf loadData];
        }];
        
    }];

}
#pragma mark --- UITabelViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"Cell";
    
    ZFJSteShopMsgCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell = [[ZFJSteShopMsgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    ZFJSteShopMsgModel * model = [self.dataArr objectAtIndex:indexPath.row];
    cell.modelMsg = model;
    cell.tagLab.text =nil;   //赋值之前 清空原有数据
    cell.cancleLabel.text =nil;
    switch ([model.sign integerValue]) {
        case 1:
        {
            cell.tagLab.text = @"已同意";
            cell.agreeBut.hidden = YES;
            cell.rejectBut.hidden = YES;
        }
            break;
        case 2:
        {
            cell.tagLab.text = @"已拒绝";
            cell.agreeBut.hidden = YES;
            cell.rejectBut.hidden = YES;
            
        }
            break;
        case 3:
        {
            cell.agreeBut.tag = 100000 + indexPath.row;
            cell.rejectBut.tag = 200000 + indexPath.row;
            [cell.agreeBut addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
            [cell.rejectBut addTarget:self action:@selector(reject:) forControlEvents:UIControlEventTouchUpInside];
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString * timeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[model.add_time integerValue]]];
            cell.timeLab.text = timeStr;
            
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}
#pragma mark --- But点击
- (void)agree:(UIButton *)button {
    self.dealWithType = @"1";
    ZFJSteShopMsgModel * model = [self.dataArr objectAtIndex:button.tag - 100000];
    self.msgUserID = model.member_id;
    self.apply_id=model.apply_id;
    //[self dealWithRequest];
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定继续此次操作？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView show];
    
}
- (void)reject:(UIButton *)button {
    self.dealWithType = @"2";
    ZFJSteShopMsgModel * model = [self.dataArr objectAtIndex:button.tag - 200000];
    self.msgUserID = model.member_id;
    self.apply_id=model.apply_id;
    //[self dealWithRequest];
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定继续此次操作？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView show];
    
}
#pragma mark --- UIActionSheetDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self dealWithRequest];
    }
}
#pragma mark --- 处理请求/*处理合伙人申请*/
- (void)dealWithRequest {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //[self setProgressHud];
    NSDictionary *parameters = @{@"assistant_id":[[WLSingletonClass defaultWLSingleton] wlUserID],
                                 @"uid":self.msgUserID,
                                 @"apply_id":self.apply_id,
                                 @"type":self.dealWithType,
                                 };
    NSLog(@"parameters = %@", parameters);
    //接口
    NSString *url= M_SS_URL_DEAL_WITH_MSG;
    //发送请求
    __weak ZFJSteShopMsgVC * weakSelf = self;
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@",  dic);
        if ([dic isKindOfClass:[NSDictionary class]] && [[dic objectForKey:@"status"] integerValue] == 1) {
            [[LXAlterView sharedMyTools] createTishi:@"完成"];
            [weakSelf.dataArr removeAllObjects];
            [weakSelf loadData];
            if ([weakSelf.dealWithType isEqualToString:@"1"]) {
                if (weakSelf.Refresh) {
                    weakSelf.Refresh();
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR: %@", error);
        [[LXAlterView sharedMyTools] createTishi:@"失败,请检查网络"];
    }];
    
}
/**
 *  获取店铺消息  -->管家消息列表
 */
- (void)loadData {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //[self setProgressHud];
    NSDictionary *parameters = @{@"assistant_id":[[WLSingletonClass defaultWLSingleton] wlUserID],
                                 @"offset":[NSString stringWithFormat:@"%ld", self.offsetNum],
                                 @"limit":@"20"};
    NSLog(@"parameters = %@", parameters);
    //接口
    NSString *url= M_SS_URL_SHOP_MSG;
    //发送请求
    __weak ZFJSteShopMsgVC * weakSelf = self;
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@",  dic);
        [self.dataArr removeAllObjects]; //清空数组
        if ([dic isKindOfClass:[NSDictionary class]] && [[dic objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary * msgDic in [dic objectForKey:@"data"]) {
                ZFJSteShopMsgModel * model = [[ZFJSteShopMsgModel alloc] initWithDictionary:msgDic];
                self.apply_id = model.apply_id;
                [self.dataArr addObject:model];
            }
            [weakSelf.tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR: %@", error);
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
- (void)refreshSteShopInfo:(void (^)())refresh {
    self.Refresh = refresh;
}
@end

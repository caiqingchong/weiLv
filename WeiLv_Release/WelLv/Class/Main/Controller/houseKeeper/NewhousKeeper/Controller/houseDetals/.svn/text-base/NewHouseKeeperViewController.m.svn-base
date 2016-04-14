//
//  NewHouseKeeperViewController.m
//  WelLv
//
//  Created by daihengbin on 16/1/13.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "NewHouseKeeperViewController.h"
#import "XCLoadMsg.h"
#import "NewGuanJiaInfoController.h"
@interface NewHouseKeeperViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) NSInteger page;//显示的页数
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSDictionary *parameters;
@end

@implementation NewHouseKeeperViewController
-(NSMutableArray*)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"管家";
    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame=CGRectMake(0, 0, 23, 23);
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    
    _page = 0;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    [self addRefreshing];
    
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
    
    __weak NewHouseKeeperViewController * Nhkvc = self;
    [self.tableView addGifHeaderWithRefreshingBlock:^{
//        [[XCLoadMsg sharedLoadMsg:Nhkvc] hideAll];
//        [[XCLoadMsg sharedLoadMsg:Nhkvc] showActivityLoading:Nhkvc.view];
       // [Nhkvc setProgressHud];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Nhkvc.dataArray removeAllObjects];
            Nhkvc.page = 0;
            [Nhkvc loadDataWithUrl:getHouseListUrl andPage:0];
    
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
//        [[XCLoadMsg sharedLoadMsg:Nhkvc] hideAll];
//        [[XCLoadMsg sharedLoadMsg:Nhkvc] showActivityLoading:Nhkvc.view];
       // [listVC setProgressHud];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           
            Nhkvc.page = Nhkvc.page + 1;
            //DLog(@"%d",Nhkvc.page);
    
            [Nhkvc loadDataWithUrl:getHouseListUrl andPage:Nhkvc.page];
            [Nhkvc.tableView.footer endRefreshing];
        });
        
    }];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}
//搜索数据
-(void)searchBtnClick{
    HouseSearchController *seachVc=[[HouseSearchController alloc] init];
    seachVc.searchType=4;
    [self.navigationController pushViewController:seachVc animated:YES];
}
//加载数据
#pragma mark - 请求数据
-(void)loadDataWithUrl:(NSString*)urlStr andPage:(NSInteger)page{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSInteger offsetNum = page * 10;
    NSString *offsetStr = [NSString stringWithFormat:@"%ld",(long)offsetNum];
    if (_flag == 0) {
        self.parameters = @{@"offset":offsetStr,@"limit":@"10",@"keywords":@"0"};
    }else{
        self.parameters = @{@"offset":offsetStr,@"limit":@"10",@"keywords":self.serchInPut};
    }
    
    //发送请求
    __weak typeof(self)weakSelf =self;
    [manager POST:urlStr parameters:self.parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
       // NSLog(@"%@",dic);
        NSString *code =[NSString stringWithFormat:@"%@",dic[@"status"]] ;
        if ([code isEqualToString:@"1"]) {
         
            
            NSArray *resultArray = dic[@"data"];
            if (page == 0) {
                [weakSelf.dataArray removeAllObjects];
            }
          
            for (NSDictionary *dic in resultArray) {
             NewHosekeeperListModel *houseKeeperListModel = [[NewHosekeeperListModel alloc]init];
                [houseKeeperListModel setValuesForKeysWithDictionary:dic];
                [weakSelf.dataArray addObject:houseKeeperListModel];
              
            }
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.header endRefreshing];
            [weakSelf.tableView.footer endRefreshing];
        }
        else
        {
            [weakSelf.tableView.header endRefreshing];
            [weakSelf.tableView.footer endRefreshing];
            [[LXAlterView sharedMyTools]createTishi:[dic valueForKey:@"msg"]];
            
            [weakSelf.tableView.footer endRefreshing];
            [weakSelf.tableView reloadData];
        }
                
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weakSelf.tableView.header endRefreshing];
        [weakSelf.tableView.footer endRefreshing];
        [[LXAlterView sharedMyTools]createTishi:@"请求失败,请检查网络!"];
        //[self.tableView.footer endRefreshing];
        [weakSelf.tableView reloadData];
    }];



}

#pragma mark - UITableViewDataSource&UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"houseKeeperCell";
 //   NewHosekeeperListModel *model = (NewHosekeeperListModel*)[self.dataArray objectAtIndex:indexPath.row];
    NewHouseKeeperListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NewHouseKeeperListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NewHosekeeperListModel *model = self.dataArray[indexPath.row];
    cell.houseKeeperListModel = model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewGuanJiaInfoController *ndv = [[NewGuanJiaInfoController alloc]init];
    NewHosekeeperListModel *model = (NewHosekeeperListModel*)[self.dataArray objectAtIndex:indexPath.row];
    ndv.userID = model.assistant_id;
    NSLog(@"%@",model.assistant_id);
    ndv.userName = model.name;
    ndv.userIcon = [NSString stringWithFormat:@"%@/%@",WLHTTP,model.avatar];
    ndv.userPhone = model.mobile;
    [self.navigationController pushViewController:ndv animated:YES];

}


@end

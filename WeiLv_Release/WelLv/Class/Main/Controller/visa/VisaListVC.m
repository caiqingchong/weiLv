//
//  VisaListVC.m
//  WelLv
//
//  Created by 张发杰 on 15/4/7.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "VisaListVC.h"
#import "VisaListCell.h"
#import "VisaDetailVC.h"
#import "LiveAddressVC.h"
#import "ZFJVisaTableViewCell.h"
#import "AFNetworking.h"
#import "ZFJVisaModel.h"
#import "XCLoadMsg.h"
#import "YXLocationManage.h"
#import "LXUserTool.h"
#import "LXAlterView.h"
#define M_LIVE_ADDRESS_HEIGHT 40
#define M_VISALIST_HEIGHT 95

#define CELL_INDENTIFIER @"Cell"

@interface VisaListVC ()<UITableViewDataSource, UITableViewDelegate>



@property (nonatomic, strong) UILabel *addressLabel;


@property (nonatomic, strong) UITableView * visaListTableView;

@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, assign) NSInteger pageInteger;
@property (nonatomic, strong) NSArray *liveAddressDataArr;


@property (nonatomic, assign) BOOL noData;



@end

@implementation VisaListVC




- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"签证产品";
    
    //self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@”返回“style:UIBarButtonItemStyleBorderedtarget:nilaction:nil];
    LXUserTool * userTool = [[LXUserTool alloc] init];
    if ([userTool getLiveCityID] == nil) {
        [self loadLiveAddressData];
    }
   
    [self addAddressView];
    
    [self addVisaListTableView];
    

}

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
    
    __weak VisaListVC *visaListVC = self;
    [self.visaListTableView addGifHeaderWithRefreshingBlock:^{
        [[XCLoadMsg sharedLoadMsg:visaListVC] hideAll];
        [[XCLoadMsg sharedLoadMsg:visaListVC] showActivityLoading:visaListVC.view];

        [visaListVC.dataArray removeAllObjects];
        //visaListVC.dataArray = nil;
        _noData = NO;
        visaListVC.pageInteger = 1;
        [visaListVC loadData];
        [visaListVC.visaListTableView.gifHeader endRefreshing];
        [visaListVC.visaListTableView.gifFooter endRefreshing];
        return;
    }];
    // 设置普通状态的动画图片
    [self.visaListTableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self.visaListTableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self.visaListTableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateRefreshing];
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
    // 马上进入刷新状态
    [self.visaListTableView.gifHeader beginRefreshing];
    
    //----------上拉加载更多
    
    //    [self.visaListTableView addGifFooterWithRefreshingBlock:^{
    //        //[visaListVC.dataArray removeAllObjects];
    //        visaListVC.pageInteger = ++visaListVC.pageInteger;
    //        NSLog(@"+++++++++++++++++%ld++++++++++", visaListVC.pageInteger);
    //        [visaListVC loadData];
    //    }];
    
    [self.visaListTableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
    
    if ([self.visaListTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.visaListTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.visaListTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.visaListTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
}
- (void)footerRefreshing
{
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.pageInteger = self.pageInteger + 1;
        [self loadData];
        [self.visaListTableView.footer endRefreshing];
    });
    
}


- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}


- (void)addAddressView
{
  

    UIView * liveAddressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, M_LIVE_ADDRESS_HEIGHT)];
    liveAddressView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:liveAddressView];
    
    UIImageView *addressIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, M_LIVE_ADDRESS_HEIGHT- 20, M_LIVE_ADDRESS_HEIGHT - 14)];
    //addressIcon.backgroundColor = [UIColor brownColor];
    addressIcon.image = [UIImage imageNamed:@"location"];
    [liveAddressView addSubview:addressIcon];
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(liveAddressView) - 0.5, ViewWidth(liveAddressView), 0.5)];
    line.backgroundColor = bordColor;
    [liveAddressView addSubview:line];
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(M_LIVE_ADDRESS_HEIGHT, 0, 150, M_LIVE_ADDRESS_HEIGHT)];
    self.addressLabel.font = [UIFont systemFontOfSize:15];
    //self.addressLabel.text = @"长期居住地：河南";
    LXUserTool * userTool = [[LXUserTool alloc] init];
    if (userTool.getUserLiveAddress == nil) {
        self.addressLabel.text = [NSString stringWithFormat:@"长期居住地：北京"];
    }else if (userTool.getUid == nil){
        self.addressLabel.text = [NSString stringWithFormat:@"长期居住地：北京"];

    }else{
        self.addressLabel.text = [NSString stringWithFormat:@"长期居住地：%@", [userTool getUserLiveAddress]];
    }
    
    [liveAddressView addSubview:self.addressLabel];
    
    UIButton *chooseAddressBut = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseAddressBut.frame = CGRectMake(self.view.frame.size.width - 60, 0, 50, M_LIVE_ADDRESS_HEIGHT);
    [chooseAddressBut setTitle:@"修改" forState:UIControlStateNormal];
    [chooseAddressBut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [chooseAddressBut addTarget:self action:@selector(chooseLiveAddress:) forControlEvents:UIControlEventTouchUpInside];
    [liveAddressView addSubview:chooseAddressBut];

}


- (void)addVisaListTableView
{
    // 状态栏(statusbar)
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    // 导航栏（navigationbar）
    CGRect rectNav = self.navigationController.navigationBar.frame;
    self.visaListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, M_LIVE_ADDRESS_HEIGHT , self.view.frame.size.width, self.view.frame.size.height - M_LIVE_ADDRESS_HEIGHT - rectStatus.size.height - rectNav.size.height)];
    self.visaListTableView.rowHeight = M_VISALIST_HEIGHT;
    self.visaListTableView.delegate = self;
    self.visaListTableView.dataSource = self;
    self.visaListTableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:self.visaListTableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    ZFJVisaTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZFJVisaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsZero;
//        cell.preservesSuperviewLayoutMargins = NO;
//        cell.layoutMargins = UIEdgeInsetsZero;

    }
    DLog(@"--------%lu",(unsigned long)self.dataArray.count);
    if (self.dataArray.count == 0) {
        return cell;
    }
    cell.visaModel = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - chooseLiveAddress
- (void)chooseLiveAddress:(UIButton *)button
{
    LiveAddressVC *liveAddressVC = [[LiveAddressVC alloc] init];
    liveAddressVC.chooesIndexPath = self.chooesIndexPath;
    [self.navigationController pushViewController:liveAddressVC animated:YES];
}

#pragma mark - tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VisaDetailVC *visaDtailVC = [[VisaDetailVC alloc] init];
    ZFJVisaModel * visaModel = [self.dataArray objectAtIndex:indexPath.row];
    //visaDtailVC.visaModel = visaModel;
    visaDtailVC.product_id = visaModel.product_id;
    self.isNeedR = NO;
    [self.navigationController pushViewController:visaDtailVC animated:YES];
}


#pragma mark ---- viewDidAppear

- (void)viewDidAppear:(BOOL)animated
{
    //NSLog(@"%@",[YXLocationManage shareManager].province);
    //[self addAddressView];
    self.pageInteger = 1;
    if (self.isNeedR == YES) {
        [self addRefreshing];
        if ([[[[LXUserTool alloc] init] getUserLiveAddress] isKindOfClass:[NSString class]]) {
            self.addressLabel.text = [NSString stringWithFormat:@"长期居住地：%@", [[[LXUserTool alloc] init] getUserLiveAddress]];
        } else {
            self.addressLabel.text = [NSString stringWithFormat:@"长期居住地：北京"];
        }
        
    }
    //[self addRefreshing];
    //NSLog(@"%@", self.liveAddress);
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.isNeedR = NO;
}


#pragma mark ---- loadData

- (void)loadData
{
    _noData = NO;
    //[self.dataArray removeAllObjects];
    NSInteger dataCount = self.dataArray.count;
    LXUserTool * userToll = [[LXUserTool alloc] init];
    NSLog(@"*******%@", self.searchStr);
    NSString * str = nil;
    if (self.searchStr == nil) {
         str=[NSString stringWithFormat:@"%@?country_id=%@&region_id=%@&page=%ld",VisaListUrl, self.country_id, [userToll getLiveCityID], self.pageInteger];
    } else {
         str=[NSString stringWithFormat:@"%@?product_name=%@&page=%ld&region_id=%@", VisaListUrl, self.searchStr, self.pageInteger, [userToll getLiveCityID]];
    }
    
    NSLog(@"%@", str);
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSLog(@"获取到的数据为：%@",dict);
        NSArray * allArr = [dict objectForKey:@"data"];
        [self.visaListTableView.header endRefreshing];
        [self.visaListTableView.footer endRefreshing];
        for (NSDictionary * dic in allArr) {
            ZFJVisaModel * visaModel = [[ZFJVisaModel alloc] initWithDictionary:dic];
            [self.dataArray addObject:visaModel];
        }
        if (self.dataArray.count == 0){
            UIView * aView = [[UIView alloc] initWithFrame:self.view.bounds];
            aView.backgroundColor = [UIColor whiteColor];
            [self.visaListTableView addSubview:aView];
            UIImageView *bgView=[[UIImageView alloc] init];
            bgView.frame=CGRectMake((windowContentWidth-200)/2, (windowContentHeight-200-140)/2, 200, 200);
            bgView.backgroundColor = [UIColor whiteColor];
            bgView.image=[UIImage imageNamed:@"没找到相关内容.png"];
            [aView addSubview:bgView];
            [bgView bringSubviewToFront:aView];
        }
        
        [self.visaListTableView.gifHeader endRefreshing];
        //[self.visaListTableView.footer endRefreshing];

        if (dataCount == self.dataArray.count) {
            [[LXAlterView sharedMyTools] createTishi:@"暂无数据"];
            self.noData = YES;
            //return;
        }else{
            [self.visaListTableView reloadData];
        }

    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
            [self loadData];
        }];

    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];

}


- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}


- (void)loadLiveAddressData
{
     
    NSString *str=[NSString stringWithFormat:@"%@", VisaLiveAdd];
    NSLog(@"%@", str);
    __weak VisaListVC * visaListVC = self;
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //[[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSLog(@"获取到的数据为：%@",dict);
        visaListVC.liveAddressDataArr = [dict objectForKey:@"data"];
       
        NSLog(@"*************************%@", _liveAddressDataArr);
        
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
        NSArray * arr = [[YXLocationManage shareManager].province componentsSeparatedByString:@"省"];
        LXUserTool * userTool = [[LXUserTool alloc] init];
        
        for (int i = 0; i < _liveAddressDataArr.count; i++) {
            if ([[[_liveAddressDataArr objectAtIndex:i] objectForKey:@"region_name"] isEqualToString:[arr objectAtIndex:0]]) {
                [userTool saveUserLiveAddress:[arr objectAtIndex:0] cityID:[[_liveAddressDataArr objectAtIndex:i] objectForKey:@"region_id"]];
            }
        }
        
        
        self.liveAddress = [arr objectAtIndex:0];
        //[self loadData];
        
        [self addAddressView];
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
//        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
//        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
//        [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
//            [self loadData];
//        }];
        
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
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

//
//  ZFJVIsaListVC.m
//  WelLv
//
//  Created by 张发杰 on 15/7/14.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJVIsaListVC.h"
#import "ZFJVisaTableViewCell.h"
#import "ZFJVisaModel.h"
#import "ZFJLiveAddressVC.h"
#import "YXLocationManage.h"
#import "ZFJVisaDetailVC.h"
#import "LXGetCityIDTool.h"
#import "ChooseTitleView.h"

#define M_VISALIST_HEIGHT 95

@interface ZFJVIsaListVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView * listTableView; //列表；
@property (nonatomic, strong) NSMutableArray * dataArray;  //数据数组；
@property (nonatomic, assign) NSInteger pageInteger;       //加载页码数；

@property (nonatomic, strong) UILabel *addressLabel;       //居住地Label；
@property (nonatomic, strong) NSMutableArray * typeArray;  //类型数组；

@property (nonatomic, copy) NSString * typeStr;            //类型
@property (nonatomic, copy) NSString * sortStr;            //排序
@end

@implementation ZFJVIsaListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"签证产品";

    self.typeStr = @"";
    self.sortStr = @"";
    
    [self loadTypeData];
    
    [self addLiveAddressBut];
    [self addCustomTableView];

    //[self addChooseVisaListView];
    [self addRefreshing];
}

#pragma mark ---- addLiveAddressBut
- (void)addLiveAddressBut {
    
    UIView * liveAddressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, self.navigationController.navigationBar.frame.size.height)];
    liveAddressView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goLocationView:)];
    [liveAddressView addGestureRecognizer:tap];
    UIImageView * locationIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, (ViewHeight(liveAddressView) * 2 / 3 - 13) / 2, 9.5 , 13)];
    locationIcon.image = [UIImage imageNamed:@"长期居住地"];
    locationIcon.backgroundColor = [UIColor whiteColor];
    locationIcon.userInteractionEnabled = YES;
    [liveAddressView addSubview:locationIcon];
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(locationIcon) + 2.5, 0, ViewWidth(liveAddressView) - 7.5 - ViewWidth(locationIcon), ViewHeight(liveAddressView) * 2 / 3)];
    self.addressLabel.backgroundColor = [UIColor whiteColor];
    
   
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"liveAddress_name"]) {
        self.addressLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"liveAddress_name"];
    } else {
        if (![[YXLocationManage shareManager].province stringByReplacingOccurrencesOfString:@"省" withString:@""]) {
            self.addressLabel.text = @"北京";
        } else{
            self.addressLabel.text = [[YXLocationManage shareManager].province stringByReplacingOccurrencesOfString:@"省" withString:@""];
        }
        //self.addressLabel.text = [[YXLocationManage shareManager].province stringByReplacingOccurrencesOfString:@"省" withString:@""];
    }
    self.addressLabel.adjustsFontSizeToFitWidth = YES;
    self.addressLabel.textAlignment = NSTextAlignmentLeft;
    self.addressLabel.font = [UIFont systemFontOfSize:15];
    self.addressLabel.textColor = [UIColor blackColor];
    self.addressLabel.userInteractionEnabled = YES;
    [liveAddressView addSubview:self.addressLabel];
    
    UILabel * liveAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewBelow(self.addressLabel), ViewWidth(liveAddressView), ViewHeight(liveAddressView) / 3)];
    liveAddressLabel.text = @"长期居住地";
    liveAddressLabel.textAlignment = NSTextAlignmentCenter;
    liveAddressLabel.textColor = [UIColor grayColor];
    liveAddressLabel.font = [UIFont systemFontOfSize:12];
    liveAddressLabel.userInteractionEnabled = YES;
    [liveAddressView addSubview:liveAddressLabel];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:liveAddressView];
}

#pragma mark ---- goLiveAddressView
- (void)goLocationView:(UITapGestureRecognizer *)tap {
    __weak ZFJVIsaListVC * visaListVC = self;
    ZFJLiveAddressVC * liveAddressVC = [[ZFJLiveAddressVC alloc] initWithLiveAddress:^(NSString *liveAddressStr) {
        _addressLabel.text = liveAddressStr;
        [visaListVC addRefreshing];
    }];
    [self presentViewController:liveAddressVC animated:YES completion:NULL];
    
}

#pragma mark ---- addChooseView 加载筛选视图
/**
 * 加载筛选视图
 */
- (void)addChooseVisaListView {
    if (self.typeArray.count == 0) {
        self.listTableView.frame = CGRectMake(0, 0, windowContentWidth, ViewHeight(self.listTableView) + 40);
        return;
    }
    [self.typeArray setObject:@"全部" atIndexedSubscript:0];
    ChooseTitleView * chooseTitleView = [[ChooseTitleView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 40) withTitleArray:@[@"综合", @"类型"] sencondTitleArray:@[@[@"销量由高到低", @"价格由高到低", @"价格由低到高"],self.typeArray]];
    
    NSArray * sortArr = @[@"&by=sell_count", @"&by=sell_price", @"&by=sell_price&sort=asc"];//排序
    
    __weak ZFJVIsaListVC * visaListVC = self;
    [chooseTitleView chooseIndex:^(NSIndexPath *index) {
        
        if (index.section == 0) {
            visaListVC.sortStr = [sortArr objectAtIndex:index.row];
            [visaListVC.listTableView.gifHeader beginRefreshing];
            
           
        } else if (index.section == 1) {
            
            if (index.row == 0) {
                visaListVC.typeStr = @"";
            } else {
                visaListVC.typeStr = [visaListVC.typeArray objectAtIndex:index.row];
            }
            [visaListVC.listTableView.gifHeader beginRefreshing];

        }
    }];
    
    [self.view addSubview:chooseTitleView];
}

#pragma mark ---- addTableView

- (void)addCustomTableView {
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    // 导航栏（navigationbar）
    CGRect rectNav = self.navigationController.navigationBar.frame;
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, windowContentWidth, windowContentHeight - rectStatus.size.height - rectNav.size.height - 40)];
    //self.listTableView.contentInset = UIEdgeInsetsMake(45, 0, 0, 0);
    self.listTableView.delegate   = self;
    self.listTableView.dataSource = self;
    self.listTableView.rowHeight  = M_VISALIST_HEIGHT;
    self.listTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.listTableView];
    
}

#pragma mark ---- addRefreshing
/**
 *  刷新
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
    
    __weak ZFJVIsaListVC *visaListVC = self;
    [self.listTableView addGifHeaderWithRefreshingBlock:^{
        [[XCLoadMsg sharedLoadMsg:visaListVC] hideAll];
        [[XCLoadMsg sharedLoadMsg:visaListVC] showActivityLoading:visaListVC.view];
        [visaListVC.dataArray removeAllObjects];
        visaListVC.pageInteger = 1;
        [visaListVC loadData];
        return;
    }];
    // 设置普通状态的动画图片
    [self.listTableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self.listTableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self.listTableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateRefreshing];
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
    // 马上进入刷新状态
    [self.listTableView.gifHeader beginRefreshing];
    
    
    [self.listTableView.footer setState:MJRefreshFooterStateIdle];
    
    [self.listTableView addLegendFooterWithRefreshingBlock:^{
        [[XCLoadMsg sharedLoadMsg:visaListVC] hideAll];
        [[XCLoadMsg sharedLoadMsg:visaListVC] showActivityLoading:visaListVC.view];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            visaListVC.pageInteger = visaListVC.pageInteger + 1;
            [visaListVC loadData];
            [visaListVC.listTableView.footer endRefreshing];
        });

    }];
    
    if ([self.listTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.listTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.listTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.listTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark ---- tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIndentifier = @"visaCell";
    ZFJVisaTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[ZFJVisaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier customStyle:ZFJVisaTableViewCellStyleTwo];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.visaModel = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark ---- TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZFJVisaDetailVC *visaDtailVC = [[ZFJVisaDetailVC alloc] init];
    ZFJVisaModel * visaModel = [self.dataArray objectAtIndex:indexPath.row];
    visaDtailVC.product_id = visaModel.product_id;
    [self.navigationController pushViewController:visaDtailVC animated:YES];
    
//    VisaDetailVC * visaDtailVC = [[VisaDetailVC alloc] init];
//    ZFJVisaModel * visaModel = [self.dataArray objectAtIndex:indexPath.row];
//    visaDtailVC.product_id = visaModel.product_id;
//    [self.navigationController pushViewController:visaDtailVC animated:YES];
    
}

#pragma mark ---- loadData

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

/**
 * 请求列表数据
 */
- (void)loadData {
    

    NSString * str = nil;
    NSString * liveAddress = [[NSUserDefaults standardUserDefaults] objectForKey:@"liveAddress_name"];
    if (!liveAddress) {
        if (![[YXLocationManage shareManager].province stringByReplacingOccurrencesOfString:@"省" withString:@""]) {
            liveAddress = @"北京";
        } else{
            liveAddress = [[YXLocationManage shareManager].province stringByReplacingOccurrencesOfString:@"省" withString:@""];
        }
    }
//    NSLog(@"\n****start*****\n%@\n*****stop****", liveAddress);
    //[LXGetCityIDTool sharedMyTools].city_regionID
    if (self.region_id == nil) {
        self.region_id = @"52";
    }
    
    
    
    NSString *assistant_id=@"";
    if ([[[LXUserTool alloc] getKeeper] rangeOfString:@"null"].location!=NSNotFound) {
        assistant_id=@"0";
    }
    else
    {
        assistant_id=[[LXUserTool alloc] getKeeper];
    }
    
    if (self.searchStr == nil) {
        str = [NSString stringWithFormat:@"%@?country_id=%@&region_name=%@&page=%ld&city_id=%@&visa_type=%@%@&assistant_id=%@",VisaListUrl, self.country_id, liveAddress, self.pageInteger, self.region_id, self.typeStr, self.sortStr,assistant_id];
    } else {
        str = [NSString stringWithFormat:@"%@?product_name=%@&page=%ld&region_name=%@&city_id=%@&visa_type=%@%@&assistant_id=%@", VisaListUrl, self.searchStr, self.pageInteger, liveAddress, self.region_id, self.typeStr, self.sortStr,assistant_id];
    }
    
    NSLog(@"%@", str);
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __weak ZFJVIsaListVC * visaListVC = self;
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        //NSLog(@"获取到的数据为：%@",dict);
        
        if ([[dict objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary * dic in [dict objectForKey:@"data"]) {
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    ZFJVisaModel * model = [[ZFJVisaModel alloc] initWithDictionary:dic];
                    [visaListVC.dataArray addObject:model];
                }
            }
        }

        if(!visaListVC.dataArray.count){
            [[LXAlterView sharedMyTools] createTishi:@"对不起，没有搜索到相关内容"];
        }
        
        [visaListVC.listTableView.gifHeader endRefreshing];
        [visaListVC.listTableView.gifFooter endRefreshing];
        
        [visaListVC.listTableView reloadData];
        if (_listTableView.contentSize.height < ControllerViewHeight) {
            [_listTableView removeFooter];
        }

    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
            [visaListVC loadData];
        }];
        
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}
- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}

/**
 * 请求筛选类型数据
 */

- (void)loadTypeData {
    
    NSString * str = VisaType_URL;
   
    
    NSLog(@"%@", str);
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __weak ZFJVIsaListVC * visaListVC = self;
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSLog(@"获取到的数据为：%@",dict);
        [visaListVC.typeArray addObjectsFromArray:[dict objectForKey:@"data"]];
        [visaListVC addChooseVisaListView];


    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
//        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
//        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
//        [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
//            
//            [visaListVC loadTypeData];
//        }];
        
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

- (NSMutableArray *)typeArray {
    if (_typeArray == nil) {
        self.typeArray = [NSMutableArray array];
    }
    return _typeArray;
}


@end

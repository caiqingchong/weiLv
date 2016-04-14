//
//  ZFJHotelListVCViewController.m
//  WelLv
//
//  Created by zhangjie on 15/10/2.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJHotelListVC.h"
#import "ZFJHotelListCell.h"
#import "ZFJFilterView.h"
#import "ZFJHotelFilterViewVC.h"
#import "ZFJHotelListLocationFilterVC.h"
#import "ZFJHotelPriceStarFilterView.h"
#import "ZFJHotelListSortView.h"
#import "HotelDetailViewController.h"
#import "HotelListModel.h"
#import "HotelBrandsModel.h"
#import "HotelThemeModel.h"
#import "HotelFacilityModel.h"
#import "WWHHotelTopListBtn.h"
#import "WWHTopBtnScrollView.h"
#import "HotelStarPriceControl.h"

#define M_SEARCHVIEW_HEIGHT 50
#define M_FILTERVIEW_HEIGHT 50

@interface ZFJHotelListVC ()<UITableViewDataSource, UITableViewDelegate,ZFJHotelFilterViewVCDelegate>

@property (nonatomic, strong) UIView * searchBackgroundView;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * filterBackgroundView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UILabel *coutLable;
@property (nonatomic, strong) NSMutableArray *topBtnArray;//视图顶栏的添加按钮

@end

@implementation ZFJHotelListVC


#pragma mark -懒加载
-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(UILabel *)coutLable
{
    if (_coutLable == nil) {
        _coutLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 260, 20)];
        _coutLable.textAlignment = NSTextAlignmentCenter;
        _coutLable.text = @"周边";
    }
    return _coutLable;
}

-(NSMutableArray *)topBtnArray
{
    if (_topBtnArray == nil) {
        _topBtnArray = [NSMutableArray array];
    }
    return _topBtnArray;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = self.coutLable;
    self.view.backgroundColor = [UIColor whiteColor];
    self.cityname = @"北京";
    self.arrivalDate = @"2015-11-11";
    self.departureDate = @"2015-11-12";
    self.queryText = @"";
    self.lowRate = @"";
    self.highRate = @"";
    self.starRate = @"";
    self.sort = @"";
    self.queryType = @"";
    self.brandId = @"";
   [self loadDataWithUrl:HotelList andParams:nil];
    
    
    //[self timeAndSearchView];
    [self listTableView];
    [self filterView];
}

#pragma  mark --- 加载人离时间和搜索View
/**
 *  加载人离时间和搜索View
 */
- (void)timeAndSearchView {
    self.searchBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, M_SEARCHVIEW_HEIGHT)];
    self.searchBackgroundView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_searchBackgroundView];
 }
#pragma mark ---  加载tableView
/**
 *  加载tableView
 */
- (void)listTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, windowContentWidth, ControllerViewHeight - M_SEARCHVIEW_HEIGHT - 2)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 90;
    [self.view addSubview:_tableView];
}

#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"Cell";
    ZFJHotelListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZFJHotelListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.hotelModel = (HotelListModel *)self.dataArray[indexPath.row];
    return cell;
}

#pragma mark --- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HotelDetailViewController * hotelDetailVC = [[HotelDetailViewController alloc] init];
    [self.navigationController pushViewController:hotelDetailVC animated:YES];
}

#pragma mark --- 加载筛选视图
/**
 *  加载筛选视图
 */
- (void)filterView {
    self.filterBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, ControllerViewHeight - M_FILTERVIEW_HEIGHT, windowContentWidth, M_FILTERVIEW_HEIGHT)];
    self.filterBackgroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.75];
    
    ZFJFilterView * filterView = [[ZFJFilterView alloc] initWithFrame:self.filterBackgroundView.bounds
                                                       withTitleArray:@[@"筛选", @"区域位置", @"价格星级", @"排序"]
                                                              iconArr:@[@"筛选", @"区域位置", @"价格星级", @"排序"]
                                                        chooseIconArr:@[@"筛选", @"区域位置", @"价格星级", @"排序"]];//
    [filterView didSelectIndex:^(NSIndexPath *index) {
        switch (index.row) {
            case 0:
            {
                ZFJHotelFilterViewVC * hotelFilterViewVC = [[ZFJHotelFilterViewVC alloc] init];
                hotelFilterViewVC.citycode = @"0101";
                hotelFilterViewVC.delegate = self;
                [self.navigationController pushViewController:hotelFilterViewVC animated:YES];
            }
                break;
            case 1:
            {
                ZFJHotelListLocationFilterVC * hotelListLocationFilterVC = [[ZFJHotelListLocationFilterVC alloc] init];
                hotelListLocationFilterVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                [self presentViewController:hotelListLocationFilterVC animated:YES completion:NULL];
                
            }
                break;
            case 2:
            {
                HotelStarPriceControl * priceStarView = [[HotelStarPriceControl alloc] init];
                
                [self.view addSubview:priceStarView];
            }
                break;
            case 3:
            {
                
            }
                break;

            default:
                break;
        }
    }];
    [self.filterBackgroundView addSubview:filterView];
    
    [self.view addSubview:_filterBackgroundView];

}

#pragma mark --- 加载数据
/**
 *  加载数据
 */
- (void)loadDataWithUrl:(NSString *)urlStr andParams:(NSDictionary *)parameters
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //参数拼接
    //    NSDictionary *parameters = @{@"cityname":self.cityname,
    //                                 @"arrivalDate":self.arrivalDate,
    //                                 @"departureDate":self.departureDate,
    //                                 @"queryText":self.queryText,
    //                                 @"lowRate":self.lowRate,
    //                                 @"highRate":self.highRate,
    //                                 @"sort":self.sort,
    //                                 @"QueryType":self.queryType,
    //                                 @"BrandId":self.brandId};
    self.arrivalDate = @"2015-11-19";
    self.departureDate = @"2015-11-20";
    
    parameters = @{@"cityname":self.cityname,
                   @"ArrivalDate":self.arrivalDate,
                   @"DepartureDate":self.departureDate,
                   @"queryText":self.queryText,
                   @"lowRate":self.lowRate,
                   @"highRate":self.highRate,
                   @"sort":self.sort,
                   @"QueryType":self.queryType,
                   @"CityId":@"0101"};
    
    //接口
    //发送请求
    // __weak ZFJHotelListVC * listVC = self;
    [manager POST:HotelList parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *code =[NSString stringWithFormat:@"%@",dic[@"Success"]] ;
        if ([code isEqualToString:@"1"]) {
            NSDictionary *resultDic = dic[@"Data"];
            NSString *taotalNumber =[NSString stringWithFormat:@"%@",resultDic[@"Count"]];
            if ([taotalNumber isEqualToString:@"<null>"]) {
                taotalNumber = @"0";
            }
            self.coutLable.text = [NSString stringWithFormat:@"周边(%@家)",taotalNumber];
           
            NSArray *resultArray = resultDic[@"Hotels"];
            [self.dataArray removeAllObjects];
            for (NSDictionary *dic in resultArray) {
            HotelListModel *hotelListModel = [[HotelListModel alloc] initWithDic:dic];
            [self.dataArray addObject:hotelListModel];
            }
            [self.tableView reloadData];
            
        }
        else
        {
         [[LXAlterView sharedMyTools]createTishi:[dic valueForKey:@"msg"]];
            
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[LXAlterView sharedMyTools]createTishi:@"请求失败,请检查网络!"];
    }];
}



@end
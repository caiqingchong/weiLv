//
//  HotCountryOrCityVC.m
//  WelLv
//
//  Created by 张发杰 on 15/8/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "HotCountryOrCityVC.h"
#import "LXGetCityIDTool.h"
#import "ZFJTicketListVC.h"
#import "LXSTListViewController.h"

@interface HotCountryOrCityVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableDictionary * dataDic;
@property (nonatomic, strong) MBProgressHUD * hud;

@end

@implementation HotCountryOrCityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.type==1) {
        [self loadData];
    }else if (self.type==2){
        [self LoadStudyTour];
        
    }
    
    [self addCustomTableView];
    
}

#pragma mark ---- 加载视图

/**
 *  加载TableView
 */
- (void)addCustomTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight - [[UIApplication sharedApplication] statusBarFrame].size.height - self.navigationController.navigationBar.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionIndexColor = [UIColor colorWithRed:112 /255.0 green:168 /255.0 blue:254 /255.0 alpha:1.0];;
    
    self.tableView.sectionHeaderHeight = 20;
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];



   [self setProgressHud];


}


#pragma mark ---- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray * tempArr = [NSMutableArray array];
    tempArr = [self.dataDic objectForKey:[self.titleArray objectAtIndex:section]];
    return tempArr.count;
}

//设置区头
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.titleArray objectAtIndex:section];
}

//索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.titleArray;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIndentifier = @"listCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsZero;
    }
    if (self.type==1) {
        NSString * str = [[self.dataDic objectForKey:[_titleArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
        cell.textLabel.text = str;
    }
    if (self.type==2) {
        //游学
        NSString * str = [[[self.dataDic objectForKey:[_titleArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"d_name"];
        cell.textLabel.text = str;
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
//给区头设置背景色。
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    view.tintColor =  [UIColor colorWithRed:131 /255.0 green:146/255.0 blue:156/255.0 alpha:1.0];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type==1) {
        NSString * str = [[self.dataDic objectForKey:[_titleArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
        [self pushToTicketListVCWithKey:@"placecity" value:str];
    }
    if (self.type==2) {
        NSString * str = [[[self.dataDic objectForKey:[_titleArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"d_name"];
        DLog(@"str----%@",str);
        LXSTListViewController *stListVc=[[LXSTListViewController alloc] init];
        stListVc.city_name=str;
        stListVc.sourceType=HotCity;
        [self.navigationController pushViewController:stListVc animated:YES];
    }
    
    
}
- (void)pushToTicketListVCWithKey:(NSString *)keyStr value:(NSString *)valueStr {
    ZFJTicketListVC * listVC = [[ZFJTicketListVC alloc] init];
    listVC.keyStr = keyStr;
    listVC.valueStr = valueStr;
    listVC.isCity = YES;
    [self.navigationController pushViewController:listVC animated:YES];
}

#pragma mark ---- loadData
- (void)loadData
{
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    NSString *str= self.listURLStr;
    NSLog(@"%@", str);
    __weak HotCountryOrCityVC * hotCountryOrCityVC = self;
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_hud hide:YES];

        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        //NSLog(@"获取到的数据为：%@",dict);
        //NSArray * allArr = [dict objectForKey:@"data"];
        
        NSArray * keyArr = [[dict objectForKey:@"data"] allKeys];
        NSMutableArray * tempArr = [NSMutableArray array];
        
        for (int i = 0; i < keyArr.count; i++) {
            NSArray * arr = [[dict objectForKey:@"data"] objectForKey:[keyArr objectAtIndex:i]];
            for (int j = 0; j < arr.count; j++) {
                [tempArr addObject:[arr objectAtIndex:j]];
            }
            
        }
        hotCountryOrCityVC.titleArray = [NSMutableArray array];
        hotCountryOrCityVC.dataDic = [NSMutableDictionary dictionary];
        for (int i = 0; i < tempArr.count; i++) {
            NSString *titleStr = [[[hotCountryOrCityVC transformMandarinToLatin:[[tempArr objectAtIndex:i] substringToIndex:1]] capitalizedString] substringToIndex:1];
            [_dataDic setValue:[NSMutableArray array] forKey:titleStr];
        }
        for (int i = 0; i < tempArr.count; i++) {
            NSString *titleStr = [[[hotCountryOrCityVC transformMandarinToLatin:[[tempArr objectAtIndex:i] substringToIndex:1]] capitalizedString] substringToIndex:1];
            NSMutableArray * valueArr = [_dataDic objectForKey:titleStr];
            [valueArr addObject:[tempArr objectAtIndex:i]];
            [hotCountryOrCityVC.dataArray addObject:valueArr];
        }
        [hotCountryOrCityVC.titleArray addObjectsFromArray:[[_dataDic allKeys] sortedArrayUsingSelector:@selector(compare:)]];
        [self.tableView reloadData];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        [_hud hide:YES];

        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
            [hotCountryOrCityVC loadData];
        }];
        
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
}

//加载游学数据
-(void)LoadStudyTour
{
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    NSString *str= StudyTourCityUrl;
    NSLog(@"%@", str);
    __weak HotCountryOrCityVC * hotCountryOrCityVC = self;
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_hud hide:YES];

        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSLog(@"获取到的数据为：%@",dict);
        //NSArray * allArr = [dict objectForKey:@"data"];
        
        // NSArray * keyArr = [[dict objectForKey:@"data"] allKeys];
        //        NSMutableArray * tempArr = [NSMutableArray array];
        //
        //        for (int i = 0; i < keyArr.count; i++) {
        //            NSArray * arr = [[dict objectForKey:@"data"] objectForKey:[keyArr objectAtIndex:i]];
        //            for (int j = 0; j < arr.count; j++) {
        //                [tempArr addObject:[arr objectAtIndex:j]];
        //            }
        //
        //        }
        hotCountryOrCityVC.titleArray = [NSMutableArray array];
        hotCountryOrCityVC.dataDic = [NSMutableDictionary dictionaryWithDictionary:[dict objectForKey:@"data"]];
        //        for (int i = 0; i < tempArr.count; i++) {
        //            NSString *titleStr = [[[hotCountryOrCityVC transformMandarinToLatin:[[tempArr objectAtIndex:i] substringToIndex:1]] capitalizedString] substringToIndex:1];
        //            [_dataDic setValue:[NSMutableArray array] forKey:titleStr];
        //        }
        //        for (int i = 0; i < tempArr.count; i++) {
        //            NSString *titleStr = [[[hotCountryOrCityVC transformMandarinToLatin:[[tempArr objectAtIndex:i] substringToIndex:1]] capitalizedString] substringToIndex:1];
        //            NSMutableArray * valueArr = [_dataDic objectForKey:titleStr];
        //            [valueArr addObject:[tempArr objectAtIndex:i]];
        //            [hotCountryOrCityVC.dataArray addObject:valueArr];
        //        }
        [hotCountryOrCityVC.titleArray addObjectsFromArray:[[_dataDic allKeys] sortedArrayUsingSelector:@selector(compare:)]];
        [self.tableView reloadData];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        [_hud hide:YES];

        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
            [hotCountryOrCityVC LoadStudyTour];
        }];
        
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
}

- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
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


@end

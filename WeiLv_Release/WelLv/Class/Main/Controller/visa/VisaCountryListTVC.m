//
//  VisaCountryListTVC.m
//  WelLv
//
//  Created by 张发杰 on 15/4/7.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "VisaCountryListTVC.h"
#import "VisaCountryListCell.h"
#import "AFNetworking.h"
#import "XCLoadMsg.h"
#import "LXGetCityIDTool.h"
#import "ZFJVIsaListVC.h"

#define RGB_COLOR(R, G, B) [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:1.0]

@interface VisaCountryListTVC ()
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) NSMutableArray * titleArray;

@property (nonatomic,copy) NSString *searchData;
@property (nonatomic, strong) NSMutableDictionary * visaCountryDic;

@end

@implementation VisaCountryListTVC

- (void)coustomNavigationBar
{
    NavSearchView *searchView = [[NavSearchView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth-140, 25) Feature:@"搜索办签目的地"];
    searchView.delegate = self;
    self.navigationItem.titleView = searchView;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"国家";
    
    [self loadData];

    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];

    UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
    //but.backgroundColor = [UIColor blackColor];
    but.frame = CGRectMake(0, 0, 16, 26);
    [but setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    [but addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:but];
    //self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:but];
    
//    BackBtn *btn = [[BackBtn alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
//    btn.leftView.image = [UIImage imageNamed:@"back"];
//    //btn.titleLab.text = self.backTitle;
//    [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];

    
//    BackBtn *btn = [[BackBtn alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
//    btn.leftView.image = [UIImage imageNamed:@"矩形-22"];
//    [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    self.tableView.sectionIndexColor = [UIColor colorWithRed:112 /255.0 green:168 /255.0 blue:254 /255.0 alpha:1.0];;
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    
    
    UIScreenEdgePanGestureRecognizer * screenEdgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    screenEdgePan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:screenEdgePan];
    //self.tableView.rowHeight = 70;
    self.tableView.rowHeight = 45;
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)close {
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray * tempArr = [NSMutableArray array];
    tempArr = [self.visaCountryDic objectForKey:[self.titleArray objectAtIndex:section]];
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 20)];
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, windowContentWidth, 20)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = [self.titleArray objectAtIndex:section];
    headerView.backgroundColor =  [UIColor colorWithRed:131 /255.0 green:146/255.0 blue:156/255.0 alpha:1.0];
    [headerView addSubview:titleLabel];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    static NSString *cellIndentifier = @"listCell";
    VisaCountryListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[VisaCountryListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsZero;
    }
    cell.countryNameLabel.text = [[[self.visaCountryDic objectForKey:[_titleArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"name"];
    [cell.countryIconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", WLHTTP, [[[self.visaCountryDic objectForKey:[_titleArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"index_thumb"]]] placeholderImage:[UIImage imageNamed:@"默认图2"]];
    return cell;
     */
    static NSString *cellIndentifier = @"listCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsZero;
    }
    cell.textLabel.text = [[[self.visaCountryDic objectForKey:[_titleArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"name"];
    return cell;
     
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZFJVIsaListVC *visaListVC = [[ZFJVIsaListVC alloc] init];
    visaListVC.country_id = [[[self.visaCountryDic objectForKey:[_titleArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"cat_id"];;
    visaListVC.region_id = self.cityIDStr;
    [self.navigationController pushViewController:visaListVC animated:YES];
    
}



#pragma mark ---- loadData

- (void)loadData
{
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    NSString *str=[NSString stringWithFormat:@"%@?city_id=%@", visaCountryList, self.cityIDStr];
    NSLog(@"%@", str);
    __weak VisaCountryListTVC * visaCountryVC = self;
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        //NSLog(@"获取到的数据为：%@",dict);
        NSArray * allArr = [dict objectForKey:@"data"];
        
        visaCountryVC.titleArray = [NSMutableArray array];
        self.visaCountryDic = [NSMutableDictionary dictionary];

        for (int i = 0; i < allArr.count; i++) {
            NSString *titleStr = [[[visaCountryVC transformMandarinToLatin:[[[allArr objectAtIndex:i] objectForKey:@"name"] substringToIndex:1]] capitalizedString] substringToIndex:1];
            [_visaCountryDic setValue:[NSMutableArray array] forKey:titleStr];
        }
        
        for (int i = 0; i < allArr.count; i++) {
            NSString *titleStr = [[[visaCountryVC transformMandarinToLatin:[[[allArr objectAtIndex:i] objectForKey:@"name"] substringToIndex:1]] capitalizedString] substringToIndex:1];
            NSMutableArray * valueArr = [_visaCountryDic objectForKey:titleStr];
            [valueArr addObject:[allArr objectAtIndex:i]];
            [self.dataArray addObject:valueArr];
        }
        
        [visaCountryVC.titleArray addObjectsFromArray:[[_visaCountryDic allKeys] sortedArrayUsingSelector:@selector(compare:)]];
        [self.tableView reloadData];
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



/*将汉字转换为不带音调的拼音
 *string是要转换的字符串*/
- (NSString *)transformMandarinToLatin:(NSString *)string
{
    /*复制出一个可变的对象*/
    NSMutableString *preString = [string mutableCopy];
    /*转换成成带音 调的拼音*/
    CFStringTransform((CFMutableStringRef)preString, NULL, kCFStringTransformMandarinLatin, NO);
    /*去掉音调*/
    CFStringTransform((CFMutableStringRef)preString, NULL, kCFStringTransformStripDiacritics, NO);
    
    /*多音字处理*/
    if ([[(NSString *)string substringToIndex:1] compare:@"长"] == NSOrderedSame)
    {
        [preString replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chang"];
    }
    if ([[(NSString *)string substringToIndex:1] compare:@"沈"] == NSOrderedSame)
    {
        [preString replaceCharactersInRange:NSMakeRange(0, 4) withString:@"shen"];
    }
    if ([[(NSString *)string substringToIndex:1] compare:@"厦"] == NSOrderedSame)
    {
        [preString replaceCharactersInRange:NSMakeRange(0, 3) withString:@"xia"];
    }
    if ([[(NSString *)string substringToIndex:1] compare:@"地"] == NSOrderedSame)
    {
        [preString replaceCharactersInRange:NSMakeRange(0, 3) withString:@"di"];
    }
    if ([[(NSString *)string substringToIndex:1] compare:@"重"] == NSOrderedSame)
    {
        [preString replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chong"];
    }
    return preString;
}



@end

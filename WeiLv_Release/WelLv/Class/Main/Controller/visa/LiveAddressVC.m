//
//  LiveAddressVC.m
//  WelLv
//
//  Created by 张发杰 on 15/4/9.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "LiveAddressVC.h"
#import "ZFJLiveAddressCell.h"
#import "XCLoadMsg.h"
#import "UIDefines.h"
#import "YXLocationManage.h"

#define M_WARN_VIEW_HEIGHT 40

@interface LiveAddressVC ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView * warnView;
@property (nonatomic, strong) UIImageView *chooesImageView;

@property (nonatomic, strong)UITableView *liveAddressTabelView;

@property (nonatomic, assign) NSArray * addressArr;
@property (nonatomic, strong) NSMutableArray * titleArray;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UITableView *searchTableView;
@property (nonatomic, strong) UIView *blurView;

@property (nonatomic, strong) NSString * searchString;

@property (nonatomic, strong) NavSearchView *searchView;


@property (nonatomic, strong) NSMutableArray * searchArray;

@property (nonatomic, copy) backViewBlock backView;

@property (nonatomic, strong) UILabel * nowLocationLabel;

@end

@implementation LiveAddressVC

- (id)initWithLiveAddress:(backViewBlock)liveAddressStr{
    if (self =[super init]) {
        self.backView = liveAddressStr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地区";
    self.view.backgroundColor = [UIColor whiteColor];

    
    [self loadData];
    /*
    self.warnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, M_WARN_VIEW_HEIGHT)];
    [self.view addSubview:_warnView];
    UILabel *warnLabel = [[UILabel alloc] initWithFrame:CGRectMake( 10, 0, self.warnView.frame.size.width - M_WARN_VIEW_HEIGHT - 10, M_WARN_VIEW_HEIGHT)];
    warnLabel.textColor = [UIColor grayColor];
    warnLabel.font = [UIFont systemFontOfSize:15];
    warnLabel.text = @"微旅将根据你的长期居住地提供办签服务";
    [self.warnView addSubview:warnLabel];
    */
    
    self.liveAddressTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    self.liveAddressTabelView.contentInset = UIEdgeInsetsMake(70, 0, 0, 0);
    _liveAddressTabelView.backgroundColor = [UIColor whiteColor];
    _liveAddressTabelView.delegate = self;
    _liveAddressTabelView.dataSource = self;
    _liveAddressTabelView.rowHeight = 50;
    _liveAddressTabelView.sectionIndexColor = [UIColor orangeColor];
    _liveAddressTabelView.sectionIndexBackgroundColor = [UIColor clearColor];
    _liveAddressTabelView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_liveAddressTabelView];
    
    //加载当前定位省份
    [self addLocationView];
}

/**
 *  加载当前定位省份
 */
- (void)addLocationView {
    
    UILabel * locatinLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -70, windowContentWidth, 30)];
    locatinLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    locatinLabel.text = @"   当前定位城市";
    locatinLabel.font = [UIFont systemFontOfSize:15];
    locatinLabel.textColor = [UIColor grayColor];
    [self.liveAddressTabelView addSubview:locatinLabel];
    
    UIView * locationView = [[UIView alloc] initWithFrame:CGRectMake(0, -40, windowContentWidth, 40)];
    locationView.backgroundColor = [UIColor whiteColor];
    
    UIImageView * locationImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 8, 13.5, 19)];
    //locationImage.backgroundColor = [UIColor orangeColor];
    locationImage.image = [UIImage imageNamed:@"location"];
    [locationView addSubview:locationImage];
    
    self.nowLocationLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(locationImage) + ViewWidth(locationImage) + 10, 5, 200, 30)];
    _nowLocationLabel.numberOfLines = 0;
    _nowLocationLabel.adjustsFontSizeToFitWidth=YES;
    
    if(![CLLocationManager locationServicesEnabled]){
        //NSLog(@"请开启定位:设置 > 隐私 > 位置 > 定位服务");
    }else{
        if ([CLLocationManager authorizationStatus] !=  kCLAuthorizationStatusAuthorized && [CLLocationManager authorizationStatus] !=  kCLAuthorizationStatusAuthorizedWhenInUse) {
            //NSLog(@"定位失败，请开启定位:设置 > 隐私 > 位置 > 定位服务 下 XX应用");
            
            _nowLocationLabel.text = @"无法获取你的位置，请在设置-隐私-定位中打开微旅管家的定位服务";
        } else {
            _nowLocationLabel.text = [[YXLocationManage shareManager].province stringByReplacingOccurrencesOfString:@"省" withString:@""];
        }
    }

    _nowLocationLabel.textColor = [UIColor orangeColor];
    _nowLocationLabel.font = [UIFont systemFontOfSize:15];
    [locationView addSubview:_nowLocationLabel];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapNowLocationView:)];
    [locationView addGestureRecognizer:tap];
    [self.liveAddressTabelView addSubview:locationView];

}

#pragma mark ----- tapNowLocationView
/**
 *  点击点前定位省份
 *
 *  @param tap 点击
 */
- (void)tapNowLocationView:(UITapGestureRecognizer *)tap {
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * arr = [self.dataArray objectAtIndex:section];
    return arr.count;
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
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 30)];
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, windowContentWidth, 30)];
    titleLabel.textColor = [UIColor orangeColor];
    
    titleLabel.text = [self.titleArray objectAtIndex:section];
    headerView.backgroundColor = bordColor;
    [headerView addSubview:titleLabel];
    return headerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"Cell";
    ZFJLiveAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[ZFJLiveAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsZero;
//        cell.preservesSuperviewLayoutMargins = NO;
//        cell.layoutMargins = UIEdgeInsetsZero;
    }
    
    cell.titleLabel.text = [[[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"region_name"];
    if ([cell.titleLabel.text isEqual:self.chooesIndexPath]) {
        cell.chooseImage.image = [UIImage imageNamed:@"选择"];
    } else {
        cell.chooseImage.image = [UIImage imageNamed:@""];
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.chooesIndexPath = indexPath;
   
    LXUserTool * userTool = [[LXUserTool alloc] init];
    [userTool saveUserLiveAddress:[[[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"region_name"] cityID:[[[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"region_id"]];
    self.backView([[[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"region_name"]);
    
   [self dismissViewControllerAnimated:YES completion:NULL];
    
}


#pragma mark ---- loadData
/**
 *  请求数据的数组的懒加载
 *
 *  @param NSMutableArray 请求的数组
 *
 *  @return
 */
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

/**
 *  请求数据
 */

- (void)loadData
{
    self.titleArray = [NSMutableArray array];
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    
    NSString *str=[NSString stringWithFormat:@"%@", VisaLiveAdd];
    NSLog(@"%@", str);
    __weak LiveAddressVC * liveAddressVC = self;
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
        NSLog(@"%@", allArr);
         NSArray *abcArr = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L",@"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
        
        for (int i = 0; i < abcArr.count; i++) {
            NSMutableArray * arr = [NSMutableArray array];
            for (int j = 0; j < allArr.count; j++) {
                if ([[[allArr objectAtIndex:j] objectForKey:@"prefix"] isEqualToString:[abcArr objectAtIndex:i]]) {
                    [arr addObject:[allArr objectAtIndex:j]];
                    NSLog(@"++++++++%@", arr);
                }
            }
            if (arr.count != 0) {
                [liveAddressVC.dataArray addObject:arr];
            }
        }
        NSLog(@"\n******start*****\n%@\n*****stop*****", _dataArray);
        
        for (int i = 0; i < _dataArray.count; i++) {
            [_titleArray addObject:[[[_dataArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"prefix"]];
        }

        [liveAddressVC.liveAddressTabelView reloadData];
        
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

/**
 *  移除加载数据时的
 */
- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}




@end

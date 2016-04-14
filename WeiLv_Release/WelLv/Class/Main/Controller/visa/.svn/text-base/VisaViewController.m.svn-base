//
//  VisaViewController.m
//  WelLv
//
//  Created by lyx on 15/4/2.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "VisaViewController.h"
#import "LXTopBtnView.h"
#import "VisaCountryListTVC.h"
#import "ZFJVisaTableViewCell.h"
//#import "VisaDetailVC.h"
#import "ZFJVisaDetailVC.h"
#import "ZFJVisaModel.h"
#import "XCLoadMsg.h"

#import "ZFJVIsaListVC.h"

#import "IconAndTitleView.h"
#import "YXBannerView.h"
#import "LXGetCityIDTool.h"


#define M_Visa_ad_View_Height 150
#define M_HotVisaCountryView_Height 230

@interface VisaViewController ()<LXTopBtnViewDelegate, UITableViewDataSource, UITableViewDelegate, EScrollerViewDelegate>
{
    NavSearchView *searchView;
}
@property (nonatomic, strong) LXTopBtnView *topView;
@property (nonatomic, strong) UITableView * privilegeTableView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, strong) NSMutableArray * countryArr;

@property (nonatomic, strong) NSMutableArray * nameArray;
@property (nonatomic, strong) NSMutableArray * imageArray;

@property (nonatomic, copy) NSString *searchStr;
@property (nonatomic, strong) YXBannerView * headerView;

/*
 修改加的属性
 */
@property (nonatomic, strong) UIScrollView * visaScrollView;
@property (nonatomic, strong) UIView * hotVisaCountryView;
@property (nonatomic, strong) NSMutableArray * adArray;

@property (nonatomic, copy) NSString * cityIDStr;


@end

@implementation VisaViewController


- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"签证";
    
    self.cityIDStr = @"";
    self.cityIDStr = [[WLSingletonClass defaultWLSingleton] wlCityId];
    
    [self loadVisaAD];
    [self loadCountryData];

    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];

    self.view.backgroundColor = [UIColor whiteColor];
//    searchView = [[NavSearchView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth - 140, 25) Feature:@"搜索办签目的地"];
//    searchView.delegate = self;
//    self.navigationItem.titleView = searchView;

    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame=CGRectMake(0, 0, 23, 23);
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:searchBtn];

    
    self.privilegeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, self.view.frame.size.height - 64)];
    self.privilegeTableView.rowHeight = 95;
    self.privilegeTableView.delegate = self;
    self.privilegeTableView.dataSource = self;
    self.privilegeTableView.tableFooterView = [[UIView alloc] init];
    //[self.view addSubview:_privilegeTableView];
    
    //[self addHotView];
    
    [self addVisaScrollView];
    //[self addHotVisaCountryView];
    //[self addDoVisaWay];
    
}

//Visa+AD轮播图
- (void)addAdScrollView {
    
   
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, M_Visa_ad_View_Height)];
    headerView.backgroundColor = [UIColor clearColor];
    if (_headerView != nil)
    {
        [_headerView removeFromSuperview];
    }
    NSMutableArray * arr = [NSMutableArray array];
    for (int i = 0; i < self.adArray.count; i++) {
        LXAdvertModel * model = [self.adArray objectAtIndex:i];
        [arr addObject:[self judgeImageURL:model.src]];
    }
    _headerView = [[YXBannerView alloc] initWithFrameRect:headerView.frame ImageArray:arr];
    _headerView.delegate = self;
    [self.visaScrollView addSubview:_headerView];
}
#pragma mark ---- 点击轮播图的方法

- (void)EScrollerViewDidClicked:(NSUInteger)index {
//    if (self.adArray.count >0) {
//        LXAdvertModel *model=[_adArray objectAtIndex:index-1];
//        if ([model.link hasPrefix:@"https://"] || [model.link hasPrefix:@"http://"]) {
//            NSString *url=[model.link stringByReplacingOccurrencesOfString:@"android" withString:@"ios"];
//            DLog(@"点击了-%@",url);
//            LXSpecialViewController *specialVc=[[LXSpecialViewController alloc] init];
//            specialVc.loadUrl=url;
//            specialVc.title=model.title;
//            [self.navigationController pushViewController:specialVc animated:YES];
//        }else{
//            DLog(@"没有连接");
//        }
//    }
    if (_adArray.count >0) {
        LXAdvertModel *model=[_adArray objectAtIndex:index-1];
        NSDictionary *dic = model.gotoDic;//[LXTools dictionaryWithJsonString:model.gotoDic];
        //NSLog(@"%@",dic);
        if ([[dic objectForKey:@"type"] isEqualToString:@"list"]) {
            //跳转列表页
                ZFJVIsaListVC *visa = [[ZFJVIsaListVC alloc] init];
                visa.region_id = self.cityIDStr;
            //[[[dic objectForKey:@"d_country"] componentsSeparatedByString:@"-"] objectAtIndex:0]
                visa.country_id = [dic objectForKey:@"visa_country"];
                [self.navigationController pushViewController:visa animated:YES];
                
        }else if([[dic objectForKey:@"type"] isEqualToString:@"detail"]) {
            //跳转详情页
                ZFJVisaDetailVC *visaDtailVC = [[ZFJVisaDetailVC alloc] init];
                visaDtailVC.product_id = [dic objectForKey:@"product_id"];
                [self.navigationController pushViewController:visaDtailVC animated:YES];
                
        }else if ([[dic objectForKey:@"type"] isEqualToString:@"page"]){
            //跳转网页
            if ([[dic objectForKey:@"link"] hasPrefix:@"https://"] || [[dic objectForKey:@"link"] hasPrefix:@"http://"]) {
                NSString *url=[model.link stringByReplacingOccurrencesOfString:@"android" withString:@"ios"];
                DLog(@"点击了-%@",url);
                LXSpecialViewController *specialVc=[[LXSpecialViewController alloc] init];
                specialVc.loadUrl=url;
                specialVc.title=model.title;
                [self.navigationController pushViewController:specialVc animated:YES];
            }else{
                DLog(@"没有连接");
            }
            
        }
    }


}

/**
 *  跳转到搜索页面。
 */
-(void)searchBtnClick
{
    SearchViewController *seachVc=[[SearchViewController alloc] init];
    seachVc.searchType = 3;
    seachVc.city_id = self.cityIDStr;
    [self.navigationController pushViewController:seachVc animated:YES];
}


//
- (void)addVisaScrollView{
    self.visaScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    self.visaScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_visaScrollView];
}

//加载热门国家
- (void)addHotVisaCountryView{
    
    if (self.countryArr.count <= 4) {
        
        self.hotVisaCountryView = [[UIView alloc] initWithFrame:CGRectMake(0, M_Visa_ad_View_Height, windowContentWidth, M_HotVisaCountryView_Height - 100)];

    } else if (self.countryArr.count > 4 && self.countryArr.count <= 8){
        
        self.hotVisaCountryView = [[UIView alloc] initWithFrame:CGRectMake(0, M_Visa_ad_View_Height, windowContentWidth, M_HotVisaCountryView_Height)];

    } else if (self.countryArr.count > 8) {
        
        self.hotVisaCountryView = [[UIView alloc] initWithFrame:CGRectMake(0, M_Visa_ad_View_Height, windowContentWidth, M_HotVisaCountryView_Height + 35)];

    }
    
        
    self.hotVisaCountryView.backgroundColor = [UIColor whiteColor];
    IconAndTitleView * hotVisaIconTitleView = [[IconAndTitleView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 45) iconImageName:@"热门国家" titleLabel:@"热门国家"];
    [self.hotVisaCountryView addSubview:hotVisaIconTitleView];
    
    //
    self.nameArray = [NSMutableArray array];
    self.imageArray = [NSMutableArray array];
    long min= 0 ;
    min = MIN(8, _countryArr.count);

    for (int i = 0; i < min; i++) {
        [_imageArray addObject:[NSString stringWithFormat:@"%@/%@", WLHTTP,[[self.countryArr objectAtIndex:i]  objectForKey:@"index_thumb"]]];
        [_nameArray addObject:[[self.countryArr objectAtIndex:i] objectForKey:@"name"]];
    }
    if (self.countryArr.count <= 4) {
        
        
        IconAndTitleView * hotContry = [[IconAndTitleView alloc] initWithFrame:CGRectMake(0, 50, windowContentWidth, 90) downTitleArray:_nameArray ImageURLStrArrary:_imageArray];
        [hotContry chooseTop:^(NSInteger chooseTop) {
            ZFJVIsaListVC * visaListVC = [[ZFJVIsaListVC alloc] init];
            visaListVC.country_id =  [[_countryArr objectAtIndex:chooseTop] objectForKey:@"cat_id"];
            visaListVC.region_id = _cityIDStr;
            [self.navigationController pushViewController:visaListVC animated:YES];
            
        }];
        [self.hotVisaCountryView addSubview:hotContry];

        
      
    } else if (self.countryArr.count > 4 && self.countryArr.count <= 8){
        IconAndTitleView * hotContry = [[IconAndTitleView alloc] initWithFrame:CGRectMake(0, 50, windowContentWidth, 180) downTitleArray:_nameArray ImageURLStrArrary:_imageArray];
        hotContry.backgroundColor = [UIColor whiteColor];
        [hotContry chooseTop:^(NSInteger chooseTop) {
            
            ZFJVIsaListVC * visaListVC = [[ZFJVIsaListVC alloc] init];
            visaListVC.country_id =  [[_countryArr objectAtIndex:chooseTop] objectForKey:@"cat_id"];
            visaListVC.region_id = _cityIDStr;
            [self.navigationController pushViewController:visaListVC animated:YES];
        }];
        [self.hotVisaCountryView addSubview:hotContry];

    } else if (self.countryArr.count > 8){
        
        IconAndTitleView * hotContry = [[IconAndTitleView alloc] initWithFrame:CGRectMake(0, 50, windowContentWidth, 180) downTitleArray:_nameArray ImageURLStrArrary:_imageArray];
        hotContry.backgroundColor = [UIColor whiteColor];
        [hotContry chooseTop:^(NSInteger chooseTop) {
            
            ZFJVIsaListVC * visaListVC = [[ZFJVIsaListVC alloc] init];
            visaListVC.country_id =  [[_countryArr objectAtIndex:chooseTop] objectForKey:@"cat_id"];
            visaListVC.region_id = _cityIDStr;
            [self.navigationController pushViewController:visaListVC animated:YES];
        }];
        [self.hotVisaCountryView addSubview:hotContry];
        UIButton * moreVisaCountryBut = [UIButton buttonWithType:UIButtonTypeCustom];
        moreVisaCountryBut.backgroundColor = [UIColor whiteColor];
        moreVisaCountryBut.frame = CGRectMake(0, ViewHeight(_hotVisaCountryView) - 30, windowContentWidth, 35);
        [moreVisaCountryBut setTitle:@"查看更多" forState:UIControlStateNormal];
        moreVisaCountryBut.titleLabel.font = [UIFont systemFontOfSize:15];
        [moreVisaCountryBut setTitleColor:[UIColor colorWithRed:123 /255.0 green:174 /255.0 blue:253 / 255.0 alpha:1.0] forState:UIControlStateNormal];
        [moreVisaCountryBut addTarget:self action:@selector(goMoreVisaCountry:) forControlEvents:UIControlEventTouchUpInside];
        [self.hotVisaCountryView addSubview:moreVisaCountryBut];
    }
    
    //_topView.delegate = self;
    
    [self.hotVisaCountryView addSubview:_topView];
    
   
    [self.visaScrollView addSubview:_hotVisaCountryView];
    
    [self addDoVisaWay];
}
#pragma mark ---- 加载办签流程
//办签流程
- (void)addDoVisaWay{
    IconAndTitleView * doVisaWay = [[IconAndTitleView alloc] initWithFrame:CGRectMake(0, ViewY(_hotVisaCountryView) + ViewHeight(_hotVisaCountryView) + 20, windowContentWidth, 45) iconImageName:@"办签流程" titleLabel:@"办签流程"];
    [self.visaScrollView addSubview:doVisaWay];
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(doVisaWay), windowContentWidth, (windowContentWidth - 30) * 104 / 603 + 15)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.visaScrollView addSubview:backView];
    
    UIImageView * doVisaWayImage = [[UIImageView alloc] initWithFrame:CGRectMake(15,0, windowContentWidth - 30, (windowContentWidth - 30) * 104 / 603)];
    doVisaWayImage.backgroundColor = [UIColor whiteColor];
    doVisaWayImage.image = [UIImage imageNamed:@"流程"];
    [backView addSubview:doVisaWayImage];
    
    UIImageView * doVisaWayImageTwo = [[UIImageView alloc] initWithFrame:CGRectMake(0, ViewBelow(backView) + 10, windowContentWidth,  windowContentWidth * 126 / 750)];
    doVisaWayImageTwo.backgroundColor = [UIColor whiteColor];
    doVisaWayImageTwo.image = [UIImage imageNamed:@"底部"];
    [self.visaScrollView addSubview:doVisaWayImageTwo];
    
    self.visaScrollView.contentSize = CGSizeMake(windowContentWidth, MAX(ViewBelow(doVisaWayImageTwo) + windowContentHeight - self.view.frame.size.height,self.view.frame.size.height));
}

#pragma mark --- 查看更多
//查看更多
- (void)goMoreVisaCountry:(UIButton *)button{
    NSLog(@"查看更多");
    VisaCountryListTVC * visaCTVC = [[VisaCountryListTVC alloc] init];
    visaCTVC.cityIDStr = _cityIDStr;
    [self.navigationController pushViewController:visaCTVC animated:YES];
}

- (void)addHotView
{
    if (self.countryArr.count >= 4) {
         //self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, windowContentWidth, 240)];
    } else {
        //self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, windowContentWidth, 140)];
    }
    
    self.nameArray = [NSMutableArray array];
    self.imageArray = [NSMutableArray array];
    long min= 0 ;
    min = MIN(8, _countryArr.count);

    for (int i = 0; i < min; i++) {
        [_imageArray addObject:[NSString stringWithFormat:@"%@/%@", WLHTTP, [[self.countryArr objectAtIndex:i]  objectForKey:@"index_thumb"]]];
        [_nameArray addObject:[[self.countryArr objectAtIndex:i] objectForKey:@"name"]];
    }
    
    if (self.countryArr.count > 4) {
        self.topView=[[LXTopBtnView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 200) nameArray:_nameArray ImageArray:_imageArray];

    } else{
        self.topView=[[LXTopBtnView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 100) nameArray:_nameArray ImageArray:_imageArray];
    }
    
    _topView.delegate = self;
    [_headerView addSubview:_topView];
    
    UILabel * privilegeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.topView.frame.origin.y + self.topView.frame.size.height, 120, 40)];
    privilegeLabel.text = @"特惠签证";
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, privilegeLabel.frame.size.height - 0.5, 70, 0.5)];
    line.backgroundColor = [UIColor orangeColor];
    [privilegeLabel addSubview:line];
    [_headerView addSubview:privilegeLabel];
    
    [self.visaScrollView addSubview:self.headerView];
}


#pragma mark --LXTopBtnViewDelegate
-(void)selectBtn:(NSUInteger)index
{
    
    if ([[_nameArray objectAtIndex:index - 1] isEqualToString:@"更多"]) {
        VisaCountryListTVC * visaCTVC = [[VisaCountryListTVC alloc] init];
        [self.navigationController pushViewController:visaCTVC animated:YES];
        
    }     
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    ZFJVisaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZFJVisaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsZero;
    }

    cell.visaModel = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZFJVisaDetailVC *visaDtailVC = [[ZFJVisaDetailVC alloc] init];
    ZFJVisaModel * visaModel = [self.dataArray objectAtIndex:indexPath.row];
    //visaDtailVC.visaModel = visaModel;
    visaDtailVC.product_id = visaModel.product_id;
    [self.navigationController pushViewController:visaDtailVC animated:YES];

}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 250)];
//    NSMutableArray *nameArray=[[NSMutableArray alloc] initWithObjects:@"美国",@"法国",@"日本",@"巴西",@"越南",@"韩国",@"意大利",@"更多", nil];
//    self.topView=[[LXTopBtnView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 200) nameArray:nameArray];
//    _topView.delegate = self;
//    [headerView addSubview:self.topView];
//    UILabel * privilegeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.topView.frame.origin.y + self.topView.frame.size.height, 120, 40)];
//    privilegeLabel.text = @"特惠签证";
//    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, privilegeLabel.frame.size.height - 0.5, 70, 0.5)];
//    line.backgroundColor = [UIColor orangeColor];
//    [privilegeLabel addSubview:line];
//    [headerView addSubview:privilegeLabel];
//    
//    return headerView;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---- loadData

- (void)loadData
{
    
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];

    NSString *assistant_id=@"";
    if ([[[LXUserTool alloc] getKeeper] rangeOfString:@"null"].location!=NSNotFound) {
        assistant_id=@"0";
    }
    else
    {
        assistant_id=[[LXUserTool alloc] getKeeper];
    }

    
    
    NSString *str=[NSString stringWithFormat:@"%@?nums=7&assistant_id=%@", VisaListUrl,assistant_id];
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
        if (allArr.count == 0) {
            UIView * noView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentWidth)];
            UIImageView * noImage = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth / 5, 20, windowContentWidth *3 /5 , windowContentWidth *3 /5 )];
            noView.backgroundColor = [UIColor whiteColor];
            noImage.image = [UIImage imageNamed:@"没找到相关内容"];
            [noView addSubview:noImage];
            self.privilegeTableView.tableFooterView = noView;
        }else{
            for (NSDictionary * dic in allArr) {
                ZFJVisaModel * visaModel = [[ZFJVisaModel alloc] initWithDictionary:dic];
                [self.dataArray addObject:visaModel];
            }
        }

        NSLog(@"%ld", self.dataArray.count);
        [self.privilegeTableView reloadData];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
            [self loadData];
        }];
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];

}


- (void)loadCountryData
{
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];

    self.countryArr = [NSMutableArray array];
    NSString *str=[NSString stringWithFormat:@"%@?city_id=%@", visaCountryList, self.cityIDStr];
    NSLog(@"%@", str);
    __weak VisaViewController * visaVC = self;
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];

        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        if ([[dict objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
            visaVC.countryArr = [dict objectForKey:@"data"];
            if (visaVC.countryArr.count > 0) {
                [visaVC addHotVisaCountryView];
            } else {
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"对不起！你当前的城市没有产品，点击确认将为你获取全国的产品。" delegate:visaVC cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
                [alertView show];
            }
        }
 

        NSLog(@"\n*****获取到的数据为：*****\n%@\n*****止*****",dict);
//        NSLog(@"******\n%ld\n******", _countryArr.count);
       
        //[visaVC addHotVisaCountryView];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
            [visaVC loadCountryData];
        }];
        
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
}
//加载签证广告
- (void)loadVisaAD
{
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    ;
    self.countryArr = [NSMutableArray array];
    NSString *str=[NSString stringWithFormat:@"%@", AdvertUrl(@"85", self.cityIDStr)];
    NSLog(@"%@", str);
    __weak VisaViewController * visaVC = self;
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
       // NSLog(@"获取到的数据为：%@",dict);
        for (NSDictionary * dic in dict) {
            //[visaVC.adArray addObject:[NSString stringWithFormat:@"%@/%@", WLHTTP, [dic objectForKey:@"src"]]];
            LXAdvertModel *detailModel = [[LXAdvertModel alloc] initWithDictionary:dic];
            [visaVC.adArray addObject:detailModel];

        }
        //visaVC.adArray = [NSMutableArray arrayWithArray:dict];
        //NSLog(@"\n *********\n %ld \n*******", _adArray.count);
        [visaVC addAdScrollView];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
            [visaVC loadCountryData];
        }];
        
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //NSLog(@"%ld", buttonIndex);
    if (buttonIndex == 1) {
        self.cityIDStr = @"52";
        [self loadCountryData];
    }
}



- (NSMutableArray *)adArray {
    if (_adArray == nil) {
        self.adArray = [NSMutableArray array];
    }
    return _adArray;
}

- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}


- (void)hiddenChooesView:(UITapGestureRecognizer *)tap
{
    UILabel * aLabel = (UILabel *)[self.view viewWithTag:200];
    aLabel.hidden = YES;
    [self loadData];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    //[self.view endEditing:YES];
  
    //searchView.searchBar.editing = NO;
    [searchView.searchBar resignFirstResponder];
}

#pragma mark ----navSearchDelegate
- (void)beginSearch:(NSString *)text
{
    if (text.length != 0) {
        ZFJVIsaListVC * visaListVC = [[ZFJVIsaListVC alloc] init];
        visaListVC.searchStr = text;
        [self.navigationController pushViewController:visaListVC animated:YES];
    }
}

@end

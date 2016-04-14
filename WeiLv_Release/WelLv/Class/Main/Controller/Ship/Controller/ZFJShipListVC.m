//
//  ZFJShipListVC.m
//  WelLv
//
//  Created by 张发杰 on 15/5/18.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJShipListVC.h"
#import "ZFJShipTableViewCell.h"
#import "ZFJShipListModel.h"
#import "ZFJShipDetailVC.h"
#import "LXGetCityIDTool.h"
#import "ChooseTitleView.h"


@interface ZFJShipListVC ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UITableView * shipListTabelView;

@property (nonatomic, strong) UIView * chooseView;
@property (nonatomic, strong) UIView *chooseDetailView;
@property (nonatomic, strong) UIButton * chooesOneBut;
@property (nonatomic, strong) UIButton * chooesTwoBut;
@property (nonatomic, copy) NSString * chooseTitle;


@property (nonatomic, copy) NSString * chooesType;
@property (nonatomic, copy) NSString * sortType;

@property (nonatomic, assign) NSInteger pageInteger;
@property (nonatomic, copy) NSString * listUrlStr;

@property (nonatomic, assign) BOOL isFooterR;

@property (nonatomic, strong) UIButton * chooesBut;
@property (nonatomic, strong) UIButton * lastChooseBut;

//@property (nonatomic, strong) ChooseTitleView * chooseTitleView;
@property (nonatomic, strong) NSDictionary * chooseTypeDic;

@property (nonatomic, strong) NSMutableDictionary * loadChooseTypeDic;

@property (nonatomic, strong) NSArray *comprehensiveTitles;

@end

@implementation ZFJShipListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.chooesType = @"min_price";
    self.sortType = @"";
    
    //4.2邮轮筛选
    [self addChooseTypeDate];
    
    //设置导航标题
    if ([self judgeString:self.lineName])
    {
        self.navigationItem.title = self.lineName;
    }
    else
    {
        self.navigationItem.title = @"邮轮列表";
    }
    
    self.comprehensiveTitles = @[@"综合", @"销量", @"价格从低到高", @"价格从高到底"];
    //创建邮轮航线列表
    self.shipListTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, windowContentWidth, ControllerViewHeight)];
    self.shipListTabelView.dataSource = self;
    self.shipListTabelView.delegate = self;
    self.shipListTabelView.rowHeight = 95;
    self.shipListTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.shipListTabelView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_shipListTabelView];
    
    //调用刷新
    [self addRefreshing];
}

#pragma mark - 创建选择类型视图
- (void)addChooseTypeView
{
    
    NSArray * chooseType = [self.chooseTypeDic allKeys];
    NSMutableDictionary * dataDic = [NSMutableDictionary dictionary];
    NSMutableArray * titleArr = [NSMutableArray array];
    NSMutableArray * iconArr = [NSMutableArray array];
    NSMutableArray * chooseIconArr = [NSMutableArray array];
    
    NSMutableArray * harborIdArr = [NSMutableArray array];
    NSMutableArray * companyIdArr = [NSMutableArray array];
    
    for (int i =0; i < chooseType.count; i++)
    {
        NSArray * typeArr = [self.chooseTypeDic objectForKey:[chooseType objectAtIndex:i]];
        if (typeArr.count >0)
        {
            if ([[chooseType objectAtIndex:i] isEqualToString:@"harbor"])
            {
                NSMutableArray * harborArr = [NSMutableArray array];
                for (int i = 0; i < typeArr.count; i++) {
                    [harborArr addObject:[[typeArr objectAtIndex:i] objectForKey:@"name"]];
                    [harborIdArr addObject:[[typeArr objectAtIndex:i] objectForKey:@"id"]];
                }
                [dataDic setObject:harborArr forKey:@"出发港口"];
                [titleArr addObject:@"出发港口"];
                [iconArr addObject:@"目的地"];
                [chooseIconArr addObject:@"目的地选中"];
            }
            
            else if ([[chooseType objectAtIndex:i] isEqualToString:@"company_id"])
            {
                NSMutableArray * companyNameArr = [NSMutableArray array];
                for (int i = 0; i < typeArr.count; i++) {
                    [companyNameArr addObject:[[typeArr objectAtIndex:i] objectForKey:@"name"]];
                    [companyIdArr addObject:[[typeArr objectAtIndex:i] objectForKey:@"company_id"]];
                }
                [dataDic setObject:companyNameArr forKey:@"邮轮品牌"];
                [titleArr addObject:@"邮轮品牌"];
                [iconArr addObject:@"邮轮品牌"];
                [chooseIconArr addObject:@"邮轮品牌-选中"];
                
            }
            else if ([[chooseType objectAtIndex:i] isEqualToString:@"month"])
            {
                NSMutableArray * monthArr = [NSMutableArray array];
                NSMutableArray * monthArrTitle = [NSMutableArray array];
                
                for (int i = 0; i < typeArr.count; i++) {
                    [monthArr addObject:[NSString stringWithFormat:@"%ld", [[typeArr objectAtIndex:i] integerValue]]];
                    [monthArrTitle addObject:[NSString stringWithFormat:@"%ld月", [[typeArr objectAtIndex:i] integerValue]]];
                }
                [dataDic setObject:monthArrTitle forKey:@"出游时间"];
                [dataDic setObject:monthArr forKey:@"出游时间post"];
                [titleArr addObject:@"出游时间"];
                [iconArr addObject:@"出游时间"];
                [chooseIconArr addObject:@"出游时间-选中"];
                
            }
            else if ([[chooseType objectAtIndex:i] isEqualToString:@"schedule_days"])
            {
                NSMutableArray * daysArr = [NSMutableArray array];
                for (NSString * str in typeArr)
                {
                    [daysArr addObject:[NSString stringWithFormat:@"%@天", str]];
                }
                [dataDic setObject:typeArr forKey:@"行程天数post"];
                [dataDic setObject:daysArr forKey:@"行程天数"];
                [titleArr addObject:@"行程天数"];
                [iconArr addObject:@"行程天数"];
                [chooseIconArr addObject:@"行程天数-选中"];
                
            }
        }
    }
    
    
    
    NSDictionary * chooseDic = @{@"data": dataDic,
                                 @"titleArr": titleArr,
                                 @"icon":iconArr,
                                 @"chooseIcon":chooseIconArr};
    /*
     NSDictionary * chooseDic = @{@"data": @{@"出发港口":@[@"01", @"02", @"03", @"04"],
     @"邮轮品牌":@[@"10", @"11", @"12", @"13"],
     @"出游时间":@[@"20", @"21"],
     @"行程天数":@[@"30", @"31", @"32", @"33", @"34", @"35"]},
     @"titleArr": @[@"出发港口", @"邮轮品牌", @"出游时间", @"行程天数"],
     @"icon":@[@"目的地", @"邮轮品牌", @"出游时间", @"行程天数"],
     @"chooseIcon":@[@"目的地选中", @"邮轮品牌-选中", @"出游时间-选中", @"行程天数-选中"]};
     */
    NSDictionary * filterOneLineIconTilteDic = @{@"icon":@[@"综合", @"销量", @"从低到高", @"从高到低"],
                                                 @"chooseIcon":@[@"综合选中", @"销量选中", @"从低到高选中", @"从高到低选中"],
                                                 @"title":self.comprehensiveTitles,
                                                 @"type":@"oneLine"};
    chooseTitleView = [[ChooseTitleView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 40) withTitleArray:@[@" 综合", @"筛选"] sencondTitleArray:@[filterOneLineIconTilteDic,chooseDic]];
    
    __weak ZFJShipListVC * shipListVC = self;
    [chooseTitleView chooseSectionRow:^(NSInteger section, NSIndexPath *index) {
        
        if (section == 0)
        {     //点击综合的下拉框项触发
            [shipListVC choose:index];
        }
        else
        {
            //点击帅选的下拉框项触发
            if ([[titleArr objectAtIndex:index.section] isEqualToString:@"出发港口"])
            {
                [self.loadChooseTypeDic setObject:[harborIdArr objectAtIndex:index.row] forKey:@"harbor"];
                
            }
            else if ([[titleArr objectAtIndex:index.section] isEqualToString:@"邮轮品牌"])
            {
                [self.loadChooseTypeDic setObject:[companyIdArr objectAtIndex:index.row] forKey:@"company_id"];
                
            }
            else if ([[titleArr objectAtIndex:index.section] isEqualToString:@"出游时间"])
            {
                NSArray * arr = [dataDic objectForKey:@"出游时间post"];
                [self.loadChooseTypeDic setObject:[arr objectAtIndex:index.row] forKey:@"month"];
                
            }
            else if ([[titleArr objectAtIndex:index.section] isEqualToString:@"行程天数"])
            {
                NSArray * arr = [dataDic objectForKey:@"行程天数post"];
                [self.loadChooseTypeDic setObject:[arr objectAtIndex:index.row] forKey:@"schedule_days"];
            }
            
            self.pageInteger = 1;
            [self.shipListTabelView.gifHeader beginRefreshing];
            
        }
    }];
    [self.view addSubview:chooseTitleView];
    
}


- (NSMutableDictionary *)loadChooseTypeDic {
    if (!_loadChooseTypeDic) {
        self.loadChooseTypeDic = [NSMutableDictionary dictionary];
    }
    return _loadChooseTypeDic;
}

/**
 *  添加选择按钮
 *
 *  @return
 */

- (void)addNavChooseBut {
    UIButton * chooseBut = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseBut.frame = CGRectMake(0, 0 , ViewHeight(self.navigationController.navigationBar) - 5, ViewHeight(self.navigationController.navigationBar) - 5);
    chooseBut.backgroundColor = [UIColor whiteColor];
    [chooseBut setImage:[UIImage imageNamed:@"综合选中"] forState:UIControlStateNormal];
    [chooseBut addTarget:self action:@selector(newSort:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:chooseBut];
}

- (void)newSort:(id)send {
    
    if (!chooseTitleView) {
        chooseTitleView = [[ChooseTitleView alloc]
                           initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)
                           withIconArray:@[@[@"综合", @"综合选中"], @[@"销量", @"销量选中"], @[@"从低到高", @"从低到高选中"], @[@"从高到低", @"从高到低选中"]]
                           titleArray:@[@"综合", @"销量", @"价格从低到高", @"价格从高到底"]];
        __weak ZFJShipListVC * shipListVC = self;
        [chooseTitleView chooseIndex:^(NSIndexPath *index) {
            [shipListVC choose:index];
        }];
        [self.view addSubview:chooseTitleView];
    } else {
        if (chooseTitleView.hidden == YES) {
            chooseTitleView.hidden = NO;
        } else if (chooseTitleView.hidden == NO) {
            chooseTitleView.hidden = YES;
        }
    }
}

#pragma mark ---- Refreshing 刷新
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
    
    __weak ZFJShipListVC *shipListVC = self;
    [self.shipListTabelView addGifHeaderWithRefreshingBlock:^{
        
        [[XCLoadMsg sharedLoadMsg:shipListVC] hideAll];
        [[XCLoadMsg sharedLoadMsg:shipListVC] showActivityLoading:shipListVC.view];
        [shipListVC.dataArray removeAllObjects];
        shipListVC.pageInteger = 1;
        
        if (shipListVC.isPrivilege != YES)
        {
            [shipListVC loadData];
            shipListVC.isFooterR = NO;
            
        }
        else
        {
        }
        [shipListVC.shipListTabelView.gifHeader endRefreshing];
        [shipListVC.shipListTabelView.gifFooter endRefreshing];
        return;
    }];
    // 设置普通状态的动画图片
    [self.shipListTabelView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self.shipListTabelView.gifHeader setImages:imageAray forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self.shipListTabelView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateRefreshing];
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
    // 马上进入刷新状态
    [self.shipListTabelView.gifHeader beginRefreshing];
    
    [self.shipListTabelView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
    [self.shipListTabelView.footer endRefreshing];
    
    if ([_shipListTabelView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_shipListTabelView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([_shipListTabelView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [_shipListTabelView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}
- (void)footerRefreshing
{
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.pageInteger = self.pageInteger + 1;
        [self loadData];
        [self.shipListTabelView.footer endRefreshing];
    });
    
}

#pragma mark ---- choose 综合
- (void)choose:(NSIndexPath *)index
{
    for(id obj in chooseTitleView.subviews){
        
        if([obj isMemberOfClass:[UILabel class]]){
            
            UILabel *titleLabel = (UILabel *)obj;
            
            if(titleLabel.tag == 100){
                
                titleLabel.text = [self.comprehensiveTitles objectAtIndex:index.row];
            }
        }
    }
    
    if (index.row == 0)
    {
        //综合
        self.chooesType = @"";
        self.sortType = @"";
    }
    else if (index.row == 1)
    {
        //销量
        self.chooesType = @"sell_count";
        self.sortType = @"desc";
    }
    else if (index.row == 2)
    {
        //价格从低到高
        self.chooesType = @"min_price";
        self.sortType = @"asc";
    }
    else if (index.row == 3)
    {
        //价格从高到底
        self.chooesType = @"min_price";
        self.sortType = @"desc";
    }
    self.pageInteger = 1;
    [self.shipListTabelView.gifHeader beginRefreshing];
}

#pragma mark ---- TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"Cell";
    ZFJShipTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZFJShipTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier customStry:ZFJShipTableViewCellStyleThree];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (self.dataArray.count != 0) {
        cell.shipListModel = [self.dataArray objectAtIndex:indexPath.row];
        
    }
    
    return cell;
}
#pragma mark ---- TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZFJShipDetailVC * detailVC = [[ZFJShipDetailVC alloc] init];
    ZFJShipListModel * shipListModel = [self.dataArray objectAtIndex:indexPath.row];
    detailVC.product_id = shipListModel.product_id;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

#pragma mark ---- loadData
//加载邮轮航线
- (void)loadData{
    
    NSString *assistant_id=@"";
    if ([[[LXUserTool alloc] getKeeper] rangeOfString:@"null"].location!=NSNotFound) {
        assistant_id=@"0";
    }
    else
    {
        assistant_id=[[LXUserTool alloc] getKeeper];
    }

    
    NSString * str = [NSString stringWithFormat:@"%@?city_id=%@&line=%@&keyword=%@&sort=%@&dir=%@&page=%@&pagesize=10&assistant_id=%@", M_URL_SHIP_LIST, [[WLSingletonClass defaultWLSingleton] wlCityId] , self.line_id, self.keywoerd, self.chooesType, self.sortType, [NSString stringWithFormat:@"%ld", self.pageInteger],assistant_id];
    
    if ([self.loadChooseTypeDic allKeys].count >0) {
        for (int i = 0; i < [self.loadChooseTypeDic allKeys].count; i++) {
            NSString * keyStr = [[self.loadChooseTypeDic allKeys] objectAtIndex:i];
            NSString * valueStr = [self.loadChooseTypeDic objectForKey:keyStr];
            str = [NSString stringWithFormat:@"%@&%@=%@",str, keyStr, valueStr];
        }
    }
    
    NSLog(@"%@", str);
    
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        
        NSInteger dataCount = self.dataArray.count;
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        
        if ([dict isKindOfClass:[NSDictionary class]] && [[dict objectForKey:@"status"] integerValue] == 1) {
            if ([[dict objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in [dict objectForKey:@"data"]) {
                    ZFJShipListModel * model = [[ZFJShipListModel alloc] initWithDictionary:dic];
                    [self.dataArray addObject:model];
                }
                if (self.dataArray.count == dataCount) {
                    [[LXAlterView sharedMyTools] createTishi:@"暂无数据"];
                }
            } else {
                [[LXAlterView sharedMyTools] createTishi:@"暂无数据"];
            }
        }else{
            //航线筛选列表，没有数据时弹出的提示框
            [[LXAlterView sharedMyTools] createTishi:@"对不起，没有搜索到相关内容"];
        }
        
        [self.shipListTabelView reloadData];
        
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

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.chooseDetailView.hidden = YES;
    
}

#pragma mark - 记载筛选类型的数据
- (void)addChooseTypeDate
{
    NSString * str = M_URL_SHIP_LIST_FILTER;
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __weak ZFJShipListVC * listVC = self;
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
         NSString *html = operation.responseString;
         NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
         id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
         if ([[dict objectForKey:@"status"] integerValue] == 1)
         {
             //NSLog(@"获取到的数据为：%@",dict);
             listVC.chooseTypeDic = [dict objectForKey:@"data"];
         }
         //创建选择类型视图
         [listVC addChooseTypeView];
     }failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"发生错误！%@",error);
         [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
         [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
         [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
             [listVC addChooseTypeDate];
         }];
     }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
}



@end

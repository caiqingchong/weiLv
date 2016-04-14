//
//  ZFJTicketListVC.m
//  WelLv
//
//  Created by 张发杰 on 15/8/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJTicketListVC.h"
#import "ChooseTitleView.h"
#import "ZFJTicketListCell.h"
#import "ZFJTicketDetailVC.h"
#import "TicketListModel.h"

@interface ZFJTicketListVC ()<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) ChooseTitleView * chooseTitleView;

@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, assign) NSInteger numbers;
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, copy) NSString * sortBy;
@property (nonatomic, copy) NSString * sortStr;
@property (nonatomic, strong) MBProgressHUD * hud;

@end

@implementation ZFJTicketListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"门票列表";
    self.view.backgroundColor = [UIColor whiteColor];
    self.sortBy = @"";
    self.sortStr = @"";
    
    [self addChooseItem];
    
    [self addCustomTableView];
    
    [self addRefreshing];

}

#pragma mark ---- 加载视图
/**
 *  加载tableView
 */
- (void)addCustomTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 90;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];

}

/**
 *  加载筛选按钮
 */
- (void)addChooseItem {
    UIButton * chooseBut = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseBut.frame = CGRectMake(0, 0 , ViewHeight(self.navigationController.navigationBar) - 5, ViewHeight(self.navigationController.navigationBar) - 5);
    chooseBut.backgroundColor = [UIColor whiteColor];
    [chooseBut setImage:[UIImage imageNamed:@"综合选中"] forState:UIControlStateNormal];
    [chooseBut addTarget:self action:@selector(addChooseView:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:chooseBut];

}
/**
 *  加载筛选视图
 *
 *  @param send 按钮
 */
- (void)addChooseView:(id)send {
    
    if (!self.chooseTitleView) {
        self.chooseTitleView = [[ChooseTitleView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight) withIconArray:@[@[@"综合", @"综合选中"],@[@"从低到高", @"从低到高选中"], @[@"从高到低", @"从高到低选中"]] titleArray:@[@"综合",@"价格从低到高", @"价格从高到底"]];
        __weak ZFJTicketListVC * listVC = self;
        [self.chooseTitleView chooseIndex:^(NSIndexPath *index) {
            [listVC nowSort:index];
        }];
        [self.view addSubview:self.chooseTitleView];
    } else {
        if (self.chooseTitleView.hidden == YES) {
            self.chooseTitleView.hidden = NO;
        } else if (self.chooseTitleView.hidden == NO) {
            self.chooseTitleView.hidden = YES;
        }
    }
}
/**
 *  排序条件
 *
 *  @param index 点击的位置
 */
- (void)nowSort:(NSIndexPath *)index{
    if (index.row == 0) {
        self.sortBy = @"";
        self.sortStr = @"";
    } else if (index.row == 1) {
        self.sortBy = @"start_price";
        self.sortStr = @"ASC";
    } else if (index.row == 2) {
        self.sortBy = @"start_price";
        self.sortStr = @"DESC";

    }
    self.numbers = 10;
    [self.tableView.gifHeader beginRefreshing];
}

/**
 *   加载刷新控件
 */
- (void)addRefreshing {
    NSMutableArray *imageAray=[NSMutableArray array];
    for (int i=0; i<2; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"单独-logo%d.png", i+2]];
        [imageAray addObject:image];
    }
    //-----------下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    
    __weak ZFJTicketListVC * listVC = self;
    [self.tableView addGifHeaderWithRefreshingBlock:^{
        [[XCLoadMsg sharedLoadMsg:listVC] hideAll];
        [[XCLoadMsg sharedLoadMsg:listVC] showActivityLoading:listVC.view];
        [listVC setProgressHud];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [listVC.dataArray removeAllObjects];
            listVC.pageCount = 1;
            listVC.numbers = 10;
            [listVC loadData];
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
        [[XCLoadMsg sharedLoadMsg:listVC] hideAll];
        [[XCLoadMsg sharedLoadMsg:listVC] showActivityLoading:listVC.view];
        [listVC setProgressHud];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            if (listVC.dataArray.count < listVC.numbers) {
//                [[LXAlterView sharedMyTools] createTishi:@"暂无数据"];
//            }
            //[listVC.dataArray removeAllObjects];
            listVC.pageCount = listVC.pageCount + 1;
            listVC.numbers = 10;
            [listVC loadData];
            [listVC.tableView.footer endRefreshing];
        });
        
    }];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }

}

#pragma mark ---- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"listCell";
    ZFJTicketListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[ZFJTicketListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsZero;
    }
    //NSLog(@"%@", self.dataArray);
    cell.model = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZFJTicketDetailVC * detailVC = [[ZFJTicketDetailVC alloc] init];
    TicketListModel * model = [self.dataArray objectAtIndex:indexPath.row];
    detailVC.product_id = model.product_id;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


#pragma mark ---- 加载数据
/**
 *  加载门票列表数据
 */
- (void)loadData {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //page
    //@"nums":[NSString stringWithFormat:@"%ld", self.numbers]

    NSString *assistant_id=@"";
    if ([[[LXUserTool alloc] getKeeper] rangeOfString:@"null"].location!=NSNotFound)
    {
        assistant_id=@"0";
    }
    else
    {
        assistant_id=[[LXUserTool alloc] getKeeper];
    }
    
    
    NSDictionary * parameters = nil;
    if ([self.keyStr isEqualToString:@"placecity"])
    {
        if (self.isCity)
        {
            //热门城市调用
            parameters = @{self.keyStr:self.valueStr, @"page":[NSString stringWithFormat:@"%ld", self.pageCount], @"sort":self.sortStr, @"by":self.sortBy,@"assistant_id":assistant_id};
        }
        else
        {
            //周边景点调用
            parameters = @{self.keyStr:self.valueStr, @"page":[NSString stringWithFormat:@"%ld", self.pageCount], @"sort":self.sortStr, @"by":self.sortBy, @"placearea":@"1",@"assistant_id":assistant_id};
        }
    }
    else
    {
        if (self.searchStr)
        {
            //搜索
            parameters = @{@"page":[NSString stringWithFormat:@"%ld", self.pageCount], @"sort":self.sortStr,@"by":self.sortBy,  @"productname":self.searchStr,@"assistant_id":assistant_id};

        }
        else
        {
            if ([self.keyStr isEqualToString:@"producttheme"])
            {
                //主题
                parameters = @{@"placecity":[[WLSingletonClass defaultWLSingleton] wlCityName], self.keyStr:self.valueStr, @"page":[NSString stringWithFormat:@"%ld", self.pageCount], @"sort":self.sortStr, @"by":self.sortBy,@"assistant_id":assistant_id};

            }
            else
            {
                //产品推荐
                parameters = @{@"placeprovince":self.provinceStr, self.keyStr:self.valueStr, @"page":[NSString stringWithFormat:@"%ld", self.pageCount], @"sort":self.sortStr, @"by":self.sortBy,@"assistant_id":assistant_id};
            }

        }

    }
    //NSLog(@"****\n%@\n****\n%@\n****", parameters, self.valueStr);
    
    //接口
    NSString *url= M_TICKET_LIST_URL;
    //发送请求
    __weak ZFJTicketListVC * listVC = self;
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"JSON: %@",  dic);
        [_hud hide:YES];

        [[XCLoadMsg sharedLoadMsg:listVC] hideActivityLoading];
        if ([[dic objectForKey:@"data"] isKindOfClass:[NSArray class]])
        {
            for (NSDictionary * dict in [dic objectForKey:@"data"])
            {
                TicketListModel * model = [[TicketListModel alloc] initWithDictionary:dict];
                if ([self judgeString:model.start_price])
                {
                    if (![model.start_price isEqualToString:@"0"])
                    {
                        [self.dataArray addObject:model];
                    }
                }
            }
            [listVC.tableView reloadData];
            [listVC.tableView.header endRefreshing];
        }
        else
        {
            [[LXAlterView sharedMyTools] createTishi:@"暂无数据"];
            [listVC.tableView.header endRefreshing];

        }
        if (_tableView.contentSize.height < ControllerViewHeight)
        {
            [_tableView removeFooter];
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
        NSLog(@"ERROR: %@", error);
        [_hud hide:YES];

        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
            [listVC loadData];
        }];

    }];

}

- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
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

//懒加载
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end

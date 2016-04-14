//
//  WLSteServeListVC.m
//  WelLv
//
//  Created by zhangjie on 15/12/6.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "WLSteServeListVC.h"
#import "ZFJSteShopOrderCell.h"
#import "ZFJFilterDetailView.h"

@interface WLSteServeListVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIImageView * iconChoose;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) WLProductType productType;
@property (nonatomic, strong) ZFJFilterDetailView * filterDetailView;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, copy) NSString *categoryIdStr;
@property (nonatomic, assign) NSInteger offsetNum;

@end

@implementation WLSteServeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"服务记录";
    [self addChooseNaviTitle];
    [self createTableView];
}

#pragma mark - UITableView
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 120;
    self.tableView.backgroundColor = M_MIAN_BG_COLOR;
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = M_MIAN_BG_COLOR;
    self.tableView.tableFooterView = view;
    [self.view addSubview:_tableView];
}

#pragma mark - 筛选
- (void)addChooseNaviTitle {
    UILabel * chooseLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [self returnTextCGRectText:@"推荐产品" textFont:17 cGSize:CGSizeMake(0, 45)].size.width + 20, 45)];
    chooseLab.text = @"服务记录";
    chooseLab.userInteractionEnabled = YES;
    self.iconChoose = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(chooseLab) - 20 + 7.5, (self.navigationController.navigationBar.frame.size.height - 5) / 2, 5, 5)];
    _iconChoose.image = [UIImage imageNamed:@"矩形-3-副本-2"];
    _iconChoose.transform = CGAffineTransformMakeRotation(M_PI_4);
    [chooseLab addSubview:_iconChoose];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseNaviTitle:)];
    [chooseLab addGestureRecognizer:tap];
    self.navigationItem.titleView = chooseLab;
    
}

#pragma mark --- NaviTitle

//点击NaviTitle
- (void)chooseNaviTitle:(UITapGestureRecognizer *)tap {
    [self changeFilterViewColor];
    if (self.filterDetailView == nil) {
        self.filterDetailView = [[ZFJFilterDetailView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight) style:ZFJFilterDetailStyleOneListFlagNoChangeColor];
        self.filterDetailView.titleArr = @[@"全部", @"旅游度假", @"邮轮", @"游学"];
        [self.view addSubview:_filterDetailView];
        
    } else {
        self.filterDetailView.hidden = !self.filterDetailView.hidden;
    }
    WS(weakSelf);
    [self.filterDetailView selectFilterViewIndexPath:^(NSIndexPath *indexPath) {
        [weakSelf changeFilterViewColor];
        
        switch (indexPath.row) {
            case 0:
            {
                self.productType = WLProductTypeTravel;
                self.categoryIdStr = @"5";//旅游
            }
                break;
            case 1:
            {
                self.productType = WLProductTypeShip;
                self.categoryIdStr = @"3";//邮轮
                
            }
                break;
            case 2:
            {
                self.productType = WLProductTypeStudyTour;
                self.categoryIdStr = @"-2";//游学
                
            }
                break;
            case 3:
            {
                self.categoryIdStr = @"";
                
            }
                break;
            case 4:
            {
                self.categoryIdStr = @"";
                
            }
                break;
                
            default:
                break;
        }
        [self addRefreshing];
        
    }];
    [self.filterDetailView selectHiddenView:^(UIView *view) {
        [weakSelf changeFilterViewColor];
    }];
    
}

//改变NaviTitleFlag
- (void)changeFilterViewColor {
    [_iconChoose.image isEqual:[UIImage imageNamed:@"矩形-3-副本-2"]] ? (_iconChoose.image = [UIImage imageNamed:@"矩形-3"]) : (_iconChoose.image = [UIImage imageNamed:@"矩形-3-副本-2"]);
}


#pragma mark - 刷新
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
    
    WS(weakSelf);
    [self.tableView addGifHeaderWithRefreshingBlock:^{
        [[XCLoadMsg sharedLoadMsg:weakSelf] hideAll];
        [[XCLoadMsg sharedLoadMsg:weakSelf] showActivityLoading:weakSelf.view];
        //[weakSelf setProgressHud];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.dataArr removeAllObjects];
            weakSelf.offsetNum = 1;
            [weakSelf loadData];
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
        [[XCLoadMsg sharedLoadMsg:weakSelf] hideAll];
        [[XCLoadMsg sharedLoadMsg:weakSelf] showActivityLoading:weakSelf.view];
        //[weakSelf setProgressHud];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (weakSelf.dataArr.count < weakSelf.offsetNum * 10) {
                [[LXAlterView sharedMyTools] createTishi:@"暂无数据"];
                [weakSelf.tableView.footer endRefreshing];
                [[XCLoadMsg sharedLoadMsg:weakSelf] hideActivityLoading];
                return;
            }
            weakSelf.offsetNum = weakSelf.offsetNum + 1;
            //weakSelf.numbers = 10;
            [weakSelf loadData];
            [weakSelf.tableView.footer endRefreshing];
        });
        
    }];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"cell";
    ZFJSteShopOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZFJSteShopOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

#pragma mark - UITableViewDelagate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - loadData

- (void)loadData {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

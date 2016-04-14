//
//  ZFJSteShopShipDistDetailVC.m
//  WelLv
//
//  Created by WeiLv on 15/11/4.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJSteShopShipDistDetailVC.h"
#import "ZFJSteShopListShipModel.h"
#import "ZFJSSDistributionShipCell.h"
#import "ZFJSSShipRoomModel.h"
#import "ZFJSteShopDistributionTravelView.h"

@interface ZFJSteShopShipDistDetailVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArr;
@end

@implementation ZFJSteShopShipDistDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self customTravelView];
    [self loadData];
}

- (void)customTravelView {
    CGFloat tittleHeight = [self returnTextCGRectText:self.modelShip.product_name textFont:17 cGSize:CGSizeMake(windowContentWidth - 20, 0)].size.height;

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight)];
    self.tableView.contentInset = UIEdgeInsetsMake(50 + tittleHeight , 0, 0, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.rowHeight = 135;
    [self.view addSubview:_tableView];
    
    UIView * headerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, -(50 + tittleHeight), windowContentWidth, 50 + tittleHeight)];
    headerBgView.backgroundColor = kColor(240, 246, 251);
    [self.tableView addSubview:headerBgView];
    UIView * titleBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, windowContentWidth, tittleHeight + 10)];
    titleBgView.backgroundColor = [UIColor whiteColor];
    [headerBgView addSubview:titleBgView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, windowContentWidth - 20, tittleHeight + 10)];
    _titleLabel.backgroundColor = [UIColor whiteColor];
    _titleLabel.numberOfLines = 0;
    _titleLabel.text = [self judgeReturnString:self.modelShip.product_name withReplaceString:@""];
    [headerBgView addSubview:_titleLabel];
    
}
#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"Cell";
    ZFJSSDistributionShipCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZFJSSDistributionShipCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    ZFJSSShipRoomModel * model = [self.dataArr objectAtIndex:indexPath.row];
    cell.modelShipRoom = model;
    //cell.view.distributionLab.text = [self judgeReturnString:model.reward withReplaceString:@"0.00"];
    cell.view.distributionLab.userInteractionEnabled = NO;
    return cell;
}

/**
 *  加载邮轮船舱数据
 */
- (void)loadData {
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //[self setProgressHud];
    NSDictionary *parameters = @{@"product_id":self.modelShip.product_id,@"assistant_id":[[LXUserTool alloc] getKeeper]};
    NSLog(@"parameters = %@", parameters);
    //接口
    NSString *url= M_SS_URL_SHIP_ROOMS;
    
    //发送请求
    __weak ZFJSteShopShipDistDetailVC * weakSelf = self;
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@",  dic);
        if ([dic isKindOfClass:[NSDictionary class]] && [[dic objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary * roomDic in [dic objectForKey:@"data"]) {
                ZFJSSShipRoomModel * model = [[ZFJSSShipRoomModel alloc] initWithDictionary:roomDic];
                [weakSelf.dataArr addObject:model];
             }
            [weakSelf.tableView reloadData];
            [[XCLoadMsg sharedLoadMsg:weakSelf] hideActivityLoading];

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR: %@", error);
        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
            [weakSelf loadData];
        }];
        
    }];
    
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}
@end

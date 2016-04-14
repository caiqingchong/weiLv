//
//  ZFJDEStoreOrderDetailsVC.m
//  WelLv
//
//  Created by WeiLv on 15/11/10.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJDEStoreOrderDetailsVC.h"
#import "ZFJDEOrderDetailCell.h"
#import "ZFJDEOrderDetailModel.h"
#import "ZFJDatePickerView.h"

#define M_CELL_HEIGHT 50

@interface ZFJDEStoreOrderDetailsVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UIView * orderDealWithView;
@property (nonatomic, copy) NSArray * orderDealWithTitleArr;
@property (nonatomic, strong) NSMutableDictionary * dataDic;
@property (nonatomic, strong) ZFJDEOrderDetailModel * modelOrderDetail;
@property (nonatomic, strong) ZFJDatePickerView * datePickerView;
@property (nonatomic, strong) UIView * blurView;
@property (nonatomic, copy) NSString * timeStr;
@end

@implementation ZFJDEStoreOrderDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单详情";
    self.view.backgroundColor = BgViewColor;
    if ([self.order_status isEqualToString:@"0"]) {
        self.orderDealWithTitleArr = @[@"接单", @"拒单"];

    } else if ([self.order_status isEqualToString:@"1"]) {
        self.orderDealWithTitleArr = @[@"销单", @"延期"];
    } else {
        self.orderDealWithTitleArr = @[];
    }
    [self addCusetmTableView];
    [self loadData];
}

#pragma mark --- 加载UITableView
- (void)addCusetmTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = BgViewColor;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = M_CELL_HEIGHT;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark --- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return self.dataArr.count;
        }
            break;
        case 1:
        {
            return 1;
        }
            break;
        case 2:
        {
            return 4;
        }
            break;
        case 3:
        {
            return 2;
        }
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"cell_type_one";
    ZFJDEOrderDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZFJDEOrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    switch (indexPath.section) {
        case 0:
        {
            cell.orderStyle = ZFJDEOrderStyleIconTitleCountPrice;
            ZFJDEOrderDetailProductModel * model = [self.dataArr objectAtIndex:indexPath.row];
            cell.titleLab.text = [self judgeReturnString:model.describe withReplaceString:@""];
            cell.msgLab.text = [NSString stringWithFormat:@"￥%@", [self judgeReturnString:model.price withReplaceString:@""]];
            cell.countLab.text = [self judgeReturnString:model.nums withReplaceString:@"0"];
        }
            break;
        case 1:
        {
            cell.orderStyle = ZFJDEOrderStyleTitlePrice;
            cell.titleLab.text = @"合计";
            cell.msgLab.text = [NSString stringWithFormat:@"￥%@", [self judgeReturnString:self.modelOrderDetail.price withReplaceString:@"0.00"]];
        }
            break;
        case 2:
        {
            if (indexPath.row == 3) {
                cell.orderStyle = ZFJDEOrderStyleTitleMsg;
                cell.titleLab.text = @"备注";
                cell.msgStr = [self judgeReturnString:self.modelOrderDetail.mark withReplaceString:@"无"];
            } else {
                cell.orderStyle = ZFJDEOrderStyleTitleOneMsg;
                NSArray * titleArr = @[@"就餐时间", @"就餐人数", @"就餐要求"];
                NSString * needRoom = @"无";
                if ([self.modelOrderDetail.is_room integerValue] == 1) {
                    needRoom = @"包间";
                }
                NSArray * msgArr = @[[[WLSingletonClass defaultWLSingleton] wlTimeYYYY_MM_dd_hh_mmWith1970Str:self.modelOrderDetail.come_time], [self judgeReturnString:self.modelOrderDetail.nums withReplaceString:@"0"], needRoom];
                cell.titleLab.text = titleArr[indexPath.row];
                cell.msgLab.text = msgArr[indexPath.row];
                
            }
        }
            break;
        case 3:
        {
            if (indexPath.row == 0) {
                cell.orderStyle =  ZFJDEOrderStyleTitleOneMsg;
                cell.titleLab.text = @"联系人";
                cell.msgLab.text = [self judgeReturnString:self.modelOrderDetail.contacts withReplaceString:@""];
            } else {
                cell.orderStyle = ZFJDEOrderStyleTitleIconMsg;
                cell.titleLab.text = @"手机号";
                cell.msgLab.text = [self judgeReturnString:self.modelOrderDetail.phone withReplaceString:@""];
            }
        }
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark --- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row == 3) {
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        return cell.frame.size.height;
    }
    return M_CELL_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3 && self.orderDealWithTitleArr.count > 0) {
        return 75.f;
    }
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 3 && self.orderDealWithTitleArr.count > 0) {
        return self.orderDealWithView;
    }
    return nil;
}

#pragma mark --- 懒加载

- (UIView *)orderDealWithView {
    if (!_orderDealWithView) {
        self.orderDealWithView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 75)];
        //NSArray * titleArr = @[@"接单", @"拒单"];
        NSArray * colorArr = @[TimeGreenColor, M_MIAN_RED_CORLOR];
        for (int i = 0; i < self.orderDealWithTitleArr.count; i++) {
            UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
            but.frame = CGRectMake(20 + 20 * i + ((windowContentWidth - 20 * 3) / 2) * i, 15, (windowContentWidth - 20 * 3) / 2, 45);
            but.layer.cornerRadius = 5.f;
            but.layer.masksToBounds = YES;
            [but setTitle:self.orderDealWithTitleArr[i] forState:UIControlStateNormal];
            [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            but.backgroundColor = colorArr[i];
            [but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];

            [self.orderDealWithView addSubview:but];
        }
    }
    return _orderDealWithView;
}

- (NSMutableDictionary *)dataDic {
    if (!_dataDic) {
        self.dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

#pragma mark --- button点击方法

- (void)clickBut:(UIButton *)button {
    if ([button.titleLabel.text isEqualToString:@"接单"]) {
        [self orderReceiving:button];
    } else if ([button.titleLabel.text isEqualToString:@"拒单"]) {
        [self orderRejecting:button];
    } else if ([button.titleLabel.text isEqualToString:@"延期"]) {
        //[self orderPostpone:button];
        CGFloat height = (windowContentWidth * 200 / 320.0 + 45);
        if (!self.datePickerView) {
            
            self.blurView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight)];
            self.blurView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
            [self.view addSubview:_blurView];

            self.datePickerView = [[ZFJDatePickerView alloc] initWithFrame:CGRectMake(0, ControllerViewHeight - height, windowContentWidth, height) style:ZFJDatePickerViewStyleYMDhm];
            [self.view addSubview:self.datePickerView];
            NSInteger year = [[[WLSingletonClass defaultWLSingleton] wlNowTimeFormatterStr:@"YYYY"] integerValue];
            NSInteger month = [[[WLSingletonClass defaultWLSingleton] wlNowTimeFormatterStr:@"MM"] integerValue];
            NSInteger day = [[[WLSingletonClass defaultWLSingleton] wlNowTimeFormatterStr:@"DD"] integerValue];
            NSInteger hour = [[[WLSingletonClass defaultWLSingleton] wlNowTimeFormatterStr:@"hh"] integerValue];
            
            [self.datePickerView.pickView selectRow:(year - 2015) inComponent:0 animated:YES];
            [self.datePickerView.pickView selectRow:(month - 1) inComponent:1 animated:YES];
            [self.datePickerView.pickView selectRow:(day - 1) inComponent:2 animated:YES];
            [self.datePickerView.pickView selectRow:hour inComponent:3 animated:YES];
            
            WS(weakSelf);
           [self.datePickerView chooseConfirmBut:^(NSString *dateStr) {
               weakSelf.blurView.hidden = YES;
               NSLog(@"%@", dateStr);
               weakSelf.timeStr = dateStr;
               [weakSelf orderPostpone:button];
           }];
            [self.datePickerView chooseCancelBut:^(UIButton *but) {
                weakSelf.blurView.hidden = YES;

            }];
            
        } else {
            self.datePickerView.hidden = !self.datePickerView.hidden;
            self.blurView.hidden = self.datePickerView.hidden;

        }
        
    } else if ([button.titleLabel.text isEqualToString:@"销单"]) {
        NSLog(@"销单");
        [self orderRejecting:button];
    }
}

//接单
- (void)orderReceiving:(UIButton *)sender {
    NSLog(@"接单");
    NSString *url = M_URL_DE_ORDER_RECEIVING;
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString *member_Id = [[WLSingletonClass defaultWLSingleton] wlUserID];
    
    NSDictionary * dataJsonDic = @{@"order_id":self.orderIDStr,
                                   @"model_id":[[WLSingletonClass defaultWLSingleton] wlProductTypeCatId:WLProductTypeDriveEat],
                                   @"operation_type":@"provider"};
    NSString *token1 = [token stringByAppendingString:member_Id];
    NSDictionary *parameters = @{@"member_id":member_Id,
                                 @"wltoken":[WXUtil md5:token1],
                                 @"datajson":[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:dataJsonDic]};
    NSLog(@"%@", parameters);
    WS(weakSelf);
    AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
    zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [zxdManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dict[@"msg"]);
        NSLog(@"%@", dict);
        if ([dict isKindOfClass:[NSDictionary class]] && [[dict objectForKey:@"state"] integerValue] == 1) {
            [[LXAlterView sharedMyTools] createTishi:@"设置成功！"];
            weakSelf.orderDealWithTitleArr = @[];
            [weakSelf.tableView reloadData];
            [weakSelf dismissView];

        } else {
            [[LXAlterView sharedMyTools] createTishi:dict[@"msg"]];

        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR: %@", error);
        [[LXAlterView sharedMyTools] createTishi:@"设置失败,请重试!"];
    }];

}

//拒单
- (void)orderRejecting:(UIButton *)sender {
    NSLog(@"拒单");
    NSString *url = M_URL_DE_ORDER_REJECYING;
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString *member_Id = [[WLSingletonClass defaultWLSingleton] wlUserID];
    
    NSDictionary * dataJsonDic = @{@"order_id":self.orderIDStr,
                                   @"model_id":[[WLSingletonClass defaultWLSingleton] wlProductTypeCatId:WLProductTypeDriveEat],
                                   @"operation_type":@"provider"};

    NSString *token1 = [token stringByAppendingString:member_Id];
    NSDictionary *parameters = @{@"member_id":member_Id,
                                 @"wltoken":[WXUtil md5:token1],
                                 @"datajson":[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:dataJsonDic]};
    NSLog(@"%@", parameters);
    WS(weakSelf);
    AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
    zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [zxdManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dict[@"msg"]);
        NSLog(@"%@", dict);
        if ([dict isKindOfClass:[NSDictionary class]] && [[dict objectForKey:@"state"] integerValue] == 1 ) {
            [[LXAlterView sharedMyTools] createTishi:@"设置成功！"];
            weakSelf.orderDealWithTitleArr = @[];
            [weakSelf.tableView reloadData];
            [weakSelf dismissView];

        } else {
            [[LXAlterView sharedMyTools] createTishi:@"设置失败,请重试!"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR: %@", error);
        [[LXAlterView sharedMyTools] createTishi:@"设置失败,请重试!"];
    }];

}

//延期
- (void)orderPostpone:(UIButton *)sender {
    NSLog(@"延期");
    NSString *url = M_URL_DE_ORDER_POSTPONE;
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString *member_Id = [[WLSingletonClass defaultWLSingleton] wlUserID];
    
    NSDictionary * dataJsonDic = @{@"order_id":self.orderIDStr,
                                   @"model_id":[[WLSingletonClass defaultWLSingleton] wlProductTypeCatId:WLProductTypeDriveEat],
                                   @"operation_type":@"provider",
                                   @"apply_time":self.timeStr};

    NSString *token1 = [token stringByAppendingString:member_Id];
    NSDictionary *parameters = @{@"member_id":member_Id,
                                 @"wltoken":[WXUtil md5:token1],
                                 @"datajson":[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:dataJsonDic]};
    NSLog(@"%@", parameters);
    WS(weakSelf);
    AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
    zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [zxdManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dict[@"msg"]);
        NSLog(@"%@", dict);
        if ([dict isKindOfClass:[NSDictionary class]] && [[dict objectForKey:@"state"] integerValue] == 1) {
            [[LXAlterView sharedMyTools] createTishi:@"设置成功！"];
            weakSelf.orderDealWithTitleArr = @[];
            [weakSelf.tableView reloadData];
            [weakSelf dismissView];
            } else {
            [[LXAlterView sharedMyTools] createTishi:@"设置失败,请重试!"];

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[LXAlterView sharedMyTools] createTishi:@"设置失败,请重试!"];
    }];
}

#pragma mark - 返回上一页
- (void)dismissView {
    [self.navigationController popViewControllerAnimated:YES];
    if(self.backLastView) {
        self.backLastView(@"");
    }
}

#pragma mark --- 数据加载

- (void)loadData {
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    NSString *url = M_URL_DE_ORDER_DETAIL;
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString *member_Id = [[WLSingletonClass defaultWLSingleton] wlUserID];

    NSDictionary * dataJsonDic = @{@"order_id":self.orderIDStr,
                                   @"model_id":[[WLSingletonClass defaultWLSingleton] wlProductTypeCatId:WLProductTypeDriveEat],
                                   @"where_field":@"driving_order_id"};
    NSString *token1 = [token stringByAppendingString:member_Id];
    NSDictionary *parameters = @{@"member_id":member_Id,
                                 @"wltoken":[WXUtil md5:token1],
                                 @"datajson":[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:dataJsonDic]};
    NSLog(@"%@", parameters);
    WS(weakSelf);
    AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
    zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [zxdManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dict[@"msg"]);
        NSLog(@"%@", dict);
        [[XCLoadMsg sharedLoadMsg:self] hideAll];
        if ([dict isKindOfClass:[NSDictionary class]] && [[dict objectForKey:@"state"] integerValue] == 1 && [[dict objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
            //weakSelf.dataDic = [NSMutableDictionary dictionaryWithDictionary:[dict objectForKey:@"data"]];
            weakSelf.modelOrderDetail = [[ZFJDEOrderDetailModel alloc] initWithDictionary:[dict objectForKey:@"data"]];
            if ([[[dict objectForKey:@"data"] objectForKey:@"products"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * productDic in [[dict objectForKey:@"data"] objectForKey:@"products"]) {
                    ZFJDEOrderDetailProductModel * productModel = [[ZFJDEOrderDetailProductModel alloc] initWithDictionary:productDic];
                    [weakSelf.dataArr addObject:productModel];
                }
            }
            [weakSelf.tableView reloadData];
        } else {
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR: %@", error);
        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
        [[XCLoadMsg sharedLoadMsg:weakSelf] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:weakSelf] showErrorMsgInView:weakSelf.view evn:^{
            [weakSelf loadData];
        }];
    }];

}

- (void)dealloc {
    [XCLoadMsg removeLoadMsg:self];
}

@end

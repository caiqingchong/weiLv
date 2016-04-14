//
//  ZFJSteShopMoneyDetailVC.m
//  WelLv
//
//  Created by WeiLv on 15/10/23.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJSteShopMoneyDetailVC.h"
#import "ZFJSteShopMoneyDetailCell.h"
#import "ZFJWithdrawDepositsVC.h"
#import "ZFJDatePickerView.h"

#import "DateView.h"

#define M_HEADER_VIEW_HEIGHT 70

@interface ZFJSteShopMoneyDetailVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) UILabel * yearLabel;
@property (nonatomic, strong) UILabel * monthLabel;
@property (nonatomic, strong) UILabel * addLabel;
@property (nonatomic, strong) UILabel * minusLabel;
@property (nonatomic, strong) UILabel * balanceLabel;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) ZFJDatePickerView * datePickerView;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, copy) NSString * timeStr;
@property (nonatomic, strong) NSDateFormatter * formatter;
@property (nonatomic, strong) NSMutableDictionary * dataDic;
@property (nonatomic, strong) NSMutableArray * titleArr;
@property (nonatomic, strong) UIView * blurView;
@property (nonatomic, strong) NSMutableDictionary * moneyDetailDic;

@end

@implementation ZFJSteShopMoneyDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收支纪录";
    self.view.backgroundColor = [UIColor whiteColor];
    self.formatter = [[NSDateFormatter alloc] init];
    [self.formatter setDateFormat:@"yyyy-MM"];
    self.timeStr = [NSString stringWithFormat:@"%@%@", [self.formatter stringFromDate:[NSDate date]], @"-00 00:00:00"];
//    NSLog(@"%@", self.timeStr);
//    NSArray * arr = @[@"2015-11-01", @"2015-11-03", @"2015-11-02", @"2015-11-04", @"2015-11-05", @"2015-11-02"];
//    NSLog(@"%@", [arr sortedArrayUsingSelector:@selector(compare:)]);
    [self loadData];
    [self addHeaderView];
    [self addTableView];
}

- (void)addHeaderView {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, M_HEADER_VIEW_HEIGHT)];
    self.headerView.backgroundColor = [UIColor orangeColor];
    
    CGFloat width = ViewWidth(_headerView) / 4.0;
    CGFloat height = ViewHeight(_headerView) / 2.0;
    
    self.yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    self.yearLabel.font = [UIFont systemFontOfSize:14];
    self.yearLabel.textColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    self.yearLabel.text = [self.timeStr substringWithRange:NSMakeRange(0, 4)];
    self.yearLabel.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:_yearLabel];
    
    self.monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewBelow(_yearLabel), ViewWidth(_yearLabel) - 20,  height)];
    //[self.timeStr substringWithRange:NSMakeRange(5, 2)]
    self.monthLabel.attributedText = [self monthStr:[self.timeStr substringWithRange:NSMakeRange(5, 2)]];
    self.monthLabel.textAlignment = NSTextAlignmentCenter;
    self.monthLabel.textColor = [UIColor whiteColor];
    [self.headerView addSubview:_monthLabel];
    
    UIImageView * icon = [[UIImageView alloc] initWithFrame:CGRectMake(ViewRight(_monthLabel), ViewY(_monthLabel) + (ViewHeight(_monthLabel) / 2 - 3.5), 12, 7)];
    icon.image = [UIImage imageNamed:@"shop_month_down"];
    [self.headerView addSubview:icon];
    
    UIView * lineView =[[UIView alloc] initWithFrame:CGRectMake(ViewRight(_yearLabel) - 0.5, 5, 0.5, ViewHeight(_headerView) - 10)];
    lineView.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:lineView];
    
    UILabel * addTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(_yearLabel), 0, width, height)];
    addTitleLabel.text = @"收入(元)";
    addTitleLabel.font = [UIFont systemFontOfSize:14];
    addTitleLabel.textAlignment = NSTextAlignmentCenter;
    addTitleLabel.textColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    [self.headerView addSubview:addTitleLabel];
    
    UILabel * minusTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(addTitleLabel), 0, width, height)];
    minusTitleLabel.text = @"支出(元)";
    minusTitleLabel.font = [UIFont systemFontOfSize:14];
    minusTitleLabel.textColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    minusTitleLabel.textAlignment = NSTextAlignmentCenter;

    [self.headerView addSubview:minusTitleLabel];
    
    UILabel * balanceTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(minusTitleLabel), 0, width, height)];
    balanceTitleLabel.text = @"余额(元)";
    balanceTitleLabel.font = [UIFont systemFontOfSize:14];
    balanceTitleLabel.textAlignment = NSTextAlignmentCenter;
    balanceTitleLabel.textColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    [self.headerView addSubview:balanceTitleLabel];

    self.addLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(_yearLabel), height, width, height)];
    self.addLabel.text = @"0.00";
    //self.addLabel.font = [UIFont systemFontOfSize:14];
    self.addLabel.textAlignment = NSTextAlignmentCenter;
    self.addLabel.textColor = [UIColor whiteColor];
    [self.headerView addSubview:self.addLabel];
    
    self.minusLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(addTitleLabel), height, width, height)];
    self.minusLabel.text = @"0.00";
    //self.minusLabel.font = [UIFont systemFontOfSize:14];
    self.minusLabel.textAlignment = NSTextAlignmentCenter;
    self.minusLabel.textColor = [UIColor whiteColor];
    [self.headerView addSubview:self.minusLabel];
    
    self.balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(minusTitleLabel), height, width, height)];
    self.balanceLabel.text = @"0.00";
    //self.balanceLabel.font = [UIFont systemFontOfSize:14];
    self.balanceLabel.textAlignment = NSTextAlignmentCenter;
    self.balanceLabel.textColor = [UIColor whiteColor];
    [self.headerView addSubview:self.balanceLabel];
    
    
    UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, 0, width, ViewHeight(_headerView));
    [but addTarget:self action:@selector(chooseTime:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:but];

    [self.view addSubview:_headerView];
}

- (NSAttributedString *)monthStr:(NSString *)str {
     return [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=color:#FFFFF;font-size:20px>%@</span><span style=color:#FFFFFF;font-size:12px>月&nbsp;</span>", [self judgeReturnString:str withReplaceString:@"01"]] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
}

- (void)chooseTime:(UIButton *)button {
    CGFloat height = (windowContentWidth * 200 / 320.0 + 45);
    if (!self.datePickerView) {
        self.blurView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(_headerView), windowContentWidth, ControllerViewHeight - ViewBelow(_headerView))];
        self.blurView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];

        self.datePickerView = [[ZFJDatePickerView alloc] initWithFrame:CGRectMake(0, windowContentHeight + height, windowContentWidth, height) style:ZFJDatePickerViewStyleYM];
        NSInteger year = [[self.timeStr substringWithRange:NSMakeRange(0, 4)] integerValue];
        NSInteger month = [[self.timeStr substringWithRange:NSMakeRange(5, 2)] integerValue];
        [self.datePickerView.pickView selectRow:(year - 2015) inComponent:0 animated:YES];
        [self.datePickerView.pickView selectRow:(month - 1) inComponent:1 animated:YES];
        
        [UIView animateWithDuration:0.7 animations:^{
            self.datePickerView.frame = CGRectMake(0, ControllerViewHeight - height, windowContentWidth, height);
            [self.view addSubview:_blurView];
            [self.view addSubview:self.datePickerView];
        }];
        
        
    } else {
        self.datePickerView.hidden = !self.datePickerView.hidden;
        self.blurView.hidden = self.datePickerView.hidden;
        if (self.datePickerView.hidden == YES) {
            self.datePickerView.frame = CGRectMake(0, windowContentHeight + height, windowContentWidth, height);
            [UIView animateWithDuration:0.7 animations:^{
                self.datePickerView.frame = CGRectMake(0, ControllerViewHeight - height, windowContentWidth, height);
            }];
        }
    }
    __weak ZFJSteShopMoneyDetailVC * weakSelf = self;
    [self.datePickerView chooseConfirmBut:^(NSString *dateStr) {
        //NSLog(@"%@", dateStr);
        weakSelf.yearLabel.text = [dateStr substringWithRange:NSMakeRange(0, 4)];
        weakSelf.monthLabel.attributedText = [weakSelf monthStr:[dateStr substringWithRange:NSMakeRange(5, 2)]];
        weakSelf.monthLabel.textAlignment = NSTextAlignmentCenter;
        weakSelf.monthLabel.textColor = [UIColor whiteColor];
        
        weakSelf.blurView.hidden = YES;
        [weakSelf.dataDic removeAllObjects];
        [weakSelf.titleArr removeAllObjects];
        weakSelf.timeStr = dateStr;
        [weakSelf loadData];
    }];
    
    [self.datePickerView chooseCancelBut:^(UIButton *but) {
        weakSelf.blurView.hidden = YES;
    }];
    
}

/**
 *  加载TabelView
 */
- (void)addTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ViewBelow(_headerView), windowContentWidth, ControllerViewHeight - ViewBelow(_headerView)) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 60.0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionHeaderHeight = 35.0;
    self.tableView.sectionFooterHeight = 0.01;
    [self.view addSubview:_tableView];
    /*
    UIButton * getMoneyBut = [UIButton buttonWithType:UIButtonTypeCustom];
    getMoneyBut.frame = CGRectMake(0, ControllerViewHeight - 50, windowContentWidth, 50);
    getMoneyBut.backgroundColor = TimeGreenColor;
    [getMoneyBut setTitle:@"提现" forState:UIControlStateNormal];
    getMoneyBut.titleLabel.font = [UIFont systemFontOfSize:20];
    getMoneyBut.titleLabel.textColor = [UIColor whiteColor];
    [getMoneyBut addTarget:self action:@selector(goWithdrawDepositsVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getMoneyBut];
    */
}

- (void)goWithdrawDepositsVC:(UIButton *)button {
    ZFJWithdrawDepositsVC * withdrawDepositsVC = [[ZFJWithdrawDepositsVC alloc] init];
    [self.navigationController pushViewController:withdrawDepositsVC animated:YES];
}

#pragma mark --- UITableViewDataSource 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray * arr = [self.dataDic objectForKey:[self.titleArr objectAtIndex:section]];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"Cell";
    ZFJSteShopMoneyDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZFJSteShopMoneyDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSArray * arr = [self.dataDic objectForKey:[self.titleArr objectAtIndex:indexPath.section]];
    NSDictionary * dic = [arr objectAtIndex:indexPath.row];
    cell.numLabel.text = [[dic objectForKey:@"orders"] objectForKey:@"order_sn"];
    cell.titleLabel.text = [[dic objectForKey:@"orders"] objectForKey:@"product_name"];
    cell.priceLabel.text = [NSString stringWithFormat:@"+%@", [self judgeReturnString:[dic objectForKey:@"amount"] withReplaceString:@"0.00"]];
    if ([self judgeString:[dic objectForKey:@"thumb"]]) {
      [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:[self judgeImageURL:[dic objectForKey:@"thumb"]]] placeholderImage:[UIImage imageNamed:@"默认图2"]];
    }else{
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"默认图2"]];
    }
    
    return cell;
}

#pragma mark --- UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString * headerIdentifier = @"header";
    UITableViewHeaderFooterView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (!view) {
        view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerIdentifier];
    }
    view.contentView.backgroundColor = [UIColor whiteColor];
    view.textLabel.text = [self.titleArr objectAtIndex:section];
    view.textLabel.textColor = UIColorFromRGB(0x6f7378);
    return view;
}

#pragma mark --- 加载数据

- (void)loadData {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{};
    NSString * url = @"";
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeMember) {
        parameters = @{@"uid":[[WLSingletonClass defaultWLSingleton] wlUserID],
                       @"offset":@"1",
                       @"limit":@"10",
                       @"create_time":self.timeStr};
        url= M_URL_SS_PARTNER_MONEY_DETAIL;

    } else if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward) {
        parameters = @{@"assistant_id":[[WLSingletonClass defaultWLSingleton] wlUserID],
                       @"offset":@"1",
                       @"limit":@"10",
                       @"create_time":self.timeStr};
        url= M_URL_SS_MONEY_DETAIL;
    }
    
    NSLog(@"parameters = %@", parameters);
    //接口
    [self.formatter setDateFormat:@"dd"];

    //发送请求
    __weak ZFJSteShopMoneyDetailVC * weakSelf = self;
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@",  dic);
        if ([dic isKindOfClass:[NSDictionary class]] && [[dic objectForKey:@"status"] integerValue] == 1 && [[dic objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
           
            weakSelf.moneyDetailDic = [dic objectForKey:@"data"];
            weakSelf.addLabel.text = [weakSelf judgeReturnString:[[[dic objectForKey:@"data"] objectForKey:@"income"] stringValue] withReplaceString:@"0.00"];
            weakSelf.minusLabel.text = [weakSelf judgeReturnString:[[[dic objectForKey:@"data"] objectForKey:@"expenditure"] stringValue] withReplaceString:@"0.00"];
            CGFloat activeV = 0.00;
            CGFloat inaactiveV = 0.00;
            NSArray * arr = [[dic objectForKey:@"data"] objectForKey:@"assistant_cash_account"];
            if ([[[dic objectForKey:@"data"] objectForKey:@"assistant_cash_account"] isKindOfClass:[NSArray class]] && arr.count > 0) {
                activeV = [[[[[dic objectForKey:@"data"] objectForKey:@"assistant_cash_account"] objectAtIndex:0] objectForKey:@"active"] floatValue];
                inaactiveV = [[[[[dic objectForKey:@"data"] objectForKey:@"assistant_cash_account"] objectAtIndex:0] objectForKey:@"inactive"] floatValue];
            }
            weakSelf.balanceLabel.text = [weakSelf judgeReturnString:[NSString stringWithFormat:@"%.2f", (activeV + inaactiveV)] withReplaceString:@"0.00"];

            if ([[[dic objectForKey:@"data"] objectForKey:@"cash_journal_lists"] isKindOfClass:[NSArray class]]) {
                
                for (NSDictionary * modelDic in [[dic objectForKey:@"data"] objectForKey:@"cash_journal_lists"]) {
                    
                    NSTimeInterval time = [[modelDic objectForKey:@"create_time"] integerValue];
                    NSDate * date = [NSDate dateWithTimeIntervalSince1970:time];
                    //NSLog(@"%@", [weakSelf.formatter stringFromDate:date]);
                    NSString * dayStr = [weakSelf.formatter stringFromDate:date];
                    if ([weakSelf.dataDic objectForKey:dayStr]) {
                        NSMutableArray * arr = [weakSelf.dataDic objectForKey:dayStr];
                        [arr addObject:modelDic];
                    } else {
                        NSMutableArray * arr = [NSMutableArray array];
                        [arr addObject:modelDic];
                        [weakSelf.dataDic setObject:arr forKey:dayStr];
                    }
                }
                [weakSelf.titleArr addObjectsFromArray:[[weakSelf.dataDic allKeys] sortedArrayUsingSelector:@selector(compare:)]];
                [weakSelf.tableView reloadData];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR: %@", error);
        weakSelf.addLabel.text = @"0.00";
        weakSelf.minusLabel.text = @"0.00";
        weakSelf.balanceLabel.text = @"0.00";
        
        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
        [[XCLoadMsg sharedLoadMsg:weakSelf] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:weakSelf] showErrorMsgInView:weakSelf.view evn:^{
            [weakSelf loadData];
        }];
    }];
    

}

#pragma mark --- 懒加载
- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        self.titleArr = [NSMutableArray array];
    }
    return _titleArr;
}

- (NSMutableDictionary *)dataDic {
    if (!_dataDic) {
        self.dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
}

- (NSMutableDictionary *)moneyDetailDic {
    if (!_moneyDetailDic) {
        self.moneyDetailDic = [NSMutableDictionary dictionary];
    }
    return _moneyDetailDic;
}

@end

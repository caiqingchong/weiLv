//
//  WLMineVC.m
//  WelLv
//
//  Created by WeiLv on 15/12/3.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "WLMineVC.h"
#import "WLMineHeaderCell.h"
#import "WLStewardDetailCell.h"
#import "WLSteFunctionCell.h"
#import "LoginAndRegisterViewController.h"
#import "WLSetingVC.h"

#define M_CELL_HEIGHT 50
#define M_BG_COLOR kColor(240, 246, 251)

@interface WLMineVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * iconArr;
@property (nonatomic, strong) NSMutableArray * titleArr;
@property (nonatomic, strong) UIButton * setupBut;

@end

@implementation WLMineVC

#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
    switch ([[WLSingletonClass defaultWLSingleton] wlUserType]) {
        case WLMemberTypeNone:
        {
            self.titleArr = [NSMutableArray arrayWithArray:@[@[@"个人资料", @"常用游客资料"], @[@"系统公告", @"清除缓存", @"帮助中心", @"关于微旅"]]];
            
            self.iconArr = [NSMutableArray arrayWithArray:@[@[@"mine_data_icon", @"mine_trave_data_icon"], @[@"mine_msg_icon", @"mine_clean_iocn", @"mine_about_wl_icon", @"mine_help_centre_icon"]]];
            if (_setupBut) {
                self.setupBut.hidden = YES;
            }
        }
            break;
            
        case WLMemberTypeMember:
        {
            self.titleArr = [NSMutableArray arrayWithArray:@[@[@"个人资料", @"常用游客资料", @"我的管家"],@[@"合伙人店铺", @"申请自驾吃店铺"]]];
            
            self.iconArr = [NSMutableArray arrayWithArray:@[@[@"mine_data_icon", @"mine_trave_data_icon", @"mine_help_centre_icon"], @[@"ste_shop_icon", @"mine_clean_iocn"]]];
            self.setupBut.hidden = NO;
        }
            break;
            
        case WLMemberTypeSteward:
        {
            self.titleArr = [NSMutableArray arrayWithArray:@[@[@"我的资料", @"常用游客资料", @"返佣明细"], @[@"服务记录", @"精通业务", @"公司地址", @"管家学堂"]]];
            
            self.iconArr = [NSMutableArray arrayWithArray:@[@[@"mine_data_icon", @"mine_trave_data_icon", @"mine_about_wl_icon"], @[@"ste_serve_icon", @"ste_master_icon", @"ste_address_icon", @"mine_help_centre_icon"]]];
            self.setupBut.hidden = NO;

        }
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
}

#pragma mark --- UITableView

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight) style:UITableViewStyleGrouped];
    //self.tableView.backgroundColor = kColor(240, 246, 251);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = M_CELL_HEIGHT;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward) {
            return 2;
        }
        return 1;
    }
    NSArray * arr = self.titleArr[section - 1];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                static NSString * cellHeaderIdentifier = @"cell_header";
                WLMineHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:cellHeaderIdentifier];
                if (!cell) {
                    cell = [[WLMineHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellHeaderIdentifier];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.height = 150;
                }
                cell.backgroundColor = [UIColor orangeColor];
                switch ([[WLSingletonClass defaultWLSingleton] wlUserType]) {
                    case WLMemberTypeNone:
                    {
                        [cell.loginBut addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];

                    }
                        break;
                    case WLMemberTypeMember:
                    {
                        cell.nameLab.text = @"我是微旅的一个会员";
                    }
                        break;
                    case WLMemberTypeSteward:
                    {
                        cell.nameLab.text = @"我是微旅的一个---管家";

                    }
                        break;

                    default:
                        break;
                }
                //[cell.loginBut addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            }
                break;
            case 1:{
               static NSString * cell_function_identifier = @"cell_function";
                WLSteFunctionCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_function_identifier];
                if (!cell) {
                    cell = [[WLSteFunctionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_function_identifier];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.height = 60;
                }
                cell.titleArr = @[@"我的的部落", @"我的会员", @"会员订单", @"管家自驾吃"];
                cell.iconArr = @[@"ste_shop_icon", @"mine_data_icon", @"mine_data_icon", @"mine_data_icon"];
                [cell clickFunctionItem:^(NSIndexPath *index) {
                    NSLog(@"%ld",index.item);
                }];
                return cell;
            }
                break;
            default:
                break;
        }
       
    }
    
   static NSString * cellIdentifier = @"Cell";
    WLStewardDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLStewardDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.height = 50;
    }
    cell.titleStr = self.titleArr[indexPath.section - 1][indexPath.row];
    cell.iconImage.image = [UIImage imageNamed:self.iconArr[indexPath.section - 1][indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward) {
            return 20.f;

        }
        return 0.1f;
    }
    return 20.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - 点击方法
/**
 *  跳转到登录
 */
- (void)login {
    NSLog(@"login");
    LoginAndRegisterViewController * vc = [[LoginAndRegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  跳转到设置
 */
- (void)setting {
    WLSetingVC * vc= [[WLSetingVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma maek - 懒加载
- (NSMutableArray *)iconArr {
    if (!_iconArr) {
        self.iconArr = [NSMutableArray array];
    }
    return _iconArr;
}

- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        self.titleArr = [NSMutableArray array];
    }
    return _titleArr;
}

- (UIButton *)setupBut {
    if (!_setupBut) {
        _setupBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _setupBut.frame=CGRectMake(0, 0, 30, 30);
        [_setupBut setBackgroundImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
        [_setupBut addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_setupBut];
    }
    return _setupBut;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

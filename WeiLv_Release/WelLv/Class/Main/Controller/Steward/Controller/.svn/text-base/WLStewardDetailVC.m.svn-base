//
//  WLStewardDetailVC.m
//  WelLv
//
//  Created by WeiLv on 15/12/1.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "WLStewardDetailVC.h"
#import "WLStewardDetailCell.h"
#import "WLMineHeaderCell.h"
#import "WLMineVC.h"
#import "WLSteServeListVC.h"
#import "WLStePartnerListVC.h"
#import "ZFJSteShopOtherVC.h"

@interface WLStewardDetailVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation WLStewardDetailVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"管家详情";
    [self createTableView];
}

#pragma mark - CreateTableView

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //self.tableView.rowHeight = 45;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return 2;
        }
            break;
        case 1:
        {
            return 3;

        }
            break;
        case 2:
        {
            return 3;
        }
            break;

        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString * cell_header_identifier = @"cell_header";
            WLMineHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_header_identifier];
            if (!cell) {
                cell = [[WLMineHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_header_identifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.height = 150;
            }
            cell.headIcon.backgroundColor = [UIColor groupTableViewBackgroundColor];
            cell.companyLab.text = @"河南省郑州市金水区金水路与玉凤路交叉口上海浦发金融中心1901郑州微旅有限公司";
            //cell.nameLab.text = @"旅行管家name";
            return cell;
        } else {
            static NSString * cell_msg_identifier = @"cell_msg";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_msg_identifier];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_msg_identifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.numberOfLines = 2;
                cell.textLabel.textColor = UIColorFromRGB(0x6f7378);
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                cell.height = 60;
            }
            cell.textLabel.text = @"旅游就好旅游就好旅游";
            return cell;
        }

    }
    static NSString * cellIdentifier = @"cell";
    WLStewardDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLStewardDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray * iconArr = @[@[@"ste_call_icon", @"ste_shop_icon", @"ste_shop_partner_icon"], @[@"ste_master_icon", @"ste_serve_icon", @"ste_address_icon"]];

    cell.iconImage.image = [UIImage imageNamed:iconArr[indexPath.section - 1][indexPath.row]];

    NSArray * titleArr = @[@[@"Ta的电话", @"Ta的部落",@"Ta的合伙人"],@[@"精通业务",@"服务记录",@"公司地址"]];
    cell.titleStr = titleArr[indexPath.section -1][indexPath.row];
    NSArray * msgArr = @[@[@"18236925230", @"", @""], @[@"旅游业务", @"1000次", @"河南省郑州市金水区金水路与玉凤路交叉口上海浦发金融中心1901郑州微旅有限公司"]];
    cell.msgStr = msgArr[indexPath.section -1][indexPath.row];

    return cell;
}

#pragma mark - UITabelViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
//        switch (indexPath.row) {
//            case 0:
//                return 150;
//                break;
//            case 1:
//                return 60;
//                break;
//            default:
//                break;
//        }
//        return 150;
//    }
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 0) {
        WLMineVC * vc = [[WLMineVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                
            }
                break;
            case 1:
            {
                
            }
                break;
            case 2:
            {
                WLStePartnerListVC * vc = [[WLStePartnerListVC alloc] init];
                vc.steward_id = @"";
                [self.navigationController pushViewController:vc
                                                     animated:YES];
            }
                break;
            default:
                break;
        }
    } else if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
            {
                
            }
                break;
            case 1:
            {
                WLSteServeListVC * vc = [[WLSteServeListVC alloc] init];
                vc.steward_id = @"";
                [self.navigationController pushViewController:vc
                                                     animated:YES];
            }
                break;
            case 2:
            {
                
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark - loadData

- (void)loadData {
    
}

@end

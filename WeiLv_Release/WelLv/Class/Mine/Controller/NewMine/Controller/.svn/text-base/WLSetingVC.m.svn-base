//
//  WLSetingVC.m
//  WelLv
//
//  Created by zhangjie on 15/12/6.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "WLSetingVC.h"

@interface WLSetingVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIButton * LogOutBut;
@end

@implementation WLSetingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = M_MIAN_BG_COLOR;
    [self createTableView];
}

#pragma mark - tableView

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = M_MIAN_BG_COLOR;
//    UIView * view = [[UIView alloc] init];
//    view.backgroundColor = M_MIAN_BG_COLOR;
//    self.tableView.tableFooterView = view;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 1;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 2) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor orangeColor];
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.textColor = [UIColor blackColor];
    }
    NSArray * titleArr = @[@[@"清除缓存", @"修改密码", @"系统公告"], @[@"推荐好友", @"帮助中心", @"关于微旅"], @[@"退出登录"]];
    cell.textLabel.text = titleArr[indexPath.section][indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelagate
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - 懒加载
- (UIButton *)LogOutBut {
    if (!_LogOutBut) {
        self.LogOutBut = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _LogOutBut;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

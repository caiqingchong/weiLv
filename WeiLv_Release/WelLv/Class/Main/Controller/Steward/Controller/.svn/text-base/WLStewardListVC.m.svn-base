//
//  WLStewardListVC.m
//  WelLv
//
//  Created by WeiLv on 15/12/1.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "WLStewardListVC.h"
#import "WLStewardDetailVC.h"
#import "WLStewardListCell.h"

@interface WLStewardListVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

@end

@implementation WLStewardListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"管家";
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdntifier = @"Cell";
    WLStewardListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdntifier];
    if (!cell) {
        cell = [[WLStewardListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdntifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WLStewardDetailVC * vc = [[WLStewardDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark - 懒加载

- (UITableView *)tableView {
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 90;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}



@end

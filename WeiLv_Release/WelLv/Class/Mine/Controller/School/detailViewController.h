//
//  detailViewController.h
//  WelLv
//
//  Created by mac for csh on 15/9/1.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"

@interface detailViewController : XCSuperObjectViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSString *idd;
    bool flag[4];
}

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic ,strong) NSString *idd;

@end

//
//  ShowFoodViewController.h
//  WelLv
//
//  Created by liuxin on 15/11/11.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"

@interface ShowFoodViewController : XCSuperObjectViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView1;
}
@property(nonatomic,retain)UITableView *tableView1;
@end

//
//  LXCContactViewController.h
//  WelLv
//
//  Created by liuxin on 15/9/10.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"
typedef void(^commonContactBlock)(NSMutableArray *array);
@interface LXCContactViewController : XCSuperObjectViewController<UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *cusInfoArray;
    NSInteger buttonTag;
    UIImageView *igview;
    UITableView *_tableView;
}
@property(nonatomic,strong) NSMutableArray *cusInfoArray;
@property(nonatomic) NSInteger buttonTag;

@property (nonatomic,strong)commonContactBlock blockArray;
@end

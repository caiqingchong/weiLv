//
//  LXCusInfoViewController.h
//  WelLv
//
//  Created by liuxin on 15/9/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagCusInfoViewController.h"
#import "XCSuperObjectViewController.h"
#import "CustomInfo.h"
#import "CustomInfoCell.h"
#import "ChangeCusInfoViewController.h"


@protocol LXCusInfoViewControllerDelegate <NSObject>

- (void)getContact:(NSDictionary *)dic;

@end

@interface LXCusInfoViewController : XCSuperObjectViewController<UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray *cusInfoArray;
    NSInteger buttonTag;
    UIImageView *igview;
    UITableView *_tableView;
}
@property(nonatomic,strong) NSMutableArray *cusInfoArray;
@property(nonatomic) NSInteger buttonTag;
@property (nonatomic,weak)id <LXCusInfoViewControllerDelegate>delegate;

@end

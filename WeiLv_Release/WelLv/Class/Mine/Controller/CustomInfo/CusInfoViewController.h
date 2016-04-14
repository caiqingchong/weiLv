//
//  CusInfoViewController.h
//  WelLv
//
//  Created by mac for csh on 15/4/13.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagCusInfoViewController.h"
#import "XCSuperObjectViewController.h"
#import "CustomInfo.h"
#import "CustomInfoCell.h"
#import "ChangeCusInfoViewController.h"


@protocol CusInfoViewControllerDelegate <NSObject>

- (void)getContact:(NSDictionary *)dic;

@end

@interface CusInfoViewController : XCSuperObjectViewController<UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>{

    NSMutableArray *cusInfoArray;
    NSInteger buttonTag;
    UIImageView *igview;
    UITableView *_tableView;
}
@property(nonatomic,strong) NSMutableArray *cusInfoArray;
@property(nonatomic) NSInteger buttonTag;
@property(nonatomic,assign) BOOL isFromeOrder;
@property (nonatomic,weak)id <CusInfoViewControllerDelegate>delegate;

@end


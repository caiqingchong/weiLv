//
//  IncomesDetailsViewController.h
//  WelLv
//
//  Created by mac for csh on 15/10/28.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"

@interface IncomesDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    NSString *conditionStr;
}

@property (nonatomic ,strong) NSString *conditionStr;

@end

//
//  LXSTListViewController.h
//  WelLv
//
//  Created by 刘鑫 on 15/8/17.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"
typedef enum {
    HotCity,//热门城市
    Theme1,   //专题
    Search  //搜索
}SourceType;

typedef enum {
    ShowTable,
    CloseTable,
    ReloadTable
}TableStatus;

@class LXSTModel;
@interface LXSTListViewController : XCSuperObjectViewController

/**
 *来源类型
 */
@property (nonatomic,assign)SourceType sourceType;

/**
 *tab状态
 */
@property (nonatomic,assign)TableStatus tableStatus;

//@property (nonatomic,strong)LXSTModel *stModel;

@property (nonatomic,copy) NSString *city_name;
@property (nonatomic,copy) NSString *themeType;
@property (nonatomic,copy) NSString *keywords;
@end

//
//  MyOrderTableViewCOntroller.h
//  WelLv
//
//  Created by mac for csh on 15/4/24.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"
typedef enum{
    isShow,//展开
    isCloose,//关闭
    Reload//刷新列表
}TableState;
@interface MyOrderTableViewCOntroller : XCSuperObjectViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>


@property (nonatomic,assign) TableState tableState;

@property(nonatomic,copy)NSString *order_id;
@property(nonatomic,copy)NSString *cat_id;
@property(nonatomic,copy)NSString *member_id;
@property(nonatomic,assign)NSInteger flag;

//@property(nonatomic,strong) UITableView *orderTab;
@end

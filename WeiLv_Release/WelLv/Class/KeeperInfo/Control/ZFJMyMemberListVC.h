//
//  ZFJMyMemberListVC.h
//  WelLv
//
//  Created by 张发杰 on 15/5/6.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavSearchView.h"
#import "XCSuperObjectViewController.h"
#import "MyMembersModel.h"


@class YXHouseModel;


@protocol ZFJMyMemberListVCDelegate <NSObject>

- (void)getMember:(MyMembersModel *)dic;

@end

@interface ZFJMyMemberListVC : XCSuperObjectViewController<UITableViewDataSource, UITableViewDelegate, NavSearchViewDelegate>

@property (nonatomic,strong)YXHouseModel *houseModel;
@property (nonatomic,weak)id<ZFJMyMemberListVCDelegate>delegate;
@property (nonatomic, strong) UILabel * memberCountLab;
@property(nonatomic,strong)NSString *type;
@end

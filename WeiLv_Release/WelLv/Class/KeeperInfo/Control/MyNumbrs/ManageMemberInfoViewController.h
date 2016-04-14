//
//  ManageMemberInfoViewController.h
//  WelLv
//
//  Created by mac for csh on 15/5/6.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"

@class MyMembersModel;
@interface ManageMemberInfoViewController : XCSuperObjectViewController<UIScrollViewDelegate,UITextViewDelegate>

@property(nonatomic,strong)MyMembersModel *memberModel;
@end

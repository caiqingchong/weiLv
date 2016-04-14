//
//  ForgetPwdViewController.h
//  WelLv
//
//  Created by 赵阳 on 16/1/25.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"

@interface ForgetPwdViewController : XCSuperObjectViewController

@property(weak, nonatomic) UIViewController *upperViewController;//从登陆页面传过来的控制器，用于最后一个页面直接pop回登录页面

@property (nonatomic, assign) WLMemberType memberType;//判断用户类型，是会员，还是管家

@end

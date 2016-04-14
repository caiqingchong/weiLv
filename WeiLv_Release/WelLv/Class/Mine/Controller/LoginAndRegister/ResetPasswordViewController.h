//
//  ResetPasswordViewController.h
//  WelLv
//
//  Created by 赵阳 on 16/1/25.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"

@interface ResetPasswordViewController : XCSuperObjectViewController

@property(weak, nonatomic) UIViewController *upperViewController;//从登陆页面传过来的控制器，用于最后一个页面直接pop回登录页面

@property (nonatomic, strong) NSString *phoneNum;//从忘记密码页面传过来的电话号码

@property (nonatomic, assign) WLMemberType memberType;//判断用户类型，是会员，还是管家


@end

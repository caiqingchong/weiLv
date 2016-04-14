//
//  LoginAndRegisterViewController.h
//  WelLv
//
//  Created by 赵阳 on 16/3/1.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import <ShareSDK/ShareSDK.h>

typedef void (^loginBlock)(NSDictionary *str);

@interface LoginAndRegisterViewController : XCSuperObjectViewController
{
    NSString *access_token;
    
    NSString *openid;
    
}

@property (nonatomic, strong)loginBlock block;

//上一级页面点击的是“登录”按钮，还是“注册”按钮
@property (nonatomic,assign) BOOL isRegister;

//给_loginAndRegisterScrollView添加“左滑”和“右滑”手势
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

- (void)resetPhoneNum:(NSString *)num;//从忘记密码页面传到重置密码页面，再从重置密码页面传过来的电话号码，用于在忘记密码找回密码之后，把电话号码传到登录页面

@end

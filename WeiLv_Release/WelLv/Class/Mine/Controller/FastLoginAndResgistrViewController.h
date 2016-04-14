//
//  FastLoginAndResgistrViewController.h
//  WelLv
//
//  Created by mac for csh on 15/4/25.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "LoginAndRegisterViewController.h"
#import "AFNetworking.h"
#import "LXUserTool.h"
#import "BindLoginViewController.h"
#import "ThirdLoginBinding.h"
typedef void (^loginBlock)(NSDictionary *str);

typedef void (^registerBlock)(NSString *str);

@interface FastLoginAndResgistrViewController : XCSuperObjectViewController<UITextFieldDelegate>{
    UIButton *loginButton;
    UIButton *registerbutton;
    
    UIView *loginView;
    UITextField *loginUsernme;
    UITextField *loginPassword;
    UIButton *loginBtn;
    NSArray *thirdArr;
    
    UIView *registerView;
    UITextField *PhoneNum;
    UITextField *yanzhengCode;
    UIButton *getCodeBtn;
    UIButton *registerBtn;
    
    //weixin
    NSString *access_token;
    NSString *openid;
    
    NSString * pwdSTRing ;
   
}

@property (nonatomic, strong)loginBlock lgblock;
@property (nonatomic, strong)registerBlock rgblock;
@end

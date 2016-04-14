//
//  ThirdLoginBinding.h
//  WelLv
//
//  Created by James on 16/3/2.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "XCObjectViewController.h"
#import "LoginAndRegisterViewController.h"

typedef void (^bindBlock)(NSString *str);
@interface ThirdLoginBinding : XCObjectViewController<UITextFieldDelegate>
{
    UITextField *_phoneTextField;//手机号
    UITextField *_verificationCodeTextField;//验证码
    UIButton *_sendVerificatCodeBtn;//发送验证码按钮
    UIButton *_finishBtn;//完成按钮
}

@property (nonatomic,strong)UIButton *navigationBack;
@property(nonatomic,strong)UILabel *navigationTitle;
@property (nonatomic,strong)UIImageView *phoneImageView;
@property (nonatomic,strong)UILabel *userName; //用户名称
@property (nonatomic,copy)NSString *name;//第三方昵称
@property (nonatomic,copy)NSString *phoneStr;//第三方头像
@property (nonatomic,copy)NSString *openId;//第三方openID
@property (nonatomic,copy)NSString *loginType;//登陆类型(WX:微信  QQ:qq)
@property(nonatomic,strong)bindBlock block; //block回调函数

@end

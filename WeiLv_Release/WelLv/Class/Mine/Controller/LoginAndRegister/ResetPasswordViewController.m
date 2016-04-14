//
//  ResetPasswordViewController.m
//  WelLv
//
//  Created by 赵阳 on 16/1/25.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "ForgetPwdViewController.h"
#import "LoginAndRegisterViewController.h"



#define AUTO_IPHONE6_HEIGHT_667 windowContentHeight/667

#define AUTO_IPHONE6_WIDTH_375 windowContentWidth/375


@interface ResetPasswordViewController ()<UITextFieldDelegate>
{
    
    //页面底层View
    UIScrollView *_bgScrollView;
    
    //返回上一页按钮
    UIButton *_backButton;
    
    //返回上一页按钮图片
    UIImageView *_backButtonImage;
    
    //页面title
    UILabel *_pageTitleLabel;
    
    //logo图标
    UIImageView *_logoImageView;
    
    //页面背景图片
    UIImageView *_backgroundImageView;
    
    //会员title
    UILabel *_memberTitleLabel;
    
    //新密码输入框
    UITextField *_newPasswordTF;
    //新密码图标
    UIImageView *_newPasswordImage;
    
    //确认密码输入框
    UITextField *_confirmPasswordTF;
    
    //确认密码图标
    UIImageView *_confirmPasswordImage;
    
    
    //下划线
    UIView *_underlineView;
    
    UIView *_underlineView1;
    
    UIView *_underlineView2;
    
    
    //重置密码“完成”按钮
    UIButton *_resetPasswordButton;
    
}

@end

@implementation ResetPasswordViewController

#pragma mark
#pragma mark  移除监听

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

#pragma mark

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.memberType == WLMemberTypeMember) {
        
        self.title=@"重置会员密码";
        
    }
    else if (self.memberType == WLMemberTypeSteward) {
        
        self.title=@"重置管家密码";
        
    }
    
    self.view.backgroundColor= BgViewColor;
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    //改变输入框光标颜色
    [[UITextField appearance] setTintColor:[UIColor whiteColor]];
    
    
    [self initContent];
    
}

-(void)initContent
{
    
    //页面背景图片
    _backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    
    _backgroundImageView.image = [UIImage imageNamed:@"登录注册页面背景"];
    
    [self.view addSubview:_backgroundImageView];
    
    
    //页面底层ScrollView
    _bgScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    
    _bgScrollView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapBgScrollView:)];
    
    [_bgScrollView addGestureRecognizer:tapGesture];
    
    [self.view addSubview:_bgScrollView];
    
    
    //返回按钮
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _backButton.frame = CGRectMake(0, 20 * AUTO_IPHONE6_HEIGHT_667, 60, 50);
    
    [_backButton addTarget:self action:@selector(popButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_bgScrollView addSubview:_backButton];
    
    
    //返回按钮图片
    _backButtonImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15 * AUTO_IPHONE6_HEIGHT_667, 16, 26)];
    
    _backButtonImage.image = [UIImage imageNamed:@"登录注册返回键"];
    
    [_backButton addSubview:_backButtonImage];
    
    
    //页面title
    _pageTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 35 * AUTO_IPHONE6_HEIGHT_667, windowContentWidth, 25)];
    
    _pageTitleLabel.text = @"忘记密码";
    
    _pageTitleLabel.textColor = [UIColor whiteColor];
    
    _pageTitleLabel.font = [UIFont systemFontOfSize:19];
    
    _pageTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    [_bgScrollView addSubview:_pageTitleLabel];
    
    
    //logo图标
    UIImage *login_reg_logo= [UIImage imageNamed:@"login_reg_logo"];
    _logoImageView = [[UIImageView alloc]init];
    
    _logoImageView.frame = CGRectMake((windowContentWidth - login_reg_logo.size.width)/2, login_reg_logo.size.width  * AUTO_IPHONE6_HEIGHT_667, login_reg_logo.size.width, login_reg_logo.size.height);
    
    if (windowContentHeight == 480) {
        
        _logoImageView.frame = CGRectMake((windowContentWidth - login_reg_logo.size.width)/2, (login_reg_logo.size.width-10)  * AUTO_IPHONE6_HEIGHT_667, login_reg_logo.size.width, login_reg_logo.size.height);
        
    }
    
    _logoImageView.image = login_reg_logo;
    
    [_bgScrollView addSubview:_logoImageView];
    
    
    //会员label
    _memberTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth/2 - 25, ViewBelow(_logoImageView) + 40 * AUTO_IPHONE6_HEIGHT_667, 50, 20)];
    
    _memberTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    if (self.memberType == WLMemberTypeMember) {
        
        _memberTitleLabel.text = @"会员";
        
    }
    else if (self.memberType == WLMemberTypeSteward) {
        
        _memberTitleLabel.text = @"管家";
        
    }
    
    _memberTitleLabel.font = [UIFont systemFontOfSize:17];
    
    _memberTitleLabel.textColor = [UIColor whiteColor];
    
    [_bgScrollView addSubview:_memberTitleLabel];
    
    
    //用户类型下划线
    _underlineView = [[UIView alloc]initWithFrame:CGRectMake(windowContentWidth/2 - 25 * AUTO_IPHONE6_WIDTH_375, ViewBelow(_memberTitleLabel) + 5 * AUTO_IPHONE6_HEIGHT_667, 50 * AUTO_IPHONE6_WIDTH_375, 1)];
    
    _underlineView.backgroundColor = [UIColor whiteColor];
    
    [_bgScrollView addSubview:_underlineView];
    
    
    //新密码输入框图标
    _newPasswordImage = [[UIImageView alloc]init];
    
    _newPasswordImage.frame = CGRectMake(50 , ViewBelow(_memberTitleLabel) + 55 * AUTO_IPHONE6_HEIGHT_667, 19, 26);
    
    _newPasswordImage.image = [UIImage imageNamed:@"登录注册密码"];
    
    [_bgScrollView addSubview:_newPasswordImage];
    
    
    //新密码输入框
    _newPasswordTF = [[UITextField alloc]initWithFrame:CGRectMake(ViewRight(_newPasswordImage) + 15, ViewY(_newPasswordImage), windowContentWidth - 135 * AUTO_IPHONE6_WIDTH_375, 25)];
    
    _newPasswordTF.borderStyle=UITextBorderStyleNone;
    
    _newPasswordTF.keyboardType=UIKeyboardTypeASCIICapable;
    
    _newPasswordTF.secureTextEntry = YES;
    
    _newPasswordTF.autocapitalizationType = UITextAutocapitalizationTypeNone;//设置英文键盘默认小写
    
    _newPasswordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _newPasswordTF.placeholder=@"请输入新密码";
    
    [_newPasswordTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    _newPasswordTF.textColor = [UIColor whiteColor];
    
    _newPasswordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _newPasswordTF.delegate=self;
    
    [_bgScrollView addSubview:_newPasswordTF];
    
    
    //输入框下方分割线
    _underlineView1 = [[UIView alloc]initWithFrame:CGRectMake(45, ViewBelow(_newPasswordImage) + 5 * AUTO_IPHONE6_HEIGHT_667, windowContentWidth - 90, 1)];
    
    _underlineView1.backgroundColor = [UIColor whiteColor];
    
    _underlineView1.alpha = 0.5;
    
    [_bgScrollView addSubview:_underlineView1];
    
    
    //确认密码输入框图标
    _confirmPasswordImage = [[UIImageView alloc]init];
    
    _confirmPasswordImage.frame = CGRectMake(50, ViewBelow(_underlineView1) + 20 * AUTO_IPHONE6_HEIGHT_667, 19, 26);
    
    _confirmPasswordImage.image = [UIImage imageNamed:@"登录注册密码"];
    
    [_bgScrollView addSubview:_confirmPasswordImage];
    
    
    //验证码输入框
    _confirmPasswordTF = [[UITextField alloc]initWithFrame:CGRectMake(ViewRight(_confirmPasswordImage) + 15, ViewBelow(_underlineView1) + 20 * AUTO_IPHONE6_HEIGHT_667, windowContentWidth - 135 * AUTO_IPHONE6_WIDTH_375, 25)];
    
    _confirmPasswordTF.borderStyle=UITextBorderStyleNone;
    
    _confirmPasswordTF.keyboardType=UIKeyboardTypeASCIICapable;
    
    _confirmPasswordTF.secureTextEntry = YES;
    
    _confirmPasswordTF.autocapitalizationType = UITextAutocapitalizationTypeNone;//设置英文键盘默认小写
    
    _confirmPasswordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _confirmPasswordTF.placeholder=@"请确认新密码";
    
    [_confirmPasswordTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    _confirmPasswordTF.textColor = [UIColor whiteColor];
    
    _confirmPasswordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _confirmPasswordTF.delegate=self;
    
    [_bgScrollView addSubview:_confirmPasswordTF];
    
    
    //输入框下方分割线
    _underlineView2 = [[UIView alloc]initWithFrame:CGRectMake(45, ViewBelow(_confirmPasswordImage) + 5 * AUTO_IPHONE6_HEIGHT_667, windowContentWidth - 90, 1)];
    
    _underlineView2.backgroundColor = [UIColor whiteColor];
    
    _underlineView2.alpha = 0.5;
    
    [_bgScrollView addSubview:_underlineView2];
    
    
    //注册按钮
    _resetPasswordButton = [[UIButton alloc]initWithFrame:CGRectMake(45 , ViewBelow(_underlineView2) + 25 * AUTO_IPHONE6_HEIGHT_667, windowContentWidth - 90, 45)];
    
    [_resetPasswordButton addTarget:self action:@selector(popToLoginVCButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_resetPasswordButton setTitle:@"完 成" forState:UIControlStateNormal];
    
    _resetPasswordButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _resetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:19];
    
    [_resetPasswordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//设置title在一般情况下为白色字体
    
    [_resetPasswordButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];//设置title在button被选中情况下为灰色字体
    
    [_resetPasswordButton setBackgroundImage:[UIImage imageNamed:@"登录注册按钮背景"] forState:UIControlStateNormal];
    
    [_bgScrollView addSubview:_resetPasswordButton];
    
}

- (void)onTapBgScrollView:(UITapGestureRecognizer *)tap {
    
    [self hideKeyboard];
}

#pragma mark
#pragma mark  隐藏键盘

- (void)hideKeyboard {
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

#pragma mark
#pragma mark  跳转到对应的页面

-(void)popToLoginVCButton:(UIButton *)btn{
    
    NSString * memberStr = @"";
    
    if (self.memberType == WLMemberTypeMember) {
        
        memberStr = @"member";
        
    }
    else if (self.memberType == WLMemberTypeSteward) {
        
        memberStr = @"assistant";
    }
    
    
    //两次输入密码相等，并且不为空
    if ([_newPasswordTF.text isEqualToString:_confirmPasswordTF.text]) {
        
        
        NSDictionary *parameters = @{@"usergroup":memberStr,
                                     @"phone":self.phoneNum,
                                     @"token": @"7a6bd7af36e5db226281a037909fbdfd",
                                     @"password":_confirmPasswordTF.text};
        
        NSString *jsonStr = [[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:parameters];
        
        NSDictionary *data = @{@"data": jsonStr};
        
        [self sendRequest:data aurl:JudgeNewPwd];
        
        _resetPasswordButton.enabled = NO;
        
    }
    else{
        
        [[LXAlterView sharedMyTools] createTishi:@"两次密码输入不一致，请重新输入"];
    }
    
}

#pragma mark
#pragma mark  修改密码请求

-(void)sendRequest:(NSDictionary *)parameters aurl:(NSString *)url
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSLog(@"%@", parameters);
    
    [manager POST:url parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              
              NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              
              DLog(@"密码----%@",resultDict);
              
              NSInteger status = [[resultDict objectForKey:@"status"] integerValue];
              
              
              if (status == 1) {
                  
                  [[UIApplication sharedApplication].keyWindow endEditing:YES];
                  
                  LoginAndRegisterViewController *loginController = (LoginAndRegisterViewController *)self.upperViewController;
                  
                  [loginController resetPhoneNum:self.phoneNum];
                  
                  [self.navigationController popToViewController:loginController animated:YES];
                  
                  [[LXAlterView sharedMyTools] createTishi:[resultDict objectForKey:@"msg"]];
                  
              }
              else if (status == -1){
                  
                  [[LXAlterView sharedMyTools] createTishi:[resultDict objectForKey:@"msg"]];
                  
              }
              
              _resetPasswordButton.enabled = YES;
              
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              
              [[LXAlterView sharedMyTools] createTishi:@"验证失败，请检查网络"];
              
              _resetPasswordButton.enabled = YES;
              
          }];
}

#pragma mark
#pragma mark  返回上一页

-(void)popButton:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark
#pragma mark  键盘弹出时背景上滑高度

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.25 animations:^{
        
        if (windowContentHeight==480)
        {
            //iPhone4
            _bgScrollView.contentSize=CGSizeMake(windowContentWidth, windowContentHeight+160);
            _bgScrollView.contentOffset=CGPointMake(0, 160);
        }
        else if(windowContentHeight==568)
        {
            //iPhone5
            _bgScrollView.contentSize=CGSizeMake(windowContentWidth, windowContentHeight+115);
            _bgScrollView.contentOffset=CGPointMake(0, 115);
        }
        else if (windowContentHeight == 667)
        {
            _bgScrollView.contentSize=CGSizeMake(windowContentWidth, windowContentHeight+80);
            _bgScrollView.contentOffset=CGPointMake(0, 80);
        }
        else
        {
            _bgScrollView.contentSize=CGSizeMake(windowContentWidth, windowContentHeight+50);
            _bgScrollView.contentOffset=CGPointMake(0, 50);
        }
        
    } completion:^(BOOL finished) {
        
    }];
    
}


-(void)closeKBoard
{
    [self.view endEditing:YES];
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    
    float height = keyboardRect.size.height;
    
    NSLog(@"height---%f,屏幕高=%f",height,windowContentHeight);
    
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    [UIView animateWithDuration:0.25
                     animations:^{
                         
                         self.view.frame=CGRectMake(0, 0, windowContentWidth, windowContentHeight);
                     }
                     completion:^(BOOL finished) {
                         
                         _bgScrollView.contentSize=CGSizeMake(windowContentWidth, windowContentHeight);
                         
                     }];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end

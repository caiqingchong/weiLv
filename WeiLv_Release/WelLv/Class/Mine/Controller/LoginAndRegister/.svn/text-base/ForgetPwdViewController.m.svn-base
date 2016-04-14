//
//  ForgetPwdViewController.m
//  WelLv
//
//  Created by 赵阳 on 16/1/25.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#define NUMBERS @"0123456789\n"


#define AUTO_IPHONE6_HEIGHT_667 windowContentHeight/667

#define AUTO_IPHONE6_WIDTH_375 windowContentWidth/375

#import "ForgetPwdViewController.h"
#import "AuthCodeViewController.h"
#import "ResetPasswordViewController.h"

@interface ForgetPwdViewController ()
<UITextFieldDelegate>
{
    
    BOOL _hasSentMessage;
    
    
    
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
    
    
    //下划线
    UIView *_underlineView;
    UIView *_underlineView1;
    UIView *_underlineView2;
    
    
    //登录注册手机号图片
    UIImageView *_loginPhoneNumImage;
    
    UIImageView *_registerPhoneNumImage;
    
    //登录注册密码图片
    UIImageView *_loginPasswordImage;
    
    UIImageView *_registerPasswordImage;
    
    //用户电话号码
    UITextField *_userPhoneNumTF;
    
    //注册验证码输入框、图片
    UIImageView *_authCodeImage;
    
    UITextField *_authCodeTF;
    
    //发送验证码图片、按钮
    UIImageView *_authCodeButtonImage;
    
    UIButton *_authCodeButton;
    
    //提交按钮
    UIButton *_submitButton;
    
}

@property(nonatomic , retain) UIPageControl *pageController;

@end

@implementation ForgetPwdViewController

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

//加载视图
- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
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
    
    //加载不需要滑动的固定视图
    [self initContent];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    _hasSentMessage = NO;
}

#pragma mark
#pragma mark  加载内容视图

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
    UIImage *login_reg_logo=[UIImage imageNamed:@"login_reg_logo"];
    _logoImageView = [[UIImageView alloc]init];
    
    _logoImageView.frame = CGRectMake((windowContentWidth - login_reg_logo.size.width)/2,login_reg_logo.size.width  * AUTO_IPHONE6_HEIGHT_667, login_reg_logo.size.width, login_reg_logo.size.height);
    
    if (windowContentHeight == 480) {
        
        _logoImageView.frame = CGRectMake((windowContentWidth - login_reg_logo.size.width)/2, (login_reg_logo.size.width-10) * AUTO_IPHONE6_HEIGHT_667,login_reg_logo.size.width,login_reg_logo.size.height);
        
    }
    
    _logoImageView.image =login_reg_logo;
    
    [_bgScrollView addSubview:_logoImageView];
    
    
    //用户类型label
    _memberTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth/2 - 25, ViewBelow(_logoImageView) + 40 * AUTO_IPHONE6_HEIGHT_667, 50, 20)];
    
    _memberTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    _memberTitleLabel.font = [UIFont systemFontOfSize:17];
    
    if (self.memberType == WLMemberTypeMember) {
        
        _memberTitleLabel.text = @"会员";
        
    }
    else if (self.memberType == WLMemberTypeSteward) {
        
        _memberTitleLabel.text = @"管家";
        
    }
    
    _memberTitleLabel.textColor = [UIColor whiteColor];
    
    [_bgScrollView addSubview:_memberTitleLabel];
    
    
    //用户类型下划线
    _underlineView = [[UIView alloc]initWithFrame:CGRectMake(windowContentWidth/2 - 25 * AUTO_IPHONE6_WIDTH_375, ViewBelow(_memberTitleLabel) + 5 * AUTO_IPHONE6_HEIGHT_667, 50 * AUTO_IPHONE6_WIDTH_375, 1)];
    
    _underlineView.backgroundColor = [UIColor whiteColor];
    
    [_bgScrollView addSubview:_underlineView];
    
    
    //注册手机号图标
    _registerPhoneNumImage = [[UIImageView alloc]init];
    
    _registerPhoneNumImage.frame = CGRectMake(50 , ViewBelow(_memberTitleLabel) + 55 * AUTO_IPHONE6_HEIGHT_667, 19, 26);
    
    _registerPhoneNumImage.image = [UIImage imageNamed:@"登录注册手机号"];
    
    [_bgScrollView addSubview:_registerPhoneNumImage];
    
    
    //注册手机号输入框
    _userPhoneNumTF = [[UITextField alloc]initWithFrame:CGRectMake(ViewRight(_registerPhoneNumImage) + 15, ViewY(_registerPhoneNumImage), windowContentWidth - 135 * AUTO_IPHONE6_WIDTH_375, 25)];
    
    _userPhoneNumTF.borderStyle=UITextBorderStyleNone;
    
    _userPhoneNumTF.keyboardType=UIKeyboardTypeNumberPad;
    
    _userPhoneNumTF.placeholder=@"请输入手机号";
    
    [_userPhoneNumTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    _userPhoneNumTF.textColor = [UIColor whiteColor];
    
    _userPhoneNumTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _userPhoneNumTF.delegate=self;
    
    [_bgScrollView addSubview:_userPhoneNumTF];
    
    
    //输入框下方分割线
    _underlineView1 = [[UIView alloc]initWithFrame:CGRectMake(45, ViewBelow(_registerPhoneNumImage) + 5 * AUTO_IPHONE6_HEIGHT_667, windowContentWidth - 90, 1)];
    
    _underlineView1.backgroundColor = [UIColor whiteColor];
    
    _underlineView1.alpha = 0.5;
    
    [_bgScrollView addSubview:_underlineView1];
    
    
    //验证码左边图标
    _authCodeImage = [[UIImageView alloc]init];
    
    _authCodeImage.frame = CGRectMake(50, ViewBelow(_underlineView1) + 20 * AUTO_IPHONE6_HEIGHT_667, 19, 26);
    
    _authCodeImage.image = [UIImage imageNamed:@"登录注册手机号验证"];
    
    [_bgScrollView addSubview:_authCodeImage];
    
    
    //验证码输入框
    _authCodeTF = [[UITextField alloc]initWithFrame:CGRectMake(ViewRight(_authCodeImage) + 15, ViewBelow(_underlineView1) + 20 * AUTO_IPHONE6_HEIGHT_667, windowContentWidth - 90*2, 25)];
    
    _authCodeTF.borderStyle=UITextBorderStyleNone;
    
    _authCodeTF.keyboardType=UIKeyboardTypeNumberPad;
    
    _authCodeTF.placeholder=@"请输入验证码";
    
    [_authCodeTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    _authCodeTF.textColor = [UIColor whiteColor];
    
    _authCodeTF.delegate=self;
    
    [_bgScrollView addSubview:_authCodeTF];
    
    
    //验证码按钮
    _authCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth * 3/4 - 50, ViewBelow(_underlineView1) + 15 * AUTO_IPHONE6_HEIGHT_667, 100 * AUTO_IPHONE6_WIDTH_375, 27)];
    
    [_authCodeButton addTarget:self action:@selector(authCodeButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _authCodeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _authCodeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    
    _authCodeButton.layer.cornerRadius = 3.0;
    
    [_authCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    
    [_authCodeButton setTitleColor:kColor(255, 153, 102) forState:UIControlStateNormal];
    
    [_authCodeButton setBackgroundColor:[UIColor whiteColor]];
    
    [_bgScrollView addSubview:_authCodeButton];
    
    
    //输入框下方分割线
    _underlineView2 = [[UIView alloc]initWithFrame:CGRectMake(45, ViewBelow(_authCodeImage) + 5 * AUTO_IPHONE6_HEIGHT_667, windowContentWidth - 90, 1)];
    
    _underlineView2.backgroundColor = [UIColor whiteColor];
    
    _underlineView2.alpha = 0.5;
    
    [_bgScrollView addSubview:_underlineView2];
    
    
    //_userTF下方提示语
    UILabel *tishiLab=[[UILabel alloc] initWithFrame:CGRectMake(45, ViewY(_underlineView2)+ViewHeight(_underlineView2)+10, windowContentWidth - 90, 40)];
    
    tishiLab.text=@"请输入您注册时填写的手机号，我们会给您发送一条验证码短信，请注意查收";
    
    tishiLab.font=[UIFont systemFontOfSize:14];
    
    tishiLab.textColor=[UIColor whiteColor];
    
    tishiLab.numberOfLines=0;
    
    tishiLab.adjustsFontSizeToFitWidth=YES;
    
    [_bgScrollView addSubview:tishiLab];
    
    
    //注册按钮
    _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(45 , ViewBelow(tishiLab) + 25 * AUTO_IPHONE6_HEIGHT_667, windowContentWidth - 90, 45)];
    
    [_submitButton addTarget:self action:@selector(pushToResetPasswordVCButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_submitButton setTitle:@"提 交" forState:UIControlStateNormal];
    
    _submitButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _submitButton.titleLabel.font = [UIFont systemFontOfSize:19];
    
    [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//设置title在一般情况下为白色字体
    
    [_submitButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];//设置title在button被选中情况下为灰色字体
    
    [_submitButton setBackgroundImage:[UIImage imageNamed:@"登录注册按钮背景"] forState:UIControlStateNormal];
    
    [_bgScrollView addSubview:_submitButton];
    
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
#pragma mark  提交按钮

-(void)pushToResetPasswordVCButton:(UIButton *)btn{
    
    //判断电话号码
    if (_userPhoneNumTF.text.length!=11) {
        
        [[LXAlterView sharedMyTools] createTishi:@"手机号不正确或者为空"];
        
    }
    else if (![self isPhoneNumber:_userPhoneNumTF.text])
    {
        
        [[LXAlterView sharedMyTools] createTishi:@"手机号不合法"];
        
    }
    else{
        
        NSDictionary *parameters = @{@"phone":_userPhoneNumTF.text,
                                     @"token": @"7a6bd7af36e5db226281a037909fbdfd",
                                     @"code":_authCodeTF.text};
        
        NSString *jsonStr = [[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:parameters];
        
        NSDictionary *data = @{@"data": jsonStr};
        
        [self sendRequest1:data aurl:JudgeAuthCode];
        
        _submitButton.enabled = NO;
        
    }
    
}

#pragma mark
#pragma mark  验证手机号验证码请求

-(void)sendRequest1:(NSDictionary *)parameters aurl:(NSString *)url
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSLog(@"%@", parameters);
    
    [manager POST:url parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              
              NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              
              DLog(@"验证码----%@",resultDict);
              
              NSInteger status = [[resultDict objectForKey:@"status"] integerValue];
              
              
              if (status == 1) {
                  
                  [[UIApplication sharedApplication].keyWindow endEditing:YES];
                  
                  ResetPasswordViewController *resetPassword = [[ResetPasswordViewController alloc]init];
                  
                  resetPassword.upperViewController = self.upperViewController;
                  
                  resetPassword.phoneNum = _userPhoneNumTF.text;
                  
                  resetPassword.memberType = self.memberType;
                  
                  [self.navigationController pushViewController:resetPassword animated:YES];
                  
              }
              else if (status == -1){
                  
                  [[LXAlterView sharedMyTools] createTishi:[resultDict objectForKey:@"msg"]];
                  
              }
              
              _submitButton.enabled = YES;
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              
              _submitButton.enabled = YES;
              
          }];
}

#pragma mark
#pragma mark  倒计时

-(void)startTime{
    
    __block int timeout=60; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                _authCodeButton.backgroundColor=[UIColor clearColor];
                
                [_authCodeButton setBackgroundImage:[UIImage imageNamed:@"登录注册发送验证码"] forState:UIControlStateNormal];
                
                [_authCodeButton setTitle:@"重新发送" forState:UIControlStateNormal];
                
                [_authCodeButton setTitleColor:kColor(255, 153, 102) forState:UIControlStateNormal];
                
                _authCodeButton.backgroundColor = [UIColor whiteColor];
                
                _authCodeButton.titleLabel.font=[UIFont systemFontOfSize:12];
                
                _authCodeButton.userInteractionEnabled = YES;
                
            });
            
        }else{
            
            //            int minutes = timeout / 60;
            int seconds = timeout % 61;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [_authCodeButton setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                
                [_authCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                [_authCodeButton setBackgroundImage:[UIImage imageNamed:@"登录注册倒计时"] forState:UIControlStateNormal];
                
                _authCodeButton.titleLabel.textColor = [UIColor whiteColor];
                
                _authCodeButton.titleLabel.font=[UIFont systemFontOfSize:10];
                
                _authCodeButton.userInteractionEnabled = NO;
                
            });
            
            timeout--;
            
        }
    });
    
    dispatch_resume(_timer);
    
}


#pragma mark
#pragma mark  获取验证码按钮

-(void)authCodeButton:(UIButton *)btn
{
    NSString * memberStr = @"";
    
    if (self.memberType == WLMemberTypeMember) {
        
        memberStr = @"member";
        
    }
    else if (self.memberType == WLMemberTypeSteward) {
        
        memberStr = @"assistant";
    }
    
    
    //判断电话号码
    if (_userPhoneNumTF.text.length!=11) {
        
        [[LXAlterView sharedMyTools] createTishi:@"手机号不正确或者为空"];
        
    }
    else if (![self isPhoneNumber:_userPhoneNumTF.text])
    {
        
        [[LXAlterView sharedMyTools] createTishi:@"手机号不合法"];
        
    }
    else
    {
        [self hideKeyboard];
        
        //        _submitButton.enabled = NO;
        
        //获取电话号码，及token密钥
        NSDictionary *parameters = @{@"usergroup":memberStr,
                                     @"phone":_userPhoneNumTF.text,
                                     @"token": @"7a6bd7af36e5db226281a037909fbdfd"};
        
        //将字典转化封装为Json字符串
        NSString *jsonStr = [[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:parameters];
        
        //将Json字符串放入字典
        NSDictionary *data = @{@"data": jsonStr};
        
        //发送请求
        [self sendRequest:data aurl:ForgetPwdGetPwd];
    }
    
}

#pragma mark
#pragma mark  发送验证码请求

-(void)sendRequest:(NSDictionary *)parameters aurl:(NSString *)url
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSLog(@"%@", parameters);
    
    
    [manager POST:url parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              
              NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              
              DLog(@"手机号----resultDict%@",resultDict);
              
              NSInteger status = [[resultDict objectForKey:@"status"] integerValue];
              
              
              if (status == 1) {
                  
                  [self startTime];
                  
                  _submitButton.enabled = YES;
                  
              }
              
              [[LXAlterView sharedMyTools] createTishi:[resultDict objectForKey:@"msg"]];
              
              
              
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              
              [[LXAlterView sharedMyTools] createTishi:@"验证失败，请重新发送"];
              
              _submitButton.enabled = YES;
              
          }];
}

#pragma mark
#pragma mark  返回上一页

-(void)popButton:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark
#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if(textField == _userPhoneNumTF)
    {
        NSCharacterSet *cs;
        
        //---判断只能输入数字
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        BOOL basicTest = [string isEqualToString:filtered];
        
        if(!basicTest)
        {
            //输入了非法字符
            return NO;
        }
        
        //---不能超过11位
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (toBeString.length>11)
        {
            return NO;
        }
    }
    
    //其他的类型不需要检测，直接写入
    return YES;
    
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark
#pragma mark  判断是否是手机号

-(BOOL)isPhoneNumber:(NSString *)str
{
    const char *charArr  = [str cStringUsingEncoding:NSUTF8StringEncoding];
    
    for (int i=0;i<str.length;i++)
    {
        
        if (charArr[i]>='0'&&charArr[i]<='9') {
            
            continue;
        }
        else
        {
            return NO;
        }
    }
    return YES;
}
@end

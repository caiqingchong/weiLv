//
//  LoginAndRegisterViewController.m
//  WelLv
//
//  Created by 赵阳 on 16/3/1.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "LoginAndRegisterViewController.h"
//#import "AFNetworking.h"
#import "LXUserTool.h"
#import "BindLoginViewController.h"
#import "ThirdLoginBinding.h"
#import "ForgetPwdViewController.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WLLoginIconTFView.h"
#import "APService.h"
#import "WebViewOfCleanSameNameVC.h"

#define NUMBERS @"0123456789\n"

#define AUTO_IPHONE6_HEIGHT_667 windowContentHeight/667

#define AUTO_IPHONE6_WIDTH_375 windowContentWidth/375


@interface LoginAndRegisterViewController () < UIScrollViewDelegate ,UITextFieldDelegate >
{
    //页面底层View
    UIScrollView *_backScrollView;
    
    //登录注册滑动视图
    UIScrollView *_loginAndRegisterScrollView;
    
    //返回上一页按钮
    UIButton *_backButton;
    
    //返回上一页按钮图片
    UIImageView *_backButtonImage;
    
    //页面title
    UILabel *_pageTitleLabel;
    
    //右上角“登录”与“注册”切换按钮
    UIButton *_loginAndRegisterTypeButton;
    
    //右上角“登录”与“注册”切换按钮label
    UILabel *_loginAndRegisterTypeButtonLabel;
    
    //logo图标
    UIImageView *_logoImageView;
    
    //页面背景图片
    UIImageView *_backgroundImageView;
    
    //用户类型title
    UILabel *_memberTitleLabel;//会员
    UILabel *_stewardTitleLabel;//管家
    
    //用户类型button
    UIButton *_memberButton;//会员
    UIButton *_stewardButton;//管家
    
    //下划线
    UIView *_underlineView1;
    UIView *_underlineView2;
    UIView *_underlineView3;
    UIView *_underlineView4;
    UIView *_underlineView5;
    UIView *_underlineView6;
    
    
    //登录注册手机号图片
    UIImageView *_loginPhoneNumImage;
    UIImageView *_registerPhoneNumImage;
    
    //登录注册密码图片
    UIImageView *_loginPasswordImage;
    UIImageView *_registerPasswordImage;
    
    //明文、非明文切换图片、按钮
    UIImageView *_passwordShowTypeImage;
    UIButton *_passwordShowTypeButton;
    
    //登录注册手机号码输入框
    UITextField *_loginPhoneNumTF;
    UITextField *_registerPhoneNumTF;
    
    //登录注册密码输入框
    UITextField *_loginPasswordTF;
    UITextField *_registerPasswordTF;
    
    //注册验证码输入框、图片
    UIImageView *_authCodeImage;
    UITextField *_authCodeTF;
    
    //发送验证码图片、按钮
    UIImageView *_authCodeButtonImage;
    UIButton *_authCodeButton;
    
    //登录按钮
    UIButton *_loginButton;
    
    //注册按钮
    UIButton *_registerButton;
    
    //忘记密码
    UIButton *_missPasswordButton;
    
    //微信登录按钮
    UIButton *_weiXinLoginButton;
    
    //微信label
    UILabel *_weiXinLoginLabel;
    
    //QQ登录按钮
    UIButton *_QQLoginButton;
    
    //QQlabel
    UILabel *_QQLofinLabel;
    
    
}

@property (nonatomic, assign) WLMemberType memberType;//用户类型




@end

@implementation LoginAndRegisterViewController

@synthesize block;

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    [XCLoadMsg removeLoadMsg:self];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [_loginPasswordTF setText:nil];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAccess_token:) name:WeiCode object:nil];
    
    
    self.memberType = WLMemberTypeMember;
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    //改变输入框光标颜色
    [[UITextField appearance] setTintColor:[UIColor whiteColor]];
    
    //加载不需要滑动的固定视图
    [self initContent];
    
    //加载需要滑动的视图
    [self initScrollView];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popToLogin:) name:@"popToLogin" object:nil];
}

#pragma mark - 第三方调整，注册的通知
- (void)popToLogin:(NSNotification *)text
{
    
    NSString *type=text.userInfo[@"loginPerson"];
    NSString *tel=text.userInfo[@"Tel"];
    if([type isEqual:@"1"])
    {
        //表示会员登录
        _loginPhoneNumTF.text=tel;
        self.memberType = WLMemberTypeMember;
        _underlineView1.frame = CGRectMake(50 + ViewWidth(_memberButton)/4, 46, ViewWidth(_memberButton)/2, 1);
        
    }
    else if([type isEqual:@"2"])
    {
        //表示管家登录
        _loginPhoneNumTF.text=tel;
        self.memberType = WLMemberTypeSteward;
        _underlineView1.frame = CGRectMake(CGRectGetMaxX(_memberButton.frame) + ViewWidth(_memberButton)/4, 46, ViewWidth(_memberButton)/2, 1);
        
        _loginAndRegisterTypeButton.hidden = YES;
        
        _loginAndRegisterTypeButtonLabel.hidden = YES;
        
        _weiXinLoginButton.hidden = YES;
        
        _weiXinLoginLabel.hidden = YES;
        
        _QQLoginButton.hidden = YES;
        
        _QQLofinLabel.hidden = YES;
        
    }
    
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
}


#pragma mark

-(void)initContent{
    
    //页面背景图片
    _backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    
    _backgroundImageView.image = [UIImage imageNamed:@"登录注册页面背景"];
    
    [self.view addSubview:_backgroundImageView];
    
    //页面底层ScrollView
    _backScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    
    _backScrollView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapBgScrollView:)];
    
    [_backScrollView addGestureRecognizer:tapGesture];
    
    [self.view addSubview:_backScrollView];
    
    //返回按钮
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _backButton.frame = CGRectMake(0, 20 * AUTO_IPHONE6_HEIGHT_667, 60, 50);
    
    [_backButton addTarget:self action:@selector(popButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_backScrollView addSubview:_backButton];
    
    
    //返回按钮图片
    _backButtonImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15 * AUTO_IPHONE6_HEIGHT_667, 16, 26)];
    
    _backButtonImage.image = [UIImage imageNamed:@"登录注册返回键"];
    
    [_backButton addSubview:_backButtonImage];
    
    
    //页面title
    _pageTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 35 * AUTO_IPHONE6_HEIGHT_667, windowContentWidth, 25)];
    
    _pageTitleLabel.text = @"会员登录";
    
    _pageTitleLabel.textColor = [UIColor whiteColor];
    
    _pageTitleLabel.font = [UIFont systemFontOfSize:19];
    
    _pageTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    [_backScrollView addSubview:_pageTitleLabel];
    
    
    //右上角“登录”与“注册”切换按钮label
    _loginAndRegisterTypeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth - 100, 35 * AUTO_IPHONE6_HEIGHT_667, 80, 25)];
    
    _loginAndRegisterTypeButtonLabel.text = @"注册";
    
    _loginAndRegisterTypeButtonLabel.textColor = [UIColor whiteColor];
    
    _loginAndRegisterTypeButtonLabel.font = [UIFont systemFontOfSize:17];
    
    _loginAndRegisterTypeButtonLabel.textAlignment = NSTextAlignmentRight;
    
    [_backScrollView addSubview:_loginAndRegisterTypeButtonLabel];
    
    
    //右上角“登录”与“注册”切换按钮
    _loginAndRegisterTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _loginAndRegisterTypeButton.frame = CGRectMake(windowContentWidth - 100, 30 * AUTO_IPHONE6_HEIGHT_667, 100, 45);
    
    [_loginAndRegisterTypeButton addTarget:self action:@selector(loginAndRegisterTypeButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_backScrollView addSubview:_loginAndRegisterTypeButton];
    
    
    //logo图标
    
    UIImage *login_reg_logo=[UIImage imageNamed:@"login_reg_logo"];
    
    _logoImageView = [[UIImageView alloc]init];
    
    _logoImageView.frame = CGRectMake((windowContentWidth - login_reg_logo.size.width)/2, login_reg_logo.size.width  * AUTO_IPHONE6_HEIGHT_667,login_reg_logo.size.width, login_reg_logo.size.height);
    
    if (windowContentHeight == 480) {
        
        _logoImageView.frame = CGRectMake((windowContentWidth - login_reg_logo.size.width)/2, (login_reg_logo.size.width-10)  * AUTO_IPHONE6_HEIGHT_667, login_reg_logo.size.width, login_reg_logo.size.height);
        
    }
    
    _logoImageView.image =login_reg_logo;
    
    [_backScrollView addSubview:_logoImageView];
    
}

#pragma mark

-(void)initScrollView{
    
    //滑动控件
    _loginAndRegisterScrollView = [[UIScrollView alloc]init];
    
    _loginAndRegisterScrollView.frame = CGRectMake(0, 170 * AUTO_IPHONE6_HEIGHT_667, windowContentWidth, windowContentHeight - 170 * AUTO_IPHONE6_HEIGHT_667);
    
    if (self.isRegister) {
        
        _loginAndRegisterScrollView.contentSize = CGSizeMake(windowContentWidth * 2, windowContentHeight - 170 * AUTO_IPHONE6_HEIGHT_667);//计算ScroollView需要的大小
        
        _pageTitleLabel.text = @"手机号注册";
        
        _loginAndRegisterTypeButtonLabel.text = @"返回登录";
        
        _loginAndRegisterScrollView.contentOffset = CGPointMake(windowContentWidth, _loginAndRegisterScrollView.contentOffset.y);
        
        _loginAndRegisterScrollView.scrollEnabled = NO;
    }
    
    _loginAndRegisterScrollView.delegate = self;
    
    _loginAndRegisterScrollView.showsHorizontalScrollIndicator = NO;
    
    _loginAndRegisterScrollView.showsVerticalScrollIndicator = NO;//隐藏垂直滚动条
    
    _loginAndRegisterScrollView.bounces = NO;//弹簧效果
    
    _loginAndRegisterScrollView.pagingEnabled = YES;//是否翻页
    
    _loginAndRegisterScrollView.alwaysBounceHorizontal = NO;//控制水平方向遇到边框是否反弹
    
    [_backScrollView addSubview:_loginAndRegisterScrollView];
    
    
    //“左滑”和“右滑”手势
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [_loginAndRegisterScrollView addGestureRecognizer:self.leftSwipeGestureRecognizer];
    
    [_loginAndRegisterScrollView addGestureRecognizer:self.rightSwipeGestureRecognizer];
    
    
#pragma mark
    
#pragma mark  会员、管家登录
    
    //会员label
    _memberTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 20 * AUTO_IPHONE6_HEIGHT_667, windowContentWidth/2 - 50, 20)];
    
    _memberTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    _memberTitleLabel.text = @"会员";
    
    _memberTitleLabel.font = [UIFont systemFontOfSize:17];
    
    _memberTitleLabel.textColor = [UIColor whiteColor];
    
    [_loginAndRegisterScrollView addSubview:_memberTitleLabel];
    
    
    //管家label
    _stewardTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth/2, 20 * AUTO_IPHONE6_HEIGHT_667, windowContentWidth/2 - 50, 20)];
    
    _stewardTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    _stewardTitleLabel.text = @"管家";
    
    _stewardTitleLabel.font = [UIFont systemFontOfSize:17];
    
    _stewardTitleLabel.textColor = [UIColor whiteColor];
    
    [_loginAndRegisterScrollView addSubview:_stewardTitleLabel];
    
    
    //会员button
    _memberButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _memberButton.frame = CGRectMake(50, 10 * AUTO_IPHONE6_HEIGHT_667, windowContentWidth/2 - 50, 40);
    
    [_memberButton addTarget:self action:@selector(memberButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_loginAndRegisterScrollView addSubview:_memberButton];
    
    
    //管家button
    _stewardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _stewardButton.frame = CGRectMake(windowContentWidth/2, 10 * AUTO_IPHONE6_HEIGHT_667, windowContentWidth/2 - 50, 40);
    
    [_stewardButton addTarget:self action:@selector(stewardButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_loginAndRegisterScrollView addSubview:_stewardButton];
    
    
    //用户类型下划线
    _underlineView1 = [[UIView alloc]initWithFrame:CGRectMake(50 + ViewWidth(_memberButton)/4, 46 , ViewWidth(_memberButton)/2, 1)];
    
    _underlineView1.backgroundColor = [UIColor whiteColor];
    
    [_loginAndRegisterScrollView addSubview:_underlineView1];
    
    
    //登录手机号图标
    _loginPhoneNumImage = [[UIImageView alloc]init];
    
    _loginPhoneNumImage.frame = CGRectMake(50, ViewHeight(_memberButton) + 55 * AUTO_IPHONE6_HEIGHT_667, 19, 26);
    
    _loginPhoneNumImage.image = [UIImage imageNamed:@"登录注册手机号"];
    
    [_loginAndRegisterScrollView addSubview:_loginPhoneNumImage];
    
    
    //登录手机号输入框
    _loginPhoneNumTF = [[UITextField alloc]initWithFrame:CGRectMake(ViewRight(_loginPhoneNumImage) + 15, ViewY(_loginPhoneNumImage), windowContentWidth - 135 * AUTO_IPHONE6_WIDTH_375, 25)];
    
    _loginPhoneNumTF.borderStyle=UITextBorderStyleNone;
    
    
    if (self.memberType == WLMemberTypeSteward) {
        
        //登录用户为管家时
        _loginPhoneNumTF.keyboardType=UIKeyboardTypeNumberPad;
        
        _loginPhoneNumTF.placeholder=@"请输入手机号";
    }
    else{
        
        //登录用户为会员时
        _loginPhoneNumTF.keyboardType = UIKeyboardTypeDefault;
        _loginPhoneNumTF.autocorrectionType=UITextAutocorrectionTypeNo;//不自动更正
        _loginPhoneNumTF.autocapitalizationType = UITextAutocapitalizationTypeNone;//设置英文键盘默认小写
        
        _loginPhoneNumTF.placeholder=@"请输入手机号或用户名";
    }
    
    
    [_loginPhoneNumTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    _loginPhoneNumTF.textColor = [UIColor whiteColor];
    
    _loginPhoneNumTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _loginPhoneNumTF.delegate=self;
    
    [_loginAndRegisterScrollView addSubview:_loginPhoneNumTF];
    
    
    //输入框下方分割线
    _underlineView2 = [[UIView alloc]initWithFrame:CGRectMake(45, ViewBelow(_loginPhoneNumImage) + 5 * AUTO_IPHONE6_HEIGHT_667, windowContentWidth - 90, 1)];
    
    _underlineView2.backgroundColor = [UIColor whiteColor];
    
    _underlineView2.alpha = 0.5;
    
    [_loginAndRegisterScrollView addSubview:_underlineView2];
    
    
    //登录密码图标
    _loginPasswordImage = [[UIImageView alloc]init];
    
    _loginPasswordImage.frame = CGRectMake(50, ViewBelow(_underlineView2) + 20 * AUTO_IPHONE6_HEIGHT_667, 19, 26);
    
    _loginPasswordImage.image = [UIImage imageNamed:@"登录注册密码"];
    
    [_loginAndRegisterScrollView addSubview:_loginPasswordImage];
    
    
    //登录密码输入框
    _loginPasswordTF = [[UITextField alloc]initWithFrame:CGRectMake(ViewRight(_loginPhoneNumImage) + 15, ViewBelow(_underlineView2) + 20 * AUTO_IPHONE6_HEIGHT_667, windowContentWidth - 90*2, 25)];
    
    _loginPasswordTF.borderStyle=UITextBorderStyleNone;
    
    _loginPasswordTF.keyboardType=UIKeyboardTypeDefault;
    
    _loginPasswordTF.placeholder=@"请输入密码";
    
    _loginPasswordTF.secureTextEntry = YES;
    
    [_loginPasswordTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    _loginPasswordTF.textColor = [UIColor whiteColor];
    
    _loginPasswordTF.delegate=self;
    
    [_loginAndRegisterScrollView addSubview:_loginPasswordTF];
    
    
    //明文非明文按钮
    _passwordShowTypeButton = [[UIButton alloc]initWithFrame:CGRectMake(ViewRight(_loginPasswordTF), ViewBelow(_underlineView2) + 5 * AUTO_IPHONE6_HEIGHT_667, 50, 40)];
    
    [_passwordShowTypeButton addTarget:self action:@selector(passwordShowTypeButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_loginAndRegisterScrollView addSubview:_passwordShowTypeButton];
    
    
    //明文非明文图片
    _passwordShowTypeImage = [[UIImageView alloc]initWithFrame:CGRectMake(22, 18 * AUTO_IPHONE6_HEIGHT_667, 20, 11)];
    
    _passwordShowTypeImage.image = [UIImage imageNamed:@"登录注册非明文密码"];
    
    [_passwordShowTypeButton addSubview:_passwordShowTypeImage];
    
    
    //输入框下方分割线
    _underlineView3 = [[UIView alloc]initWithFrame:CGRectMake(45, ViewBelow(_loginPasswordImage) + 5 * AUTO_IPHONE6_HEIGHT_667, windowContentWidth - 90, 1)];
    
    _underlineView3.backgroundColor = [UIColor whiteColor];
    
    _underlineView3.alpha = 0.5;
    
    [_loginAndRegisterScrollView addSubview:_underlineView3];
    
    
    //登录按钮
    _loginButton = [[UIButton alloc]initWithFrame:CGRectMake(45, ViewBelow(_underlineView3) + 25 * AUTO_IPHONE6_HEIGHT_667, windowContentWidth - 90, 45)];
    
    [_loginButton addTarget:self action:@selector(loginButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_loginButton setTitle:@"登  录" forState:UIControlStateNormal];
    
    _loginButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _loginButton.titleLabel.font = [UIFont systemFontOfSize:19];
    
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//设置title在一般情况下为白色字体
    
    [_loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];//设置title在button被选中情况下为灰色字体
    
    [_loginButton setBackgroundImage:[UIImage imageNamed:@"登录注册按钮背景"] forState:UIControlStateNormal];
    
    [_loginAndRegisterScrollView addSubview:_loginButton];
    
    
#pragma mark
    
#pragma mark  忘记密码
    
    //忘记密码按钮
    _missPasswordButton = [[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth - 115, ViewBelow(_loginButton) + 10 * AUTO_IPHONE6_HEIGHT_667, 70, 30)];
    
    [_missPasswordButton setTitle:@"忘记密码 ?" forState:UIControlStateNormal];
    
    [_missPasswordButton addTarget:self action:@selector(missPasswordButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _missPasswordButton.titleLabel.textAlignment = NSTextAlignmentRight;
    
    _missPasswordButton.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [_missPasswordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//设置title在一般情况下为白色字体
    
    [_loginAndRegisterScrollView addSubview:_missPasswordButton];
    
    
#pragma mark
    
#pragma mark  微信、QQ第三方登录
    
    //微信第三方登录按钮
    _weiXinLoginButton = [[UIButton alloc]init];
    
    _weiXinLoginButton.frame = CGRectMake(windowContentWidth/3 - 30, ViewHeight(_loginAndRegisterScrollView) - 110 * AUTO_IPHONE6_HEIGHT_667, 60, 60);
    
    if (windowContentHeight == 480) {
        
        _weiXinLoginButton.frame = CGRectMake(windowContentWidth/3 - 30, ViewHeight(_loginAndRegisterScrollView) - 125 * AUTO_IPHONE6_HEIGHT_667, 60, 60);
        
    }
    
    [_weiXinLoginButton setBackgroundImage:[UIImage imageNamed:@"第三方登录微信"] forState:UIControlStateNormal];
    
    [_weiXinLoginButton addTarget:self action:@selector(weiXinLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_loginAndRegisterScrollView addSubview:_weiXinLoginButton];
    
    
    //微信第三方登录label
    _weiXinLoginLabel = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth/3 - 35, ViewBelow(_weiXinLoginButton) + 8 * AUTO_IPHONE6_HEIGHT_667, 70, 20 * AUTO_IPHONE6_HEIGHT_667)];
    
    _weiXinLoginLabel.text = @"微信登录";
    
    _weiXinLoginLabel.textColor = [UIColor whiteColor];
    
    _weiXinLoginLabel.font = [UIFont systemFontOfSize:13];
    
    _weiXinLoginLabel.textAlignment = NSTextAlignmentCenter;
    
    [_loginAndRegisterScrollView addSubview:_weiXinLoginLabel];
    
    
    //QQ第三方登录按钮
    _QQLoginButton = [[UIButton alloc]init];
    
    _QQLoginButton.frame = CGRectMake(windowContentWidth/3 * 2 - 30, ViewHeight(_loginAndRegisterScrollView) - 110 * AUTO_IPHONE6_HEIGHT_667, 60, 60);
    
    if (windowContentHeight == 480) {
        
        _QQLoginButton.frame = CGRectMake(windowContentWidth/3 * 2 - 30, ViewHeight(_loginAndRegisterScrollView) - 125 * AUTO_IPHONE6_HEIGHT_667, 60, 60);
        
    }
    
    [_QQLoginButton setBackgroundImage:[UIImage imageNamed:@"第三方登录QQ"] forState:UIControlStateNormal];
    
    [_QQLoginButton addTarget:self action:@selector(QQLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_loginAndRegisterScrollView addSubview:_QQLoginButton];
    
    
    //QQ第三方登录label
    _QQLofinLabel = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth/3 * 2 - 35, ViewBelow(_QQLoginButton) + 8 * AUTO_IPHONE6_HEIGHT_667, 70, 20 * AUTO_IPHONE6_HEIGHT_667)];
    
    _QQLofinLabel.text = @"QQ登录";
    
    _QQLofinLabel.textColor = [UIColor whiteColor];
    
    _QQLofinLabel.font = [UIFont systemFontOfSize:13];
    
    _QQLofinLabel.textAlignment = NSTextAlignmentCenter;
    
    [_loginAndRegisterScrollView addSubview:_QQLofinLabel];
    
    
#pragma mark
    
#pragma mark  注册视图
    
    [self initRegisterView];
    
}

//注册视图
-(void)initRegisterView{
    
    //注册手机号图标
    _registerPhoneNumImage = [[UIImageView alloc]init];
    
    _registerPhoneNumImage.frame = CGRectMake(50 + windowContentWidth, ViewHeight(_memberButton) + 55 * AUTO_IPHONE6_HEIGHT_667, 19, 26);
    
    _registerPhoneNumImage.image = [UIImage imageNamed:@"登录注册手机号"];
    
    [_loginAndRegisterScrollView addSubview:_registerPhoneNumImage];
    
    
    //注册手机号输入框
    _registerPhoneNumTF = [[UITextField alloc]initWithFrame:CGRectMake(ViewRight(_registerPhoneNumImage) + 15, ViewY(_registerPhoneNumImage), windowContentWidth - 135 * AUTO_IPHONE6_WIDTH_375, 25)];
    
    _registerPhoneNumTF.borderStyle=UITextBorderStyleNone;
    
    _registerPhoneNumTF.keyboardType=UIKeyboardTypeNumberPad;
    
    _registerPhoneNumTF.placeholder=@"请输入手机号";
    
    [_registerPhoneNumTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    _registerPhoneNumTF.textColor = [UIColor whiteColor];
    
    _registerPhoneNumTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _registerPhoneNumTF.delegate=self;
    
    [_loginAndRegisterScrollView addSubview:_registerPhoneNumTF];
    
    
    //输入框下方分割线
    _underlineView4 = [[UIView alloc]initWithFrame:CGRectMake(45 + windowContentWidth, ViewBelow(_registerPhoneNumImage) + 5 * AUTO_IPHONE6_HEIGHT_667, windowContentWidth - 90, 1)];
    
    _underlineView4.backgroundColor = [UIColor whiteColor];
    
    _underlineView4.alpha = 0.5;
    
    [_loginAndRegisterScrollView addSubview:_underlineView4];
    
    
    //验证码左边图标
    _authCodeImage = [[UIImageView alloc]init];
    
    _authCodeImage.frame = CGRectMake(50 + windowContentWidth, ViewBelow(_underlineView4) + 20 * AUTO_IPHONE6_HEIGHT_667, 19, 26);
    
    _authCodeImage.image = [UIImage imageNamed:@"登录注册手机号验证"];
    
    [_loginAndRegisterScrollView addSubview:_authCodeImage];
    
    
    //验证码输入框
    _authCodeTF = [[UITextField alloc]initWithFrame:CGRectMake(ViewRight(_authCodeImage) + 15, ViewBelow(_underlineView2) + 20 * AUTO_IPHONE6_HEIGHT_667, windowContentWidth - 90*2, 25)];
    
    _authCodeTF.borderStyle=UITextBorderStyleNone;
    
    _authCodeTF.keyboardType=UIKeyboardTypeNumberPad;
    
    _authCodeTF.placeholder=@"请输入验证码";
    
    [_authCodeTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    _authCodeTF.textColor = [UIColor whiteColor];
    
    _authCodeTF.delegate=self;
    
    [_loginAndRegisterScrollView addSubview:_authCodeTF];
    
    
    //验证码按钮
    _authCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth * 3/4 - 50 + windowContentWidth, ViewBelow(_underlineView4) + 15 * AUTO_IPHONE6_HEIGHT_667, 100 * AUTO_IPHONE6_WIDTH_375, 27)];
    
    [_authCodeButton addTarget:self action:@selector(registerAuthCodeButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _authCodeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _authCodeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    
    _authCodeButton.layer.cornerRadius = 3.0;
    
    [_authCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    
    [_authCodeButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    [_authCodeButton setBackgroundColor:[UIColor whiteColor]];
    
    [_loginAndRegisterScrollView addSubview:_authCodeButton];
    
    
    //输入框下方分割线
    _underlineView5 = [[UIView alloc]initWithFrame:CGRectMake(45 + windowContentWidth, ViewBelow(_authCodeImage) + 5 * AUTO_IPHONE6_HEIGHT_667, windowContentWidth - 90, 1)];
    
    _underlineView5.backgroundColor = [UIColor whiteColor];
    
    _underlineView5.alpha = 0.5;
    
    [_loginAndRegisterScrollView addSubview:_underlineView5];
    
    
    //注册密码图标
    _registerPasswordImage = [[UIImageView alloc]init];
    
    _registerPasswordImage.frame = CGRectMake(50 + windowContentWidth, ViewBelow(_underlineView5) + 20 * AUTO_IPHONE6_HEIGHT_667, 19, 26);
    
    _registerPasswordImage.image = [UIImage imageNamed:@"登录注册密码"];
    
    [_loginAndRegisterScrollView addSubview:_registerPasswordImage];
    
    
    //注册密码输入框
    _registerPasswordTF = [[UITextField alloc]initWithFrame:CGRectMake(ViewRight(_registerPasswordImage) + 15, ViewBelow(_underlineView5) + 20 * AUTO_IPHONE6_HEIGHT_667, windowContentWidth - 135 * AUTO_IPHONE6_WIDTH_375, 25)];
    
    _registerPasswordTF.borderStyle = UITextBorderStyleNone;
    
    _registerPasswordTF.keyboardType = UIKeyboardTypeASCIICapable;
    
    _registerPasswordTF.secureTextEntry = YES;
    
    _registerPasswordTF.autocapitalizationType = UITextAutocapitalizationTypeNone;//设置英文键盘默认小写
    
    _registerPasswordTF.placeholder = @"请输入密码";
    
    [_registerPasswordTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    _registerPasswordTF.textColor = [UIColor whiteColor];
    
    _registerPasswordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _registerPasswordTF.delegate=self;
    
    [_loginAndRegisterScrollView addSubview:_registerPasswordTF];
    
    
    //输入框下方分割线
    _underlineView6 = [[UIView alloc]initWithFrame:CGRectMake(45 + windowContentWidth, ViewBelow(_registerPasswordImage) + 5 * AUTO_IPHONE6_HEIGHT_667, windowContentWidth - 90, 1)];
    
    _underlineView6.backgroundColor = [UIColor whiteColor];
    
    _underlineView6.alpha = 0.5;
    
    [_loginAndRegisterScrollView addSubview:_underlineView6];
    
    
    //注册按钮
    _registerButton = [[UIButton alloc]initWithFrame:CGRectMake(45 + windowContentWidth, ViewBelow(_underlineView6) + 25 * AUTO_IPHONE6_HEIGHT_667, windowContentWidth - 90, 45)];
    
    [_registerButton addTarget:self action:@selector(registerButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_registerButton setTitle:@"注册并登录" forState:UIControlStateNormal];
    
    _registerButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _registerButton.titleLabel.font = [UIFont systemFontOfSize:19];
    
    [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//设置title在一般情况下为白色字体
    
    [_registerButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];//设置title在button被选中情况下为灰色字体
    
    [_registerButton setBackgroundImage:[UIImage imageNamed:@"登录注册按钮背景"] forState:UIControlStateNormal];
    
    [_loginAndRegisterScrollView addSubview:_registerButton];
    
    
}

- (void)onTapBgScrollView:(UITapGestureRecognizer *)tap {
    
    [self hideKeyboard];
}

//隐藏键盘
- (void)hideKeyboard {
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

#pragma mark
#pragma mark  注册--获取验证码按钮

-(void)registerAuthCodeButton:(UIButton *)btn{
    
    DLog(@"authCodeButton");
    //获取验证码
    if (_registerPhoneNumTF.text.length!=11) {
        
        DLog(@"手机号不正确或者为空");
        
        [[LXAlterView sharedMyTools] createTishi:@"手机号不正确或者为空"];
        
    }else
    {
        //[self startTime];
        //发送验证码
        NSDictionary *parameters = @{@"phone_number":_registerPhoneNumTF.text};
        
        [self sendRequest:parameters aurl:GetVerficatCodeUrl aTag:1];
        
    }
    
}

#pragma mark
#pragma mark  注册--注册并登录按钮

//注册并登陆按钮
-(void)registerButton:(UIButton *)btn{
    
    DLog(@"registerButton");
    
    //开始使用
    if (_registerPhoneNumTF.text.length!=11)
    {
        DLog(@"手机号不正确或者为空");
        
        [[LXAlterView sharedMyTools] createTishi:@"手机号不正确或者为空"];
        
    }
    else if(_registerPasswordTF.text.length==0){
        
        DLog(@"秘密啊不能为空");
        
        [[LXAlterView sharedMyTools] createTishi:@"密码不能为空"];
    }
    else if(_registerPasswordTF.text.length<6)
    {
        
        [[LXAlterView sharedMyTools] createTishi:@"请输入6位以上密码"];
        
    }
    else if(_authCodeTF.text.length==0)
    {
        DLog(@"请输入验证码");
        
        [[LXAlterView sharedMyTools] createTishi:@"请输入验证码"];
        
    }
    else
    {
        NSDictionary *parameters = @{@"phone":_registerPhoneNumTF.text,@"code":_authCodeTF.text,@"password":_registerPasswordTF.text,@"mtype":@"3"};
        
        [self sendRequest:parameters aurl:ordinaryRegisterUrl aTag:2];
    }
    
    
}

#pragma mark
#pragma mark  注册--“获取验证码/验证验证码”请求

-(void)sendRequest:(NSDictionary *)parameters aurl:(NSString *)url aTag:(int)tag
{
    
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:url parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              
              if (tag==1)
              {
                  
                  //获取验证码
                  if ([[responseObject objectForKey:@"msg"] isEqualToString:@"发送成功"]) {
                      
                      [[LXAlterView sharedMyTools] createTishi:[responseObject objectForKey:@"msg"]];
                      
                      [self startTime];
                      
                  }else
                  {
                      if ([[responseObject objectForKey:@"msg"] isEqualToString:@"手机号码已被注册"]) {
                          
                          UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"该手机号已经注册微旅会员，是否直接登录？" delegate:self cancelButtonTitle:@"去登陆" otherButtonTitles:@"取消", nil];
                          
                          [alerView show];
                      }
                      else{
                          
                          [[LXAlterView sharedMyTools] createTishi:[responseObject objectForKey:@"msg"]];
                          
                      }
                      
                  }
                  
              }
              else if(tag==2)
              {
                  //注册
                  DLog(@"Success: %@==msg=%@", responseObject,[responseObject objectForKey:@"msg"]);
                  
                  if ([[responseObject objectForKey:@"msg"] isEqualToString:@"注册成功！"])
                  {
                      
                      [[LXAlterView sharedMyTools] createTishi:[responseObject objectForKey:@"msg"]];
                      
                      NSDictionary *dic=[responseObject objectForKey:@"data"];
                      
                      DLog(@"注册成功");
                      
                      [[LXUserTool alloc] saveUserNameAndPwd:[dic objectForKey:@"username"]
                                                      andPwd:_registerPasswordTF.text
                                                  andBalance:[dic objectForKey:@"balance"]
                                                 andBirthday:[dic objectForKey:@"birthday"]
                                               andCreatetime:[dic objectForKey:@"createtime"]
                                                     andDiqu:[dic objectForKey:@"diqu"]
                                                    andEmail:[dic objectForKey:@"email"]
                                                 andIdnumber:[dic objectForKey:@"idnumber"]
                                                   andIdtype:[dic objectForKey:@"idtype"]
                                                    andLevel:[dic objectForKey:@"level"]
                                                   andLevels:[dic objectForKey:@"levels"]
                                                andLogintime:[dic objectForKey:@"logintime"]
                                                    andMtype:[dic objectForKey:@"mtype"]
                                                    andPhone:[dic objectForKey:@"phone"]
                                                 andRealname:[dic objectForKey:@"realname"]
                                                     andSalt:[dic objectForKey:@"salt"]
                                                      adnSex:[dic objectForKey:@"sex"]
                                           andShengshiquxian:[dic objectForKey:@"address"]
                                                      andUid:[dic objectForKey:@"uid"]
                                             adnAssistant_id:[dic objectForKey:@"assistant_id"]
                                            andIs_detachable:[dic objectForKey:@"is_detachable"]
                                                andUsergroup:[dic objectForKey:@"usergroup"]
                                                   andAvater:[dic objectForKey:@"avater"]
                                             andMember_count:[dic objectForKey:@"member_count"]
                                                     andPwd2:_registerPasswordTF.text
                                              andIs_withdraw:[dic objectForKey:@"is_withdraw"]];
                      
                      //跳回登录前页面
                      //[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-3] animated:YES];
                      //NSArray *array=@[_userTF.text,_pwdTF.text];
                      [[LXUserTool sharedUserTool] addUserMemberWithDic:dic];
                      
                      [super close];
                      if (self.block) {
                          
                          block(_registerPhoneNumTF.text);
                      }
                      
                  }
                  else
                  {
                      [[LXAlterView sharedMyTools] createTishi:[responseObject objectForKey:@"msg"]];
                      DLog(@"注册失败");
                  }
                  
              }
              [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              
              DLog(@"Error: %@", error);
              
              [[LXAlterView sharedMyTools] createTishi:@"注册失败，请检查网络"];
              
          }];
    
}

#pragma mark - 弹出框提示、注册手机号相同时

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0)
    {
        //计算ScroollView需要的大小
        _loginAndRegisterScrollView.contentSize = CGSizeMake(windowContentWidth, windowContentHeight - 170 * AUTO_IPHONE6_HEIGHT_667);
        
        _loginAndRegisterScrollView.contentOffset = CGPointMake(0, _loginAndRegisterScrollView.contentOffset.y);
        
        _pageTitleLabel.text = @"登录";
        
        _loginAndRegisterTypeButtonLabel.text = @"注册";
    }
}

#pragma mark - 倒计时

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
                //DLog(@"____%@",strTime);
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
#pragma mark  “忘记密码”按钮

-(void)missPasswordButton:(UIButton *)btn{
    
    DLog(@"missPasswordButton");
    
    ForgetPwdViewController *forgetPwdVC = [[ForgetPwdViewController alloc]init];
    
    forgetPwdVC.upperViewController = self;
    
    forgetPwdVC.memberType = self.memberType;
    
    [self.navigationController pushViewController:forgetPwdVC animated:YES];
    
}


#pragma mark - 明文、非明文按钮

-(void)passwordShowTypeButton:(UIButton *)btn{
    
    DLog(@"passwordShowTypeButton");
    
    _loginPasswordTF.secureTextEntry = !_loginPasswordTF.secureTextEntry;
    
    if (!_loginPasswordTF.secureTextEntry) {
        
        _passwordShowTypeImage.image = [UIImage imageNamed:@"登录注册明文密码"];
        
    }
    else{
        
        _passwordShowTypeImage.image = [UIImage imageNamed:@"登录注册非明文密码"];
        
    }
    
    NSString* text = _loginPasswordTF.text;
    
    _loginPasswordTF.text = @" ";
    
    _loginPasswordTF.text = text;
    
}


#pragma mark - 第三方登录 点击事件

//微信第三方登录
-(void)weiXinLoginButton:(UIButton *)btn{
    
    DLog(@"weiXinLoginButton");
    if ([WXApi isWXAppInstalled])
    {
        
        SendAuthReq *req = [[SendAuthReq alloc] init];
        
        req.scope =  @"snsapi_userinfo";
        
        req.state = @"weilv";
        
        req.openID = @"b5e3112f5ae05b3c3a8af70bdc36116a";
        
        [WXApi sendReq:req];
        
    }
    
}

//QQ第三方登录
-(void)QQLoginButton:(UIButton *)brn{
    
    DLog(@"QQLoginButton");
    [ShareSDK cancelAuthWithType:ShareTypeQQSpace];
    
    //qq登陆
    [ShareSDK getUserInfoWithType:ShareTypeQQSpace authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error){
        
        DLog(@"error == %@", error);
        
        if (result)
        {
            DLog(@"qq_user_info === %@", [userInfo uid]);
            
            [self QQIsLogin:[userInfo uid] image:[[userInfo sourceData] objectForKey:@"figureurl_qq_2"] name:[userInfo nickname]];
        }
        else
        {
            if ([error errorCode] == -6004)
            {
                [[LXAlterView alloc] createTishi:@"未安装应用"];
            }
            else
            {
                [[LXAlterView alloc] createTishi:@"授权失败"];
            }
        }
    }];
    
}

#pragma mark
#pragma mark  微信登录、验证信息notification

-(void)getAccess_token:(NSNotification *)notification
{
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WeiXinID,WeiXinAPPSecret,notification.object];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data)
            {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                access_token =  [dic objectForKey:@"access_token"];
                openid =  [dic objectForKey:@"openid"];
                
                [self getUserInfo];
            }
        });
    });
}
-(void)getUserInfo
{
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,openid];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                DLog(@"weixin JSON === %@", dic);
                [self isLogin:dic];
                
            }
        });
        
    });
}

#pragma mark - 微信验证是否是首次登陆
- (void)isLogin:(NSDictionary *)weiXinDic
{
    __weak LoginAndRegisterViewController * weakSelf = self;
    
    NSDictionary *parameters = @{@"wx_name":[weiXinDic objectForKey:@"nickname"],@"avater":[weiXinDic objectForKey:@"headimgurl"],@"openid":[weiXinDic objectForKey:@"openid"]};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:WeiLoginUrl parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         // DLog(@"参数：%@,JOSN ===%@",parameters,dic);
         if (dic != nil)
         {
             NSString *errStr = [dic objectForKey:@"msg"];
             int errNumber=[[dic objectForKey:@"errno"] intValue];
             if (errNumber==-1)
             {
                 //登录失败！请重试
                 [[LXAlterView sharedMyTools] createTishi:errStr];
                 return ;
             }
             else if (errNumber==0)
             {
                 //登录成功
                 if ([dic isKindOfClass:[NSDictionary class]])
                 {
                     [weakSelf dealWithUserWithDic:dic];
                 }
             }
             else if(errNumber==1 || errNumber==2)
             {
                 //1:手机号需要绑定,2:初次登录需要绑定手机号
                 //BindLoginViewController *bindVC = [[BindLoginViewController alloc] init];
                 ThirdLoginBinding *bindVC = [[ThirdLoginBinding alloc] init];
                 bindVC.phoneStr = [weiXinDic objectForKey:@"headimgurl"];
                 bindVC.name = [weiXinDic objectForKey:@"nickname"];
                 bindVC.openId = [weiXinDic objectForKey:@"openid"];
                 bindVC.loginType = @"WX";
                 [self.navigationController pushViewController:bindVC animated:YES];
             }
             else if (errNumber==8)
             {
                 //您是管家，请到管家登录
                 [[LXAlterView sharedMyTools] createTishi:errStr];
                 return;
             }
         }
         else
         {
             [[LXAlterView sharedMyTools] createTishi:@"网络请求失败"];
         }
     }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
         DLog(@"%@",error);
         [[LXAlterView sharedMyTools] createTishi:@"登陆失败"];
         
     }];
}
#pragma mark - qq验证是否是首次登陆
- (void)QQIsLogin:(NSString *)uid image:(NSString *)avter name:(NSString *)nickName
{
    NSDictionary *parameters = @{@"nick_name":nickName,@"avater":avter,@"openid":uid};
    DLog(@"openid===%@",uid);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    __weak LoginAndRegisterViewController * weakSelf = self;
    
    [manager POST:QQLoginUrl parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         DLog(@"QQ === JSON === %@", dic[@"msg"]);
         if (dic != nil)
         {
             NSString *errStr = [dic objectForKey:@"msg"];
             
             int errNumber=[[dic objectForKey:@"errno"] intValue];
             if (errNumber==-1)
             {
                 //登录失败！请重试
                 [[LXAlterView sharedMyTools] createTishi:errStr];
                 return ;
             }
             else if (errNumber==0)
             {
                 //登录成功
                 if ([dic isKindOfClass:[NSDictionary class]]) {
                     [weakSelf dealWithUserWithDic:dic];
                     
                 }
             }
             else if(errNumber==1 || errNumber==2)
             {
                 //1:手机号需要绑定,2:初次登录需要绑定手机号
                 //BindLoginViewController *bindVC = [[BindLoginViewController alloc] init];
                 ThirdLoginBinding *bindVC = [[ThirdLoginBinding alloc] init];
                 bindVC.phoneStr = avter;
                 bindVC.name = nickName;
                 bindVC.openId = uid;
                 bindVC.loginType = @"QQ";
                 [self.navigationController pushViewController:bindVC animated:YES];
             }
             else if (errNumber==8)
             {
                 //您是管家，请到管家登录
                 [[LXAlterView sharedMyTools] createTishi:errStr];
                 return;
             }
             
         }
         else
         {
             [[LXAlterView sharedMyTools] createTishi:@"网络请求失败"];
         }
     }failure:^(AFHTTPRequestOperation *operation,NSError *error)
     {
         [[LXAlterView sharedMyTools] createTishi:@"登陆失败"];
     }];
    
}

#pragma mark  点击登陆按钮

- (BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
    
}

#pragma mark - 登录按钮

-(void)loginButton:(UIButton *)btn{
    
    //登录
    if (_loginPhoneNumTF.text.length == 0 )
    {
        if (self.memberType == WLMemberTypeMember) {
            
            [[LXAlterView sharedMyTools] createTishi:@"手机号或用户名不能为空"];

        }
        else if (self.memberType == WLMemberTypeSteward){
            
            [[LXAlterView sharedMyTools] createTishi:@"手机号不能为空"];

        }
    }
    else
    {
        if ([self isMobileNumber:_loginPhoneNumTF.text])
        {
            if ( _loginPasswordTF.text.length == 0)
            {
                [[LXAlterView sharedMyTools] createTishi:@"密码不能为空"];
            }
            else
            {
                [self sendRequest];
            }
        }
        else
        {
            //                    if (_userNameView.inputTF.text.length<6) {
            //                        [[LXAlterView sharedMyTools] createTishi:@"用户名长度至少6为字符"];
            //                    }
            //                    else if (_userNameView.inputTF.text.length>25)
            //                    {
            //                        [[LXAlterView sharedMyTools] createTishi:@"用户名长度不能超过25个字符"];
            //                    }
            if ( _loginPasswordTF.text.length == 0)
            {
                [[LXAlterView sharedMyTools] createTishi:@"密码不能为空"];
            }
            else
            {
                [self sendRequest];
            }
        }
        
    }
    
}

#pragma mark
#pragma mark  判断是否是手机号
-(BOOL)isMobileNumber:(NSString *)mobileNum
{
    
    NSString *phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    BOOL isMatch = [pred evaluateWithObject:mobileNum];
    
    return isMatch;
}

#pragma mark
#pragma mark  登陆请求

-(void)sendRequest {
    
    NSDictionary * parameters = @{@"username":_loginPhoneNumTF.text,
                                  @"password":_loginPasswordTF.text};
    NSString * url = @"";
    if (self.memberType == WLMemberTypeMember) {
        url = ordinaryLoginUrl;
    } else if (self.memberType == WLMemberTypeSteward) {
        url = M_URL_STEWARD_LOGIN;
    }
    DLog(@"parameters = %@, url = %@", parameters, url);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    __weak LoginAndRegisterViewController * weakSelf = self;
    
    [manager POST:url
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              DLog(@"JSON == %@", dict);
              if ([dict isKindOfClass:[NSDictionary class]] &&
                  [[dict objectForKey:@"status"] integerValue] == 1 &&
                  [[dict objectForKey:@"data"]isKindOfClass:[NSDictionary class]])
              {
                  NSDictionary *dic=[dict objectForKey:@"data"];
                  if (weakSelf.memberType == WLMemberTypeMember) {
                      
#pragma mark  用户名相同时跳转的webview
                      
                      if ([[dict objectForKey:@"is_upgrade"] integerValue] == 1) {
                          
                          
                          WebViewOfCleanSameNameVC *forgetPwdVC = [[WebViewOfCleanSameNameVC alloc]init];
                          
                          forgetPwdVC.loginPasswordTF = _loginPasswordTF;
                          
                          forgetPwdVC.dict = dict;
                          
                          [self.navigationController pushViewController:forgetPwdVC animated:YES];
                          
                      }
                      else{
                          
                          [weakSelf dealWithUserWithDic:dict];
                      }
                      
                  } else if (weakSelf.memberType == WLMemberTypeSteward) {
                      DLog(@"登录成功 ------ 管家");
                      [[LXUserTool sharedUserTool] saveUserNameAndPwd:[dic objectForKey:@"nickname"]  //用户名
                                                               andPwd:_loginPasswordTF.text
                                                           andBalance:[dic objectForKey:@"balance"]
                                                          andBirthday:[dic objectForKey:@"birthday"]
                                                        andCreatetime:[dic objectForKey:@"createtime"]
                                                              andDiqu:[dic objectForKey:@"diqu"]
                                                             andEmail:[dic objectForKey:@"email"]
                                                          andIdnumber:[dic objectForKey:@"idnumber"]
                                                            andIdtype:[dic objectForKey:@"idtype"]
                                                             andLevel:[dic objectForKey:@"level"]   //评分
                                                            andLevels:[dic objectForKey:@"levels"]
                                                         andLogintime:[dic objectForKey:@"logintime"]
                                                             andMtype:[dic objectForKey:@"mtype"]
                                                             andPhone:[dic objectForKey:@"mobile"]   //移动电话
                                                          andRealname:[dic objectForKey:@"name"]     //真名
                                                              andSalt:[dic objectForKey:@"salt"]
                                                               adnSex:[dic objectForKey:@"sex"]
                                                    andShengshiquxian:[dic objectForKey:@"address"]   //地址
                                                               andUid:[dic objectForKey:@"id"]         //用户ID(管家ID)
                                                      adnAssistant_id:[dic objectForKey:@"assistant_id"] //管家ID
                                                     andIs_detachable:[dic objectForKey:@"is_detachable"]
                                                         andUsergroup:@"assistant"
                                                            andAvater:[dic objectForKey:@"avatar"]     //头像
                                                      andMember_count:[dic objectForKey:@"member_count"]
                                                              andPwd2:_loginPasswordTF.text
                                                       andIs_withdraw:[dict objectForKey:@"is_withdraw"]];
                      
                      NSNotification *notification = [NSNotification notificationWithName:UpdateImage object:nil];
                      [[NSNotificationCenter defaultCenter] postNotification:notification];
                      [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@", [self judgeReturnString:[dic objectForKey:@"store_id"] withReplaceString:@"0"]] forKey:@"ste_shop_ID"];
                      [[LXUserTool alloc] saveHouseAdmin:[dic objectForKey:@"seller_id"]];
                      
                      [[LXUserTool sharedUserTool] addUserStewardWithDic:dic];
                      DLog(@"*** uid === %@ ***", [LXUserTool sharedUserTool].modelSteward.regionName);
                      [weakSelf loginBlock];
                      __autoreleasing NSMutableSet *tags = [NSMutableSet set];
                      NSString *uidStr = [[LXUserTool sharedUserTool] getUid];
                      __autoreleasing NSString *alias = uidStr;
                      [self analyseInput:&alias tags:&tags];
                      
                      [APService setTags:tags
                                   alias:alias
                        callbackSelector:@selector(tagsAliasCallback:tags:alias:)
                                  target:self];
                  }
                  
                  
              } else {
                  DLog(@"登录失败");
                  [[LXAlterView sharedMyTools] createTishi:[dict objectForKey:@"msg"]];
                  
              }
              
              [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              DLog(@"Error: %@", error);
              [[LXAlterView sharedMyTools] createTishi:@"登录失败，请检查网络"];
              
          }];
    
}




#pragma mark
#pragma mark  处理普通会员登录成功后的信息

- (void)dealWithUserWithDic:(NSDictionary *)dict{
    NSDictionary *dic=[dict objectForKey:@"data"];
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        
        DLog(@"登录成功------会员");
        //把用户信息存到本地
        [[LXUserTool sharedUserTool] saveUserNameAndPwd:[dic objectForKey:@"username"]
                                                 andPwd:_loginPasswordTF.text
                                             andBalance:[dic objectForKey:@"balance"]
                                            andBirthday:[dic objectForKey:@"birthday"]
                                          andCreatetime:[dic objectForKey:@"createtime"]
                                                andDiqu:[dic objectForKey:@"diqu"]
                                               andEmail:[dic objectForKey:@"email"]
                                            andIdnumber:[dic objectForKey:@"idnumber"]
                                              andIdtype:[dic objectForKey:@"idtype"]
                                               andLevel:[dic objectForKey:@"level"]
                                              andLevels:[dic objectForKey:@"levels"]
                                           andLogintime:[dic objectForKey:@"logintime"]
                                               andMtype:[dic objectForKey:@"mtype"]
                                               andPhone:[dic objectForKey:@"phone"]
                                            andRealname:[dic objectForKey:@"realname"]
                                                andSalt:[dic objectForKey:@"salt"]
                                                 adnSex:[dic objectForKey:@"sex"]
                                      andShengshiquxian:[dic objectForKey:@"address"]
                                                 andUid:[dic objectForKey:@"uid"]
                                        adnAssistant_id:[dic objectForKey:@"assistant_id"]
                                       andIs_detachable:[dic objectForKey:@"is_detachable"]
                                           andUsergroup:[dic objectForKey:@"usergroup"]
                                              andAvater:[dic objectForKey:@"avater"]
                                        andMember_count:[dic objectForKey:@"member_count"]
                                                andPwd2:_loginPasswordTF.text
                                         andIs_withdraw:[dict objectForKey:@"is_withdraw"]];
        
        NSNotification *notification = [NSNotification notificationWithName:UpdateImage object:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];  //保存到本地磁盘
        [[LXUserTool sharedUserTool] deleteUserMemberDic];
        /**
         *  判断 合伙人store_id 是否位空
         */
        NSMutableDictionary * modelDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        if ([dict objectForKey:@"store_id"]) {
            [modelDic setObject:[dict objectForKey:@"store_id"] forKey:@"store_id"];
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@", [self judgeReturnString:[dict objectForKey:@"store_id"]  withReplaceString:@"0"]] forKey:@"ste_shop_ID"];
        } else {
            [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"ste_shop_ID"];
            
        }
        if ([dict objectForKey:@"assistant_mobile"]) {
            [modelDic setObject:[dict objectForKey:@"assistant_mobile"] forKey:@"assistant_mobile"];
        }
        [[LXUserTool sharedUserTool] addUserMemberWithDic:modelDic];
        [self loginBlock];
        /*---------------------支付推送测试-----------------------------------*/
        __autoreleasing NSMutableSet *tags = [NSMutableSet set];
        NSString *uidStr = [[LXUserTool sharedUserTool] getUid];
        __autoreleasing NSString *alias = uidStr;
        [self analyseInput:&alias tags:&tags];
        
        [APService setTags:tags
                     alias:alias
          callbackSelector:@selector(tagsAliasCallback:tags:alias:)
                    target:self];
    } else {
        [[LXAlterView sharedMyTools] createTishi:@"登录失败,请重试"];
    }
    
}

-(void)sendRequestGetAdmin_id:(NSString *)uid {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:getHouseAdmin_id(uid) parameters:nil
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              DLog(@"Success: %@,msg=%@", responseObject,[dic objectForKey:@"msg"]);
              if ([[dic objectForKey:@"status"] integerValue]==1) {
                  
                  [[LXUserTool alloc] saveHouseAdmin:[[dic objectForKey:@"data"] objectForKey:@"admin_id"]];
              }
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              DLog(@"Error: %@", error);
          }];
    
}
- (void)loadShopIDDataWithUserId:(NSString *)userID userType:(WLMemberType)userType {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString * typeStr = @"";
    NSString * url = @"";
    NSDictionary * parameters = @{};
    if (userType == WLMemberTypeMember) {
        typeStr = @"2";
        url = M_SS_URL_JUDGE_SHOP;
        parameters = @{@"uid":[[WLSingletonClass defaultWLSingleton] wlUserID],
                       @"type":typeStr};
    } else if (userType == WLMemberTypeSteward) {
        typeStr = @"1";
        url = M_SS_URL_SHOP_ID;
        parameters = @{@"uid":[[WLSingletonClass defaultWLSingleton] wlUserID],
                       @"id_type":typeStr};
    }
    
    DLog(@"***%@***\n *** parameters = %@ ***", url, parameters);
    
    __weak LoginAndRegisterViewController * weakSelf = self;
    [manager POST:url parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              DLog(@"shop_dic === %@", dic);
              DLog(@"%@", [dic objectForKey:@"msg"]);
              if ([dic isKindOfClass:[NSDictionary class]] && [[dic objectForKey:@"status"] integerValue] == 1) {
                  [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@", [self judgeReturnString:[[dic objectForKey:@"data"] objectForKey:@"store_id"] withReplaceString:@"0"]] forKey:@"ste_shop_ID"];
              } else {
                  [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"ste_shop_ID"];
              }
              [weakSelf loginBlock];
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              DLog(@"Error: %@", error);
              [[LXAlterView sharedMyTools] createTishi:@"登录失败,请重试"];
              
          }];
}


- (void)loginBlock {
    if (self.block) {
        block(nil);
    }
    [super close];
}

#pragma mark
#pragma mark  激光设置
- (void)analyseInput:(NSString **)alias tags:(NSSet **)tags {
    // alias analyse
    if (![*alias length]) {
        // ignore alias
        *alias = nil;
    }
    // tags analyse
    if (![*tags count]) {
        *tags = nil;
    } else {
        __block int emptyStringCount = 0;
        [*tags enumerateObjectsUsingBlock:^(NSString *tag, BOOL *stop) {
            if ([tag isEqualToString:@""]) {
                emptyStringCount++;
            } else {
                emptyStringCount = 0;
                *stop = YES;
            }
        }];
        if (emptyStringCount == [*tags count]) {
            *tags = nil;
        }
    }
}

- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    
    // DLog(@"TagsAlias回调:%d", iResCode);
}

#pragma mark
#pragma mark  会员按钮

-(void)memberButton:(UIButton *)btn{
    
    self.memberType = WLMemberTypeMember;
    
    _pageTitleLabel.text = @"会员登录";
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    
    //登录用户为会员时
    _loginPhoneNumTF.keyboardType=UIKeyboardTypeDefault;
    _loginPhoneNumTF.autocorrectionType=UITextAutocorrectionTypeNo;//不自动更正
    _loginPhoneNumTF.autocapitalizationType = UITextAutocapitalizationTypeNone;//设置英文键盘默认小写
    _loginPhoneNumTF.placeholder=@"请输入手机号或用户名";
    
    [_loginPhoneNumTF setText:nil];
    
    [_loginPasswordTF setText:nil];
    
        
    [UIView animateWithDuration:0.35 animations:^{
        
        _loginAndRegisterTypeButton.alpha = 1;
        
        _loginAndRegisterTypeButtonLabel.alpha = 1;
        
        _weiXinLoginButton.alpha = 1;
        
        _weiXinLoginLabel.alpha = 1;
        
        _QQLoginButton.alpha = 1;
        
        _QQLofinLabel.alpha = 1;
        
        _underlineView1.frame = CGRectMake(50 + ViewWidth(_memberButton)/4, 46, ViewWidth(_memberButton)/2, 1);
    }];


    //计算ScroollView需要的大小
    _loginAndRegisterScrollView.contentSize = CGSizeMake(windowContentWidth, windowContentHeight - 170 * AUTO_IPHONE6_HEIGHT_667);
    
}

#pragma mark
#pragma mark  管家按钮

-(void)stewardButton:(UIButton *)btn{
    
    self.memberType = WLMemberTypeSteward;
    
    _pageTitleLabel.text = @"管家登录";
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    //登录用户为管家时
    _loginPhoneNumTF.keyboardType=UIKeyboardTypeNumberPad;
    
    _loginPhoneNumTF.placeholder=@"请输入手机号";
    
    [_loginPhoneNumTF setText:nil];
    
    [_loginPasswordTF setText:nil];

    
    [UIView animateWithDuration:0.35 animations:^{
        
        _loginAndRegisterTypeButton.alpha = 0;
        
        _loginAndRegisterTypeButtonLabel.alpha = 0;
        
        _weiXinLoginButton.alpha = 0;
        
        _weiXinLoginLabel.alpha = 0;
        
        _QQLoginButton.alpha = 0;
        
        _QQLofinLabel.alpha = 0;
        
        _underlineView1.frame = CGRectMake(CGRectGetMaxX(_memberButton.frame) + ViewWidth(_memberButton)/4, 46, ViewWidth(_memberButton)/2, 1);
        
    }];
    

    //计算ScroollView需要的大小
    _loginAndRegisterScrollView.contentSize = CGSizeMake(windowContentWidth, windowContentHeight - 170 * AUTO_IPHONE6_HEIGHT_667);
    
}

#pragma mark
#pragma mark  登录页“左滑”“右滑”手势方法

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if ([_loginAndRegisterTypeButtonLabel.text isEqualToString:@"注册"]) {
        
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        
        //左滑
        if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
            
            //登录用户为管家时
            self.memberType = WLMemberTypeSteward;
            
            _pageTitleLabel.text = @"管家登录";
            
            _loginPhoneNumTF.keyboardType=UIKeyboardTypeNumberPad;
            
            _loginPhoneNumTF.placeholder=@"请输入手机号";
            
            [_loginPhoneNumTF setText:nil];
            
            [_loginPasswordTF setText:nil];
            
            
            [UIView animateWithDuration:0.35 animations:^{
                
                _loginAndRegisterTypeButton.alpha = 0;
                
                _loginAndRegisterTypeButtonLabel.alpha = 0;
                
                _weiXinLoginButton.alpha = 0;
                
                _weiXinLoginLabel.alpha = 0;
                
                _QQLoginButton.alpha = 0;
                
                _QQLofinLabel.alpha = 0;
                
                _underlineView1.frame = CGRectMake(CGRectGetMaxX(_memberButton.frame) + ViewWidth(_memberButton)/4, 46, ViewWidth(_memberButton)/2, 1);
                
            }];
            
             DLog(@"我在往左滑！！！！！！！");
            
        }
        
        //右滑
        if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
            
            //登录用户为会员时
            self.memberType = WLMemberTypeMember;
            
            _pageTitleLabel.text = @"会员登录";
            
            _loginPhoneNumTF.keyboardType=UIKeyboardTypeASCIICapable;
            _loginPhoneNumTF.placeholder=@"请输入手机号或用户名";
            
            [_loginPhoneNumTF setText:nil];
            
            [_loginPasswordTF setText:nil];
            
            DLog(@"我在往右滑！！！！！！！");
            
  
            [UIView animateWithDuration:0.35 animations:^{
                
                _loginAndRegisterTypeButton.alpha = 1;
                
                _loginAndRegisterTypeButtonLabel.alpha = 1;
                
                _weiXinLoginButton.alpha = 1;
                
                _weiXinLoginLabel.alpha = 1;
                
                _QQLoginButton.alpha = 1;
                
                _QQLofinLabel.alpha = 1;
                
                _underlineView1.frame = CGRectMake(50 + ViewWidth(_memberButton)/4, 46, ViewWidth(_memberButton)/2, 1);
                
            }];
            
        }
    }
}

#pragma mark
#pragma mark  返回上一页按钮

-(void)popButton:(UIButton *)btn{
    
    DLog(@"popButton");
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

#pragma mark
#pragma mark  右上角“登录”与“注册”切换按钮

-(void)loginAndRegisterTypeButton:(UIButton *)btn{
    
    _loginAndRegisterScrollView.scrollEnabled = YES;
    
    if([_loginAndRegisterTypeButtonLabel.text isEqualToString:@"返回登录"]){
        
        [UIView animateWithDuration:0.3 animations:^{
            
            //计算ScroollView需要的大小
            _loginAndRegisterScrollView.contentSize = CGSizeMake(windowContentWidth, windowContentHeight - 170 * AUTO_IPHONE6_HEIGHT_667);
            
            _loginAndRegisterScrollView.contentOffset = CGPointMake(0, _loginAndRegisterScrollView.contentOffset.y);
            
        } completion:^(BOOL finished) {
            
            _pageTitleLabel.text = @"会员登录";
            
            _loginAndRegisterTypeButtonLabel.text = @"注册";
        }];
    }
    
    if([_loginAndRegisterTypeButtonLabel.text isEqualToString:@"注册"]){
        
        [UIView animateWithDuration:0.3 animations:^{
            
            //计算ScroollView需要的大小
            _loginAndRegisterScrollView.contentSize = CGSizeMake(windowContentWidth, windowContentHeight - 170 * AUTO_IPHONE6_HEIGHT_667);
            
            _loginAndRegisterScrollView.contentOffset = CGPointMake(windowContentWidth, _loginAndRegisterScrollView.contentOffset.y);
            
        } completion:^(BOOL finished) {
            
            _pageTitleLabel.text = @"手机号注册";
            
            _loginAndRegisterTypeButtonLabel.text = @"返回登录";
        }];
    }
}

//忘记密码页面，修改完密码pop回来时，传的手机号
- (void)resetPhoneNum:(NSString *)num {
    
    _loginPhoneNumTF.text = num;
}

#pragma mark

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    //DLog(@"textField.text.length-%d =%d= --%d",_phoneTF.text.length,_pwdTF.text.length,range.location);
    
    
    NSCharacterSet *cs;
    if(textField == _registerPhoneNumTF)
    {
        
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark
#pragma mark  键盘弹出时背景上滑高度

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //开始编辑时触发，文本字段将成为first responder
    
    [UIView animateWithDuration:0.25 animations:^{
        
        if (windowContentHeight==480)
        {
            //iPhone4
            _backScrollView.contentSize=CGSizeMake(windowContentWidth, windowContentHeight+160);
            _backScrollView.contentOffset=CGPointMake(0, 160);
        }
        else if(windowContentHeight==568)
        {
            //iPhone5
            _backScrollView.contentSize=CGSizeMake(windowContentWidth, windowContentHeight+115);
            _backScrollView.contentOffset=CGPointMake(0, 115);
        }
        else if (windowContentHeight == 667)
        {
            _backScrollView.contentSize=CGSizeMake(windowContentWidth, windowContentHeight+80);
            _backScrollView.contentOffset=CGPointMake(0, 80);
        }
        else
        {
            _backScrollView.contentSize=CGSizeMake(windowContentWidth, windowContentHeight+50);
            _backScrollView.contentOffset=CGPointMake(0, 50);
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
    DLog(@"height---%f,屏幕高=%f",height,windowContentHeight);
    
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.frame=CGRectMake(0, 0, windowContentWidth, windowContentHeight);
        
        _backScrollView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        
        _backScrollView.contentSize=CGSizeMake(windowContentWidth, windowContentHeight);
        
    }];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

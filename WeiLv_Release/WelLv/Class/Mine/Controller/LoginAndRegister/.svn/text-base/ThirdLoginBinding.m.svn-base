//
//  ThirdLoginBinding.m
//  WelLv
//
//  Created by James on 16/3/2.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "ThirdLoginBinding.h"
#import "APService.h"

@implementation ThirdLoginBinding
@synthesize phoneImageView = _phoneImageView;
@synthesize userName = _userName;
@synthesize name = _name;
@synthesize phoneStr = _phoneStr;
@synthesize openId = _openId;
@synthesize block;


#pragma mark - 页面初始化
- (void)viewDidLoad
{
    //初始化父视图
    [super viewDidLoad];

    //初始化背景视图
    [self initBackGroundView];
    
    //初始化导航区域
    [self initNavigationSection];
    
    //初始化头像区域
    [self initHeadImageSection];
    
    //初始化验证主题区域
    [self initVerificationSection];
}

#pragma mark - 视图即将显示
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=YES;
    [super viewWillAppear:YES];
}

#pragma mark - 视图即将消失
-(void)viewWillDisappear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [super viewWillDisappear:YES];
}

#pragma mark - 初始化背景视图
-(void)initBackGroundView
{
    //创建scrollViews视图
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,-20, windowContentWidth, windowContentHeight+20)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
 
 
    //创建背景视图
    UIImage *backImage=[UIImage imageNamed:@"登录注册页面背景"];
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,windowContentWidth,windowContentHeight)];
    bgImage.image=backImage;
    bgImage.contentMode = UIViewContentModeScaleAspectFill;
    [_scrollView addSubview:bgImage];
    
    
    [self.view addSubview:_scrollView];

}


#pragma mark - 初始化导航区域
-(void)initNavigationSection
{
    //创建导航返回按钮
    UIImage *imageBack=[UIImage imageNamed:@"登录注册返回键"];
    self.navigationBack=[[UIButton alloc] initWithFrame:CGRectMake(RectX(15),RectY(20),RectWidth(imageBack.size.width),RectHeight(imageBack.size.height))];
    [self.navigationBack setBackgroundImage:imageBack forState:UIControlStateNormal];
    [self.navigationBack addTarget:self action:@selector(backEvent) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:self.navigationBack];
    
    //创建导航标题
    self.navigationTitle=[[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth/2-60+RectX(15),RectHeight(imageBack.size.height)/2,120,44)];
    self.navigationTitle.text=@"绑定手机号";
    self.navigationTitle.font=RectFontSize(18);
    self.navigationTitle.textColor=[UIColor whiteColor];
    [_scrollView addSubview:self.navigationTitle];
    
}

#pragma mark - 初始化头像区域
-(void)initHeadImageSection
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake((windowContentWidth - 106)/2,ViewBelow(self.navigationBack)+20, 106, 106)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 53.0;
    [_scrollView addSubview:view];
    
    _phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake((windowContentWidth - 100)/2, ViewY(view)+3, 100, 100)];
    [_phoneImageView sd_setImageWithURL:[NSURL URLWithString:self.phoneStr]];
    _phoneImageView.userInteractionEnabled = YES;
    _phoneImageView.layer.masksToBounds=YES;
    _phoneImageView.layer.cornerRadius = 50.0;
    [_scrollView addSubview:_phoneImageView];
    
    _userName = [YXTools allocLabel:self.name font:systemBoldFont(15) textColor:[UIColor whiteColor] frame:CGRectMake(0, ViewY(view)+ViewHeight(view), windowContentWidth, 30) textAlignment:1];
    [_scrollView addSubview:_userName];
    

}

#pragma mark - 初始化验证主题区域
-(void)initVerificationSection
{
    //创建输入手机号图标
    UIImage *phoneImage=[UIImage imageNamed:@"登录注册手机号"];
    UIImageView *phoneIconView=[[UIImageView alloc] initWithFrame:CGRectMake(RectX(50),ViewBelow(_userName)+50,RectWidth(phoneImage.size.width),RectHeight(phoneImage.size.height))];
    phoneIconView.image=phoneImage;
    [_scrollView  addSubview:phoneIconView];
    
    //创建输入手机号文本框
    _phoneTextField=[[UITextField alloc] initWithFrame:CGRectMake(ViewRight(phoneIconView)+17,ViewBelow(_userName)+50,windowContentWidth-50*2-RectWidth(phoneImage.size.width)-5,RectHeight(phoneImage.size.height))];
    _phoneTextField.keyboardType=UIKeyboardTypePhonePad;
    _phoneTextField.clearButtonMode=UITextFieldViewModeAlways;
    _phoneTextField.textColor=[UIColor whiteColor];
    _phoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phoneTextField.returnKeyType = UIReturnKeySearch;
    _phoneTextField.placeholder=@"请输入手机号";
    [_phoneTextField setValue:[UIColor whiteColor]forKeyPath:@"_placeholderLabel.textColor"];
    _phoneTextField.font = systemBoldFont(16);
    _phoneTextField.delegate = self;
    [_scrollView addSubview:_phoneTextField];
    
    
    //创建分割线视图
    UIView *lineView1=[[UIView alloc] initWithFrame:CGRectMake(RectX(45),ViewBelow(phoneIconView)+5,windowContentWidth-45*2,0.5)];
    lineView1.backgroundColor=[UIColor whiteColor];
    lineView1.alpha=0.5;
    [_scrollView addSubview:lineView1];
    
    //创建输入验证码图标
    UIImage *verificatCodeImage=[UIImage imageNamed:@"登录注册手机号验证"];
    UIImageView *verificatIconView=[[UIImageView alloc] initWithFrame:CGRectMake(RectX(50), ViewBelow(lineView1)+18, RectWidth(verificatCodeImage.size.width), RectHeight(verificatCodeImage.size.height))];
    verificatIconView.image=verificatCodeImage;
    [_scrollView addSubview:verificatIconView];
    
    //创建输入验证码文本框
    _verificationCodeTextField=[[UITextField alloc] initWithFrame:CGRectMake(ViewRight(verificatIconView)+17,ViewBelow(lineView1)+18,windowContentWidth-50*2-RectWidth(verificatCodeImage.size.width)-70-30,RectHeight(verificatCodeImage.size.height))];
    _verificationCodeTextField.keyboardType=UIKeyboardTypePhonePad;
    _verificationCodeTextField.clearButtonMode=UITextFieldViewModeAlways;
    _verificationCodeTextField.textColor=[UIColor whiteColor];
    _verificationCodeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _verificationCodeTextField.returnKeyType = UIReturnKeySearch;
    _verificationCodeTextField.placeholder=@"请输入验证码";
    [_verificationCodeTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    _verificationCodeTextField.font = systemBoldFont(16);
    _verificationCodeTextField.delegate = self;
    [_scrollView addSubview:_verificationCodeTextField];
    
    
    
    //创建发送验证码按钮
    _sendVerificatCodeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _sendVerificatCodeBtn.frame=CGRectMake(ViewRight(_verificationCodeTextField)+3,ViewBelow(lineView1)+13,85,RectHeight(verificatCodeImage.size.height)+5);
    [_sendVerificatCodeBtn setBackgroundColor:[UIColor whiteColor]];
    [_sendVerificatCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    _sendVerificatCodeBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [_sendVerificatCodeBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_sendVerificatCodeBtn setTintAdjustmentMode:UIViewTintAdjustmentModeAutomatic];
    _sendVerificatCodeBtn.layer.cornerRadius=1.5;
    _sendVerificatCodeBtn.layer.masksToBounds=YES;
    
    [_sendVerificatCodeBtn addTarget:self action:@selector(sendCodeEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_sendVerificatCodeBtn];
    
    //创建分割线视图
    UIView *lineView2=[[UIView alloc] initWithFrame:CGRectMake(RectX(45),ViewBelow(verificatIconView)+5,windowContentWidth-45*2,0.5)];
    lineView2.backgroundColor=[UIColor whiteColor];
    lineView2.alpha=0.5;
    [_scrollView addSubview:lineView2];
    
    
    //创建完成按钮
    UIImage *finishImage=[UIImage imageNamed:@"登录注册按钮背景"];
    _finishBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _finishBtn.frame=CGRectMake(RectX(45),ViewBelow(lineView2)+30,windowContentWidth-45*2,RectHeight(finishImage.size.height));
    [_finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_finishBtn setBackgroundImage:finishImage forState:UIControlStateNormal];
    [_finishBtn addTarget:self action:@selector(finishEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_finishBtn];
    
    
}


#pragma mark - 发送验证码点击事件
-(void)sendCodeEvent:(UIButton *)sender
{
     NSString *url;
    if ([YXTools stringIsNotNullTrim:_phoneTextField.text])
    {
        [[LXAlterView sharedMyTools] createTishi:@"请输入手机号"];
        return;
    }
    else if ([YXTools isValidateMobile:_phoneTextField.text]==NO)
    {
        [[LXAlterView sharedMyTools] createTishi:@"请输入正确的手机号"];
        return;
    }
    else
    {
        if ([self.loginType isEqualToString:@"QQ"])
        {
            url = QQCodeUrl;
        }
        else if ([self.loginType isEqualToString:@"WX"])
        {
            url = WeiXinCodeUrl;
        }
        NSDictionary *parameters = @{@"phone_number":_phoneTextField.text};
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject)
         {
             /**
              0  : 发送成功
              1 ：发送失败
              2 ：手机号已绑定
              3 ： 手机号码不正确
              5 ： 请输入手机号（*手机号没接收到 为空 * 不输出）
              -8：您是管家，请前往管家登录
              **/
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             NSString *errStr =[dic objectForKey:@"msg"];
             int errNumber=[[dic objectForKey:@"errno"] intValue];
             if (errNumber==0)
             {
                 //发送成功
                 [[LXAlterView sharedMyTools] createTishi:[NSString stringWithFormat:@"已发送短信验证码到 %@",_phoneTextField.text]];
                 //开始倒计时
                 [self startTime];
                 _sendVerificatCodeBtn.userInteractionEnabled=NO;
             }
             else if(errNumber==1)
             {
                 //发送失败
                 [[LXAlterView sharedMyTools] createTishi:errStr];
             }
             else if (errNumber==2)
             {
                 
                 //添加 字典，将label的值通过key值设置传递
                 NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"loginPerson",_phoneTextField.text,@"Tel", nil];
                 //创建通知
                 NSNotification *notification =[NSNotification notificationWithName:@"popToLogin" object:nil userInfo:dict];
                 //通过通知中心发送通知
                 [[NSNotificationCenter defaultCenter] postNotification:notification];
                 
                 //手机号码已绑定
                 [[LXAlterView sharedMyTools] createTishi:errStr];
                 [self.navigationController popViewControllerAnimated:YES];
             }
             else if (errNumber==3)
             {
                 //手机号码不正确
                 [[LXAlterView sharedMyTools] createTishi:errStr];
             }
             else if (errNumber==5)
             {
                 //请输入手机号（*手机号没接收到 为空 * 不输出）
                 [[LXAlterView sharedMyTools] createTishi:errStr];
             }
             else if (errNumber==-8)
             {
                 //添加 字典，将label的值通过key值设置传递
                 NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"2",@"loginPerson",_phoneTextField.text,@"Tel", nil];
                 //创建通知
                 NSNotification *notification =[NSNotification notificationWithName:@"popToLogin" object:nil userInfo:dict];
                 //通过通知中心发送通知
                 [[NSNotificationCenter defaultCenter] postNotification:notification];

                 //您是管家，请前往管家登录
                 [[LXAlterView sharedMyTools] createTishi:errStr];
                 [self.navigationController popViewControllerAnimated:YES];
             }
             
         }failure:^(AFHTTPRequestOperation *operation,NSError *error)
         {
             [[LXAlterView sharedMyTools] createTishi:@"网络请求失败"];
             [self.navigationController popViewControllerAnimated:YES];
         }];

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
                
                //设置界面的按钮显示 根据自己需求设置，表示验证码过期
                _sendVerificatCodeBtn.backgroundColor=[UIColor clearColor];
                [_sendVerificatCodeBtn setBackgroundImage:[UIImage imageNamed:@"登录注册发送验证码"] forState:UIControlStateNormal];
                [_sendVerificatCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                [_sendVerificatCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                _sendVerificatCodeBtn.titleLabel.font=[UIFont systemFontOfSize:12];
                _sendVerificatCodeBtn.userInteractionEnabled=YES;
                [_scrollView setNeedsDisplay];
            });
            
        }else{
            int seconds = timeout % 61;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                [_sendVerificatCodeBtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                _sendVerificatCodeBtn.titleLabel.font=[UIFont systemFontOfSize:10];
                _sendVerificatCodeBtn.userInteractionEnabled=NO;
                
            });
            
            timeout--;
            
        }
    });
    
    dispatch_resume(_timer);
    
}



#pragma mark - 完成点击事件
-(void)finishEvent:(UIButton *)sender
{
    if ([YXTools stringIsNotNullTrim:_phoneTextField.text])
    {
        [[LXAlterView sharedMyTools] createTishi:@"请输入手机号"];
        return;
    }
    else if ([YXTools isValidateMobile:_phoneTextField.text]==NO)
    {
        [[LXAlterView sharedMyTools] createTishi:@"请输入正确的手机号"];
        return;
    }
    if ([YXTools stringIsNotNullTrim:_verificationCodeTextField.text])
    {
        [[LXAlterView sharedMyTools] createTishi:@"请输入验证码"];
        return;
    }
    else
    {
        NSString *url;
        NSString *nick;
        if ([self.loginType isEqualToString:@"QQ"])
        {
            url = QQBindPhoneUrl;
            nick = @"nick_name";
        }
        else if ([self.loginType isEqualToString:@"WX"])
        {
            url = WeiBindPhoneUrl;
            nick = @"wx_name";
        }
        NSDictionary *parameters = @{@"phone":_phoneTextField.text,@"code":_verificationCodeTextField.text,@"openid":self.openId,@"avater":self.phoneStr,nick:self.name};
 
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject)
         {
             NSDictionary *respose = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             /*
              
              errno = -1    手机号码不正确
              errno = -2    验证码不正确
              errno = -3    绑定失败
              errno = -8    您是管家，请前往管家登录
              errno = 1    绑定成功
              
              */
             if (respose != nil)
             {
                 NSString *errStr = [respose objectForKey:@"msg"];
                 int errNumber=[[respose objectForKey:@"errno"] intValue];
                 if (errNumber==-1)
                 {
                     //表示：手机号码不正确
                     [[LXAlterView sharedMyTools] createTishi:errStr];
                 }
                 else if (errNumber==-2)
                 {
                     //表示：验证码不正确
                     [[LXAlterView sharedMyTools] createTishi:errStr];
                 }
                 else if (errNumber==-3)
                 {
                     //表示：绑定失败
                     [[LXAlterView sharedMyTools] createTishi:errStr];
                 }
                 else if(errNumber==-8)
                 {
                     
                     //添加 字典，将label的值通过key值设置传递
                     NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"2",@"loginPerson",_phoneTextField.text,@"Tel", nil];
                     //创建通知
                     NSNotification *notification =[NSNotification notificationWithName:@"popToLogin" object:nil userInfo:dict];
                     //通过通知中心发送通知
                     [[NSNotificationCenter defaultCenter] postNotification:notification];
                     
                     //表示：您是管家，请前往管家登录
                     [[LXAlterView sharedMyTools] createTishi:errStr];
                     [self.navigationController popViewControllerAnimated:YES];
                 }
                 else if (errNumber==1)
                 {
                     NSDictionary *dic=[respose objectForKey:@"data"];
                     if (dic && [dic isKindOfClass:[NSDictionary class]])
                     {
                         
                         DLog(@"登录成功------会员");
                         //把用户信息存到本地
                         [[LXUserTool sharedUserTool] saveUserNameAndPwd:[dic objectForKey:@"username"]
                                                                  andPwd:[dic objectForKey:@"password"]
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
                                                         andPwd2:@"123456"andIs_withdraw:@"0"];
                         
                         NSNotification *notification = [NSNotification notificationWithName:UpdateImage object:nil];
                         [[NSNotificationCenter defaultCenter] postNotification:notification];
                         [[LXUserTool sharedUserTool] deleteUserMemberDic];
                         
                         NSMutableDictionary * modelDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                         if ([respose objectForKey:@"store_id"]) {
                             [modelDic setObject:[respose objectForKey:@"store_id"] forKey:@"store_id"];
                             [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@", [self judgeReturnString:[respose objectForKey:@"store_id"]  withReplaceString:@"0"]] forKey:@"ste_shop_ID"];
                         } else {
                             [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"ste_shop_ID"];
                             
                         }
                         if ([respose objectForKey:@"assistant_mobile"]) {
                             [modelDic setObject:[respose objectForKey:@"assistant_mobile"] forKey:@"assistant_mobile"];
                         }
                         [[LXUserTool sharedUserTool] addUserMemberWithDic:modelDic];
                         [self loginBlock];
                     }
                     else
                     {
                         [[LXAlterView sharedMyTools] createTishi:@"登录失败,请重试"];
                         
                     }
                     [self.navigationController popViewControllerAnimated:YES];
                     
                     
                 }
             }
             else
             {
                 [[LXAlterView sharedMyTools] createTishi:@"网络请求失败"];
                 [self.navigationController popViewControllerAnimated:YES];
             }
             
         }failure:^(AFHTTPRequestOperation *operation,NSError *error)
         {
             [[LXAlterView sharedMyTools] createTishi:@"网络请求失败"];
             [self.navigationController popViewControllerAnimated:YES];
         }];

    }
}

#pragma mark - 文本框代理方法实现

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (textField==_phoneTextField)
    {
        //限制手机号最大长度
        if (toBeString.length > 11)
        {
            textField.text = [toBeString substringToIndex:11];
            return NO;
        }
    }
    else if(textField==_verificationCodeTextField)
    {
        //限制验证码最大长度
        if (toBeString.length > 6)
        {
            
            textField.text = [toBeString substringToIndex:6];
            return NO;
        }
    }
    return YES;
    
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField ==_phoneTextField) {
        if (textField.text.length >11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }else if (textField==_verificationCodeTextField){
        if (textField.text.length >6) {
            textField.text = [textField.text substringToIndex:6];
        }
    }
}

#pragma mark - 控制键盘不遮挡按钮和输入框
- (void)keyboardWillHide:(NSNotification *)notification
{
    _textView = nil;
    
    NSDictionary* userInfo = [notification userInfo];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [YXTools uiViewAnimationTransition:nil typeIndex:0 duration:_animationDuration animation:^{
        _scrollView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    }];
}


#pragma mark - 导航返回点击事件
-(void)backEvent
{
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 登录回调
- (void)loginBlock
{
    if (self.block)
    {
        block(nil);
    }
    [super close];
}

#pragma mark - 视图消失事件
- (void)viewDidAppear:(BOOL)animated
{
    [_phoneTextField resignFirstResponder];
    [_verificationCodeTextField resignFirstResponder];
    [super viewDidAppear:YES];
}

#pragma mark - 内存警告
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end

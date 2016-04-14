//
//  FastLoginAndResgistrViewController.m
//  WelLv
//
//  Created by mac for csh on 15/4/25.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
#define NUMBERS @"0123456789\n"

#import "FastLoginAndResgistrViewController.h"
#import "ForgetPwdViewController.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface FastLoginAndResgistrViewController ()

@end

@implementation FastLoginAndResgistrViewController
@synthesize lgblock;
@synthesize rgblock;

- (void)dealloc
{
    
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *bgimage = [UIImage imageNamed:@"注册背景.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgimage];
   // self.view.layer.contents = (id) bgimage.CGImage;
    self.view.alpha = 0.8;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAccess_token:) name:WeiCode object:nil];
    
    loginButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 40, windowContentWidth/2 - 30, 25)];
    [loginButton.layer setMasksToBounds:YES];
    [loginButton.layer setCornerRadius:0.0]; //设置矩形四个圆角半径
    [loginButton.layer setBorderWidth:1.5];//边框宽度
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0,0,255,255});
//    [loginButton.layer setBorderColor:colorref];//边框颜色
    loginButton.layer.borderColor=[kColor(10, 220, 124) CGColor];
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];//button title
    [loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//title color
    [loginButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];//button 点击回调方法
    loginButton.backgroundColor = [UIColor clearColor];
    loginButton.tag =1;  loginButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [loginButton setTitleColor:[UIColor whiteColor ] forState:UIControlStateNormal];
    [self.view addSubview:loginButton];
    [loginButton setBackgroundColor:kColor(10, 220, 124)];
    
    registerbutton = [[UIButton alloc] initWithFrame:CGRectMake(windowContentWidth/2-1, 40, windowContentWidth/2 - 30, 25)];
    [registerbutton.layer setMasksToBounds:YES];
    [registerbutton.layer setCornerRadius:0.0]; //设置矩形四个圆角半径
    [registerbutton.layer setBorderWidth:1.5];//边框宽度
   // CGColorSpaceRef colorSpace1 = CGColorSpaceCreateDeviceRGB();
   // CGColorRef colorref1 = CGColorCreate(colorSpace1,(CGFloat[]){ 0,0,255,255});
    //[registerbutton.layer setBorderColor:colorref1];//边框颜色
    registerbutton.layer.borderColor=[kColor(10, 220, 124) CGColor];
    [registerbutton setTitle:@"注册" forState:UIControlStateNormal];//button title
    [registerbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//title color
    [registerbutton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];//button 点击回调方法
    registerbutton.backgroundColor = [UIColor clearColor];
    registerbutton.tag =2;  registerbutton.titleLabel.font = [UIFont systemFontOfSize:14];
    [registerbutton setTitleColor:[UIColor whiteColor ] forState:UIControlStateNormal];
    [self.view addSubview:registerbutton];
    
    [self initLoginView];
    //[self initRegister];
        
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    
  /*  //取消操作button
    UIButton *dissmissBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 10, 25 , 25)];
    [dissmissBtn addTarget:self action:@selector(dismissFromView) forControlEvents:UIControlEventTouchUpInside];//button 点击回调方法
    //UIImage *imagesss = [UIImage imageNamed:@"37V58PICnNy_1024.png"];
    //dissmissBtn.layer.contents = (id)imagesss.CGImage;
    [self.view addSubview:dissmissBtn];
    [dissmissBtn setBackgroundColor:kColor(10, 220, 124)];*/
}

-(void)initLoginView{
    //login View
    loginView = [[UIView alloc] initWithFrame:CGRectMake(30, 60+30, windowContentWidth-60, 160)];
    loginView.backgroundColor = [UIColor clearColor];
    loginView.alpha = 1;
    loginView.userInteractionEnabled=YES;
    [self.view addSubview:loginView];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth-60, 40)];
    lab1.text =@"   账号:";
    [lab1 setBackgroundColor:[UIColor whiteColor]];
    lab1.tintColor = [UIColor blackColor];
    lab1.font = [UIFont systemFontOfSize:17];
    [loginView addSubview:lab1];
    
    loginUsernme = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, windowContentWidth-60, 39)];
    loginUsernme.placeholder =@"请填写手机号"; 
    loginUsernme.font = [UIFont systemFontOfSize:14];
    loginUsernme.clearButtonMode = UITextFieldViewModeWhileEditing;
    loginUsernme.delegate =self;
    [loginView addSubview:loginUsernme];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 39, windowContentWidth - 60 -20 , 0.5)];
    lab.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    lab.layer.borderWidth = 0.5;
    [loginView addSubview:lab];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, windowContentWidth-60, 40)];
    lab2.text =@"   密码:";
    [lab2 setBackgroundColor:[UIColor whiteColor]];
    lab2.tintColor = [UIColor blackColor];
    lab2.font = [UIFont systemFontOfSize:17];
    [loginView addSubview:lab2];
    
    loginPassword = [[UITextField alloc] initWithFrame:CGRectMake(60, 40, windowContentWidth-60, 40)];
    loginPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    loginPassword.secureTextEntry = YES;
    loginPassword.delegate =self;
    [loginView addSubview:loginPassword];
    
    UIButton *forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPwdBtn.frame = CGRectMake(self.view.frame.size.width-45-80, 80, 80, 25);
    forgetPwdBtn.backgroundColor = [UIColor clearColor];
    [forgetPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetPwdBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    forgetPwdBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [forgetPwdBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [forgetPwdBtn addTarget:self action:@selector(jumpForPwd) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:forgetPwdBtn];
    
    loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame=CGRectMake(0,160-40,windowContentWidth - 60 ,40);
    loginBtn.layer.cornerRadius=5;
    loginBtn.backgroundColor=kColor(254, 204, 65);
    [loginBtn setTitle:@"登      陆" forState:UIControlStateNormal];
    [loginBtn setTintColor:[UIColor whiteColor]];
    loginBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    loginBtn.tag=1;
    [loginBtn addTarget:self action:@selector(loginbtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:loginBtn];
    
    
    
  /*  if (![WXApi isWXAppInstalled]) {
        [ShareSDK getUserInfoWithType:ShareTypeQQSpace authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error){
            if (result) {
                thirdArr = [NSArray arrayWithObjects:@"QQ", nil];
                [self initThirldLoginView];
            }else
            {
                thirdArr = [NSArray arrayWithObjects:nil];
               // [self initThirldLoginView];
            }
        }];

    }else{
        [ShareSDK getUserInfoWithType:ShareTypeQQSpace authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error){
            if (result) {
                thirdArr = [NSArray arrayWithObjects:@"微信",@"QQ", nil];
                [self initThirldLoginView];
            }else
            {
                thirdArr = [NSArray arrayWithObjects:@"微信", nil];
                [self initThirldLoginView];
            }
        }];
    }*/
    
    if (![WXApi isWXAppInstalled] && ![QQApi isQQInstalled]) {
        thirdArr = nil;
    }else if([WXApi isWXAppInstalled] &&![QQApi isQQInstalled])
    {
        thirdArr = [NSArray arrayWithObjects:@"微信", nil];
    }else if ([QQApi isQQInstalled] && ![WXApi isWXAppInstalled]){
        thirdArr = [NSArray arrayWithObjects:@"QQ", nil];
    }else if ([WXApi isWXAppInstalled] && [QQApi isQQInstalled])
    {
        thirdArr = [NSArray arrayWithObjects:@"微信",@"QQ", nil];
    }
    [self initThirldLoginView];

  
}

-(void)initThirldLoginView{
    
    UILabel *thirdLogin = [YXTools allocLabel:@"———————— 第三方账号登录 ———————" font:systemFont(18) textColor:[UIColor lightGrayColor] frame:CGRectMake(0, windowContentHeight-200, windowContentWidth, 30) textAlignment:1];
    thirdLogin.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:thirdLogin];
    NSLog(@"thirdArr.count is %@",thirdArr);
    for (int i=0; i<thirdArr.count; i++)
    {
        UIButton *wxloginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        wxloginBtn.frame=CGRectMake((windowContentWidth - thirdArr.count*54 - 30*(thirdArr.count-1))/2 + 84*i, ViewY(thirdLogin)+ViewHeight(thirdLogin)+20, 54, 54);
        wxloginBtn.layer.cornerRadius=27;
        [wxloginBtn setBackgroundImage:[UIImage imageNamed:[thirdArr objectAtIndex:i]] forState:UIControlStateNormal];
        wxloginBtn.tag=100+i;
        [wxloginBtn addTarget:self action:@selector(thirdLogin:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:wxloginBtn];
    }

}

-(void)initRegister{
    registerView = [[UIView alloc] initWithFrame:CGRectMake(30, 60+30, windowContentWidth-60, 160)];
    registerView.backgroundColor = [UIColor clearColor];
    registerView.alpha = 1;
    [self.view addSubview:registerView];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth-60, 40)];
    lab1.text =@"   手机号:";
    lab1.tintColor = [UIColor blackColor];
    [lab1 setBackgroundColor:[UIColor whiteColor]];
    lab1.font = [UIFont systemFontOfSize:17];
    [registerView addSubview:lab1];
    
    PhoneNum = [[UITextField alloc] initWithFrame:CGRectMake(80, 0, windowContentWidth-60, 39)];
    PhoneNum.placeholder =@"填写手机号";
    PhoneNum.font = [UIFont systemFontOfSize:16];
    PhoneNum.clearButtonMode = UITextFieldViewModeWhileEditing;
    PhoneNum.delegate =self;
    [registerView addSubview:PhoneNum];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 39, windowContentWidth - 60 -20 , 0.5)];
    lab.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    lab.layer.borderWidth = 0.5;
    [registerView addSubview:lab];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, windowContentWidth-60, 40)];
    lab2.text =@"   验证码:";
    lab2.tintColor = [UIColor blackColor];
    [lab2 setBackgroundColor:[UIColor whiteColor]];
    lab2.font = [UIFont systemFontOfSize:17];
    [registerView addSubview:lab2];
    
    yanzhengCode = [[UITextField alloc] initWithFrame:CGRectMake(80, 40, windowContentWidth-60-75-100, 40)];
    yanzhengCode.clearButtonMode = UITextFieldViewModeWhileEditing;
    yanzhengCode.delegate =self;
    [registerView addSubview:yanzhengCode];
    
    //获取验证码
    getCodeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    getCodeBtn.frame=CGRectMake(windowContentWidth-60-75-20,40+5,75+15,30);
    getCodeBtn.layer.cornerRadius=5;
    getCodeBtn.backgroundColor=kColor(254, 204, 65);
    [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCodeBtn setTintColor:[UIColor whiteColor]];
    getCodeBtn.titleLabel.font=[UIFont systemFontOfSize:11];
    getCodeBtn.tag=1;
    [getCodeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [registerView addSubview:getCodeBtn];
    
    registerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame=CGRectMake(0,160-40,windowContentWidth - 60 ,40);
    registerBtn.layer.cornerRadius=5;
    registerBtn.backgroundColor=kColor(254, 204, 65);
    [registerBtn setTitle:@"注      册" forState:UIControlStateNormal];
    [registerBtn setTintColor:[UIColor whiteColor]];
    registerBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    registerBtn.tag=1;
    [registerBtn addTarget:self action:@selector(registerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [registerView addSubview:registerBtn];

}
//跳转找回密码
-(void)jumpForPwd{
    ForgetPwdViewController *fpVC = [[ForgetPwdViewController alloc] init];
    [self.navigationController pushViewController:fpVC animated:YES];
}

-(void)dismissFromView{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void) buttonClicked: (id) sender{
    UIButton *btn=(UIButton *)sender;
    NSLog(@"%d",(int)btn.tag);
    if (btn.tag == 1) {
        [registerbutton setBackgroundColor:[UIColor clearColor]];
        [loginButton setBackgroundColor:kColor(10, 220, 124)];
        [self initLoginView];
        [registerView removeFromSuperview];
        
    }else if(btn.tag == 2){
        [loginButton setBackgroundColor:[UIColor clearColor]];
        [registerbutton setBackgroundColor:kColor(10, 220, 124)];
        [self  initRegister];
        [loginView removeFromSuperview];
        
    }
}
/**********************************************************************登陆************************************************************************/

//第三方登陆
- (void)thirdLogin:(UIButton *)sender
{
    if (sender.tag == 100)
    {
        //微信登陆
        if ([WXApi isWXAppInstalled]) {
            
            SendAuthReq *req = [[SendAuthReq alloc] init];
            req.scope =  @"snsapi_userinfo";
            req.state = @"weilv";
            req.openID = @"b5e3112f5ae05b3c3a8af70bdc36116a";
            [WXApi sendReq:req];
        }else
        {
            //qq登陆
            [ShareSDK getUserInfoWithType:ShareTypeQQSpace authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error){
                if (result) {
                    //打印输出用户uid：
                   // DLog(@"uid = %@",[userInfo uid]);
                    //打印输出用户昵称：
                   // DLog(@"name = %@",[userInfo nickname]);
                    //打印输出用户头像地址：
                   // DLog(@"icon = %@",[userInfo profileImage]);
                }else
                {
                    if ([error errorCode] == -6004) {
                        [[LXAlterView alloc] createTishi:@"未安装应用"];
                    }else
                    {
                        [[LXAlterView alloc] createTishi:@"授权失败"];
                    }
                    
                    DLog(@"授权失败!error code == %ld, error code == %@", [error errorCode], [error errorDescription]);
                }
            }];
            
        }
        
    }else if(sender.tag == 101)
    {
        
        //qq登陆
        [ShareSDK getUserInfoWithType:ShareTypeQQSpace authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error){
            if (result) {
                [self QQIsLogin:[userInfo uid] image:[userInfo profileImage] name:[userInfo nickname]];
            }else
            {
                if ([error errorCode] == -6004) {
                    [[LXAlterView alloc] createTishi:@"未安装应用"];
                }else
                {
                    [[LXAlterView alloc] createTishi:@"授权失败"];
                }
            }
        }];
        
        
    }

}

//qq验证是否是首次登陆
- (void)QQIsLogin:(NSString *)uid image:(NSString *)avter name:(NSString *)nickName
{
    NSDictionary *parameters = @{@"nick_name":nickName,@"avater":avter,@"openid":uid};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:QQLoginUrl parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         if (dic != nil) {
             NSString *errStr = [dic objectForKey:@"msg"];
             [[LXAlterView sharedMyTools] createTishi:errStr];
             if ([[dic objectForKey:@"errno"] intValue]==0)
             {
                 NSDictionary *userInfo=[dic objectForKey:@"data"];
                 //把用户信息存到本地
                 [[LXUserTool alloc] saveUserNameAndPwd:[userInfo objectForKey:@"username"] andPwd:[userInfo objectForKey:@"password"] andBalance:[userInfo objectForKey:@"balance"] andBirthday:[userInfo objectForKey:@"birthday"] andCreatetime:[userInfo objectForKey:@"createtime"] andDiqu:[userInfo objectForKey:@"diqu"] andEmail:[userInfo objectForKey:@"email"] andIdnumber:[userInfo objectForKey:@"idnumber"] andIdtype:[userInfo objectForKey:@"idtype"] andLevel:[userInfo objectForKey:@"level"] andLevels:[userInfo objectForKey:@"levels"] andLogintime:[userInfo objectForKey:@"logintime"] andMtype:[userInfo objectForKey:@"mtype"] andPhone:[userInfo objectForKey:@"phone"] andRealname:[userInfo objectForKey:@"realname"] andSalt:[userInfo objectForKey:@"salt"] adnSex:[userInfo objectForKey:@"sex"] andShengshiquxian:[userInfo objectForKey:@"address"] andUid:[userInfo objectForKey:@"uid"] adnAssistant_id:[userInfo objectForKey:@"assistant_id"] andIs_detachable:[userInfo objectForKey:@"is_detachable"] andUsergroup:[userInfo objectForKey:@"usergroup"] andAvater:[userInfo objectForKey:@"avater"] andMember_count:[userInfo objectForKey:@"member_count"]andPwd2:@"123456"andIs_withdraw:@"0"];
                 
                 NSNotification *notification = [NSNotification notificationWithName:UpdateImage object:nil];
                 [[NSNotificationCenter defaultCenter] postNotification:notification];
                 [super close];
             }else
             {
                 BindLoginViewController *bindVC = [[BindLoginViewController alloc] init];
                 bindVC.phoneStr = avter;
                 bindVC.name = nickName;
                 bindVC.openId = uid;
                 bindVC.loginType = @"QQ";
                 [self.navigationController pushViewController:bindVC animated:YES];

             }
             
         }else
         {
             [[LXAlterView sharedMyTools] createTishi:@"网络请求失败"];
         }
     }failure:^(AFHTTPRequestOperation *operation,NSError *error)
     {
         NSLog(@"___________%@",error);
         [[LXAlterView sharedMyTools] createTishi:@"登陆失败"];
     }];
    
}


-(void)getAccess_token:(NSNotification *)notification
{
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WeiXinID,WeiXinAPPSecret,notification.object];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
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
                NSLog(@"_____________%@",dic);
                [self isLogin:dic];
                
            }
        });
        
    });
}

//验证是否是首次登陆
- (void)isLogin:(NSDictionary *)weiXinDic
{
    NSDictionary *parameters = @{@"wx_name":[weiXinDic objectForKey:@"nickname"],@"avater":[weiXinDic objectForKey:@"headimgurl"],@"openid":[weiXinDic objectForKey:@"openid"]};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:WeiLoginUrl parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         if (dic != nil) {
             NSString *errStr = [dic objectForKey:@"msg"];
             [[LXAlterView sharedMyTools] createTishi:errStr];
             if ([[dic objectForKey:@"errno"] intValue]==0)
             {
                 NSDictionary *userInfo=[dic objectForKey:@"data"];
                 //把用户信息存到本地
                 [[LXUserTool alloc] saveUserNameAndPwd:[userInfo objectForKey:@"username"] andPwd:[userInfo objectForKey:@"password"] andBalance:[userInfo objectForKey:@"balance"] andBirthday:[userInfo objectForKey:@"birthday"] andCreatetime:[userInfo objectForKey:@"createtime"] andDiqu:[userInfo objectForKey:@"diqu"] andEmail:[userInfo objectForKey:@"email"] andIdnumber:[userInfo objectForKey:@"idnumber"] andIdtype:[userInfo objectForKey:@"idtype"] andLevel:[userInfo objectForKey:@"level"] andLevels:[userInfo objectForKey:@"levels"] andLogintime:[userInfo objectForKey:@"logintime"] andMtype:[userInfo objectForKey:@"mtype"] andPhone:[userInfo objectForKey:@"phone"] andRealname:[userInfo objectForKey:@"realname"] andSalt:[userInfo objectForKey:@"salt"] adnSex:[userInfo objectForKey:@"sex"] andShengshiquxian:[userInfo objectForKey:@"address"] andUid:[userInfo objectForKey:@"uid"] adnAssistant_id:[userInfo objectForKey:@"assistant_id"] andIs_detachable:[userInfo objectForKey:@"is_detachable"] andUsergroup:[userInfo objectForKey:@"usergroup"] andAvater:[userInfo objectForKey:@"avater"] andMember_count:[userInfo objectForKey:@"member_count"]andPwd2:@"123456"andIs_withdraw:@"0"];
                
                 NSNotification *notification = [NSNotification notificationWithName:UpdateImage object:nil];
                 [[NSNotificationCenter defaultCenter] postNotification:notification];
                 [super close];
                 
             }else
             {
                 BindLoginViewController *bindVC = [[BindLoginViewController alloc] init];
                 bindVC.phoneStr = [weiXinDic objectForKey:@"headimgurl"];
                 bindVC.name = [weiXinDic objectForKey:@"nickname"];
                 bindVC.openId = [weiXinDic objectForKey:@"openid"];
                 [self.navigationController pushViewController:bindVC animated:YES];
             }
             
         }else
         {
             [[LXAlterView sharedMyTools] createTishi:@"网络请求失败"];
         }
     }failure:^(AFHTTPRequestOperation *operation,NSError *error)
     {
         [[LXAlterView sharedMyTools] createTishi:@"登陆失败"];
     }];
}


//点击登陆button

-(void)loginbtnClicked{
    if (loginUsernme.text.length==0 || loginPassword.text.length==0)
    {
        DLog(@"手机号不正确或者为空");
        [[LXAlterView sharedMyTools] createTishi:@"手机号不正确或者为空"];
    }
//    else if (loginPassword.text.length==0)
//    {
//        [[LXAlterView sharedMyTools] createTishi:@"请填写密码"];
//    }
    else{
        [self sendRequestaTag:1];
    }
}

-(void)sendRequestaTag:(int)tag
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    //申明返回的结果是json类型
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //    //申明请求的数据是json类型
    //    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //    //如果报接受类型不一致请替换一致text/html或别的
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
   
     NSDictionary *parameters = @{@"username":loginUsernme.text,@"password":loginPassword.text};
    //if (tag == 1) {
    //      NSDictionary *parameters = @{@"username":loginUsernme.text,@"password":loginPassword.text};
     // }
     //if (tag == 2) {
    //  parameters = @{@"username":PhoneNum.text,@"password":pwdSTRing};
  //  }
    
    [manager POST:ordinaryLoginUrl parameters:parameters
     
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              
              DLog(@"denglu msg is: %@---- %@", [responseObject objectForKey:@"msg"],responseObject);
              if ([[responseObject objectForKey:@"status"] integerValue]==1)
              {
                  
                  [[LXAlterView sharedMyTools] createTishi:@"登录成功"];
                  NSDictionary *dic=[responseObject objectForKey:@"data"];
                  DLog(@"登录成功");
                  
                  //把用户信息存到本地
                  [[LXUserTool alloc] saveUserNameAndPwd:[dic objectForKey:@"username"] andPwd:loginPassword.text andBalance:[dic objectForKey:@"balance"] andBirthday:[dic objectForKey:@"birthday"] andCreatetime:[dic objectForKey:@"createtime"] andDiqu:[dic objectForKey:@"diqu"] andEmail:[dic objectForKey:@"email"] andIdnumber:[dic objectForKey:@"idnumber"] andIdtype:[dic objectForKey:@"idtype"] andLevel:[dic objectForKey:@"level"] andLevels:[dic objectForKey:@"levels"] andLogintime:[dic objectForKey:@"logintime"] andMtype:[dic objectForKey:@"mtype"] andPhone:[dic objectForKey:@"phone"] andRealname:[dic objectForKey:@"realname"] andSalt:[dic objectForKey:@"salt"] adnSex:[dic objectForKey:@"sex"] andShengshiquxian:[dic objectForKey:@"address"] andUid:[dic objectForKey:@"uid"] adnAssistant_id:[dic objectForKey:@"assistant_id"] andIs_detachable:[dic objectForKey:@"is_detachable"] andUsergroup:[dic objectForKey:@"usergroup"] andAvater:[dic objectForKey:@"avater"] andMember_count:[dic objectForKey:@"member_count"]andPwd2:@"123456"andIs_withdraw:@"0"];
                  
                  //获取管家所属销售商id
                  if ([[dic objectForKey:@"usergroup"] isEqualToString:@"assistant"]) {
                      [self sendRequestGetAdmin_id:[dic objectForKey:@"uid"]];
                  }
                  
                  NSNotification *notification = [NSNotification notificationWithName:UpdateImage object:nil];
                  [[NSNotificationCenter defaultCenter] postNotification:notification];
                  [self.navigationController popViewControllerAnimated:YES];
                  
                  //把用户信息传到上一个页面
                  if (self.lgblock) {
                      lgblock([responseObject objectForKey:@"data"]);
                  }
                  
                 // [super close];
                  
                  
              }
              else
              {
                  DLog(@"登录失败");
                  [[LXAlterView sharedMyTools] createTishi:@"登录失败"];
              }
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              [[LXAlterView sharedMyTools] createTishi:@"登录失败，请检查网络"];
              
          }];
    
}

-(void)sendRequestGetAdmin_id:(NSString *)uid
{
    
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
              NSLog(@"Error: %@", error);
          }];
    
}


/**********************************************************************注册************************************************************************/


//注册获取验证码按钮
-(void)btnClick:(id)sender{
    //获取验证码
    if (PhoneNum.text.length!=11) {
        DLog(@"手机号不正确或者为空");
        [[LXAlterView sharedMyTools] createTishi:@"手机号不正确或者为空"];
    }else
    {
        //[self startTime];
        //发送验证码
        NSDictionary *parameters = @{@"phone_number":PhoneNum.text};
        [self sendRequest:parameters aurl:GetVerficatCodeUrl aTag:1];
    }

}


//注册button
-(void)registerBtnClicked{
    if (PhoneNum.text.length!=11)
    {
        DLog(@"手机号不正确或者为空");
        [[LXAlterView sharedMyTools] createTishi:@"手机号不正确或者为空"];
    }
    else
    {
        NSDictionary *parameters = @{@"phone":PhoneNum.text,@"code":yanzhengCode.text,@"mtype":@"3"};
         [self sendRequest:parameters aurl:FirstLoginUrl aTag:2];
    }
}

-(void)sendRequest:(NSDictionary *)parameters aurl:(NSString *)url aTag:(int)tag
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    //申明返回的结果是json类型
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //    //申明请求的数据是json类型
    //    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //    //如果报接受类型不一致请替换一致text/html或别的
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
     manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters
     
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              if (tag==1)
              {
                  //获取验证码
                  if ([[dic objectForKey:@"msg"] isEqualToString:@"发送成功"]) {
                      [self startTime];
                  }
                  else
                  {
                      [[LXAlterView sharedMyTools] createTishi:[dic objectForKey:@"msg"]];
                  }
                 // DLog(@"Success: %@=====%@", responseObject,[dic objectForKey:@"msg"]);
                  
              }
              else if(tag==2)
              {
                  //注册
                  DLog(@"zhuce msg is : %@ ", dic);
              //if([dic objectForKey:@"errno"] != [NSNull null]){
                  
                  NSLog(@"898989999999999----%@",[dic objectForKey:@"msg"]);
                  if ([[dic objectForKey:@"msg"] isEqualToString:@"注册成功！"])
                  {
                      
                      [[LXAlterView sharedMyTools] createTishi:@"注册成功,已自动登录"];
                     //Plist
                      NSDictionary *diccc= [dic objectForKey:@"data"];
                      
                      [self.navigationController popViewControllerAnimated:YES];
                      //把用户信息存到本地
                      [[LXUserTool alloc] saveUserNameAndPwd:[diccc objectForKey:@"username"] andPwd:loginPassword.text andBalance:[diccc objectForKey:@"balance"] andBirthday:[diccc objectForKey:@"birthday"] andCreatetime:[diccc objectForKey:@"createtime"] andDiqu:[diccc objectForKey:@"diqu"] andEmail:[diccc objectForKey:@"email"] andIdnumber:[diccc objectForKey:@"idnumber"] andIdtype:[diccc objectForKey:@"idtype"] andLevel:[diccc objectForKey:@"level"] andLevels:[diccc objectForKey:@"levels"] andLogintime:[diccc objectForKey:@"logintime"] andMtype:[diccc objectForKey:@"mtype"] andPhone:[diccc objectForKey:@"phone"] andRealname:[diccc objectForKey:@"realname"] andSalt:[diccc objectForKey:@"salt"] adnSex:[diccc objectForKey:@"sex"] andShengshiquxian:[diccc objectForKey:@"address"] andUid:[diccc objectForKey:@"uid"] adnAssistant_id:[diccc objectForKey:@"assistant_id"] andIs_detachable:[diccc objectForKey:@"is_detachable"] andUsergroup:[diccc objectForKey:@"usergroup"] andAvater:[diccc objectForKey:@"avater"] andMember_count:[diccc objectForKey:@"member_count"]andPwd2:@"123456"andIs_withdraw:@"0"];

                      
                      NSNotification *notification = [NSNotification notificationWithName:UpdateImage object:nil];
                      [[NSNotificationCenter defaultCenter] postNotification:notification];
                      
                      if (self.rgblock) {
                          rgblock(PhoneNum.text);
                      }
                     
                  }else if([[dic objectForKey:@"msg"] isEqualToString:@"您已经是我站会员，将直接登录"])
                  {
                      [[LXAlterView sharedMyTools] createTishi:@"该手机号已注册"];
                  }
                  else
                  {
                      [[LXAlterView sharedMyTools] createTishi:@"注册失败"];
                    //  DLog(@"注册失败");
                }
                  
              }
              
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              [[LXAlterView sharedMyTools] createTishi:@"注册失败，请检查网络"];
              
          }];
    
}


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
                [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                getCodeBtn.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
               // NSLog(@"____%@",strTime);
                [getCodeBtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                getCodeBtn.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}



#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs;
    if(textField == loginUsernme || textField == PhoneNum)
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



//keyboardmiss
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [loginUsernme resignFirstResponder];
    [loginPassword resignFirstResponder];
    [PhoneNum resignFirstResponder];
    [yanzhengCode resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
     [loginUsernme resignFirstResponder];
     [loginPassword resignFirstResponder];
     [PhoneNum resignFirstResponder];
     [yanzhengCode resignFirstResponder];
    return YES;
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

@end

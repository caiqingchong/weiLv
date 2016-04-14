
//
//  AppDelegate.m
//  WelLv
//
//  Created by 刘鑫 on 15/4/1.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "AppDelegate.h"
#import <AlipaySDK/AlipaySDK.h>
#import <ShareSDK/ISSPlatformApp.h>
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WeiboSDK.h"
#import "APService.h"

#define AUTO_IPHONE6_HEIGHT_667 windowContentHeight/667

#define AUTO_IPHONE6_WIDTH_375 windowContentWidth/375

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    //延迟一秒
    sleep(1);
    
    //获取当前屏幕尺寸
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //设置当前屏幕背景颜色
    self.window.backgroundColor = [UIColor whiteColor];
    
    //设置当前屏幕可显示
    [self.window makeKeyAndVisible];
    
    //检测网络情况
    [self checkNetWork];
    
    //极光注册
    [self JPushSetup:launchOptions];
    
    //判断用户是否是第一次安装APP，如果是就显示引导页，否则直接进入主页面
    [self isFirstTimeSetupApp];
    
    //第三方ShareSDK注册
    [self thirdShareSDKSetup];

    //百度地图注册
    [self BMapSetup];
    
    //友盟统计注册
    [self UMENGSetup];
    
    //Bugly崩溃统计注册
    [self BuglySetup];
    
    //当前APP版本检测更新
    if ([isCheckUpage isEqual:@"YES"])
    {
        [CheckVersion checkVersion];
    }
    
    return YES;
}


#pragma mark - Bugly崩溃统计
-(void)BuglySetup
{
    [[CrashReporter sharedInstance] enableLog:YES];
    [[CrashReporter sharedInstance] installWithAppId:@"900020095"];
}

#pragma mark - 友盟统计注册
-(void)UMENGSetup
{
    //如果不需要捕捉异常，注释掉此行
    [MobClick setCrashReportEnabled:NO];
    
    // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    //[MobClick setLogEnabled:YES];
    
    //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    [MobClick setAppVersion:AppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默
    
    //设置是否对日志信息进行加密, 默认NO(不加密)
    [MobClick setEncryptEnabled:YES];
    
    //友盟统计注册
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) BATCH channelId:nil];
    
}
#pragma mark - 监测网络情况
-(void)checkNetWork
{
    // 监测网络情况
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [hostReach startNotifier];

}
#pragma mark - 监测网络状态
- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    switch (status)
    {
        case NotReachable:
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:WeiLvAppName message:@"当前网络状态不可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
        case ReachableViaWiFi:
        case ReachableViaWWAN:
            break;
        case kReachableVia2G:
            break;
        case kReachableVia3G:
            break;
        case kReachableVia4G:
            break;
    }
}


#pragma mark - 极光推送 注册
-(void)JPushSetup:(NSDictionary *)launchOptions
{
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
        {
        
            //可以添加自定义categories
            [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                           UIUserNotificationTypeSound |
                                                           UIUserNotificationTypeAlert)
                                               categories:nil];
        }
        else
        {
            //categories 必须为nil
            [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                           UIRemoteNotificationTypeSound |
                                                           UIRemoteNotificationTypeAlert)
                                               categories:nil];
        }
        //Required
        [APService setupWithOption:launchOptions];
}

#pragma mark - 判断用户是否是第一次安装APP
//http://www.cnblogs.com/ygm900/p/3571915.html
-(void)isFirstTimeSetupApp
{
    BOOL useing = [[NSUserDefaults standardUserDefaults] boolForKey:USER_GUIDE_KEY];
    if (useing == NO)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:ImageLink];
        self.introductionView = [[FirstStartViewController alloc]init];
        self.window.rootViewController=self.introductionView;
        __weak AppDelegate *weakSelf = self;
        self.introductionView.didSelectedEnter = ^()
        {
            [weakSelf.introductionView.view removeFromSuperview];
            weakSelf.introductionView = nil;
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:USER_GUIDE_KEY];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //显示首页
            [weakSelf showMain];
        };
        
    }
    else
    {
        //显示首页
        [self showMain];
    }

}

#pragma mark - 显示APP首页
- (void)showMain
{
    //显示APP首页
    [self checkUserInfo];
    
    _viewController = [[NTViewController alloc]init];
    
    self.window.rootViewController = _viewController;
    
    //启动页动画
    self.launchBackImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    
    self.launchBackImage.image = [UIImage imageNamed:@"登录注册页面背景"];
    
    [self.window addSubview:self.launchBackImage];
    
    [self.window bringSubviewToFront:self.launchBackImage];
    
    [self performSelector:@selector(setSubviewsOfLaunchImage) withObject:nil afterDelay:0.0f];
    
}

- (void)setSubviewsOfLaunchImage {
    
    //logo图片
    UIImage *login_reg_logo=[UIImage imageNamed:@"login_reg_logo"];
    
    UIImageView *logoImageView = [[UIImageView alloc] init];
    
    if (windowContentHeight == 480) {
        
        logoImageView.frame = CGRectMake(123, 125, login_reg_logo.size.width * AUTO_IPHONE6_WIDTH_375, (login_reg_logo.size.height + 8) * AUTO_IPHONE6_HEIGHT_667);
        
    }
    else{
        
        logoImageView.frame = CGRectMake(144.5 * AUTO_IPHONE6_WIDTH_375, 202 * AUTO_IPHONE6_HEIGHT_667, login_reg_logo.size.width * AUTO_IPHONE6_WIDTH_375,login_reg_logo.size.height * AUTO_IPHONE6_HEIGHT_667);
        
    }
    
    logoImageView.image =login_reg_logo;
    
    [self.launchBackImage addSubview:logoImageView];
    
    [self setAnimation:logoImageView andAnimationDirection:@"up"];
    
    
    //文字图片
    UIImageView *titleImageView = [[UIImageView alloc] init];
    
    if (windowContentHeight == 480) {
        
        titleImageView.frame = CGRectMake(68, 218, windowContentWidth - 68 * 2, 20);
        
    }
    else{
        
        titleImageView.frame = CGRectMake(80.5 * AUTO_IPHONE6_WIDTH_375, 315 * AUTO_IPHONE6_HEIGHT_667, 214 * AUTO_IPHONE6_WIDTH_375, 24 * AUTO_IPHONE6_HEIGHT_667);
    }
    
    titleImageView.image = [UIImage imageNamed:@"您家门口的旅行管家"];
    
    [self.launchBackImage addSubview:titleImageView];
    
    [self setAnimation:titleImageView andAnimationDirection:@"down"];
    
}

-(void)setAnimation:(UIImageView *)imageView andAnimationDirection:(NSString *)direction {
    
     UIImage *login_reg_logo=[UIImage imageNamed:@"login_reg_logo"];
    
    [UIView animateWithDuration:2.0f animations:^{
        
        if([direction isEqualToString:@"up"]){
            
            if (windowContentHeight == 480) {
                
                [imageView setFrame:CGRectMake(123, 80, login_reg_logo.size.width * AUTO_IPHONE6_WIDTH_375, (login_reg_logo.size.height + 8) * AUTO_IPHONE6_HEIGHT_667)];
            }
            else{
                
                [imageView setFrame:CGRectMake(144.5 * AUTO_IPHONE6_WIDTH_375, 100 * AUTO_IPHONE6_HEIGHT_667,login_reg_logo.size.width * AUTO_IPHONE6_WIDTH_375, login_reg_logo.size.height * AUTO_IPHONE6_HEIGHT_667)];
                
            }
            
        }else{
            
            if (windowContentHeight == 480) {
                
                [imageView setFrame:CGRectMake(68, 300, windowContentWidth - 68 * 2, 20)];
            }
            else{
                
                [imageView setFrame:CGRectMake(80.5 * AUTO_IPHONE6_WIDTH_375, windowContentHeight - 310 * AUTO_IPHONE6_HEIGHT_667, 214 * AUTO_IPHONE6_WIDTH_375, 24 * AUTO_IPHONE6_HEIGHT_667)];
                
            }
        }
        
        imageView.alpha = 0.1f;
        
    } completion:^(BOOL finished) {
        
        [imageView removeFromSuperview];
        
        [self.launchBackImage removeFromSuperview];
        
    }];
}

#pragma mark - 检验用户
- (void)checkUserInfo
{
    
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] != WLMemberTypeNone)
    {
        //用户类型（会员，管家）
        NSString * usergroup_str = @"";
        NSString *userPwd=@"";
        NSString *userName=@"";
        if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeMember)
        {
            //会员登录
            usergroup_str = [LXUserTool sharedUserTool].getuserGroup;
            
            if ([LXUserTool sharedUserTool].getUserName!=nil) {
                userName=[LXUserTool sharedUserTool].getUserName ;
            }
        }
        else if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward)
        {
            //管家登录
            usergroup_str = [LXUserTool sharedUserTool].getuserGroup;
            
            if ([LXUserTool sharedUserTool].getPhone!=nil) {
                userName=[LXUserTool sharedUserTool].getPhone;
            }
        }
        if ([LXUserTool sharedUserTool].getPwd!=nil) {
            userPwd=[LXUserTool sharedUserTool].getPwd;
        }
        userName=[userName  stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSDictionary *parameters = @{@"username":userName,
                                     @"password":userPwd,
                                     @"usergroup":usergroup_str};
        
       
        DLog(@"管家判断登录参数：%@",parameters);
        //检查登录验证接口
        NSString *url= M_URL_CHECK_LOGIN;
        //发送请求
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if ([dic isKindOfClass:[NSDictionary class]] && [[dic objectForKey:@"status"] integerValue] == 1)
            {
                
            }
            else
            {
                //移除登录者信息
                [[LXUserTool sharedUserTool] deleteUser];
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
           // DLog(@"ERROR: %@", error);
        }];
    }
    
}

#pragma mark - 微信注册、第三方分享ShareSDK注册
-(void)thirdShareSDKSetup
{
    
    //微信注册
    [WXApi registerApp:@"wxfeec97b008327f80"];
    
    //ShareSDK分享注册
    [ShareSDK registerApp:@"8293244e2a87"];
    
    //1.微信登陆的时候需要初始化
    [ShareSDK connectWeChatWithAppId:@"wxfeec97b008327f80"
                           appSecret:@"7a4818311a585eb073d3c8a5da517413"
                           wechatCls:[WXApi class]];
    
    //2.注册qq
    [ShareSDK connectQQWithQZoneAppKey:@"1104548384" qqApiInterfaceCls:[QQApiInterface class] tencentOAuthCls:[TencentOAuth class]];
    
    //3.注册QQ空间
    [ShareSDK connectQZoneWithAppKey:@"1104548384" appSecret:@"6N5XkFpM5KfpIP6H" qqApiInterfaceCls:[QQApiInterface class] tencentOAuthCls:[TencentOAuth class]];
    
    //4.注册新浪微博客户端
    //[ShareSDK connectSinaWeiboWithAppKey:@"2224092312" appSecret:@"93a6c0da2a6696a2f53d618d340bdef2" redirectUri:@"https://api.weibo.com/oauth2/default.html" weiboSDKCls:[WeiboSDK class]];
}

#pragma mark - 百度地图 注册
-(void)BMapSetup
{
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"Qz7vYgQeGo4QtcGyInN8w7f0" generalDelegate:self];

    if (!ret)
    {
      //DLog(@"百度地图启动失败");
    }
}


- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
   // [application setApplicationIconBadgeNumber:0];
    //[application cancelAllLocalNotifications];
    //把角标设置为0 清除所有的通知
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{
   
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //判断是否是支付宝支付
    if ([url.host isEqualToString:@"safepay"])
    {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic){
           // DLog(@"result = %@",resultDic);
        }];

        return YES;
    }
    else if ([url.host isEqualToString:@"oauth"])
    {
        //微信第三方登录
        return [WXApi handleOpenURL:url delegate:self];
    }
    else
    {
        //ShareSDK分享URL处理
        return [ShareSDK handleOpenURL: url sourceApplication:sourceApplication annotation: annotation wxDelegate: self];
    }
}


#pragma mark - 第三方登录（微信，QQ）登录、支付回调函数
- (void)onResp:(BaseResp *)resp
{
    SendAuthResp *aresp = (SendAuthResp *)resp;
   
    if ([resp isKindOfClass:[PayResp class]])
    {
        PayResp *response = (PayResp *)resp;
        
        NSString *strTitle = [NSString stringWithFormat:@"支付结果"];
        NSString *strMsg = [NSString stringWithFormat:@"%d", response.errCode];
        
        switch (response.errCode)
        {
            //微信支付成功
            case WXSuccess:
            {
              strMsg = @"支付结果：成功！";
                NSNotification *notification = [NSNotification notificationWithName:ORDER_PAY_NOTIFICATION object:strMsg];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
            //用户取消微信支付
            case WXErrCodeUserCancel:
            {
                strMsg = @"用户取消操作！";
                break;
            }
            default:
            {
                //微信支付失败
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                break;
            }
        }
        //弹出提示框
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
                                                        message:strMsg
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];

    }
    else if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        if (resp.errCode==0)
        {
            NSString *errCode=[NSString stringWithFormat:@"%d",resp.errCode];
            
            NSNotification *notification = [NSNotification notificationWithName:WeiCode object:errCode];
            [[NSNotificationCenter defaultCenter] postNotification:notification];

        }
    }
    else
    {
        //第三方登录回调函数处理
        if (resp.errCode == 0)
        {
            NSString *code = aresp.code;
            NSNotification *notification = [NSNotification notificationWithName:WeiCode object:code];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }
        
    }

}
#pragma mark - 获取当前设备的Token，并把Token注册至推送消息服务器
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //获取当前设备的Token
    [APService registerDeviceToken:deviceToken];
}

#pragma mark - 收到通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [APService handleRemoteNotification:userInfo];
    
  //  DLog(@"收到通知:%@",userInfo);
}

#pragma mark - 收到远程通知 业务处理
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [APService handleRemoteNotification:userInfo];
   // DLog(@"收到通知:%@",userInfo);
    //接受通知消息内容
    NSString *notficationMsg=@"";
    //获取通知消息
    if ([userInfo objectForKey:@"aps"]!=nil)
    {
        if ([[userInfo objectForKey:@"aps"] objectForKey:@"alert"]!=nil)
        {
            notficationMsg=[[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
            
        }
    }
    
    //判断接受消息的当前状态
    if (1==[UIApplication sharedApplication].applicationState)
    {
//        UIAlertView *aletView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:notficationMsg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [aletView show];
    }
    else
    {
//        UIAlertView *aletView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:notficationMsg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
//        [aletView show];
        
    }
    completionHandler(UIBackgroundFetchResultNewData);
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (1==buttonIndex)
    {
       // DLog(@"大家好");
        //APP端版本 提示框 按钮
        NSString *iTunesString = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@",WeiLvAppID];
        NSURL *iTunesURL = [NSURL URLWithString:iTunesString];
        [[UIApplication sharedApplication] openURL:iTunesURL];
    }
    else
    {
       // DLog(@"大家辛苦了");
    }
}


#pragma mark - 推送消息 报错消息
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
   // DLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}



#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings
{
 
    
}


- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler
{
    
    
}


- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler
{
    
    
}
#endif






- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification
{
    [APService showLocalNotificationAtFront:notification identifierKey:nil];
}

@end

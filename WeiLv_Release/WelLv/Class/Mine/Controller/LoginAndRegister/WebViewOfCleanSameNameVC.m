//
//  WebViewOfCleanSameNameVC.m
//  WelLv
//
//  Created by 赵阳 on 16/3/17.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "WebViewOfCleanSameNameVC.h"
#import "LoginAndRegisterViewController.h"
#import "LXUserTool.h"
#import "APService.h"
#import "MineViewController.h"

@interface WebViewOfCleanSameNameVC ()< UIWebViewDelegate >
{
    //用户名重复时跳转WebView
    UIWebView *_userWebView;
}
@end

@implementation WebViewOfCleanSameNameVC

@synthesize block;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    

    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    self.title = @"修改用户名";

    
    [self initContent];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
}


-(void)initContent{
    
    _userWebView=[[UIWebView alloc] init];
    
    _userWebView.frame=CGRectMake(0, 0, windowContentWidth, windowContentHeight);
    
    _userWebView.delegate=self;
    
    [self.view addSubview:_userWebView];
    
    NSURLRequest *urlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:CLEAN_SAME_USERNAME_RUL]];
    
    [_userWebView loadRequest:urlRequest];
    
}

#pragma mark - 用户名相同时跳转的webview

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 处理事件
    NSString *requestString = [[request URL] absoluteString];
    
    DLog(@"====%@",requestString);
    
    //字符串末尾有某字符串；
    if ([requestString hasSuffix:@"upgrade?AType=ios"]) {
        
        DLog(@"has upgrade");
    }
    else
    {
        MineViewController * getmoney = nil;
        
        for (UIViewController * VC in self.navigationController.viewControllers) {
            
            if ([VC isKindOfClass:[MineViewController class]]) {
                
                getmoney = (MineViewController *)VC;
                
            }
            
        }
        
        [self.navigationController popToViewController:getmoney animated:YES];
        
        __weak WebViewOfCleanSameNameVC * weakSelf = self;
        
        [weakSelf dealWithUserWithDic:self.dict];
        
    }
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    //[[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
    [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
    
    [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
        
        NSURLRequest *urlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:CLEAN_SAME_USERNAME_RUL]];
        
        [_userWebView loadRequest:urlRequest];
        
    }];
}


#pragma mark - 处理普通会员登录成功后的信息

- (void)dealWithUserWithDic:(NSDictionary *)dict{
    NSDictionary *dic=[dict objectForKey:@"data"];
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        
        DLog(@"登录成功------会员");
        //把用户信息存到本地
        [[LXUserTool sharedUserTool] saveUserNameAndPwd:[dic objectForKey:@"username"]
                                                 andPwd:self.loginPasswordTF.text
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
                                                andPwd2:self.loginPasswordTF.text
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

- (void)loginBlock {
    if (self.block) {
        block(nil);
    }
    [super close];
}

- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias
{
    
    // DLog(@"TagsAlias回调:%d", iResCode);
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

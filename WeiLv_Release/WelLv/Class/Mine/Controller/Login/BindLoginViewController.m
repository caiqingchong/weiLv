//
//  BindLoginViewController.m
//  WelLv
//
//  Created by lyx on 15/4/17.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "BindLoginViewController.h"
#import "APService.h"

@interface BindLoginViewController ()
{
     NSMutableArray* _textFields;
}
@end

@implementation BindLoginViewController
@synthesize phoneImageView = _phoneImageView;
@synthesize userName = _userName;
@synthesize name = _name;
@synthesize phoneStr = _phoneStr;
@synthesize openId = _openId;
@synthesize block;

- (void)viewDidAppear:(BOOL)animated
{
    [_inputTextField resignFirstResponder];
    [super viewDidAppear:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.title = @"绑定手机号";

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
    _textFields = [[NSMutableArray alloc] init];
    
    UIImageView *bgImage = [YXTools allocImageView:self.view.bounds image:[UIImage imageNamed:@"第三方登录背景"]];
    bgImage.contentMode = UIViewContentModeScaleAspectFill;
    [_scrollView addSubview:bgImage];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake((windowContentWidth - 106)/2, 120, 106, 106)];
    view1.backgroundColor = [UIColor whiteColor];
    view1.layer.cornerRadius = 53.0;
    [_scrollView addSubview:view1];
    _phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake((windowContentWidth - 100)/2, ViewY(view1)+3, 100, 100)];
    [_phoneImageView sd_setImageWithURL:[NSURL URLWithString:self.phoneStr]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ModifyPhone:)];
    [_phoneImageView addGestureRecognizer:tap];
    _phoneImageView.userInteractionEnabled = YES;
    _phoneImageView.layer.masksToBounds=YES;
    _phoneImageView.layer.cornerRadius = 50.0;
    [_scrollView addSubview:_phoneImageView];
    
    _userName = [YXTools allocLabel:self.name font:systemBoldFont(15) textColor:[UIColor whiteColor] frame:CGRectMake(0, ViewY(view1)+ViewHeight(view1)+10, windowContentWidth, 30) textAlignment:1];
    [_scrollView addSubview:_userName];
    
    [self initView];
}

- (void)ModifyPhone:(UIGestureRecognizer *)tap
{
    if (_verificView.hidden == NO && _phoneTextField.text.length > 0) {
        [YXTools uiViewAnimationTransition:_bindView typeIndex:3 duration:0.5 animation:^{
            _verificView.hidden = YES;
            _bindView.hidden = NO;
            [_inputTextField resignFirstResponder];
            [verificatBtn setTitle:@"绑定" forState:UIControlStateNormal];
        }];
    }
}
- (void)initView
{
    UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"third_Phone_Bg"]];
    leftView.frame = CGRectMake(5, 0, 40, 56/2);
    leftView.contentMode = UIViewContentModeScaleAspectFit;
    
    _bindView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(_userName)+ViewHeight(_userName)+20, windowContentWidth , 100)];
    _bindView.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:_bindView];
    
    _phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, windowContentWidth - 30, 50)];
    _phoneTextField.clearButtonMode = UITextFieldViewModeAlways;
    _phoneTextField.textColor = [UIColor whiteColor];
    _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    _phoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phoneTextField.returnKeyType = UIReturnKeySearch;
    _phoneTextField.placeholder = @"请输入您的手机号码";
    [_phoneTextField setValue:[UIColor colorWithRed:228/255.0 green:231/25.0 blue:233/255.0 alpha:1]forKeyPath:@"_placeholderLabel.textColor"];
    _phoneTextField.font = systemBoldFont(16);
    _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    _phoneTextField.leftView = leftView;
    _phoneTextField.delegate = self;
    [_bindView addSubview:_phoneTextField];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, ViewHeight(_phoneTextField)+ViewY(_phoneTextField), windowContentWidth - 30, 1)];
    line.backgroundColor = [UIColor whiteColor];
    [_bindView addSubview:line];
    
    verificatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    verificatBtn.frame=CGRectMake(ViewX(line), ViewHeight(_bindView)+ViewY(_bindView), ViewWidth(line), 35);
    [verificatBtn.layer setCornerRadius:35/2];
    verificatBtn.titleLabel.font = systemBoldFont(15);
    [verificatBtn setTitle:@"绑定" forState:UIControlStateNormal];
    [verificatBtn setBackgroundImage:[UIImage imageNamed:@"green_Btn"] forState:UIControlStateNormal];
    [verificatBtn addTarget:self action:@selector(verificatClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:verificatBtn];
    
    UILabel *loginLabel = [YXTools allocLabel:@"初次登录需绑定手机号码" font:systemBoldFont(14) textColor:[UIColor whiteColor] frame:CGRectMake(0, ViewY(verificatBtn)+ViewHeight(verificatBtn), windowContentWidth, 30) textAlignment:1];
    [_scrollView addSubview:loginLabel];
    
    _scrollView.contentSize = CGSizeMake(0, ViewY(_bindView)+ViewHeight(_bindView)+150);
    
    
    _verificView = [[UIView alloc] initWithFrame:_bindView.frame];
    _phoneLabel = [YXTools allocLabel:@"短信验证已发送" font:systemBoldFont(15) textColor:[UIColor whiteColor] frame:CGRectMake(0, 0, windowContentWidth, 30) textAlignment:1];
    [_verificView addSubview:_phoneLabel];
    
    CGFloat itemX = (windowContentWidth - 30*6+10)/2;
    CGFloat itemWidth = 20;
    for (int i = 0; i<6; i++) {
        YXPasscodeField *view = [[YXPasscodeField alloc] initWithFrame:CGRectMake(itemX +(10+itemWidth)*i, ViewHeight(_phoneLabel)+ViewY(_phoneLabel)+20, itemWidth, itemWidth)];
        [_verificView addSubview:view];
        [_textFields addObject:view];
    }
    [_scrollView addSubview:_verificView];
    _inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_inputTextField setDelegate:self];
    [_inputTextField addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventEditingChanged];
    _inputTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_inputTextField];
    _verificView.hidden = YES;
}

#pragma mark - 点击 "绑定" 事件
- (void)verificatClick
{
    if (_verificView.hidden)
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
        else
        {
            NSDictionary *parameters = @{@"phone_number":_phoneTextField.text};
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            [manager POST:WeiXinCodeUrl parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject)
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
                    [YXTools uiViewAnimationTransition:_verificView typeIndex:3 duration:0.5 animation:^{
                        _verificView.hidden = NO;
                        _bindView.hidden = YES;
                        [_inputTextField becomeFirstResponder];
                        [verificatBtn setTitle:@"登录" forState:UIControlStateNormal];
                    }];
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
        NSDictionary *parameters = @{@"phone":_phoneTextField.text,@"code":_inputTextField.text,@"openid":self.openId,@"avater":self.phoneStr,nick:self.name};
        WS(weakSelf);
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
                                                                 andPwd2:@"123456"
                         andIs_withdraw:@"0"];
                        
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
                         
                         /*---------------------支付推送测试-----------------------------------*/
                         __autoreleasing NSMutableSet *tags = [NSMutableSet set];
                         NSString *uidStr = [[LXUserTool sharedUserTool] getUid];
                         __autoreleasing NSString *alias = uidStr;
                         [self analyseInput:&alias tags:&tags];
                         
                         [APService setTags:tags
                                      alias:alias
                           callbackSelector:@selector(tagsAliasCallback:tags:alias:)
                                     target:self];
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
            // DLog(@"验证码：%@",error);
             [[LXAlterView sharedMyTools] createTishi:@"网络请求失败"];
             [self.navigationController popViewControllerAnimated:YES];
         }];

    }
}

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _inputTextField)
    {
        NSUInteger oldLength = [textField.text length];
        NSUInteger replacementLength = [string length];
        NSUInteger rangeLength = range.length;
        NSUInteger newLength = oldLength - rangeLength + replacementLength;
        BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
        return newLength <= 6|| returnKey;
    }
    return YES;
}


//控制键盘不遮挡按钮和输入框
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [YXTools uiViewAnimationTransition:nil typeIndex:0 duration:_animationDuration animation:^{
        _scrollView.contentOffset = CGPointMake(_scrollView.frame.origin.x, [textField superview].frame.origin.y - 30);
    }];

}

- (void)editingChanged:(UITextField *)sender
{
    for (YXPasscodeField* field in _textFields)
    {
        field.text = @"";
    }
    for (int i = 0; i < sender.text.length; i++)
    {
        YXPasscodeField* field = [_textFields objectAtIndex:i];
        NSRange range;
        range.length = 1;
        range.location = i;
        field.text = [sender.text substringWithRange:range];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)loginBlock
{
    if (self.block)
    {
        block(nil);
    }
    [super close];
}

#pragma mark   -激光设置
- (void)analyseInput:(NSString **)alias tags:(NSSet **)tags {
    if (![*alias length])
    {
        *alias = nil;
    }
    if (![*tags count])
    {
        *tags = nil;
    }
    else
    {
        __block int emptyStringCount = 0;
        [*tags enumerateObjectsUsingBlock:^(NSString *tag, BOOL *stop)
        {
            if ([tag isEqualToString:@""])
            {
                emptyStringCount++;
            }
            else
            {
                emptyStringCount = 0;
                *stop = YES;
            }
        }];
        if (emptyStringCount == [*tags count])
        {
            *tags = nil;
        }
    }
}

- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias
{
    
   // DLog(@"TagsAlias回调:%d", iResCode);
}

@end


@implementation YXPasscodeField

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _emptyIndicator = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height / 2 - 1, self.bounds.size.width, 2)];
        _emptyIndicator.backgroundColor = [UIColor whiteColor];
        [self addSubview:_emptyIndicator];
        
        _textLable = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2 - 6, self.bounds.size.height / 2 - 6, 12, 12)];
        _textLable.backgroundColor = [UIColor clearColor];
        _textLable.textColor = [UIColor whiteColor];
        [self addSubview:_textLable];
    }
    return self;
}

- (void)setText:(NSString *)text
{
    _emptyIndicator.alpha = text.length > 0 ? 0.0f : 1.0f;
    _textLable.text = text;
}

@end

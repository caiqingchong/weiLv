//
//  AuthCodeViewController.m
//  WelLv
//
//  Created by 赵阳 on 16/1/25.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "AuthCodeViewController.h"

#import "ResetPasswordViewController.h"

@interface AuthCodeViewController ()<UITextFieldDelegate>
{
    BOOL _hasSentMessage;
    
    UITextField *_AuthCodeTF;//验证码输入框
    
    UILabel *_getAuthCode;//验证码倒计时
    
    UILabel *_stepLabel1;
    
    UILabel *_stepLabel2;
    
    UILabel *_stepLabel3;
    
    UIButton *_loginBtn;
    
    UIScrollView *_bgScrollView;
    
    UIView *_contentView;
}

@end

@implementation AuthCodeViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.memberType == WLMemberTypeMember) {
        
        self.title=@"验证会员身份";
        
    }
    else if (self.memberType == WLMemberTypeSteward) {
        
        self.title=@"验证管家身份";
        
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
    
    
    [self initContent];//加载内容
    
    [self startTime];//开启倒计时
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    _hasSentMessage = NO;
}

-(void)initContent
{
    _bgScrollView=[[UIScrollView alloc] initWithFrame:self.view.frame];
    
    _bgScrollView.backgroundColor= BgViewColor;
    
    [self.view addSubview:_bgScrollView];
    
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 55, windowContentWidth, 50)];
    
    _contentView.backgroundColor=[UIColor whiteColor];
    
    [_bgScrollView addSubview:_contentView];
    
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKBoard)];
    
    [_bgScrollView addGestureRecognizer:tap];
    

    //步骤Label
    _stepLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 8, windowContentWidth/3, 45)];
    
    _stepLabel1.text = @"1.输入手机号";
    
    _stepLabel1.font = [UIFont systemFontOfSize:17];
    
    _stepLabel1.textAlignment = NSTextAlignmentRight;

    _stepLabel1.textColor = [UIColor blackColor];
    
    _stepLabel1.alpha = 0.3;
    
    [_bgScrollView addSubview:_stepLabel1];
    
    
    _stepLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth/3, 8, windowContentWidth/3, 45)];
    
    _stepLabel2.text = @"2.短信验证";
    
    _stepLabel2.font = [UIFont systemFontOfSize:17];
    
    _stepLabel2.textAlignment = NSTextAlignmentCenter;
    
    _stepLabel2.textColor = [UIColor orangeColor];
    
    _stepLabel2.alpha = 1.0;
    
    [_bgScrollView addSubview:_stepLabel2];
    
    
    _stepLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(2*windowContentWidth/3, 8, windowContentWidth/3, 45)];
    
    _stepLabel3.text = @"3.重置密码";
    
    _stepLabel3.font = [UIFont systemFontOfSize:17];
    
    _stepLabel3.textAlignment = NSTextAlignmentLeft;
    
    _stepLabel3.textColor = [UIColor blackColor];
    
    _stepLabel3.alpha = 0.3;
    
    [_bgScrollView addSubview:_stepLabel3];
    
    
    UIImageView *authCodeImage=[[UIImageView alloc] init];
    
    authCodeImage.frame=CGRectMake(30, 15, 15, 19);
    
    authCodeImage.image=[UIImage imageNamed:@"验证码"];
    
    [_contentView addSubview:authCodeImage];

    _AuthCodeTF=[[UITextField alloc] init];
    
    _AuthCodeTF.frame=CGRectMake(ViewWidth(authCodeImage)+40, 10, windowContentWidth-200, 30);
    
    _AuthCodeTF.placeholder=@"请输入验证码";
    
    _AuthCodeTF.delegate=self;
    
    [_contentView addSubview:_AuthCodeTF];

    
    //验证码倒计时
    _getAuthCode = [[UILabel alloc]initWithFrame:CGRectMake(ViewX(_AuthCodeTF)+ViewWidth(_AuthCodeTF)+10, 10, windowContentWidth-ViewX(_AuthCodeTF)-ViewWidth(_AuthCodeTF)-20, 30)];
        
    _getAuthCode.font = [UIFont systemFontOfSize:15];
    
    _getAuthCode.textColor = [UIColor orangeColor];
    
    [_contentView addSubview:_getAuthCode];
    
    
    UILabel *tishiLab=[[UILabel alloc] initWithFrame:CGRectMake(30, ViewY(_contentView)+ViewHeight(_contentView)+10, windowContentWidth-60, 30)];
    
    tishiLab.text= [NSString stringWithFormat:@"已发送短信验证码到 %@",self.phoneNum];
    
    tishiLab.font=[UIFont systemFontOfSize:14];
    
    tishiLab.alpha = 0.5;
    
    tishiLab.textColor=[UIColor blackColor];
    
    tishiLab.numberOfLines=0;
    
    tishiLab.adjustsFontSizeToFitWidth=YES;
    
    [_bgScrollView addSubview:tishiLab];
    
    
    //下一步按钮背景图
    UIImage* img=[UIImage imageNamed:@"评价"];//原图
    
    UIEdgeInsets edge=UIEdgeInsetsMake(5, 10, 5,10);
    
    //UIImageResizingModeStretch：拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片
    //UIImageResizingModeTile：平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图
    
    img= [img resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
    
    
    _loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    _loginBtn.frame=CGRectMake(30, ViewHeight(tishiLab)+ViewY(tishiLab)+40, windowContentWidth-60, 40);
    
    [_loginBtn setBackgroundImage:img forState:UIControlStateNormal];
    
    [_loginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    
    [_loginBtn setTintColor:[UIColor whiteColor]];
    
    [_loginBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _loginBtn.enabled = YES;
    
    [_bgScrollView addSubview:_loginBtn];
}

-(void)btnClick:(UIButton *)btn
{
    
    DLog(@"enter");
    
    NSDictionary *parameters = @{@"phone":self.phoneNum,
                                 @"token": @"7a6bd7af36e5db226281a037909fbdfd",
                                 @"code":_AuthCodeTF.text};
    
    NSString *jsonStr = [[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:parameters];
    
    NSDictionary *data = @{@"data": jsonStr};
    
    [self sendRequest:data aurl:JudgeAuthCode];
    
    _loginBtn.enabled = NO;
    
}

//重新布置页面高度，便于屏幕不够用时显示输入框
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (windowContentHeight==480)
    {
        //iPhone4
        _bgScrollView.contentSize=CGSizeMake(windowContentWidth, windowContentHeight+150);
        
        _bgScrollView.contentOffset=CGPointMake(0, 150);
        
    }

}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_bgScrollView endEditing:YES];
}

-(void)sendRequest:(NSDictionary *)parameters aurl:(NSString *)url
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
                  
                  resetPassword.phoneNum = self.phoneNum;
                  
                  resetPassword.memberType = self.memberType;
                  
                  [self.navigationController pushViewController:resetPassword animated:YES];
              
              }
              else if (status == -1){
                  
                  [[LXAlterView sharedMyTools] createTishi:[resultDict objectForKey:@"msg"]];

              }
              
              _loginBtn.enabled = YES;
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              
              _loginBtn.enabled = YES;
              
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
                _getAuthCode.text = @"验证时间过期";
                
                _loginBtn.userInteractionEnabled = NO;
                
            });
            
        }else{
            
            //            int minutes = timeout / 60;
            int seconds = timeout % 61;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                _getAuthCode.text = [NSString stringWithFormat:@"%@秒后重新发送",strTime];

                _loginBtn.userInteractionEnabled = YES;

            });
            
            timeout--;

        }
    });
    
    dispatch_resume(_timer);

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
        
        self.view.frame=CGRectMake(0, 64, windowContentWidth, windowContentHeight);
        
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

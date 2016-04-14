//
//  JYCBankCardsDetail.m
//  WelLv
//
//  Created by lyx on 16/1/19.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "JYCBankCardsDetail.h"

@interface JYCBankCardsDetail ()<UITextFieldDelegate>
{
    UITextField *codeTextField;
    //UITextField *nameTextField;
    AFHTTPRequestOperationManager *manager;
    NSString *code;
    UILabel *nameTextLabel;
    UIView *backgroundView;
}
@property(nonatomic,strong)UIButton *testBtn;

@end

@implementation JYCBankCardsDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"银行卡详情";
    self.view.backgroundColor=BgViewColor;
    [self createView];
}
-(void)createView
{
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 20, windowContentWidth, 160)];
    topView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:topView];
    UIImageView *logoImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    [logoImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WLHTTP,self.model.img]] placeholderImage:[UIImage imageNamed:@"默认图3"]];
    [topView addSubview:logoImage];
    UILabel *bankNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(logoImage)+10, 10, 150, 20)];
    bankNameLabel.textColor=[UIColor blackColor];
    bankNameLabel.font=[UIFont systemFontOfSize:16];
    bankNameLabel.text=[NSString stringWithFormat:@"%@",self.model.bank];
    [topView addSubview:bankNameLabel];
    UILabel *numlabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewX(bankNameLabel),ViewBelow(bankNameLabel)+20, 90, 20)];
    NSString *str2=[self.model.account substringWithRange:NSMakeRange(self.model.account.length-4, 4)];
    numlabel.text=[NSString stringWithFormat:@"尾号%@",str2];
    numlabel.textColor=[UIColor grayColor];
    numlabel.font=[UIFont systemFontOfSize:16];
    [topView addSubview:numlabel];
    UILabel *typeLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(numlabel)+10, ViewY(numlabel), 80, 20)];
    typeLabel.text=[NSString stringWithFormat:@"%@",self.model.card_type];
    typeLabel.textColor=[UIColor grayColor];
    typeLabel.font=[UIFont systemFontOfSize:16];
    [topView addSubview:typeLabel];
    UILabel *line1=[[UILabel alloc]initWithFrame:CGRectMake(0, 79.5, windowContentWidth, 0.5)];
    line1.backgroundColor=bordColor;
    [topView addSubview:line1];
    UILabel *cardNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, ViewBelow(line1), 100, 40)];
    cardNameLabel.text=@"持卡人姓名";
    cardNameLabel.textColor=[UIColor blackColor];
    cardNameLabel.font=[UIFont systemFontOfSize:16];
    [topView addSubview:cardNameLabel];
    if (![self judgeString:self.model.img])
    {
        logoImage.hidden=YES;
        [bankNameLabel setFrame:CGRectMake(10, 10, 150, 20)];
        [numlabel setFrame:CGRectMake(ViewX(bankNameLabel),ViewBelow(bankNameLabel)+20, 90, 20)];
        [typeLabel setFrame:CGRectMake(ViewRight(numlabel)+10, ViewY(numlabel), 80, 20)];
    }

    
    nameTextLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(cardNameLabel)+10, ViewBelow(line1), windowContentWidth-130, 40)];
    
    nameTextLabel.font=[UIFont systemFontOfSize:15];
    nameTextLabel.textColor=[UIColor blackColor];
    
    nameTextLabel.text=[NSString stringWithFormat:@"%@",self.model.name];
    [topView addSubview:nameTextLabel];
    UILabel *line2=[[UILabel alloc]initWithFrame:CGRectMake(0, 119.5, windowContentWidth, 0.5)];
    line2.backgroundColor=bordColor;
    [topView addSubview:line2];
    UILabel *codeLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, ViewBelow(line2), 100, 40)];
    codeLabel.textColor=[UIColor blackColor];
    codeLabel.font=[UIFont systemFontOfSize:16];
    codeLabel.text=@"短信验证码";
    [topView addSubview:codeLabel];
    codeTextField=[[UITextField alloc]initWithFrame:CGRectMake(ViewRight(codeLabel)+10, ViewBelow(line2), 100, 40)];
    //codeTextField.placeholder=@"请输入验证码";
    codeTextField.font=[UIFont systemFontOfSize:15];
    codeTextField.delegate=self;
    codeTextField.returnKeyType =UIReturnKeyDone;
    [topView addSubview:codeTextField];
    self.testBtn=[[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth-10-80, 120+5, 80, 30)];
    [self.testBtn setBackgroundImage:[UIImage imageNamed:@"获取"] forState:UIControlStateNormal];
    self.testBtn.layer.cornerRadius=4.0;
    [self.testBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.testBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.testBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:self.testBtn];
    UILabel *botomLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, ViewBelow(topView)+10, windowContentWidth-20, 20)];
    botomLabel.numberOfLines=0;
    NSString *str=[[LXUserTool sharedUserTool].getPhone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    botomLabel.text=[NSString stringWithFormat:@"如需解绑银行卡,请先验证手机,验证码将发送至%@",str];
    botomLabel.textColor=[UIColor grayColor];
    botomLabel.font=[UIFont systemFontOfSize:11];
    [self.view addSubview:botomLabel];
    UIButton *unfreezeBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, ViewBelow(botomLabel)+10, windowContentWidth-20, 40)];
    [unfreezeBtn setBackgroundImage:[UIImage imageNamed:@"解绑"] forState:UIControlStateNormal];
    [unfreezeBtn setTitle:@"解除绑定" forState:UIControlStateNormal];
    [unfreezeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [unfreezeBtn addTarget:self action:@selector(unfreezeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:unfreezeBtn];
    backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth,windowContentHeight)];
    backgroundView.backgroundColor=[UIColor colorWithWhite:0.2 alpha:0.5];
    [[[UIApplication sharedApplication] keyWindow] addSubview:backgroundView];
   
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [backgroundView addGestureRecognizer:tap];
    
    backgroundView.hidden=YES;
    UIView *whiteView=[[UIView alloc]initWithFrame:CGRectMake(40, windowContentHeight/2-75, windowContentWidth-80, 150)];
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap2)];
    [whiteView addGestureRecognizer:tap2];
    whiteView.layer.cornerRadius=4.0;
    whiteView.backgroundColor=[UIColor whiteColor];
    [backgroundView addSubview:whiteView];
    UILabel *topLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, ViewWidth(whiteView)-20, 20)];
    topLabel.textColor=[UIColor orangeColor];
    topLabel.textAlignment=NSTextAlignmentCenter;
    topLabel.text=@"您确定要解除绑定该银行卡吗";
    topLabel.font=[UIFont systemFontOfSize:15];
    [whiteView addSubview:topLabel];
    UIButton *cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, ViewBelow(topLabel)+40, (ViewWidth(whiteView)-20-10)/2, 40)];
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"未选中状态"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtn) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [whiteView addSubview:cancelBtn];
    UIButton * confirmBtn=[[UIButton alloc]initWithFrame:CGRectMake(ViewRight(cancelBtn)+10, ViewY(cancelBtn), ViewWidth(cancelBtn), ViewHeight(cancelBtn))];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtn) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setBackgroundImage:[UIImage imageNamed:@"选中状态"] forState:UIControlStateNormal];
    [whiteView addSubview:confirmBtn];
    
}
-(void)tap2{
    //这里不错任何操作，拦截父视图的点击事件
}
-(void)cancelBtn
{
    backgroundView.hidden=YES;
}
//确定取消绑定
-(void)confirmBtn
{
    backgroundView.hidden=YES;
    
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString *user_id = [LXUserTool sharedUserTool].getUid;
    
        // user_id = @"33058";
    NSString *token1 = [token stringByAppendingString:user_id];
    NSDictionary *dict=@{@"member_id":user_id,
                             @"_token":[WXUtil md5:token1],@"group_name":[[LXUserTool alloc] getuserGroup],@"action":@"unbind",@"mobile":[LXUserTool sharedUserTool].getPhone,@"sms_code":code,@"card_id":self.model.userid};
    DLog(@"%@",dict);
    [self bindWith:modify_bank_card and:dict];
    
}
-(void)tap
{
    backgroundView.hidden=YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [codeTextField resignFirstResponder];
}
#pragma textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   [textField resignFirstResponder];
    
    return YES;
}
-(void)unfreezeClick
{
    //NSString *bank_name=[NSString stringWithFormat:@"%@%@",bankName,bankBrandName];
   
    code=codeTextField.text;
    
    if ([code isEqualToString:@""]) {
        [[LXAlterView sharedMyTools]createTishi:@"请输入验证码"];
        return;
    }

    backgroundView.hidden=NO;


}
#pragma mark 解除绑定绑定信息验证
-(void)bindWith:(NSString *)url and:(NSDictionary *)dict
{
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];

    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dict[@"flag"]intValue]==1) {
            [[LXAlterView sharedMyTools]createTishi:@"解绑成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [[LXAlterView sharedMyTools]createTishi:dict[@"msg"]];
        }
        DLog(@"%@",dict);
         [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
         [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        
    }];
    
    
    
}


-(void)btnClick
{
    [self getPhoneNumber];
}

#pragma mark 获取手机验证码
-(void)getPhoneNumber
{
    [self startTime];
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    DLog(@"%@",[LXUserTool sharedUserTool].getPhone);
    // NSString *token1 = [token stringByAppendingString:user_id];
    NSString *groupName=[[LXUserTool alloc] getuserGroup];
    
    
    NSDictionary *zxdparameters = @{@"phone":[LXUserTool sharedUserTool].getPhone,@"usergroup":groupName,@"token":@"7a6bd7af36e5db226281a037909fbdfd"};
    
    NSString *str=[[WLSingletonClass defaultWLSingleton]wlDictionaryToJson:zxdparameters];
    NSDictionary *dic=@{@"data":str};
     [manager POST:ForgetPwdGetPwd parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       
        NSDictionary *zxdDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         [[LXAlterView sharedMyTools]createTishi:zxdDict[@"msg"]];
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"==========00000000000000=============")
    }];
}
#pragma mark-验证码计时
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
                [self.testBtn setTitle:@"获取" forState:UIControlStateNormal];
                [self.testBtn setFrame:CGRectMake(windowContentWidth-5-80, 120+5, 80, 30)];
                self.testBtn.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime;
            if (timeout==60) {
                strTime=[NSString stringWithFormat:@"%d", 60];
            }else{
                strTime = [NSString stringWithFormat:@"%d", seconds];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [self.testBtn setTitle:[NSString stringWithFormat:@"发送验证码(%@秒)",strTime] forState:UIControlStateNormal];
                [self.testBtn setFrame:CGRectMake(windowContentWidth-5-130, 120+5, 130, 30)];
                self.testBtn.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
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

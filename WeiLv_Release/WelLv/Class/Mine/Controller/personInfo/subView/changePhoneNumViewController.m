//
//  changePhoneNumViewController.m
//  aa
//
//  Created by mac for csh on 15/4/14.
//  Copyright (c) 2015年 mac for csh. All rights reserved.
//

#import "changePhoneNumViewController.h"
#import "LXUserTool.h"
#import "AFNetworking.h"
#import "LXAlterView.h"

@interface changePhoneNumViewController ()

@end

@implementation changePhoneNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"修改手机号码"];
    self.view.backgroundColor = BgViewColor;
    
    //navigation bar
 /*   UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 35, 25);
    [btn setBackgroundImage:[UIImage imageNamed:@"圆角矩形-65-拷贝.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(getBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    */
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@" 保存" style:UIBarButtonItemStyleDone target:self action:@selector(nextStep)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);

    
    //label
    UILabel *tsmLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, [[UIScreen mainScreen] bounds].size.width-30, 30)];
    tsmLabel.text = @"提示：手机号是我们联系您的主要方式，请慎重填写";
    tsmLabel.backgroundColor = [UIColor clearColor];
    tsmLabel.textAlignment = NSTextAlignmentLeft;
    tsmLabel.font = [UIFont systemFontOfSize:12];
    tsmLabel.textColor = [UIColor orangeColor];
    [self.view addSubview: tsmLabel];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10+30, [[UIScreen mainScreen] bounds].size.width, 40)];
    phoneLabel.text = @"   原手机号";
    phoneLabel.backgroundColor = [UIColor whiteColor];
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    phoneLabel.font = [UIFont systemFontOfSize:15];
    phoneLabel.textColor = [UIColor blackColor];
    [self.view addSubview: phoneLabel];
    
    //新手机号
    UILabel *newPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10+30+40, [[UIScreen mainScreen] bounds].size.width, 40)];
    newPhoneLabel.text = @"   新手机号";
    newPhoneLabel.backgroundColor = [UIColor whiteColor];
    newPhoneLabel.textAlignment = NSTextAlignmentLeft;
    newPhoneLabel.font = [UIFont systemFontOfSize:15];
    newPhoneLabel.textColor = [UIColor blackColor];
    [self.view addSubview: newPhoneLabel];
    
    //Security Code
    UILabel *SecurityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10+30+40+40, [[UIScreen mainScreen] bounds].size.width, 40)];
    SecurityLabel.text = @"   验证码";
    SecurityLabel.backgroundColor = [UIColor whiteColor];
    SecurityLabel.textAlignment = NSTextAlignmentLeft;
    SecurityLabel.font = [UIFont systemFontOfSize:15];
    SecurityLabel.textColor = [UIColor blackColor];
    [self.view addSubview: SecurityLabel];
    
    //   UILabel *tsm2Label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10+30+40*3+20, [[UIScreen mainScreen] bounds].size.width-30, 30)];
    //    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"提示：获取验证码免费，请放心使用"];
    //    tsm2Label.font = [UIFont systemFontOfSize:12];
    //    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,[str length]-11)];
    //    [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange([str length]-13,13)];
    //    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Courier-BoldOblique" size:14] range:NSMakeRange([str length]-13,13)];
    //    tsm2Label.attributedText = str;
    UILabel *tsm2Label = [[UILabel alloc] initWithFrame:CGRectMake(15, 30+40*3+20, [[UIScreen mainScreen] bounds].size.width-30, 30)];
    tsm2Label.text = @"提示：获取验证码免费，请放心使用";
    tsm2Label.textColor = [UIColor orangeColor];
    tsm2Label.font = [UIFont systemFontOfSize:12];
    tsm2Label.backgroundColor = [UIColor clearColor];
    tsm2Label.textAlignment = NSTextAlignmentLeft;
    tsm2Label.numberOfLines = 0;
    [self.view addSubview: tsm2Label];
    
    UILabel *phoneNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+70,13+30, [[UIScreen mainScreen] bounds].size.width-15-70, 40)];
    phoneNumLabel.text = [[LXUserTool alloc] getPhone];
    phoneNumLabel.backgroundColor = [UIColor whiteColor];
    phoneNumLabel.textAlignment = NSTextAlignmentLeft;
    phoneNumLabel.font = [UIFont systemFontOfSize:15];
    phoneNumLabel.textColor = [UIColor blackColor];
    [self.view addSubview: phoneNumLabel];
    
      UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(10,15+30+40 , [[UIScreen mainScreen] bounds].size.width, 0.25)];
    label.layer.borderColor = [[UIColor grayColor] CGColor];
    label.layer.borderWidth = 0.1;
    [self.view addSubview:label];
    UILabel* label1 = [[UILabel alloc] initWithFrame: CGRectMake(10,15+30+40*2 , [[UIScreen mainScreen] bounds].size.width, 0.25)];
    label1.layer.borderColor = [[UIColor grayColor] CGColor];
    label1.layer.borderWidth = 0.1;
    [self.view addSubview:label1];
    
    //textfield
    messageCodeField = [[UITextField alloc ]initWithFrame:CGRectMake(10+70,15+30+40+40, [[UIScreen mainScreen] bounds].size.width*0.35, 40)];
    messageCodeField.placeholder = @"请填写短信验证码";
    messageCodeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    messageCodeField.textAlignment = NSTextAlignmentLeft;
    messageCodeField.textColor = [UIColor redColor];
    messageCodeField.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:messageCodeField];
    messageCodeField.delegate =self;
    
    newPhonetextField = [[UITextField alloc ]initWithFrame:CGRectMake(10+70,15+30+40, [[UIScreen mainScreen] bounds].size.width*0.35, 40)];
    newPhonetextField.placeholder = @"请填写新手机号码";
    newPhonetextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    newPhonetextField.textAlignment = NSTextAlignmentLeft;
    newPhonetextField.textColor = [UIColor blackColor];
    newPhonetextField.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:newPhonetextField];
    newPhonetextField.delegate =self;

    
    //button
    securityBtn = [[UIButton alloc]initWithFrame:CGRectMake(10+70+[[UIScreen mainScreen] bounds].size.width*0.4, 15+30+40+5-40, [[UIScreen mainScreen] bounds].size.width*0.6-15-70-25, 40-10)];
    [securityBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    securityBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [securityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [securityBtn setBackgroundColor:[UIColor orangeColor]];
    [securityBtn.layer setCornerRadius:10.0];
    securityBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [securityBtn addTarget:self action:@selector(getSecCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:securityBtn];
    
    //keyboardhidden
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];


}

//获取验证码
-(void)getSecCode{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"mobile":[[LXUserTool alloc] getPhone]};
    [manager POST:UpdatePhoneGetCode parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
             // NSString *msgString = [responseObject objectForKey:@"msg"];
              NSLog(@"dict---%@ ",dict);
              if ([[dict objectForKey:@"status"] integerValue]== 1) {
                  [[LXAlterView alloc] createTishi:@"验证码发送成功"];
              }else{
                  [[LXAlterView alloc] createTishi:@"验证码发送失败"];
              }
              
              [self startTime];
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              
          }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getBack{
    [self.navigationController popViewControllerAnimated:YES];
}


//保存
-(void)nextStep{
    if (  [YXTools isValidateMobile:newPhonetextField.text] == NO) {
        [[LXAlterView sharedMyTools]createTishi:@"请输入正确的手机号"];
    }else{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSDictionary *parameters = @{@"uid":[[LXUserTool alloc] getUid],@"old_mobile":[[LXUserTool alloc] getPhone],@"new_mobile":newPhonetextField.text,@"code":messageCodeField.text};
        [manager POST:UpdatePhone  parameters:parameters
     
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
              NSLog(@"dict ***  %@   msg is  %@",dict ,[dict objectForKey:@"msg"]);
             
              if ([[dict objectForKey:@"status"] integerValue] == 1) {
                  [[LXAlterView sharedMyTools] createTishi:@"修改成功"];
                  
                  NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
                  [settings setObject: newPhonetextField.text forKey:@"phone"];
                   [[LXAlterView alloc]createTishi:@"修改成功"];
                  [self.navigationController popViewControllerAnimated:YES];
              }else{
                  [[LXAlterView sharedMyTools] createTishi:[dict objectForKey:@"msg"]];
              }
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              
          }];

    }

}




//timer--
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
                [securityBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                securityBtn.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                // NSLog(@"____%@",strTime);
                [securityBtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                securityBtn.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}



-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [messageCodeField resignFirstResponder];
    [newPhonetextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [messageCodeField resignFirstResponder];
    [newPhonetextField resignFirstResponder];
    return YES;
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

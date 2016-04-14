//
//  NewPhNumViewController.m
//  WelLv
//
//  Created by mac for csh on 15/4/17.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "NewPhNumViewController.h"
#import "LXUserTool.h"
#import "AFNetworking.h"
#import "LXAlterView.h"

@interface NewPhNumViewController ()

@end

@implementation NewPhNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"绑定新号码"];
    self.view.backgroundColor = kColor(227, 233, 238);
    
    //navigation bar
  /*  UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 35, 25);
    [btn setBackgroundImage:[UIImage imageNamed:@"圆角矩形-65-拷贝.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(getBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    */
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@" 提交" style:UIBarButtonItemStyleDone target:self action:@selector(conserve)];
    self.navigationItem.rightBarButtonItem.tintColor =  kColor(255, 165, 98);
    
    
    //label
    UILabel *tsmLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, [[UIScreen mainScreen] bounds].size.width-30, 30)];
    tsmLabel.text = @"提示：手机号是我们联系您的主要方式，请慎重填写";
    tsmLabel.backgroundColor = [UIColor clearColor];
    tsmLabel.textAlignment = NSTextAlignmentLeft;
    tsmLabel.font = [UIFont systemFontOfSize:12];
    tsmLabel.textColor = [UIColor orangeColor];
    [self.view addSubview: tsmLabel];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10+30, [[UIScreen mainScreen] bounds].size.width, 40)];
    phoneLabel.text = @"   新手机号";
    phoneLabel.backgroundColor = [UIColor whiteColor];
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    phoneLabel.font = [UIFont systemFontOfSize:15];
    phoneLabel.textColor = [UIColor blackColor];
    [self.view addSubview: phoneLabel];
    

    NewPhTextField = [[UITextField alloc] initWithFrame:CGRectMake(10+70,13+30, [[UIScreen mainScreen] bounds].size.width-15, 40)];
    NewPhTextField.placeholder = @"请输入新号码";
    NewPhTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    NewPhTextField.textAlignment = NSTextAlignmentLeft;
    NewPhTextField.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:NewPhTextField];
    NewPhTextField.delegate =self;
    
    //keyboardhidden
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getBack{
    [self.navigationController popViewControllerAnimated:YES];
}

//保存
-(void)conserve{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"uid":[[LXUserTool alloc] getUid],@"phone":NewPhTextField.text};
    [manager POST:@"http://m.weilv100.com:1025/front/member/update_info" parameters:parameters
     
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *msgString = [responseObject objectForKey:@"msg"];
              NSLog(@"errno = %@  msg = %@",[responseObject objectForKey:@"errno"],msgString);
              if ([[responseObject objectForKey:@"msg"] isEqualToString:@"修改成功"] ) {
                  NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
                  [settings setObject: NewPhTextField.text forKey:@"phone"];
                  
                  [self.navigationController popViewControllerAnimated:YES];
                  [self.navigationController popViewControllerAnimated:YES];
              }else{
                  [[LXAlterView sharedMyTools] createTishi:@"验证码不正确"];
              }
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
               [[LXAlterView sharedMyTools] createTishi:@"验证码不正确"];
          }];
}



-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [NewPhTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [NewPhTextField resignFirstResponder];
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

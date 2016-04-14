//
//  changeEmailViewController.m
//  aa
//
//  Created by mac for csh on 15/4/14.
//  Copyright (c) 2015年 mac for csh. All rights reserved.
//

#import "changeEmailViewController.h"
#import "AFNetworking.h"
#import "LXUserTool.h"
#import "LXAlterView.h"

@interface changeEmailViewController ()

@end

@implementation changeEmailViewController
@synthesize phoneNumField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"修改邮箱"];
    self.view.backgroundColor = BgViewColor;
    
  
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(conserve)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);
    
    phoneNumField = [[UITextField alloc ]initWithFrame:CGRectMake(0,15, [[UIScreen mainScreen] bounds].size.width, 40)];
    phoneNumField.backgroundColor = [UIColor whiteColor];
    phoneNumField.placeholder = @"";
    if ([[LXUserTool alloc] getEmail] && ! [[[LXUserTool alloc] getEmail] isEqual:[NSNull null]]) {
        phoneNumField.text = [[LXUserTool alloc] getEmail];
    }
    phoneNumField.textAlignment = NSTextAlignmentCenter;
    [phoneNumField setTintColor:[UIColor blackColor]];
    phoneNumField.font = [UIFont systemFontOfSize:17];
    phoneNumField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:phoneNumField];phoneNumField.delegate= self;
    
    UILabel *tsLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,15+40+10, [[UIScreen mainScreen] bounds].size.width, 20)];
    tsLabel.text = @"邮箱将用来接收旅游合同的，请慎重填写";
    tsLabel.backgroundColor = [UIColor clearColor];
    tsLabel.textAlignment = NSTextAlignmentLeft;
    tsLabel.font = [UIFont systemFontOfSize:12];
    tsLabel.textColor = [UIColor blackColor];
    tsLabel.numberOfLines = 0;
    [self.view addSubview: tsLabel];
    
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
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
    BOOL EmailType = [self isValidateEmail:phoneNumField.text];
    if ([self judgeString:phoneNumField.text] == NO) {
        [[LXAlterView sharedMyTools] createTishi:@"邮箱不能为空"];
    }else if (EmailType == 0) {
        [[LXAlterView sharedMyTools] createTishi:@"邮箱格式不正确"];
    }else{
        
       //上传服务器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *parameters = @{@"uid":[[LXUserTool alloc] getUid],@"email": phoneNumField.text};
    
    [manager POST:UpdateUserInfo parameters:parameters
     
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              
              NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
              [settings setObject: phoneNumField.text forKey:@"email"];
              [[LXAlterView alloc]createTishi:@"修改成功"];
              [self.navigationController popViewControllerAnimated:YES];

              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              
          }];
    }
}

//检测邮箱格式
-(BOOL)isValidateEmail:(NSString *)email

{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [phoneNumField resignFirstResponder];
    return YES;
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [phoneNumField resignFirstResponder];
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

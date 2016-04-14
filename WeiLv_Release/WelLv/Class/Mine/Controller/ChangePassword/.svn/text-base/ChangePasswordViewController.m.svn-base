//
//  ChangePasswordViewController.m
//  WelLv
//
//  Created by lyx on 15/4/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "LXUserTool.h"
#import "AFNetworking.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController
@synthesize bgimage;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BgViewColor;
    
    [self.navigationItem setTitle:@"修改密码"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(conserve)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);
    
    bgimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, [[UIScreen mainScreen] bounds].size.width, 50*3)];
    bgimage.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgimage];
    
    //初始化label
    UILabel *oldPwdLanel = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, [[UIScreen mainScreen] bounds].size.width*0.3, 50)];
    oldPwdLanel.text = @"原密码";
    oldPwdLanel.backgroundColor = [UIColor clearColor];
    oldPwdLanel.textAlignment = NSTextAlignmentLeft;
    oldPwdLanel.font = [UIFont systemFontOfSize:16];
    [bgimage addSubview: oldPwdLanel];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(oldPwdLanel)+ViewHeight(oldPwdLanel)-1, windowContentWidth, 0.3)];
    view1.backgroundColor = [UIColor lightGrayColor];
    [bgimage addSubview:view1];
    
    UILabel *newPwdLanel = [[UILabel alloc] initWithFrame:CGRectMake(25, 50, [[UIScreen mainScreen] bounds].size.width*0.3, 50)];
    newPwdLanel.text = @"新密码";
    newPwdLanel.backgroundColor = [UIColor clearColor];
    newPwdLanel.textAlignment = NSTextAlignmentLeft;
    newPwdLanel.font = [UIFont systemFontOfSize:16];
    [bgimage addSubview: newPwdLanel];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(newPwdLanel)+ViewHeight(newPwdLanel)-1, windowContentWidth, 0.3)];
    view2.backgroundColor = [UIColor lightGrayColor];
    [bgimage addSubview:view2];
    
    
    UILabel *repPwdLanel = [[UILabel alloc] initWithFrame:CGRectMake(25, 50*2, [[UIScreen mainScreen] bounds].size.width*0.3, 50)];
    repPwdLanel.text = @"确认新密码";
    repPwdLanel.backgroundColor = [UIColor clearColor];
    repPwdLanel.textAlignment = NSTextAlignmentLeft;
    repPwdLanel.font = [UIFont systemFontOfSize:16];
    [bgimage addSubview: repPwdLanel];
    
    /*UILabel *bzLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 50*3+20, 55, 40)];
     bzLabel.text = @"备注";
     bzLabel.backgroundColor = [UIColor clearColor];
     bzLabel.textAlignment = NSTextAlignmentLeft;
     bzLabel.textColor = [UIColor lightGrayColor];
     bzLabel.font = [UIFont systemFontOfSize:15];
     [self.view addSubview:bzLabel];
     */
    UILabel *bzzLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 50*3+20,[[UIScreen mainScreen] bounds].size.width -10, 40)];
    bzzLabel.text = @"备注:密码为6-16位，不宜太简单，以免造成不必要的风险";
    bzzLabel.backgroundColor = [UIColor clearColor];
    bzzLabel.textAlignment = NSTextAlignmentLeft;
    bzzLabel.textColor = [UIColor lightGrayColor];
    bzzLabel.font = [UIFont systemFontOfSize:14];
    bzzLabel.numberOfLines = 0;
    [self.view addSubview:bzzLabel];
    
    //初始化textfield
    oldPwdTextFild = [[UITextField alloc ]initWithFrame:CGRectMake(25+0.3*[[UIScreen mainScreen] bounds].size.width,0+20, [[UIScreen mainScreen] bounds].size.width*0.7-25, 50)];
    oldPwdTextFild.placeholder = @"";
    oldPwdTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
    oldPwdTextFild.textAlignment = NSTextAlignmentLeft;
    oldPwdTextFild.secureTextEntry = YES;
    [self.view addSubview:oldPwdTextFild];oldPwdTextFild.delegate =self;
    
    newPwdTextFild = [[UITextField alloc ]initWithFrame:CGRectMake(25+0.3*[[UIScreen mainScreen] bounds].size.width,50+20, [[UIScreen mainScreen] bounds].size.width*0.7-25, 50)];
    newPwdTextFild.placeholder = @"";
    newPwdTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
    newPwdTextFild.textAlignment = NSTextAlignmentLeft;
    newPwdTextFild.secureTextEntry = YES;
    [self.view addSubview:newPwdTextFild];newPwdTextFild.delegate =self;
    
    repPwdTextFild = [[UITextField alloc ]initWithFrame:CGRectMake(25+0.3*[[UIScreen mainScreen] bounds].size.width,50*2+20, [[UIScreen mainScreen] bounds].size.width*0.7-25, 50)];
    repPwdTextFild.placeholder = @"";
    repPwdTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
    repPwdTextFild.textAlignment = NSTextAlignmentLeft;
    repPwdTextFild.secureTextEntry = YES;
    [self.view addSubview:repPwdTextFild];repPwdTextFild.delegate =self;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(void)getBack{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//保存
-(void)conserve{
    NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:@"^[0-9]*$" options:0 error:nil];
    //对象进行匹配
    NSTextCheckingResult *result2 = [regex2 firstMatchInString:newPwdTextFild.text options:0 range:NSMakeRange(0, [newPwdTextFild.text length])];
    
    NSLog(@"pwd=%@",[[LXUserTool sharedUserTool] getPwd]);
    if ([oldPwdTextFild.text isEqualToString:@""]) {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:@"原密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [al show];
    }else if([newPwdTextFild.text isEqualToString:@""]){
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:@"新密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [al show];
    }else if([repPwdTextFild.text isEqualToString:@""]){
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:@"确认新密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [al show];
    }
//    else if (![oldPwdTextFild.text isEqualToString:[[LXUserTool sharedUserTool] getPwd2]] ) {
//        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:@"原密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [al show];
//    }
    else if (![newPwdTextFild.text isEqualToString:repPwdTextFild.text]) {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:@"新密码不一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [al show];
    }else if([newPwdTextFild.text length]<6 || [newPwdTextFild.text length]>16){
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:@"密码必须为6-16位字符" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [al show];
    }else if([newPwdTextFild.text isEqualToString:oldPwdTextFild.text]){
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:@"新旧密码不能一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [al show];
    }/*else if(result2){
      UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:@"密码不能是纯数字" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
      [al show];
      }*/else{
          //写本地
          
          [self uploadToServer];
          //[[LXUserTool alloc] setPwd:newPwdTextFild.text];
      }
}

-(void)uploadToServer{
    
    NSString * idStr = @"";
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeMember) {
        idStr = @"uid";
    } else if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward) {
        idStr = @"assistant_id";
    }
    //上传服务器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters = @{idStr:[[LXUserTool sharedUserTool] getUid],
                                 @"password": oldPwdTextFild.text,
                                 @"new_password": newPwdTextFild.text};
    NSString * url = @"";
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeMember) {
        url = UpdatePwd;
        
    }else if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward) {
        url = M_USER_CENTER_CHANGE_PSW_STE;
    }
    [manager POST:url parameters:parameters
     
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
              
              NSLog(@"xxxxxxx = %@",dict);
              NSLog(@"xxxxxxx = %@",[dict valueForKey:@"msg"]);
              // NSLog(@"Success: %@", [responseObject objectForKey:@"msg"] );
              
              if ([[dict objectForKey:@"status"] integerValue] == 1) {
                  [[LXAlterView sharedMyTools]createTishi:@"修改成功"];
                  [[LXUserTool sharedUserTool] setPwd:newPwdTextFild.text];
                  [[LXUserTool sharedUserTool] setPwd2:newPwdTextFild.text];

                  [self getBack];
              }else{
                  [[LXUserTool sharedUserTool] setPwd:newPwdTextFild.text];
              }
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              
          }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//keyboardmiss
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [oldPwdTextFild resignFirstResponder];
    [newPwdTextFild resignFirstResponder];
    [repPwdTextFild resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [oldPwdTextFild resignFirstResponder];
    [newPwdTextFild resignFirstResponder];
    [repPwdTextFild resignFirstResponder];
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




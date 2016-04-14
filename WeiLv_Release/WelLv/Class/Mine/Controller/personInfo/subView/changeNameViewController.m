//
//  changeNameViewController.m
//  aa
//
//  Created by mac for csh on 15/4/14.
//  Copyright (c) 2015年 mac for csh. All rights reserved.
//

#import "changeNameViewController.h"
#import "AFNetworking.h"
#import "LXUserTool.h"
#import "LXAlterView.h"

@interface changeNameViewController ()

@end

@implementation changeNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"修改真实姓名"];
    self.view.backgroundColor = BgViewColor;
  
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(conserve)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);
    
    nameField = [[UITextField alloc ]initWithFrame:CGRectMake(0,15, [[UIScreen mainScreen] bounds].size.width, 45)];
    nameField.backgroundColor = [UIColor whiteColor];
    nameField.placeholder = @"";
    if ([[LXUserTool alloc] getRealname] && ! [[[LXUserTool alloc] getRealname] isEqual:[NSNull null]]) {
        nameField.text = [[LXUserTool alloc] getRealname];
    }
    nameField.textAlignment = NSTextAlignmentCenter;
    [nameField setTintColor:[UIColor blackColor]];
    nameField.font = [UIFont systemFontOfSize:17];
    nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:nameField];
    nameField.delegate= self;
    
    UILabel *tsLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,15+45+10, [[UIScreen mainScreen] bounds].size.width, 20)];
    tsLabel.text = @"真实姓名必须是2-16个英文或2-4个中文";
    tsLabel.backgroundColor = [UIColor clearColor];
    tsLabel.textAlignment = NSTextAlignmentLeft;
    tsLabel.font = [UIFont systemFontOfSize:13];
    tsLabel.textColor = [UIColor lightGrayColor];
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
    
    if ([nameField.text isEqualToString:@""]) {
        [[LXAlterView sharedMyTools] createTishi:@"请输入您的姓名"];
    }else{
        NSRange range=NSMakeRange(0,1);
        NSString *subString=[nameField.text substringWithRange:range];
        const char *cString=[subString UTF8String];
        NSInteger index = strlen(cString);
    
        if (index == 3 && nameField.text.length<5 && nameField.text.length>1) {
            for (int i=0; i <[nameField.text length];i++)
            {
                NSRange range=NSMakeRange(i,1);
                NSString *subString=[nameField.text substringWithRange:range];
                const char *cString=[subString UTF8String];
                if (strlen(cString)!=index)
                {
                    [[LXAlterView sharedMyTools] createTishi:@"您输入的姓名格式有误，请重新输入"];
                    return;
                }else if(i == [nameField.text length]-1){
                    [self Conserveed];
                }
            }
        }else if(index == 1 && nameField.text.length<17 && nameField.text.length>1){
            for (int i=0; i <[nameField.text length];i++)
            {
                NSRange range=NSMakeRange(i,1);
                NSString *subString=[nameField.text substringWithRange:range];
                const char *cString=[subString UTF8String];
                if (strlen(cString)!=index)
                {
                    [[LXAlterView sharedMyTools] createTishi:@"您输入的姓名格式有误，请重新输入"];
                    return;
                }else if(i == [nameField.text length]-1){
                    [self Conserveed];
                }
            }
        }else{
            [[LXAlterView sharedMyTools] createTishi:@"您输入的姓名格式有误，请重新输入"];
        }
  }
    
   
}
-(void)Conserveed{
    //上传服务器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *parameters = @{@"uid":[[LXUserTool alloc] getUid],@"realname": nameField.text};
    
    [manager POST:UpdateUserInfo parameters:parameters
     
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              
              // NSLog(@"xxxxxxx = %@",responseObject);
              NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
              [settings setObject: nameField.text forKey:@"realname"];
              [[LXAlterView alloc] createTishi:@"修改成功"];
              [self.navigationController popViewControllerAnimated:YES];
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
               
              NSLog(@"Error: %@", error);
          }];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [nameField resignFirstResponder];
    return YES;
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [nameField resignFirstResponder];
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

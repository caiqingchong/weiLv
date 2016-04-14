//
//  PhoneNumTFViewController.m
//  WelLv
//
//  Created by mac for csh on 15/11/17.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "PhoneNumTFViewController.h"

@interface PhoneNumTFViewController ()<UITextFieldDelegate>

{
    UITextField *callTF;
    UITextField *phoneTF;
}

@end

@implementation PhoneNumTFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BgViewColor;
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(conserve)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);


    UIView *bgview = [[UIView alloc] initWithFrame: CGRectMake(0, 15, windowContentWidth, 40*2)];
    bgview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgview];
    
    callTF = [[UITextField alloc ]initWithFrame:CGRectMake(15,0, [[UIScreen mainScreen] bounds].size.width-15, 40)];
    callTF.backgroundColor = [UIColor whiteColor];
    callTF.placeholder = @"区号-号码";
    callTF.textAlignment = NSTextAlignmentLeft;
    [callTF setTintColor:[UIColor blackColor]];
    callTF.font = [UIFont systemFontOfSize:16];
    callTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    callTF.tag =1;
    [bgview addSubview:callTF];callTF.delegate= self;
    
    phoneTF = [[UITextField alloc ]initWithFrame:CGRectMake(15,40, [[UIScreen mainScreen] bounds].size.width-15, 40)];
    phoneTF.backgroundColor = [UIColor whiteColor];
    phoneTF.placeholder = @"手机号码";
    phoneTF.textAlignment = NSTextAlignmentLeft;
    [phoneTF setTintColor:[UIColor blackColor]];
    phoneTF.font = [UIFont systemFontOfSize:16];
    phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTF.tag = 2;
    [bgview addSubview:phoneTF];phoneTF.delegate= self;
    
    
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(void)conserve{
    
    NSDictionary *dictionary = @{@"mobile":[self judgeReturnString:callTF.text withReplaceString:@""],@"phone":[self judgeReturnString:phoneTF.text withReplaceString:@""]};
        //创建通知
        NSDictionary *dic = @{@"type":@"2",@"index":[NSString stringWithFormat:@"%ld",(long)self.arrayIndex],@"text":dictionary};
        NSNotification *notification =[NSNotification notificationWithName:@"OStongzhi" object:nil userInfo:dic];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [phoneTF resignFirstResponder];
    [callTF resignFirstResponder];
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

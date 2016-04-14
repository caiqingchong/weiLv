//
//  OpenShopTFViewController.m
//  WelLv
//
//  Created by mac for csh on 15/10/29.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "OpenShopTFViewController.h"
#import "YXTools.h"

@interface OpenShopTFViewController ()

@end

@implementation OpenShopTFViewController
@synthesize OStextField;
@synthesize arrayIndex;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BgViewColor;
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(conserve)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);
    
    OStextField = [[UITextField alloc ]initWithFrame:CGRectMake(0,15, [[UIScreen mainScreen] bounds].size.width, 40)];
    OStextField.backgroundColor = [UIColor whiteColor];
    OStextField.placeholder = @"";
    OStextField.textAlignment = NSTextAlignmentCenter;
    [OStextField setTintColor:[UIColor blackColor]];
    OStextField.font = [UIFont systemFontOfSize:17];
    OStextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:OStextField];OStextField.delegate= self;
    
    UILabel *tsLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,15+40+10, [[UIScreen mainScreen] bounds].size.width, 20)];
    tsLabel.text = @"提示：请填写真实信息";
    tsLabel.backgroundColor = [UIColor clearColor];
    tsLabel.textAlignment = NSTextAlignmentLeft;
    tsLabel.font = [UIFont systemFontOfSize:13];
    tsLabel.textColor = [UIColor grayColor];
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
  /*  if (!OStextField.text || OStextField.text == nil || [OStextField.text isKindOfClass:[NSNull class]] || [OStextField.text isEqualToString:@""] ||OStextField.text.length ==0 ) {
        [[LXAlterView sharedMyTools]createTishi:@"请输入后保存"];
    }else if(arrayIndex == 0 && [YXTools isValidateMobile:OStextField.text] == NO) {
        [[LXAlterView sharedMyTools]createTishi:@"请输入正确的手机号"];
    }else{
   
    }*/
    if(!OStextField.text || [OStextField.text isEqualToString:@""] || OStextField.text == nil || [OStextField.text isEqualToString:@"(null)"] ){
        [[LXAlterView sharedMyTools]createTishi:@"请填写内容"];
    }else{
        //创建通知
        NSDictionary *dic = @{@"type":@"1",@"index":[NSString stringWithFormat:@"%ld",(long)self.arrayIndex],@"text":OStextField.text};
        NSNotification *notification =[NSNotification notificationWithName:@"OStongzhi" object:nil userInfo:dic];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [OStextField resignFirstResponder];
    return YES;
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [OStextField resignFirstResponder];
}


@end

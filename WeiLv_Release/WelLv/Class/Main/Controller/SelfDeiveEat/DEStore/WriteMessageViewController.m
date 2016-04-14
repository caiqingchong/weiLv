//
//  WriteMessageViewController.m
//  WelLv
//
//  Created by liuxin on 15/11/9.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "WriteMessageViewController.h"

@interface WriteMessageViewController ()

@end

@implementation WriteMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.view.backgroundColor = BgViewColor;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(conserve)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);
    if (self.arrindex1 == 2&& self.arrindex2 == 3) {
        [self creatView2];
    }
    else{
        [self creatview1];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tap.cancelsTouchesInView = NO;
    //设置为NO表示当前控件响应后会传播到其他控件上,默认为yes
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}
-(void)creatView2
{
    self.zxdTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 15, windowContentWidth, 40)];
    self.zxdTextField.backgroundColor = [UIColor whiteColor];
    self.zxdTextField.placeholder = @"请输入电话号码(包括区号)";
    self.zxdTextField.textAlignment = NSTextAlignmentCenter;
    [self.zxdTextField setTintColor:[UIColor blackColor]];
    self.zxdTextField.font = [UIFont systemFontOfSize:17];
    self.zxdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.zxdTextField];
    self.zxdTextField.delegate = self;
    
    self.zxdTextField2 = [[UITextField alloc] initWithFrame:CGRectMake(0, 60, windowContentWidth, 40)];
    self.zxdTextField2.backgroundColor = [UIColor whiteColor];
    self.zxdTextField2.placeholder = @"请输入手机号码";
    self.zxdTextField2.textAlignment = NSTextAlignmentCenter;
    [self.zxdTextField2 setTintColor:[UIColor blackColor]];
    self.zxdTextField2.font = [UIFont systemFontOfSize:17];
    self.zxdTextField2.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.zxdTextField2];
    self.zxdTextField2.delegate = self;

    
    
    UILabel *tsLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15+40+10+40, windowContentWidth, 20)];
    tsLabel.text = @"提示:请填写真实信息";
    tsLabel.backgroundColor = [UIColor clearColor];
    tsLabel.textAlignment = NSTextAlignmentCenter;
    tsLabel.font = [UIFont systemFontOfSize:13];
    tsLabel.textColor = [UIColor grayColor];
    tsLabel.numberOfLines = 0;
    [self.view addSubview:tsLabel];

}
-(void)creatview1
{
    self.zxdTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 15, windowContentWidth, 40)];
    self.zxdTextField.backgroundColor = [UIColor whiteColor];
    self.zxdTextField.text = self.strtext;
    self.zxdTextField.textAlignment = NSTextAlignmentCenter;
    [self.zxdTextField setTintColor:[UIColor blackColor]];
    self.zxdTextField.font = [UIFont systemFontOfSize:17];
    self.zxdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.zxdTextField];
    self.zxdTextField.delegate = self;
    
    
    UILabel *tsLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15+40+10, windowContentWidth, 20)];
    tsLabel.text = @"提示:请填写真实信息";
    tsLabel.backgroundColor = [UIColor clearColor];
    tsLabel.textAlignment = NSTextAlignmentCenter;
    tsLabel.font = [UIFont systemFontOfSize:13];
    tsLabel.textColor = [UIColor grayColor];
    tsLabel.numberOfLines = 0;
    [self.view addSubview:tsLabel];
    
   
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}
-(void)keyboardHide:(UITapGestureRecognizer *)tap
{
    [self.zxdTextField resignFirstResponder];
    if (self.arrindex1 == 2&& self.arrindex2 == 3) {
        [self.zxdTextField2 resignFirstResponder];
    }

   }

-(void)conserve
{
    NSString *str = [[NSString alloc] init];
    str = self.zxdTextField.text;
    if(!self.zxdTextField.text||self.zxdTextField.text == nil || [self.zxdTextField isKindOfClass:[NSNull class]]||[self.zxdTextField.text isEqualToString:@""] ||self.zxdTextField.text.length == 0)
    {
        [[LXAlterView sharedMyTools] createTishi:@"请输入后保存"];
    }
    
    else
    {
                //创建通知
       // NSLog(@"%@",@"123456/n123446");
        if (self.arrindex1 == 2&& self.arrindex2 == 3) {
            NSDictionary *dic = @{@"arrindex1":[NSString stringWithFormat:@"%ld",(long)self.arrindex1],@"arrindex2":[NSString stringWithFormat:@"%ld",(long)self.arrindex2],@"text1":self.zxdTextField.text,@"text2":self.zxdTextField2.text,@"text3":@""};
            NSNotification *notification = [NSNotification notificationWithName:@"zxdZZ" object:nil userInfo:dic];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            [self.navigationController popViewControllerAnimated:YES];
        }
       else
       {
           NSDictionary *dic = @{@"arrindex1":[NSString stringWithFormat:@"%ld",(long)self.arrindex1],@"arrindex2":[NSString stringWithFormat:@"%ld",(long)self.arrindex2],@"text":self.zxdTextField.text};
           NSNotification *notification = [NSNotification notificationWithName:@"ZxdTZ" object:nil userInfo:dic];
           [[NSNotificationCenter defaultCenter] postNotification:notification];
           [self.navigationController popViewControllerAnimated:YES];

       }
       
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

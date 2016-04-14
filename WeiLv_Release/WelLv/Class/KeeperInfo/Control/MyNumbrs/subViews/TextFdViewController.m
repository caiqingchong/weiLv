//
//  TextFdViewController.m
//  WelLv
//
//  Created by mac for csh on 15/7/24.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "TextFdViewController.h"

@interface TextFdViewController (){
    
}

@end

@implementation TextFdViewController
@synthesize contentString,key,uid;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BgViewColor;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(conserve)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 20, windowContentWidth, 45)];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.placeholder = @"请输入";
    _textField.text = contentString;
    _textField.textAlignment = NSTextAlignmentCenter;
    [_textField setTintColor:[UIColor blackColor]];
    _textField.font = [UIFont systemFontOfSize:17];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.delegate= self;
    [self.view addSubview:_textField];
   
}

-(void)conserve{
    [_textField resignFirstResponder];
    if (!_textField.text || _textField.text == nil || [_textField.text isEqualToString:@""]) {
        [[LXAlterView sharedMyTools]createTishi:@"内容不能为空，请输入"];
    }else{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSDictionary *infoarr = @{key:_textField.text};
        NSDictionary *parameters = @{@"member_id":self.uid,@"data":[self dictionaryToJson:infoarr]};
        [manager POST:GjManagMemberURL parameters:parameters
              success:^(AFHTTPRequestOperation *operation,id responseObject) {
                  NSString *html = operation.responseString;
                  NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
                  NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
                  [[LXAlterView sharedMyTools] createTishi:[dict objectForKey:@"msg"]];
                //  NSLog(@"dict = %@  \n msg = %@",dict,[dict objectForKey:@"msg"]);
                  [self.navigationController popViewControllerAnimated:YES];
              }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                  
                  NSLog(@"Error: %@", error);
                  
              }];
    }

    
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textField resignFirstResponder];
    return YES;
}

-(void)keyboardHide:(UITapGestureRecognizer *)tap{
    [_textField resignFirstResponder];
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

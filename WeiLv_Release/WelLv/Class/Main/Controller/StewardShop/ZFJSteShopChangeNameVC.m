//
//  ZFJSteShopChangeNameVC.m
//  WelLv
//
//  Created by WeiLv on 15/10/28.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJSteShopChangeNameVC.h"

@interface ZFJSteShopChangeNameVC ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *nameField;

@end

@implementation ZFJSteShopChangeNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor(243, 248, 252);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(conserve)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);
    

    self.nameField = [[UITextField alloc ]initWithFrame:CGRectMake(0,15, [[UIScreen mainScreen] bounds].size.width, 45)];
    _nameField.backgroundColor = [UIColor whiteColor];
    _nameField.placeholder = @"";
    _nameField.tintColor = [UIColor orangeColor];
    _nameField.textAlignment = NSTextAlignmentCenter;
    [_nameField setTintColor:[UIColor blackColor]];
    _nameField.font = [UIFont systemFontOfSize:17];
    _nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_nameField];
    _nameField.delegate= self;
    
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}



-(void)getBack{
    [self.navigationController popViewControllerAnimated:YES];
}

//保存
-(void)conserve{
    if (self.nameField.text.length == 0 && ![self judgeString:self.nameField.text]) {
        [[LXAlterView sharedMyTools] createTishi:@"设置错误,请重试"];
        return;
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
 
    NSDictionary * parameters = @{@"store_id":[[WLSingletonClass defaultWLSingleton] wlUserSteShopID],
                                  @"store_name":self.nameField.text};
    
    NSLog(@"parameters = %@", parameters);
    //接口
    NSString *url= M_SS_URL_SHOP_NAME;
    
    //发送请求
    __weak ZFJSteShopChangeNameVC * weakSelf = self;
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@",  dic);
        NSLog(@"msg ==== %@", [dic objectForKey:@"msg"]);
        if ([dic objectForKey:@"status"] && [[dic objectForKey:@"status"] integerValue] == 1) {
            [[LXAlterView sharedMyTools] createTishi:@"成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shopName" object:_nameField.text];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } else {
            [[LXAlterView sharedMyTools] createTishi:@"设置失败,请重试"];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR: %@", error);
        [[LXAlterView sharedMyTools] createTishi:@"设置失败,请重试"];
        
    }];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_nameField resignFirstResponder];
    return YES;
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_nameField resignFirstResponder];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"shopName" object:nil];
}

@end

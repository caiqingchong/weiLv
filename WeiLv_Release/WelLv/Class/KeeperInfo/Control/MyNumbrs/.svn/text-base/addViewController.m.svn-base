//
//  addViewController.m
//  WelLv
//
//  Created by liuxin on 16/1/28.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "addViewController.h"
#import "MBProgressHUD.h"
#import "zxdMemberModel.h"
@interface addViewController ()<UITextFieldDelegate>
@property(nonatomic,strong) MBProgressHUD *zxdHud;
@property(nonatomic,strong) NSMutableArray *arrBack;
@end

@implementation addViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTitle];
    [self creatInput];
    // Do any additional setup after loading the view.
}
-(void)creatTitle
{
    self.view.backgroundColor = BgViewColor;
    //self.navigationItem.title = @"保存游客资料";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(zxdConserve)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    tap.cancelsTouchesInView = NO;
    //设置为NO表示当前控件响应后会传播到其他控件上,默认为yes
    [self.view addGestureRecognizer:tap];
}
-(void)keyboardHide
{
    [_zxdTextField1 resignFirstResponder];
    [_zxdTextField2 resignFirstResponder];
    [_zxdTextField3 resignFirstResponder];
}
-(void)creatInput
{
    //姓名
    _zxdTextField1 = [[UITextField alloc] init];
    _zxdTextField1.frame = CGRectMake(0, 0+15, windowContentWidth, 45);
    _zxdTextField1.placeholder = @"请输入游客姓名";
    _zxdTextField1.backgroundColor = [UIColor whiteColor];
    _zxdTextField1.textAlignment = NSTextAlignmentCenter;
    [self.zxdTextField1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _zxdTextField1.delegate = self;
    
    [self.view addSubview:_zxdTextField1];
    //手机号
    _zxdTextField2 = [[UITextField alloc] init];
    _zxdTextField2.frame = CGRectMake(0, 46+15, windowContentWidth, 45);
    _zxdTextField2.placeholder = @"请输入游客手机号";
    _zxdTextField2.delegate = self;
    _zxdTextField2.textAlignment = NSTextAlignmentCenter;
    _zxdTextField2.backgroundColor = [UIColor whiteColor];
     [self.zxdTextField2 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_zxdTextField2];
    //QQ号
    _zxdTextField3 = [[UITextField alloc] init];
    _zxdTextField3.frame = CGRectMake(0, 92+15, windowContentWidth, 45);
    _zxdTextField3.placeholder = @"请输入游客QQ号";
    _zxdTextField3.delegate = self;
    _zxdTextField3.textAlignment = NSTextAlignmentCenter;
    _zxdTextField3.backgroundColor = [UIColor whiteColor];
     [self.zxdTextField3 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_zxdTextField3];
    if ([self judgeString:self.strUid]) {
        _zxdTextField1.text = self.strName;
        _zxdTextField2.text = self.strPhone;
        _zxdTextField3.text = self.strQQ;
    }
}
#pragma 正则匹配手机号
- (BOOL)checkTelNumber:(NSString *) telNumber
{
    NSString *pattern = @"^[0-9]{11}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}
#pragma mark----保存数据
-(void)zxdConserve
{
    if (self.zxdTextField1.text.length == 0) {
         [[LXAlterView sharedMyTools] createTishi:@"姓名不能为空"];
        return;
    }
    if (self.zxdTextField2.text.length != 0) {
        //[[LXAlterView sharedMyTools] createTishi:@"手机号不能为空"];
        if (![self checkTelNumber:self.zxdTextField2.text])
        {
            [[LXAlterView sharedMyTools] createTishi:@"请输入正确的手机号"];
            return;
        }
       // return;
    }
    
    if (self.zxdTextField3.text.length != 0) {
       // [[LXAlterView sharedMyTools] createTishi:@"QQ号不能为空"];
        //return;
        if (self.zxdTextField3.text.length<5||self.zxdTextField3.text.length>12) {
            [[LXAlterView sharedMyTools] createTishi:@"QQ号不合法"];
            return;
        }
        if (![self isPureInt:self.zxdTextField3.text]) {
            [[LXAlterView sharedMyTools] createTishi:@"QQ号不合法"];
            return;
        }

    }
    
    NSDictionary *parameters = nil;
    NSString *strUrl = nil;
    if ([self judgeString:self.strUid]) {
        strUrl = zxdTourEdittUrl;
            NSDictionary *dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                                  @"visitor":self.zxdTextField1.text,
                                  @"phone":self.zxdTextField2.text,
                                  @"qq":self.zxdTextField3.text,
                                  };
        parameters = @{@"member_id":self.strd,
                       @"visitor_id":self.strUid,
                        @"data":[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:dic]};
    }
    else
    {
        strUrl = zxdTourAddtUrl;
        NSDictionary *dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                              @"visitor":self.zxdTextField1.text,
                              @"phone":self.zxdTextField2.text,
                              @"qq":self.zxdTextField3.text,
                              };
        parameters = @{@"member_id":self.strd,
                       @"data":[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:dic]};
    }
    __weak typeof (self)weakSelf = self;
    [self setHud:@"正在修改"];
    AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
    zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [zxdManager POST:strUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        weakSelf.zxdHud.hidden = YES;
        if ([dict[@"status"] integerValue]==1) {
            NSArray *itemArr = dict[@"data"];
            weakSelf.arrBack = [[NSMutableArray alloc] init];
            [[LXAlterView sharedMyTools] createTishi:@"修改成功"];
            for (NSDictionary *item in itemArr) {
                zxdMemberModel *model = [[zxdMemberModel alloc] init];
                [model setValuesForKeysWithDictionary:item];
                [weakSelf.arrBack addObject:model];
            }
            if ([weakSelf.delegate respondsToSelector:@selector(tourViewController:zxdArr:)]) {
                [weakSelf.delegate tourViewController:weakSelf zxdArr:weakSelf.arrBack];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
            
        }
        else
        {
           [[LXAlterView sharedMyTools] createTishi:@"修改失败"];
        }
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        weakSelf.zxdHud.hidden = YES;
        [[LXAlterView sharedMyTools] createTishi:@"修改失败"];

    }];
}
-(void)setHud:(NSString *)str
{
    
    self.zxdHud = [[MBProgressHUD alloc] initWithView:self.view];
    self.zxdHud.frame = self.view.bounds;
    self.zxdHud.minSize = CGSizeMake(100, 100);
    self.zxdHud.mode = MBProgressHUDModeIndeterminate;
    self.zxdHud.labelText = str;
    [self.view addSubview:self.zxdHud];
    // [_zxdTableView bringSubviewToFront:self.zxdHud];
    [self.zxdHud show:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark----限制输入长度
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSInteger existedlength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (existedlength - selectedLength + replaceLength >18) {
        return  NO;
    }
    return YES;
}

#pragma mark-----长度限制
-(void)textFieldDidChange:(UITextField *)textField
{
    
        if (textField.text.length>18) {
            textField.text = [textField.text substringToIndex:18];
        }
        
}
-(BOOL)isPureInt:(NSString *)string
{
    NSScanner *scan = [NSScanner scannerWithString:string];
    int Val;
    return [scan scanInt:&Val]&&[scan isAtEnd];
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

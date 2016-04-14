//
//  zxdLockTwoViewController.m
//  WelLv
//
//  Created by liuxin on 16/1/29.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "zxdLockTwoViewController.h"
#import "MBProgressHUD.h"
@interface zxdLockTwoViewController ()
@property(nonatomic,strong) MBProgressHUD *zxdHud;
@end

@implementation zxdLockTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatView1];
    [self creatTitle];
    // Do any additional setup after loading the view.
}
-(void)creatView1
{
    self.zxdTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 15, windowContentWidth, 40)];
    self.zxdTextField.backgroundColor = [UIColor whiteColor];
    self.zxdTextField.text = self.strtext;
    self.zxdTextField.textAlignment = NSTextAlignmentCenter;
    [self.zxdTextField setTintColor:[UIColor blackColor]];
    [self.zxdTextField addTarget:self action:@selector(textFieldDicChange:) forControlEvents:UIControlEventEditingChanged];
    self.zxdTextField.font = [UIFont systemFontOfSize:15];
    self.zxdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.zxdTextField];
    self.zxdTextField.delegate = self;
}
-(void)creatTitle
{
    self.view.backgroundColor = BgViewColor;
    switch (self.type) {
        case 1:
        {
            self.navigationItem.title = @"职位";
            self.zxdTextField.placeholder = @"请输入您的职位";
        }
            break;
        case 7:
        {
            self.navigationItem.title = @"民族";
            self.zxdTextField.placeholder = @"请输入您的民族";
        }
            break;
        case 8:
        {
            self.navigationItem.title = @"信仰";
            self.zxdTextField.placeholder = @"请输入您的宗教信仰";
        }
            break;
        case 11:
        {
            self.navigationItem.title = @"护照号";
            self.zxdTextField.placeholder = @"请输入您的护照号";
            
        }
            break;

        default:
            break;
    }
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[YXTools stringToColor:@"#3c4042"]}];
    //确定按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(doneClick)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);
    //取消按钮
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(BackClick)];
    //    self.navigationItem.leftBarButtonItem.tintColor = kColor(255, 165, 98);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tap.cancelsTouchesInView = NO;
    //设置为NO表示当前控件响应后会传播到其他控件上,默认为yes
    [self.view addGestureRecognizer:tap];
}
-(void)doneClick
{
    if (self.zxdTextField.text.length==0) {
        [[LXAlterView sharedMyTools] createTishi:@"没有要保存的内容"];
    }
    else
    {
        
        [self downDate];
        
        // [self close];
    }
    
}
-(void)downDate
{
     NSDictionary *dic = nil;
    switch (self.type) {
        case 1:
        {
            //职位
            dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                    @"position":self.zxdTextField.text};

        }
            break;
        case 7:
        {
            //民族
            dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                    @"nation":self.zxdTextField.text};
        }
            break;
        case 8:
        {
            //信仰
            dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                    @"religiou":self.zxdTextField.text};
            
        }
            break;
        case 11:
        {
            //护照
            dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                    @"passport":self.zxdTextField.text};
            
        }
            break;
        default:
            break;
    }
     NSString *url = [NSString stringWithFormat:@"%@%@",WLHTTP,@"/api/assistant/edit_member_info"];
    NSDictionary *parameters = @{@"member_id":self.uid,
                                 @"data":[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:dic]};
    [self setHud:@"正在保存"];
    __weak typeof (self)weakSelf = self;
    AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
    zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [zxdManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        weakSelf.zxdHud.hidden = YES;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dict count]==0) {
            [[LXAlterView sharedMyTools] createTishi:@"保存失败"];
            
        }
        else if ([[dict objectForKey:@"status"] integerValue]!=1)
        {
            [[LXAlterView sharedMyTools] createTishi:@"保存失败"];
        }
        else
        {
            if ([weakSelf.delegate respondsToSelector:@selector(zxdViewController4:text:Number:)]) {
                [weakSelf.delegate zxdViewController4:weakSelf text:weakSelf.zxdTextField.text Number:weakSelf.type];
            }
            [self.navigationController popViewControllerAnimated:YES];
        
        }
       
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        weakSelf.zxdHud.hidden = NO;
    }];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}
#pragma mark-----点击空白处收键盘

-(void)keyboardHide:(UITapGestureRecognizer *)tap
{
    
    [self.zxdTextField resignFirstResponder];
    
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
-(void)zxdBackDelegate
{
    if ([self.delegate respondsToSelector:@selector(zxdViewController4:text:Number:)]) {
        [self.delegate zxdViewController4:self text:self.zxdTextField.text Number:self.type];
    }
}
#pragma mark----限制输入长度
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.zxdTextField) {
        if (string.length == 0) {
            return  YES;
        }
        NSInteger existedlength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedlength - selectedLength + replaceLength >18) {
            return  NO;
        }
    }
    return YES;
}
//监听事件
-(void)textFieldDicChange:(UITextField *)textField
{
    if (textField == self.zxdTextField) {
        if (textField.text.length>18) {
            textField.text = [textField.text substringToIndex:18];
        }
    }
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

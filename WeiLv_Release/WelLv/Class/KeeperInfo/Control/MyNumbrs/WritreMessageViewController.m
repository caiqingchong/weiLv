//
//  WritreMessageViewController.m
//  WelLv
//
//  Created by liuxin on 16/1/18.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "WritreMessageViewController.h"
#import "MBProgressHUD.h"
@interface WritreMessageViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,strong)UIDatePicker *datapicker1;
@property(nonatomic,strong)NSDateFormatter *dateFormateter;
@property(nonatomic,strong)UIPickerView *zxdPickViewSex;
@property(nonatomic,strong)NSArray *arrSex;
@property(nonatomic,strong) MBProgressHUD *zxdHud;
@end

@implementation WritreMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTitle];
    [self creatView1];
    if (2==self.type) {
        [self creatDataPicker];
        self.zxdTextField.userInteractionEnabled = NO;
    }
    if (1 == self.type) {
        [self creatPickViewSex];
         self.zxdTextField.userInteractionEnabled = NO;
    }
    // Do any additional setup after loading the view.
}
-(void)creatTitle
{
    self.view.backgroundColor = BgViewColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[YXTools stringToColor:@"#3c4042"]}];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(zxdConserve)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tap.cancelsTouchesInView = NO;
    //设置为NO表示当前控件响应后会传播到其他控件上,默认为yes
    [self.view addGestureRecognizer:tap];

}
-(void)creatDataPicker
{
    self.datapicker1 = [[UIDatePicker alloc] init];
    self.datapicker1.frame = CGRectMake(0, 180, windowContentWidth, 150);
    [self.datapicker1 setDatePickerMode:UIDatePickerModeDate];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中
    self.datapicker1.locale = locale;
    self.dateFormateter = [[NSDateFormatter alloc] init];
    self.datapicker1.backgroundColor = [UIColor whiteColor];
    [self.dateFormateter setDateFormat:@"YYYY-MM-dd"];

    [self.datapicker1 addTarget:self action:@selector(changeDate) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.datapicker1];
}
-(void)changeDate
{
    
    self.zxdTextField.text = [NSString stringWithFormat:@"%@",[self.dateFormateter stringFromDate:self.datapicker1.date]];
    
}
-(void)creatView1
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

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}
//邮箱验证
-(BOOL)isValidateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}
//身份证号码验证
#pragma 正则匹配用户身份证号15或18位
-(BOOL)checkUserIdCard: (NSString *) idCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}
-(void)zxdConserve
{
    
    if (self.type==0) {
        if (self.zxdTextField.text.length>7) {
            [[LXAlterView sharedMyTools] createTishi:@"会员姓名过长"];
          return;
        }
        [self downDate];
        
    }
    if (self.type == 3) {
        
        if (self.zxdTextField.text.length!=0) {
            if(![self checkUserIdCard:self.zxdTextField.text])
            {
                [[LXAlterView sharedMyTools] createTishi:@"身份证号码不正确"];
                return;
            }
            [self downDate];
        }
        
        else
        {
            [self downDate];
            
        }
    }

    if (self.type == 4) {
       
        if(![self isValidateEmail:self.zxdTextField.text])
        {
            [[LXAlterView sharedMyTools] createTishi:@"邮箱号不正确"];
            return;
        }
        else
        {
            [self downDate];

        }
    }
    if (self.type == 1||self.type == 2) {
        [self downDate];
    }
}
//点击空白处收键盘
-(void)keyboardHide:(UITapGestureRecognizer *)tap
{
    [self.zxdTextField resignFirstResponder];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)downDate
{
    if (self.type == 3) {
        //身份证号
    }
    if (self.type == 4) {
        //邮箱号
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",WLHTTP,@"/api/assistant/edit_member_info"];
    
    //    NSDictionary *dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
    //                          @"select":@"*"};
    NSDictionary *dic = nil;
    switch (self.type) {
        case 0:
        {
            dic  = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                      @"remark_name":self.zxdTextField.text};
        }
            break;
        case 1:
        {
            if ([self.zxdTextField.text isEqualToString:@"男"]) {
                dic  = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                         @"gender":@"1"};

            }
            else
            {
                dic  = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                         @"gender":@"2"};
                

            }
            
        }
            break;
        case 2:
        {
            dic  = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                     @"birth_date":self.zxdTextField.text};

        }
            break;
        case 3:
        {
            dic  = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                     @"id_number":self.zxdTextField.text};

        }
            break;
        case 4:
        {
            dic  = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                     @"info_email":self.zxdTextField.text};

        }
            break;

        default:
            break;
    }
    NSDictionary *parameters = @{@"member_id":self.uid,
                                 @"data":[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:dic]};
    //data={"token":"7a6bd7af36e5db226281a037909fbdfd","select":"*"}&member_id=31040
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
            if ([self.delegate respondsToSelector:@selector(zxdViewController:text:number:)]) {
                [self.delegate zxdViewController:self text:self.zxdTextField.text number:self.type];
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            else
            {
                [[LXAlterView sharedMyTools] createTishi:@"保存失败"];
            }
   
        }
        //weakSelf.zxdHud.labelText = dict[@"msg"];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        weakSelf.zxdHud.hidden = YES;
         [[LXAlterView sharedMyTools] createTishi:@"保存失败"];
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
-(void)creatPickViewSex
{
    self.arrSex = @[@"男",@"女"];
    self.zxdPickViewSex = [[UIPickerView alloc] init];
    _zxdPickViewSex.frame = CGRectMake(0, 182, windowContentWidth, 120);
    _zxdPickViewSex.backgroundColor = [UIColor whiteColor];
    _zxdPickViewSex.delegate = self;
    _zxdPickViewSex.dataSource = self;
    [self.view addSubview:_zxdPickViewSex];
    
}
#pragma mark---pickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.arrSex.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.arrSex objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.zxdTextField.text = [self.arrSex objectAtIndex:row];
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return windowContentWidth;
}

#pragma mark-----身份证号码验证

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

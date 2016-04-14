//
//  zxdChangYongViewController.m
//  WelLv
//
//  Created by liuxin on 16/1/25.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "zxdChangYongViewController.h"

@interface zxdChangYongViewController ()<UITextFieldDelegate,UITextViewDelegate>
@property(nonatomic,strong)UITextField *zxdTxetField1;
@property(nonatomic,strong)UITextField *zxdTxetField2;
@property(nonatomic,strong)UITextView *zxdTextView1;
@property(nonatomic,strong)UILabel *zxdLabel;
@property(nonatomic,strong)UIView *view2;

@end

@implementation zxdChangYongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTitle];
    [self creatView1];
    if (self.type == 2) {
        [self creatView2];
         [self getCity:nil];
    }
   
   
    // Do any additional setup after loading the view.
}
-(void)creatView2
{
    UIView *zxdView = [[UIView alloc] init];
    zxdView.frame =CGRectMake(0, 15, windowContentWidth, 127);
    zxdView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:zxdView];
    UITapGestureRecognizer *zxdTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zxdTapClick)];
    zxdTap.cancelsTouchesInView = NO;
    //设置为NO表示当前控件响应后会传播到其他控件上,默认为yes
    [zxdView addGestureRecognizer:zxdTap];
    
    self.zxdLabel = [[UILabel alloc] init];
    _zxdLabel.frame = CGRectMake(0, 5, windowContentWidth, 35);
    _zxdLabel.textAlignment = NSTextAlignmentCenter;
    _zxdLabel.text = [self judgeString:self.frist]?self.frist:@"请选择省市区";
    [zxdView addSubview:self.zxdLabel];
    self.view2 = [[UIView alloc] init];
    _view2.frame = CGRectMake(0, windowContentHeight-64-300, windowContentWidth, 300);
    _zxdTxetField1.userInteractionEnabled = NO;
    _zxdTxetField1.hidden = YES;
    _zxdTxetField2.userInteractionEnabled = NO;
    _zxdTxetField2.hidden = YES;

    _view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_view2];
    UILabel *labelLine = [[UILabel alloc] init];
    labelLine.frame = CGRectMake(0, 45, windowContentWidth, 1);
    labelLine.backgroundColor = BgViewColor;
    [zxdView addSubview:labelLine];
    //地址
    self.zxdTextView1 = [[UITextView alloc] init];
    _zxdTextView1.frame = CGRectMake(0, 47, windowContentWidth, 80);
    _zxdTextView1.backgroundColor = [UIColor whiteColor];
    _zxdTextView1.delegate = self;
    
    _zxdTextView1.font = [UIFont systemFontOfSize:17];
    _zxdTextView1.textAlignment = NSTextAlignmentCenter;
    _zxdTextView1.text = self.second;
    [zxdView addSubview:_zxdTextView1];
    //创建城市选择器
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
    areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSArray *components = [areaDic allKeys];
    NSArray *sortedArray = [components sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    NSMutableArray *provinceTmp = [[NSMutableArray alloc] init];
    for (int  i= 0; i<[sortedArray count]; i++) {
        NSString *index = [sortedArray objectAtIndex:i];
        NSArray *tmp = [[areaDic objectForKey:index] allKeys];
        [provinceTmp addObject:[tmp objectAtIndex:0]];
    }
    province = [[NSArray alloc] initWithArray: provinceTmp];
    //初始化为一个值，否则会闪退
     selectedProvince = [province objectAtIndex: 0];
    //
    NSString *index = [sortedArray objectAtIndex:0];
    NSString *selected = [province objectAtIndex:0];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [[areaDic objectForKey:index]objectForKey:selected]];
    
    NSArray *cityArray = [dic allKeys];
    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [cityArray objectAtIndex:0]]];
    city = [[NSArray alloc] initWithArray: [cityDic allKeys]];
    
    
    NSString *selectedCity = [city objectAtIndex: 0];
    district = [[NSArray alloc] initWithArray: [cityDic objectForKey: selectedCity]];
    
    
    
    picker = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 0, windowContentWidth, 300)];
    picker.dataSource = self;
    picker.delegate = self;
    picker.showsSelectionIndicator = YES;
    [picker selectRow: 0 inComponent: 0 animated: YES];
    [self.view2 addSubview: picker];
    //确定按钮
    UIButton *zxdBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [zxdBtn addTarget:self action:@selector(zxdChangeClick) forControlEvents:UIControlEventTouchUpInside];
    [zxdBtn setTitle:@"确定" forState:UIControlStateNormal];
    zxdBtn.frame = CGRectMake(windowContentWidth-60, 0, 60, 30);
    zxdBtn.tintColor = kColor(255, 165, 98);
  //  [picker addSubview:zxdBtn];
    

}

-(void)zxdTapClick
{
    
    [self.zxdTxetField2 resignFirstResponder];
    [[LXAlterView sharedMyTools] createTishi:@"用轮播选择城市"];
    self.view2.hidden = NO;
}
#pragma 正则匹配手机号
- (BOOL)checkTelNumber:(NSString *) telNumber
{
    NSString *pattern = @"^[0-9]{11}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}
//上传数据
-(void)zxdChangeClick
{
 
//    [self getCity:@"11"];
//    return;
    NSString *url = [NSString stringWithFormat:@"%@%@",WLHTTP,@"/api/assistant/edit_member_info"];
    NSDictionary *dic = nil;
    if (self.type == 1) {
        if (self.zxdTxetField1.text.length>7) {
            [[LXAlterView sharedMyTools] createTishi:@"姓名的长度不能超过7位"];
            return;
        }
        if (self.zxdTxetField2.text.length!=0) {
            if (![self checkTelNumber:self.zxdTxetField2.text]) {
                [[LXAlterView sharedMyTools] createTishi:@"请输入正确的手机号"];
                return;
            }
        }
        dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                @"contact":self.zxdTxetField1.text,
                @"contact_phone":self.zxdTxetField2.text};
       
    }
    else if (self.type == 2)
    {
        if (self.zxdTextView1.text.length == 0) {
            [[LXAlterView sharedMyTools] createTishi:@"请完善信息"];
            return;
        }
        else{
        dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                @"info_province":self.zxdcity1,
                @"info_city":self.zxdcity2,
                @"info_country":self.zxdcity3,
                @"info_address":self.zxdTextView1.text};
        }

    }
    
    NSDictionary *parameters = @{@"member_id":self.uid,
                                 @"data":[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:dic]};
    __weak typeof (self)weakSelf = self;
    AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
    zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [zxdManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
            if ([dict[@"data"] count]==0) {
                [[LXAlterView sharedMyTools] createTishi:@"保存失败"];
            }else
            {
                
                [[LXAlterView sharedMyTools] createTishi:@"保存成功"];
                [weakSelf zxdBackDelegate];
            }
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      [[LXAlterView sharedMyTools] createTishi:@"保存失败"];
    }];

}
-(void)creatView1
{
    self.zxdTxetField1 = [[UITextField alloc] init];
    _zxdTxetField1.frame = CGRectMake(0, 15, windowContentWidth, 45);
    _zxdTxetField1.delegate = self;
    _zxdTxetField1.text = self.frist;
    _zxdTxetField1.placeholder = @"姓名";
    _zxdTxetField1.tag = 101;
    [self.zxdTxetField1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _zxdTxetField1.backgroundColor = [UIColor whiteColor];
    _zxdTxetField1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.zxdTxetField1];
    
    self.zxdTxetField2 = [[UITextField alloc] init];
    
    _zxdTxetField2.frame = CGRectMake(0, 61, windowContentWidth, 45);
    
    _zxdTxetField2.delegate = self;
    _zxdTxetField2.text = self.second;
    [self.zxdTxetField2 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
           _zxdTxetField2.placeholder = @"电话";
    
    _zxdTxetField2.tag = 102;
    _zxdTxetField2.textAlignment = NSTextAlignmentCenter;
    _zxdTxetField2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_zxdTxetField2];
}
-(void)creatTitle
{
    self.view.backgroundColor = BgViewColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[YXTools stringToColor:@"#3c4042"]}];
    //确定按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(zxdChangeClick)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tap.cancelsTouchesInView = NO;
    //设置为NO表示当前控件响应后会传播到其他控件上,默认为yes
    [self.view addGestureRecognizer:tap];

}
#pragma mark---确定按钮
-(void)doneClick
{
    NSInteger provinceIndex = [picker selectedRowInComponent: PROVINCE_COMPONENT];
    NSInteger cityIndex = [picker selectedRowInComponent: CITY_COMPONENT];
    NSInteger districtIndex = [picker selectedRowInComponent: DISTRICT_COMPONENT];
    
    NSString *provinceStr = [province objectAtIndex: provinceIndex];
    NSString *cityStr = [city objectAtIndex: cityIndex];
    NSString *districtStr = [district objectAtIndex:districtIndex];
    
    if ([provinceStr isEqualToString: cityStr] && [cityStr isEqualToString: districtStr]) {
        cityStr = @"";
        districtStr = @"";
    }
    else if ([cityStr isEqualToString: districtStr]) {
        districtStr = @"";
    }
    
    NSString *showMsg = [NSString stringWithFormat: @"%@-%@-%@", provinceStr, cityStr, districtStr];
    self.zxdcity1 = provinceStr;
    self.zxdcity2 = cityStr;
    self.zxdcity3 = districtStr;
    self.zxdLabel.text = showMsg;
    self.zxdStr1 = provinceStr;
    self.zxdStr2 = cityStr;
    self.zxdStr3  = districtStr;
    [self getCity:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//点击空白处收键盘
-(void)keyboardHide:(UITapGestureRecognizer *)tap
{
    if (self.type == 2) {
        [self.zxdTxetField2 resignFirstResponder];
        self.view2.hidden = NO;
    }
    else
    {
        [self.zxdTxetField1 resignFirstResponder];
        [self.zxdTxetField2 resignFirstResponder];
    }
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 102) {
        self.view2.hidden = YES;
    }
}
#pragma mark---城市选择器
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark- button clicked

- (void) buttobClicked:(id)sender {
    
    
   
    
}



#pragma mark- Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return [province count];
    }
    else if (component == CITY_COMPONENT) {
        return [city count];
    }
    else {
        return [district count];
    }
}


#pragma mark- Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return [province objectAtIndex: row];
    }
    else if (component == CITY_COMPONENT) {
        return [city objectAtIndex: row];
    }
    else {
        return [district objectAtIndex: row];
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        selectedProvince = [province objectAtIndex: row];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: [NSString stringWithFormat:@"%ld", row]]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
        NSArray *cityArray = [dic allKeys];
        NSArray *sortedArray = [cityArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;//递减
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;//上升
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i=0; i<[sortedArray count]; i++) {
            NSString *index = [sortedArray objectAtIndex:i];
            NSArray *temp = [[dic objectForKey: index] allKeys];
            [array addObject: [temp objectAtIndex:0]];
        }
        
        
        city = [[NSArray alloc] initWithArray: array];
       
        
        
        NSDictionary *cityDic = [dic objectForKey: [sortedArray objectAtIndex: 0]];
        district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [city objectAtIndex: 0]]];
        [picker selectRow: 0 inComponent: CITY_COMPONENT animated: YES];
        [picker selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
        [picker reloadComponent: CITY_COMPONENT];
        [picker reloadComponent: DISTRICT_COMPONENT];
        
    }
    else if (component == CITY_COMPONENT) {
        NSString *provinceIndex = [NSString stringWithFormat: @"%ld", [province indexOfObject: selectedProvince]];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: provinceIndex]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
        NSArray *dicKeyArray = [dic allKeys];
        NSArray *sortedArray = [dicKeyArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [sortedArray objectAtIndex: row]]];
        NSArray *cityKeyArray = [cityDic allKeys];
        
        
        district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [cityKeyArray objectAtIndex:0]]];
        [picker selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
        [picker reloadComponent: DISTRICT_COMPONENT];
    }
    [self doneClick];
    
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return 80;
    }
    else if (component == CITY_COMPONENT) {
        return 100;
    }
    else {
        return 115;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *myView = nil;
    
    if (component == PROVINCE_COMPONENT) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 78, 30)] ;
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = [province objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    else if (component == CITY_COMPONENT) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 95, 30)] ;
        myView.textAlignment = NSTextAlignmentCenter;;
        myView.text = [city objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    else {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 110, 30)] ;
        myView.textAlignment = NSTextAlignmentCenter;;
        myView.text = [district objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    
    return myView;
}

- (void)getCity:(NSString *)cityId
{
    NSDictionary *parameters = @{@"province":self.zxdcity1,
                                 @"city":self.zxdcity2,
                                 @"country":self.zxdcity3,
                                 @"sign":@"id",
                                 @"token":@"7a6bd7af36e5db226281a037909fbdfd",
                                 };
   // [self setHud:@"正在下载"];
    __weak typeof (self)weakSelf = self;
    AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
    zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [zxdManager POST:zxdIdtoCityUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //weakSelf.zxdHud.hidden = YES;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dict[@"status"] integerValue]==1) {
            NSString *strpro = nil;
            NSString  *strCity = nil;
            NSString *strCountry = nil;
            strpro = dict[@"province"];
            strCity = dict[@"city"];
            strCountry = dict[@"country"];
            weakSelf.zxdcity1 = [weakSelf judgeString:strpro]?strpro:@"11";
            weakSelf.zxdcity2= [weakSelf judgeString:strCity]?strCity:@"149";
            weakSelf.zxdcity3 = [weakSelf judgeString:strCountry]?strCountry:@"1259";
            
           // [weakSelf.zxdTableView reloadData];
        }
        else
        {
            [[LXAlterView sharedMyTools] createTishi:@"下载失败"];
        }
        //  NSDictionary *zxddict = dict;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       // weakSelf.zxdHud.hidden = YES;
        [[LXAlterView sharedMyTools] createTishi:@"下载失败"];
    }];
}
-(void)zxdBackDelegate
{
    if (self.type == 1) {
        if ([self.delegate respondsToSelector:@selector(zxdVcBack:text1:text2:text3:text4:text5:zxdBool:)]) {
            [self.delegate zxdVcBack:self text1:nil text2:nil text3:nil text4:self.zxdTxetField1.text text5:self.zxdTxetField2.text zxdBool:self.type];
            [self close];
        }
    }
    else
    {
        if ([self.delegate respondsToSelector:@selector(zxdVcBack:text1:text2:text3:text4:text5:zxdBool:)]) {
            [self.delegate zxdVcBack:self text1:self.zxdStr1 text2:self.zxdStr2 text3:self.zxdStr3 text4:self.zxdTxetField1.text text5:self.zxdTextView1.text zxdBool:self.type];
            [self close];
        }
    }
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
    if (textField == self.zxdTxetField1) {
        if (textField.text.length>18) {
            textField.text = [textField.text substringToIndex:18];
        }

    }
    else if (textField == self.zxdTxetField2)
    {
        if (textField.text.length>18) {
            textField.text = [textField.text substringToIndex:18];
        }
    }
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

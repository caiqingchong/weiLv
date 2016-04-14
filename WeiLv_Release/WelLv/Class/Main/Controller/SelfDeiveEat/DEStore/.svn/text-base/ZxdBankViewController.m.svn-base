//
//  ZxdBankViewController.m
//  WelLv
//
//  Created by liuxin on 15/11/25.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//
#import "ChoseBankViewController.h"
#import "ZxdBankViewController.h"
#import "BankCardModel.h"
#import "JSONKit.h"
#define FristComponent 0
#define SendComponent 1
#define ThirdComponent 2
#define cellHeight 45
#import "WXUtil.h"
@interface ZxdBankViewController ()<UIAlertViewDelegate>
{
    UIView *bgView;
    UITextField *textF1;
    UITextField *textF3;
    UITextField *textF5;
    UIButton *button4;
    UIButton *button2;
    
    NSInteger chooseinteger;
}
@end

@implementation ZxdBankViewController
-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"ChooseBankTZ" object:nil];
    
    
}
- (void)tongzhi:(NSNotification *)dic{
    
    NSString *text = dic.userInfo[@"text"];
    [self.arrText replaceObjectAtIndex:1 withObject:text];
    [button2 setTitle:text forState:UIControlStateNormal];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrText = [[NSMutableArray alloc] initWithObjects:@"持卡人姓名",@"请选择储蓄卡所属银行",@"卡号",@"请填写储蓄卡开户地区",@"支行姓名", nil];
    self.view.backgroundColor = BgViewColor;
    //保存按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(zxdConserve)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);
    [self creatPickview];
    [self initView];
    [self DownLoad];
}

-(void)initView{
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 15, windowContentWidth, cellHeight*5)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    NSArray *lefttitlle = [[NSArray alloc] initWithObjects:@"持卡人",@"银行",@"卡号",@"开户地区",@"支行名称", nil];
    for(int i = 0 ;i< lefttitlle.count;i++){
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,cellHeight*i +15, 60, 20)];
        leftLabel.text = lefttitlle[i];
        leftLabel.font = [UIFont systemFontOfSize:15];
        leftLabel.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:leftLabel];
        
        if(i != lefttitlle.count -1){
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0 ,cellHeight*i+45 -1, windowContentWidth, 1)];
            line.backgroundColor = bordColor;
            [bgView addSubview:line];
        }
    }
    
    textF1 = [[UITextField alloc] initWithFrame:CGRectMake(80, 5, windowContentWidth -80, 39)];
    textF1.text = self.arrText[0];
    //textF1.placeholder = @"请填写储蓄卡开户人姓名";
    textF1.font = [UIFont systemFontOfSize:14];
    textF1.delegate= self;
     //textF1.textAlignment = NSTextAlignmentCenter;
    textF3 = [[UITextField alloc] initWithFrame:CGRectMake(80,cellHeight*2+5 , windowContentWidth -80, 39)];
   // textF3.placeholder = @"请填写储蓄卡号";
    textF3.font = [UIFont systemFontOfSize:14];
    textF3.delegate= self;
    //textF3.textAlignment = NSTextAlignmentCenter;
    textF3.text = self.arrText[2];
    textF5 = [[UITextField alloc] initWithFrame:CGRectMake(80,cellHeight*4+ 5, windowContentWidth -80, 39)];
   // textF5.placeholder = @"请填写开户行支行名称";
    textF5.font = [UIFont systemFontOfSize:14];
    textF5.text = self.arrText[4];
    //textF5.textAlignment = NSTextAlignmentCenter;
    textF5.delegate= self;
    [bgView addSubview:textF1];
    [bgView addSubview:textF3];
    [bgView addSubview:textF5];
    
    
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(80, cellHeight *1+5 , windowContentWidth-80, 44);
    button2.backgroundColor = [UIColor clearColor];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button2.titleLabel.font= [UIFont systemFontOfSize:14];
    button2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //button2.titleEdgeInsets = UIEdgeInsetsMake(0, 1, 0, 0);
    //button2.titleLabel.textAlignment = NSTextAlignmentLeft;
    [button2 setTitle:self.arrText[1] forState:UIControlStateNormal]  ;
    button2.tag = 2;
    [button2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:button2];
    
    button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame = CGRectMake(80, cellHeight *3+3 , windowContentWidth-80, 44);
    button4.backgroundColor = [UIColor clearColor];
    [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button4.titleLabel.font= [UIFont systemFontOfSize:14];
    button4.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button4 setTitle:self.arrText[3] forState:UIControlStateNormal]  ;
    button4.tag = 4;
   // button4.tintColor = kColor(255, 165, 98);
    [button4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:button4];
    
    
    UIView *viewWar = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(bgView) + ViewHeight(bgView) +10, windowContentWidth, 40)];
    viewWar.backgroundColor = kColor(254, 255, 199);
    [self.view addSubview:viewWar];
    UILabel *labelWar = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, windowContentWidth-25, 30)];
    labelWar.text = @"该银行账户将作为店家交易结算账户,请仔细填写持卡人姓名并确保与店主姓名一致";
    labelWar.numberOfLines=2;
    labelWar.font = [UIFont systemFontOfSize:12];
    
    labelWar.textColor = kColor(255, 165, 98);
    [viewWar addSubview:labelWar];
    
}


-(void)btnClick:(UIButton*)sender
{
    if (sender.tag ==  2) {
        ChoseBankViewController *cBank = [[ChoseBankViewController alloc] init];
        cBank.title = @"选择银行";
        [self.navigationController pushViewController:cBank animated:YES];
        
    }
    else if(sender.tag == 13)
    {
        [UIView animateWithDuration:3 animations:^{
            self.PicView.hidden = YES;
        }];
        //[button4 setTitle:@"请填写储蓄卡开户地区" forState:UIControlStateNormal];
        
        
    }
    else if (sender.tag == 4)
    {
        
        // UILabel *label = (UILabel *)[self.view viewWithTag:4];
        // label.text = @"请选择银行卡开户地区";
        [UIView animateWithDuration:3 animations:^{
            self.PicView.hidden = NO;
        }];
    }
    else if (sender.tag == 14)
    {
        [UIView animateWithDuration:3 animations:^{
            self.PicView.hidden = YES;
        }];
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
        self.strText = [NSString stringWithFormat: @"%@-%@-%@", provinceStr, cityStr, districtStr];
        self.arrText[3] = self.strText;
    }
}
//创建城市选择器
-(void)creatPickview
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
    areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSArray *components = [areaDic allKeys];
    NSArray *sortedArray = [components sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 integerValue]>[obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([obj1 integerValue]<[obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
            
        }
        return (NSComparisonResult)NSOrderedSame;
        
    }];
    NSMutableArray *provinceTmp = [[NSMutableArray  alloc] init];
    for (int i=0; i<[sortedArray count]; i++) {
        NSString *index = [sortedArray objectAtIndex:i];
        NSArray *tmp = [[areaDic objectForKey:index] allKeys];
        [provinceTmp addObject:[tmp objectAtIndex:0]];
    }
    province = [[NSArray alloc] initWithArray:provinceTmp];
    NSString *index = [sortedArray objectAtIndex:0];
    NSString *selected = [province objectAtIndex:0];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[[areaDic objectForKey:index] objectForKey:selected]];
    NSArray *cityArray = [dic allKeys];
    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary:[dic objectForKey:[cityArray objectAtIndex:0]]];
    city = [[NSArray alloc] initWithArray:[cityDic allKeys]];
    NSString *selectedCity = [city objectAtIndex:0];
    district = [[NSArray alloc] initWithArray:[cityDic objectForKey:selectedCity]];
    self.PicView = [[UIView alloc] initWithFrame:CGRectMake(0, windowContentHeight-270, windowContentWidth, 180)];
    [self.view addSubview:self.PicView];
    picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, windowContentWidth, 200)];
    picker.dataSource = self;
    picker.delegate = self;
    picker.showsSelectionIndicator = YES;
    [picker selectRow:0 inComponent:0 animated:YES];
    picker.backgroundColor = kColor(244, 245, 246);
    [self.PicView addSubview:picker];
    self.PicView.backgroundColor = picker.backgroundColor;
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(10, 0, 50, 30);
    button3.tag = 13;
    [button3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [button3 setTitle:@"取消" forState:UIControlStateNormal];
    
    
    //button1.backgroundColor = [UIColor redColor];
    //button1.titleLabel.textColor = [UIColor blackColor];
    [button3 setTitleColor:kColor(255, 165, 98) forState:UIControlStateNormal];
    [self.PicView addSubview:button3];
    UIButton *button44 = [UIButton buttonWithType:UIButtonTypeCustom];
    button44.frame = CGRectMake(windowContentWidth-60, 0, 50, 30);
    button44.tag = 14;
    [button44 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [button44 setTitle:@"确定" forState:UIControlStateNormal];
    [button44 setTitleColor:kColor(255, 165, 98) forState:UIControlStateNormal];
    [self.PicView addSubview:button44];
    self.PicView.hidden = YES;
    
    
}
#pragma mark - 保存事件
-(void)zxdConserve
{
    [self textFieldDidEndEditing:textF1];
    [self textFieldDidEndEditing:textF5];
    [self textFieldDidEndEditing:textF3];
    for (NSString *str in self.arrText) {
        NSLog(@"+++%@",str);
    }
    NSString *str1 = [button2 currentTitle];
    NSLog(@"str1==%@",str1);
    NSString *str2 = [button4 currentTitle];
    NSLog(@"str1==%@",str2);
    NSString *url = [NSString stringWithFormat:@"%@/api/drivingBank/edit_bank",WLHTTP];
    
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString *member_id = [[WLSingletonClass defaultWLSingleton] wlUserID];
    NSString * shopId = [[WLSingletonClass defaultWLSingleton] wlDEShopID];
    NSString *token1 = [token stringByAppendingString:member_id];
    
    NSDictionary *dataDict=@{
                             @"bank_sn":textF3.text,
                             @"open_bank_name":textF5.text,
                             @"open_branch_name":str1,
                             @"open_bank_dir":str2,
                             @"cardholder":textF1.text
                             };
    NSDictionary *dict = @{
                           @"wltoken":[WXUtil md5:token1],
                           @"member_id":member_id,
                           @"shopId":shopId,
                           @"data":[dataDict JSONString]
                        };
    AFHTTPRequestOperationManager *manager2 = [AFHTTPRequestOperationManager manager];
    manager2.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager2 POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *zxdDict2 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"下载的数据%@",zxdDict2);
        UIAlertView *alertSuccess = [[UIAlertView alloc] initWithTitle:@"提示" message:zxdDict2[@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertSuccess show];
        
        
        NSLog(@"+++===%@",zxdDict2[@"msg"]);
        //return ;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        NSLog(@"失败");
        UIAlertView *alertfail = [[UIAlertView alloc] initWithTitle:@"提示" message:@"上传失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertfail show];
        // return ;
    }];

    
    
    
}

//点击空白处收键盘
-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma -mark TestFieldDelegate
//清除按钮
-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}
//点击键盘return键的时候调用
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

//结束编辑
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == textF1) {
        self.arrText[0] = textField.text;
    }else if(textField == textF3) {
        self.arrText[2] = textField.text;
    }else if(textField == textF5) {
        self.arrText[4] = textField.text;
    }
    
    NSLog(@"=========%@",self.arrText);
}
#pragma mark--UIPickerViewDataSource
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


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

#pragma mark--UIPickerViewDelegate
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
        chooseinteger = row;
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
    
    selectedProvince = [province objectAtIndex:chooseinteger];
    NSInteger zxdselectedIndex = [picker selectedRowInComponent:1];
    NSInteger zxdselectedIndex2 = [picker selectedRowInComponent:2];
    NSString *strmsg = [NSString stringWithFormat:@"%@-%@-%@",selectedProvince,[city objectAtIndex:zxdselectedIndex],[district objectAtIndex:zxdselectedIndex2]];
    [button4 setTitle:strmsg forState:UIControlStateNormal];
    //label.text = strmsg;
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
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = [city objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    else {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 110, 30)] ;
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = [district objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    
    return myView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 获取数据
-(void)DownLoad
{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/drivingBank/get_member_bank",WLHTTP];
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString *member_id = [[WLSingletonClass defaultWLSingleton] wlUserID];
    NSString * shopId = [[WLSingletonClass defaultWLSingleton] wlDEShopID];
    NSString *token1 = [token stringByAppendingString:member_id];
    
    NSDictionary *dict = @{@"shopId":shopId,
                           @"member_id":member_id,
                           @"wltoken":[WXUtil md5:token1],
                                                    };
    AFHTTPRequestOperationManager *manager2 = [AFHTTPRequestOperationManager manager];
    manager2.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager2 POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *zxdDict2 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"下载的数据%@",zxdDict2);
       /* UIAlertView *alertSuccess = [[UIAlertView alloc] initWithTitle:@"提示" message:zxdDict2[@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertSuccess show];*/
      
        [self updata:zxdDict2];
        NSLog(@"+++===%@",zxdDict2[@"msg"]);
        //return ;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        NSLog(@"失败");
        UIAlertView *alertfail = [[UIAlertView alloc] initWithTitle:@"提示" message:@"下载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertfail show];
       // return ;
    }];


}
-(void)updata:(NSDictionary *)dic
{
    NSDictionary *zxdDict = dic[@"data"];
    //持卡人
    if ([self judgeString:zxdDict[@"cardholder"]]) {
         textF1.text = zxdDict[@"cardholder"];
    }
    //银行
    if ([self judgeString:zxdDict[@"open_branch_name"]]) {
        [button2 setTitle:zxdDict[@"open_branch_name"] forState:UIControlStateNormal];
    }
    //卡号
    if ([self judgeString:zxdDict[@"bank_sn"]]) {
         textF3.text = zxdDict[@"bank_sn"];
    }
    //开户地址
    if ([self judgeString:zxdDict[@"open_bank_dir"]]) {
        [button4 setTitle:zxdDict[@"open_bank_dir"] forState:UIControlStateNormal];
    }
    //支行名称
    if ([self judgeString:zxdDict[@"open_bank_name"]]) {
         textF5.text = zxdDict[@"open_bank_name"];
    }
    
    
}

- (NSString*)arrayToJson:(NSArray *)arr {
    
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end

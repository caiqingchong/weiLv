//
//  AddBankCardsViewController.m
//  WelLv
//
//  Created by lyx on 16/1/18.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "AddBankCardsViewController.h"
#import "AddBankNameVC.h"
#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2
#define cellHeight 45
@interface AddBankCardsViewController ()<UIScrollViewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIView *bgView;
    AFHTTPRequestOperationManager *manager;
    BOOL isReturn;//是否返回银行信息
    UIPickerView *picker;
    UIView *pickTopView;
    NSDictionary *areaDic;
    NSArray *province;
    NSArray *city;
    NSArray *district;
    NSString *selectedProvince;
    NSInteger chooseinteger;
    NSString *strmsg;
    NSDictionary *dict2;//银行返回信息
    NSString *cardNumber;
    NSString *bankName;
    NSString *cardName;
    NSString *banklocation;
    NSString *bankBrandName;
    NSString *code;
    NSString *cityId;//返回城市id
}

@property(nonatomic,strong)UIScrollView *scrollow;
@property(nonatomic,strong)UIButton *testBtn;
@end

@implementation AddBankCardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=BgViewColor;
    self.title=@"添加银行卡";
    [self initData];
    [self createUI];
   
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    UITextField *textField1=(UITextField *)[bgView viewWithTag:101];
    [textField1 resignFirstResponder];
    UITextField *textField2=(UITextField *)[bgView viewWithTag:102];
    [textField2 resignFirstResponder];
    UITextField *textField3=(UITextField *)[bgView viewWithTag:103];
    [textField3 resignFirstResponder];
    UITextField *textField4=(UITextField *)[bgView viewWithTag:104];
    [textField4 resignFirstResponder];
    UITextField *textField5=(UITextField *)[bgView viewWithTag:105];
    [textField5 resignFirstResponder];
    
    UITextField *textField6=(UITextField *)[bgView viewWithTag:106];
    [textField6 resignFirstResponder];
    
}

-(void)initData
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
    areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSArray *components = [areaDic allKeys];
    NSArray *sortedArray = [components sortedArrayUsingComparator:^NSComparisonResult(id  obj1, id  obj2) {
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
    selectedProvince = [province objectAtIndex: 0];
}
-(void)createUI
{
    bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 20, windowContentWidth, 40*6)];
    bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bgView];
    NSArray *leftArr=[NSArray arrayWithObjects:@"卡号",@"开户银行",@"开户名称",@"开户地区",@"支行名称",@"短信验证码", nil];
    
    NSArray *placeHoldeArr=[NSArray arrayWithObjects:@"请填写储蓄卡号",@"请选择储蓄卡所属银行",@"请填写储蓄卡开户人姓名",@"请选择储蓄卡开户所在地",@"请填写开户支行名称",@"", nil];
    for (int i=0; i<leftArr.count; i++) {
        UILabel *leftLable=[[UILabel alloc]initWithFrame:CGRectMake(10, i*40, 80, 40)];
        leftLable.text=leftArr[i];
        leftLable.textColor=[UIColor blackColor];
        leftLable.font=systemFont(18);
        [bgView addSubview:leftLable];
        UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(ViewRight(leftLable), i *40, windowContentWidth-ViewRight(leftLable)+10, 40)];
        textField.placeholder=placeHoldeArr[i];
        textField.returnKeyType =UIReturnKeyDone;
        textField.tag=101+i;
        
        textField.adjustsFontSizeToFitWidth=YES;
        [textField addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
        textField.delegate=self;
        [bgView addSubview:textField];
        UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, 40+i*40, windowContentWidth, 0.5)];
        line.backgroundColor=bordColor;
        [bgView addSubview:line];
        if (i==leftArr.count-1) {
            
            [leftLable setFrame:CGRectMake(10, i*40, 100, 40)];
            
            [textField setFrame:CGRectMake(ViewRight(leftLable), i *40, windowContentWidth-ViewRight(leftLable)-10-80, 40)];
            self.testBtn=[[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth-10-80, ViewY(leftLable)+5, 80, 30)];
            [self.testBtn setBackgroundColor:[UIColor colorWithRed:254/255.0 green:154/255.0 blue:101/255.0 alpha:1]];
            self.testBtn.layer.cornerRadius=4.0;
            [self.testBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            self.testBtn.titleLabel.font=[UIFont systemFontOfSize:16];
            [self.testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.testBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:self.testBtn];
            line.hidden=YES;
        }
    }
    
    UILabel *botomLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 260, windowContentWidth-20, 30)];
    botomLabel.numberOfLines=0;
    NSString *str=[[LXUserTool sharedUserTool].getPhone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    botomLabel.text=[NSString stringWithFormat:@"为确保您的用卡安全,添加银行卡需要验证手机,验证码将发送至%@",str];
    botomLabel.textColor=[UIColor grayColor];
    botomLabel.font=[UIFont systemFontOfSize:11];
    [self.view addSubview:botomLabel];

    
    UIButton *bindBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, windowContentHeight-64-40, windowContentWidth, 40)];
    [bindBtn setBackgroundColor:[YXTools stringToColor:@"#ff9a66"]];
    
    [bindBtn setTintColor:[UIColor whiteColor]];
    [bindBtn setTitle:@"绑定" forState:UIControlStateNormal];
    [bindBtn addTarget:self action:@selector(bindBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bindBtn];
    picker=[[UIPickerView alloc]init];
    picker.frame=CGRectMake(0, windowContentHeight-64-150+20, windowContentWidth, 150);
    picker.backgroundColor=[UIColor whiteColor];
    picker.delegate=self;
    picker.dataSource=self;
    picker.hidden=YES;
    [self.view addSubview:picker];
    pickTopView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewY(picker)-40, windowContentWidth, 40)];
    pickTopView.backgroundColor=[UIColor whiteColor];
    pickTopView.hidden=YES;
    [self.view addSubview:pickTopView];
    UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, 39.5, windowContentWidth,0.5)];
    line.backgroundColor=bordColor;
    [pickTopView addSubview:line];
    UIButton *buton=[[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth-50, 0, 40, 40)];
    [buton setTitle:@"完成" forState:UIControlStateNormal];
    [buton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [buton addTarget:self action:@selector(accomplishBtn) forControlEvents:UIControlEventTouchUpInside];
    [pickTopView addSubview:buton];
    
}

-(void)bindBtn
{
    UITextField *textField1=(UITextField *)[bgView viewWithTag:101];
    cardNumber=textField1.text;
    UITextField *textField2=(UITextField *)[bgView viewWithTag:102];
    bankName=textField2.text;
    UITextField *textField3=(UITextField *)[bgView viewWithTag:103];
    cardName=textField3.text;
    UITextField *textField4=(UITextField *)[bgView viewWithTag:104];
    banklocation=textField4.text;
    UITextField *textField5=(UITextField *)[bgView viewWithTag:105];
    bankBrandName=textField5.text;
    UITextField *textField6=(UITextField *)[bgView viewWithTag:106];
    code=textField6.text;
    if ([cardNumber isEqualToString:@""]) {
        [[LXAlterView sharedMyTools]createTishi:@"请输入银行卡号"];
        return;
    }
    if ([bankName isEqualToString:@""]){
        [[LXAlterView sharedMyTools]createTishi:@"请输入开户银行"];
        return;
 
    }if ([cardName isEqualToString:@""]) {
        [[LXAlterView sharedMyTools]createTishi:@"请输入开户名称"];
        return;
    }if ([banklocation isEqualToString:@""]) {
       [[LXAlterView sharedMyTools]createTishi:@"请输入开户地区"];
        return;
    }if ([bankBrandName isEqualToString:@""]) {
         [[LXAlterView sharedMyTools]createTishi:@"请输入支行名称"];
        return;
    }if ([code isEqualToString:@""]) {
        [[LXAlterView sharedMyTools]createTishi:@"请输入验证码"];
        return;
    }
    NSString *bank_name=[NSString stringWithFormat:@"%@%@",bankName,bankBrandName];
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString *user_id = [LXUserTool sharedUserTool].getUid;
    // user_id = @"33058";
    NSString *bk_id;
    if (dict2[@"id"]) {
     bk_id=dict2[@"id"];
    }else if(!dict2[@"id"]){
        bk_id=@"-1";
    }
    
    NSString *token1 = [token stringByAppendingString:user_id];
    NSDictionary *dict=@{@"member_id":user_id,
                         @"_token":[WXUtil md5:token1],@"group_name":[[LXUserTool alloc] getuserGroup],@"action":@"bind",@"mobile":[LXUserTool sharedUserTool].getPhone,@"sms_code":code,@"city_id":cityId,@"bank_number":cardNumber,@"bank_name":bank_name,@"account_name":cardName,@"bank_id":bk_id};
    DLog(@"%@",dict);
    [self bindWith:modify_bank_card and:dict];
    
}
-(void)btnClick
{
    UITextField *textField1=(UITextField *)[bgView viewWithTag:101];
    cardNumber=textField1.text;
    UITextField *textField2=(UITextField *)[bgView viewWithTag:102];
    bankName=textField2.text;
    UITextField *textField3=(UITextField *)[bgView viewWithTag:103];
    cardName=textField3.text;
    UITextField *textField4=(UITextField *)[bgView viewWithTag:104];
    banklocation=textField4.text;
    UITextField *textField5=(UITextField *)[bgView viewWithTag:105];
    bankBrandName=textField5.text;
    UITextField *textField6=(UITextField *)[bgView viewWithTag:106];
    code=textField6.text;
    if ([cardNumber isEqualToString:@""]) {
        [[LXAlterView sharedMyTools]createTishi:@"请输入银行卡号"];
        return;
    }if (cardNumber.length<16||cardNumber.length>19) {
        [[LXAlterView sharedMyTools]createTishi:@"请输入正确的银行卡账号"];
        return;
    }
    if ([bankName isEqualToString:@""]){
        [[LXAlterView sharedMyTools]createTishi:@"请输入开户银行"];
        return;
        
    }if ([cardName isEqualToString:@""]) {
        [[LXAlterView sharedMyTools]createTishi:@"请输入开户名称"];
        return;
    }if ([banklocation isEqualToString:@""]) {
        [[LXAlterView sharedMyTools]createTishi:@"请输入开户地区"];
        return;
    }if ([bankBrandName isEqualToString:@""]) {
        [[LXAlterView sharedMyTools]createTishi:@"请输入支行名称"];
        return;
    }    
    [self getPhoneNumber];
}



#pragma mark 绑定信息验证
-(void)bindWith:(NSString *)url and:(NSDictionary *)dict
{
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dict[@"flag"]intValue]==1) {
            [[LXAlterView sharedMyTools]createTishi:@"绑定成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
           [[LXAlterView sharedMyTools]createTishi:dict[@"msg"]];
        }
        DLog(@"%@",dict);
         [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
         [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        
    }];
   


}



#pragma mark 获取手机验证码
-(void)getPhoneNumber
{
    [self startTime];
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    DLog(@"%@",[LXUserTool sharedUserTool].getPhone);
   
    NSString *groupName=[[LXUserTool alloc] getuserGroup];
    
    NSDictionary *zxdparameters = @{@"phone":[LXUserTool sharedUserTool].getPhone,@"usergroup":groupName,@"token":@"7a6bd7af36e5db226281a037909fbdfd"};
    
    NSString *str=[[WLSingletonClass defaultWLSingleton]wlDictionaryToJson:zxdparameters];
    NSDictionary *dic=@{@"data":str};
    
    
    [manager POST:ForgetPwdGetPwd parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
       
     NSDictionary *zxdDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [[LXAlterView sharedMyTools]createTishi:zxdDict[@"msg"]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"==========00000000000000=============")
    }];
}
#pragma mark-验证码计时
-(void)startTime{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.testBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [self.testBtn setFrame:CGRectMake(windowContentWidth-10-80, 200+5, 80, 30)];
                self.testBtn.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime;
            if (timeout==60) {
              strTime=[NSString stringWithFormat:@"%d", 60];
            }else{
              strTime = [NSString stringWithFormat:@"%d", seconds];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [self.testBtn setTitle:[NSString stringWithFormat:@"发送验证码(%@秒)",strTime] forState:UIControlStateNormal];
                [self.testBtn setFrame:CGRectMake(windowContentWidth-10-140, 200+5, 140, 30)];
                self.testBtn.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}

-(void)accomplishBtn
{
    NSString *cityName;
    UITextField *textField=(UITextField *)[bgView viewWithTag:104];
    if (strmsg) {
     textField.text=strmsg;
        NSArray *arr=[strmsg componentsSeparatedByString:@"-"];
        cityName=arr[1];
    }else{
    textField.text=@"北京市-北京市-东城区";
        NSArray *arr=[textField.text componentsSeparatedByString:@"-"];
        cityName=arr[1];
    }
    DLog(@"%@",cityName);
    [self getF_cityIdWith:cityName];
    picker.hidden=YES;
    pickTopView.hidden=YES;
}
#pragma --获取银行卡城市ID
-(void)getF_cityIdWith:(NSString *)cityName
{
    //DLog(@"ccccccc--%@",[YXLocationManage shareManager].city);
    NSString *city2;
    NSRange searchRange = [cityName rangeOfString:@"市"];
    if (searchRange.location != NSNotFound) {
        NSString *city1 = [cityName stringByReplacingOccurrencesOfString:@"市" withString:@""];
        city2=city1;
    }
    else
    {
        city2=cityName;
    }
    NSString *regionType;
    
    if ([city2 isEqualToString:@"北京"] || [city2 isEqualToString:@"上海"] || [city2 isEqualToString:@"天津"] || [city2 isEqualToString:@"重庆"] || [city2 isEqualToString:@"香港"]  || [city2 isEqualToString:@"澳门"] || [city2 isEqualToString:@"台湾"] )
    {
        regionType=@"2";
    }
    else
    {
        regionType=@"3";
    }
    
    
    NSDictionary *dic;
    if (city2!=nil && regionType!=nil)
    {
        dic=@{@"region_name":city2,@"region_type":regionType};
        NSString *url=GetCityIDUrl;
       [self sendRequest:dic aurl:url];
    }
    

}
#pragma --获取银行卡城市ID
-(void)sendRequest:(NSDictionary *)dic aurl:(NSString *)url
{
   
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        DLog(@"%@",dict);
        if ([dict[@"status"]intValue]==1) {
            NSArray *arr=dict[@"data"];
            NSDictionary *dic2=arr[0];
            cityId=dic2[@"region_id"];
        }else{
            return;
        }
        
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
        
       
    }];
    
}
//实时监测到编辑情况
-(void)valueChanged:(UITextField *)textField
{
    switch (textField.tag) {
        case 101:
        {
            NSString *str;
            if (textField.text.length>10) {
               str=[textField.text substringToIndex:6];
            }else{
                str=textField.text;
            }
            if (str.length>=6) {
                NSString *token = @"~0;id<zOD.{ll@]JKi(:";
                NSString * memberId =[[WLSingletonClass defaultWLSingleton] wlUserID];
                NSString *token1 = [token stringByAppendingString:memberId];
                NSString *groupName=[[LXUserTool alloc] getuserGroup];
               
                NSDictionary *dict=@{@"card_number":str,@"_token":[WXUtil md5:token1],@"member_id":memberId,@"group_name":groupName};
                
                if (isReturn==NO) {
                  [self getBankCardWith:get_bank_by_card_Url and:dict];
                }else if(isReturn==YES)
                {
                    return;
                }
            }else if(str.length<6){
                isReturn=NO;
            }
        }
            break;
        default:
            break;
        
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag==104) {
    UITextField *textField1=(UITextField *)[bgView viewWithTag:101];
    [textField1 resignFirstResponder];
    UITextField *textField2=(UITextField *)[bgView viewWithTag:102];
    [textField2 resignFirstResponder];
    UITextField *textField3=(UITextField *)[bgView viewWithTag:103];
    [textField3 resignFirstResponder];
    UITextField *textField5=(UITextField *)[bgView viewWithTag:105];
    [textField5 resignFirstResponder];
    UITextField *textField6=(UITextField *)[bgView viewWithTag:106];
    [textField6 resignFirstResponder];
    pickTopView.hidden=NO;
    picker.hidden=NO;
    //这里returnNo，代表 不让textfield返回值 ，只让在pickerView里面选择
    return NO;
    }else if (textField.tag==105)
    {
        AddBankNameVC *vc=[[AddBankNameVC alloc]init];
        UITextField *textField=(UITextField *)[bgView viewWithTag:105];
        vc.block=^(NSString *str){
        textField.text=str;
        textField.adjustsFontSizeToFitWidth=YES;
        
        };
        vc.text=textField.text;
        
        [self.navigationController pushViewController:vc animated:YES];
        
 
    }
    return YES;
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
#pragma mark 获取银行卡信息的请求
-(void)getBankCardWith:(NSString *)url and:(NSDictionary *)dict
{
  
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         DLog(@"%@",dict);
        if ([dict[@"flag"]intValue]==2) {
            
            NSArray *arr=dict[@"data"];
            dict2=arr[0];
            UITextField *textField=(UITextField *)[bgView viewWithTag:102];
            textField.text=[NSString stringWithFormat:@"%@",dict2[@"bank"]];
            DLog(@"%@",dict2[@"id"]);
            isReturn=YES;
        }else{
            [[LXAlterView sharedMyTools]createTishi:dict[@"msg"]];
        }
        
      
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
       
       
    }];


}
//- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
//{
//    CGRect rect = [string boundingRectWithSize:CGSizeMake(windowContentWidth - 110, 8000)//限制最大的宽度和高度
//                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
//                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
//                                       context:nil];
//    
//    return rect.size;
//}

#pragma mark--UIPickerViewDataSource
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//}


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
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: [NSString stringWithFormat:@"%ld", (long)row]]];
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
        NSString *provinceIndex = [NSString stringWithFormat: @"%ld", (unsigned long)[province indexOfObject: selectedProvince]];
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
    strmsg = [NSString stringWithFormat:@"%@-%@-%@",selectedProvince,[city objectAtIndex:zxdselectedIndex],[district objectAtIndex:zxdselectedIndex2]];
    //[button4 setTitle:strmsg forState:UIControlStateNormal];
   // label.text = strmsg;
    
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return 100;
    }
    else if (component == CITY_COMPONENT) {
        return 100;
    }
    else {
        return 100;
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
-(void)dealloc{
    [XCLoadMsg removeLoadMsg:self];
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

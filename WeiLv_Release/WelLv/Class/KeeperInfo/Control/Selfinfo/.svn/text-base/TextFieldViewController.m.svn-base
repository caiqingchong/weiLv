//
//  TextFieldViewController.m
//  WelLv
//
//  Created by mac for csh on 15/7/15.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "TextFieldViewController.h"

@interface TextFieldViewController ()<UITextFieldDelegate>{
    NSMutableDictionary *infoDivtionary;
    UITextField *_textField;
    NSString *key;
    NSDictionary *infodic;
}

@end

@implementation TextFieldViewController
@synthesize textt;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BgViewColor;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(conserve)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];

    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 20, windowContentWidth, 45)];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.placeholder = @"请输入";
    _textField.text = textt;
    
    _textField.textAlignment = NSTextAlignmentCenter;
    [_textField setTintColor:[UIColor blackColor]];
    _textField.font = [UIFont systemFontOfSize:17];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.delegate= self;
    [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_textField];

    
    //取本地数据
    infoDivtionary =[[NSMutableDictionary alloc]init];
    infoDivtionary =  [[[NSUserDefaults standardUserDefaults] objectForKey:AssitantData] mutableCopy];
    NSLog(@"indictionary is %@",infoDivtionary);
    
    key = @"";
    if ([self.title isEqualToString:@"修改籍贯"]) {
        key = @"native_place";
        _textField.tag = 1;
    }else if ([self.title isEqualToString:@"修改QQ"]){
        key = @"qq";
        _textField.tag = 2;
    }else if ([self.title isEqualToString:@"修改邮箱"]){
        key = @"email";
        _textField.tag = 3;
    }else if ([self.title isEqualToString:@"修改职业"]){
        key = @"occupation";
        _textField.tag = 4;
    }else if ([self.title isEqualToString:@"修改居住地"]){
        key = @"region_id";// 从region取值  但是修改的是region_id
        _textField.tag = 5;
    }
    
    infodic = [[NSDictionary alloc] init];
    
    if (_textField.tag == 5) {
        UILabel *tsm2Label = [[UILabel alloc] initWithFrame:CGRectMake(15, 20+45+15, [[UIScreen mainScreen] bounds].size.width-30, 30)];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"提示：居住地只需输入城市名即可"];
        tsm2Label.font = [UIFont systemFontOfSize:12];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,[str length]-10)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange([str length]-12,12)];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Courier-BoldOblique" size:14] range:NSMakeRange([str length]-12,12)];
        tsm2Label.attributedText = str;
        tsm2Label.backgroundColor = [UIColor clearColor];
        tsm2Label.textAlignment = NSTextAlignmentLeft;
        tsm2Label.numberOfLines = 0;
        [self.view addSubview: tsm2Label];
    }
    
//    if ([infoDivtionary objectForKey:key] && ![[infoDivtionary objectForKey:key]isEqual:[NSNull null]] && ![[infoDivtionary objectForKey:key] isEqualToString:@"(null)"]) {
//        _textField.text = [infoDivtionary objectForKey:key];
//    }
   
}

-(void)conserve{
    //NSInteger Index= _textField.tag;
    switch (_textField.tag) {
        case 1:
            if ([_textField.text isEqualToString:@""] || _textField.text == nil) {
                [[LXAlterView sharedMyTools] createTishi:@"请输入籍贯"];
            }else{
            infodic =  @{key:_textField.text};
            [self loadAndSet];
            }
            break;
        case 2:{
            NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:@"^[0-9]*$" options:0 error:nil];
            NSTextCheckingResult *result2 = [regex2 firstMatchInString:_textField.text options:0 range:NSMakeRange(0, [_textField.text length])];
            if (!result2 || [_textField.text isEqualToString: @""]|| _textField.text == nil) {
                [[LXAlterView alloc]createTishi:@"请输入正确的qq号码"];
            }else{
                infodic =  @{key:_textField.text};
                [self loadAndSet];
            }
        }
            break;
        case 3:{
            BOOL EmailType = [self isValidateEmail:_textField.text];
            if (EmailType == 0) {
                [[LXAlterView sharedMyTools] createTishi:@"邮箱格式不正确"];
            }else{
            infodic =  @{key:_textField.text};
                [self loadAndSet];
            }
        }
            break;
        case 4:
            if ([_textField.text isEqualToString:@""] || _textField.text == nil) {
                [[LXAlterView sharedMyTools] createTishi:@"请输入职业"];
            }else{
            infodic =  @{key:_textField.text};
            [self loadAndSet];
            }
            break;
        case 5:
            if ([_textField.text isEqualToString:@""] || _textField.text == nil) {
                [[LXAlterView sharedMyTools] createTishi:@"请输入居住地城市"];
            }else{
            //获取城市regin_ID
            [self getReginID];
            }
            break;
        default:
            break;
    }

}

//检测邮箱格式
-(BOOL)isValidateEmail:(NSString *)email

{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}
    

-(void)getReginID{
    //chengshi当前城市名转化成region_id
    NSString *city = @"";
    NSRange searchRange = [_textField.text rangeOfString:@"市"];
    if (searchRange.location != NSNotFound) {
        NSString *city1 = [_textField.text stringByReplacingOccurrencesOfString:@"市" withString:@""];
        city=city1;
    }
    else
    {
        city=_textField.text;
    }
    
    NSString *regionType;
    regionType=@"3";
    NSDictionary *dic;
    if (!city.length == 0 && regionType!=nil)
    {
        dic=@{@"region_name":city,@"region_type":regionType};
    }else
    {
        dic=@{@"region_name":@"北京",@"region_type":@"3"};
    }
    
    NSString *url=[NSString stringWithFormat:@"%@/api/route/region",WLHTTP];
    //@"https://www.weilv100.com/api/route/region";
    __block NSString *city_regionID=nil;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dic
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              if ([[dic objectForKey:@"status"] integerValue]==1)
              {
                  NSArray *array=[dic objectForKey:@"data"];
                  NSDictionary *dict1=[[NSDictionary alloc] init];
                  dict1=[array objectAtIndex:0];
                  city_regionID=[dict1 objectForKey:@"region_id"];
                  NSLog(@"%@ is City_regionID = %@",_textField.text,city_regionID);
                  infodic = @{key:city_regionID};
                  [self loadAndSet];
              }else{
                  [[LXAlterView sharedMyTools] createTishi:@"请输入正确城市名"];
              }
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
              
          }];

}

-(void)loadAndSet{
    //1、上传服务器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   // NSDictionary *infodic = @{key:_textField.text};
    
    NSDictionary *parameters = @{@"assistant_id":[infoDivtionary objectForKey:@"id"],@"data":[self dictionaryToJson:infodic]};
    [manager POST:GJManageSelfInfoUrl parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
              if([[dict objectForKey:@"status"]integerValue] == 1){
                  [[LXAlterView sharedMyTools] createTishi:@"操作成功"];
                  // 2、cun 村本地
                  [infoDivtionary setValue:_textField.text forKey:key];
                  if (_textField.tag ==5) {
                      [infoDivtionary setValue:_textField.text forKey:@"region"];
                      [infoDivtionary setValue: [infodic objectForKey:key] forKey:key];
                  }
                  [[NSUserDefaults standardUserDefaults] setObject:infoDivtionary forKey:AssitantData];
                  //3、修改成功返回上个页面
                  [self.navigationController popViewControllerAnimated:YES];
              }
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
            [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
          }];

}

//字典数据转Json
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

     
//手势keybooardMIss
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_textField resignFirstResponder];
}


- (void)textFieldDidChange:(UITextField *)textField
{
   
    {
        if (_textField.text.length >20) {
            
            _textField.text = [textField.text substringToIndex:20];
            [[LXAlterView sharedMyTools]createTishi:@"最多输入20个字"];
        }
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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

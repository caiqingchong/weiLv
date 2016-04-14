//
//  changeAdressViewController.m
//  WelLv
//
//  Created by mac for csh on 15/4/15.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "changeAdressViewController.h"
#import "PersonalViewController.h"
#import "AFNetworking.h"
#import "LXUserTool.h"

#define FirstComponent 0
#define SubComponent 1
#define ThirdComponent 2

@interface changeAdressViewController ()
{
    UILabel *placeLabel;
}
@property(nonatomic,retain)NSDictionary* dict;
@property(nonatomic,retain)NSArray* pickerArray;
@property(nonatomic,retain)NSArray* subPickerArray;
@property(nonatomic,retain)NSArray* thirdPickerArray;
@property(nonatomic,retain)NSArray* selectArray;
@property(nonatomic,retain)UIPickerView *piker;

@property (nonatomic, assign) NSInteger choooseRow;
@end

@implementation changeAdressViewController
@synthesize dict=_dict;
@synthesize pickerArray=_pickerArray;
@synthesize subPickerArray=_subPickerArray;
@synthesize thirdPickerArray=_thirdPickerArray;
@synthesize selectArray=_selectArray;
@synthesize piker = _piker;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BgViewColor;
    [self.navigationItem setTitle:@"修改地址"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(conserve)];
    self.navigationItem.rightBarButtonItem.tintColor =  kColor(255, 165, 98);
    
    
    UILabel *addressLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, [[UIScreen mainScreen] bounds].size.width, 44)];
    addressLbl.text = @"省、市、县(区)";
    addressLbl.backgroundColor = [UIColor whiteColor];
    addressLbl.textAlignment = NSTextAlignmentLeft;
    addressLbl.font = [UIFont systemFontOfSize:17];
    [self.view addSubview: addressLbl];
    UIView *vieww = [[UIView alloc] initWithFrame:CGRectMake(0, 44, [[UIScreen mainScreen] bounds].size.width, 0.35)];
    vieww.backgroundColor = [UIColor lightGrayColor];
    [addressLbl addSubview:vieww];
    
    
    UILabel *detailAddressLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 20+45, [[UIScreen mainScreen] bounds].size.width, 80)];
    detailAddressLbl.text = @"详细地址";
    detailAddressLbl.backgroundColor = [UIColor whiteColor];
    detailAddressLbl.textAlignment = NSTextAlignmentLeft;
    detailAddressLbl.font = [UIFont systemFontOfSize:17];
    [self.view addSubview: detailAddressLbl];
    
    btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame=CGRectMake( 115, 20, [[UIScreen mainScreen] bounds].size.width-115, 44);
    [btn1 setTitle:@"请选择" forState:UIControlStateNormal];
    //  [btn1 setTitle:string1 forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor clearColor]];
    [btn1 addTarget:self action:@selector(loadpicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    UIImageView *IGV = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(btn1)-45 , 7.5, 45, 30)];
    [IGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    [btn1 addSubview:IGV];
    
    
    repPwdTextFild = [[UITextView alloc ]initWithFrame:CGRectMake(80, 20+45, [[UIScreen mainScreen] bounds].size.width-80, 80)];
//    placeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width-80, 20)];
//    placeLabel.text=@"请输入详细地址";
//    placeLabel.textColor=[UIColor grayColor];
//    [repPwdTextFild addSubview:placeLabel];
    repPwdTextFild.font=systemFont(18);
    
    //[repPwdTextFild addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //[repPwdTextFild setFrame:CGRectMake(80, 65, windowContentWidth-80, size.height)];
    //   repPwdTextFild.text = string;
    
    //repPwdTextFild.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:repPwdTextFild];repPwdTextFild.delegate = self;
    
    //    if ([[LXUserTool alloc] getAddress] && ![[[LXUserTool alloc] getAddress]isEqual:[NSNull null]]) {
    //        NSString *string = [[LXUserTool alloc] getAddress];
    //        for (int i = 0; i < 3; i ++) {
    //            NSRange range = [string rangeOfString:@" "];//匹配得到的下标
    //            NSLog(@"rang.location:%ld",(long)range.location);
    //            string = [string substringFromIndex:range.location+1];//截取范围类的字符串
    //            NSLog(@"截取的值为：%@",string);
    //            if (string.length > 1) {
    //                continue;
    //            }else{
    //                break;
    //            }
    //        }
    //        NSString *string1 = [[[LXUserTool alloc] getAddress] substringToIndex:[[[LXUserTool alloc] getAddress] length] -string.length-1];
    //        NSLog(@"%@",string1);
    //    }
    
    
    NSString *adressStr = [[LXUserTool alloc] getAddress];
    if ([self judgeString:adressStr] == YES) {
        for (int i = 0; i < 3; i ++) {
            NSRange range = [adressStr rangeOfString:@" "];//匹配得到的下标
            NSLog(@"rang.location:%ld",(long)range.location);
            NSString *string = [adressStr substringToIndex:range.location];//截取范围类的字符串
            adressStr = [adressStr substringFromIndex:range.location+1];
            NSLog(@"截取的值为：string=%@,\nadressStr=%@.",string,adressStr);
            if (string.length > 1) {
                if (i == 0) {
                    seletedProvince = string;
                }else if (i == 1) {
                    seletedCity = string;
                }else if (i == 2) {
                    seletedp = string;
                    
                    repPwdTextFild.text = [self judgeReturnString:adressStr withReplaceString:@""];
                    if (repPwdTextFild.text) {
                        placeLabel.hidden=YES;
 
                    }
                   
                    [btn1 setTitle:[NSString stringWithFormat:@"%@ %@ %@ ", seletedProvince,seletedCity,seletedp] forState:UIControlStateNormal];
                }
                
                continue;
            }else{
                break;
            }
        }
        
    }
    
    
    
    //load pickr
    _piker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-200-80, [[UIScreen mainScreen] bounds].size.width, 220)];
    _piker.delegate = self;
    seletedProvince = [self.pickerArray objectAtIndex:0];
    _piker.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_piker];
    //
    // NSString* plistPath=[[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    // _dict=[[NSDictionary alloc] initWithContentsOfFile:plistPath];
    //  NSLog(@"xxxxxxxaaaaa = %@",_dict);
    NSString *sortpath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
    // NSArray *sortarray = [[NSArray alloc] initWithContentsOfFile:sortpath];
    _dict = [[NSDictionary alloc] initWithContentsOfFile:sortpath];
    NSArray *components = [_dict allKeys];
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
    for (int i=0; i<[sortedArray count]; i++) {
        NSString *index = [sortedArray objectAtIndex:i];
        NSArray *tmp = [[_dict objectForKey: index] allKeys];
        [provinceTmp addObject: [tmp objectAtIndex:0]];
    }
    
    self.pickerArray=provinceTmp;//NSLog(@"%@",self.pickerArray);
    NSString *index = [sortedArray objectAtIndex:0];
    NSString *selected = [self.pickerArray objectAtIndex:0];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [[_dict objectForKey:index]objectForKey:selected]];
    
    NSArray *cityArray = [dic allKeys];
    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [cityArray objectAtIndex:0]]];
    self.subPickerArray = [[NSArray alloc] initWithArray: [cityDic allKeys]];
    
    
    NSString *selectedCity = [self.subPickerArray objectAtIndex: 0];
    self.thirdPickerArray = [[NSArray alloc] initWithArray: [cityDic objectForKey: selectedCity]];
    
    /* self.selectArray=[_dict objectForKey:[self.pickerArray objectAtIndex:0]];
     if ([_selectArray count]>0) {
     self.subPickerArray= [[self.selectArray objectAtIndex:0] allKeys];
     }
     if ([_subPickerArray count]>0) {
     self.thirdPickerArray=[[self.selectArray objectAtIndex:0] objectForKey:[self.subPickerArray objectAtIndex:0]];
     }*/
    _piker.hidden = YES;
    
    
    btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake([[UIScreen mainScreen] bounds].size.width-20-40, [[UIScreen mainScreen] bounds].size.height-200-25-50, 40, 25);
    [btn2 setTitle:@"确定" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor clearColor]];
    [btn2 addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    btn2.hidden = YES;
    
    
    //touch miss kyboard
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getBack{
    [self.navigationController popViewControllerAnimated:YES];
}

//保存
-(void)conserve{
    if (![btn1.titleLabel.text isEqualToString:@"请选择"]) {
        
        NSString * str = [btn1.titleLabel.text stringByAppendingString:repPwdTextFild.text];
        
        //上传服务器
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        NSDictionary *parameters = @{@"uid":[[LXUserTool alloc] getUid],@"address":str,@"province":[self judgeReturnString:seletedProvince withReplaceString:@""],@"city":[self judgeReturnString:seletedCity withReplaceString:@""],@"country":[self judgeReturnString:seletedp withReplaceString:@""]};
        
        [manager POST:UpdateUserInfo parameters:parameters
         
              success:^(AFHTTPRequestOperation *operation,id responseObject) {
                  NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
                  [settings setObject:str forKey:@"address"];
                  [settings setObject:seletedProvince forKey:@"province"];
                  [settings setObject:seletedCity forKey:@"city"];
                  [settings setObject:seletedp forKey:@"country"];
                  [[LXAlterView alloc] createTishi:@"修改成功"];
                  [self.navigationController popViewControllerAnimated:YES];
                  
              }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                  
                  NSLog(@"Error: %@", error);
                  
              }];
        
        
        /*
         NSDictionary *parameters1 = @{@"uid":[[LXUserTool alloc] getUid],@"province":seletedProvince,@"city":seletedCity,@"country":seletedp};
         
         [manager POST:UpdateUserInfo parameters:parameters1
         
         success:^(AFHTTPRequestOperation *operation,id responseObject) {
         
         NSLog(@"xxxxxxx = %@",responseObject);
         //  NSLog(@"Success: %@", [[responseObject objectForKey:@"msg"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
         
         }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
         
         NSLog(@"Error: %@", error);
         
         }];*/
    }else{
        [[LXAlterView sharedMyTools] createTishi:@"请选择城市"];
    }
    
    
    
}

-(void)loadpicker{
    _piker.hidden = NO;
    btn2.hidden = NO;
}

-(void)setting{
    _piker.hidden = YES;
    btn2.hidden = YES;
}

#pragma mark --
#pragma mark--UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==FirstComponent) {
        return [self.pickerArray count];
    }
    if (component==SubComponent) {
        return [self.subPickerArray count];
    }
    if (component==ThirdComponent) {
        return [self.thirdPickerArray count];
    }
    return 0;
}


#pragma mark--
#pragma mark--UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==FirstComponent) {
        return [self.pickerArray objectAtIndex:row];
    }
    if (component==SubComponent) {
        return [self.subPickerArray objectAtIndex:row];
    }
    if (component==ThirdComponent) {
        return [self.thirdPickerArray objectAtIndex:row];
    }
    return nil;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    self.choooseRow = row;
    seletedProvince = [self.pickerArray objectAtIndex:self.choooseRow];
    if (component==0) {
        
      
        
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [_dict objectForKey: [NSString stringWithFormat:@"%ld", row]]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: [self.pickerArray objectAtIndex:row]]];
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
        self.subPickerArray = array;
        
        NSDictionary *cityDic = [dic objectForKey: [sortedArray objectAtIndex: 0]];
        self.thirdPickerArray = [[NSArray alloc] initWithArray: [cityDic objectForKey: [self.subPickerArray objectAtIndex: 0]]];
        
        
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        
        
    }
    if (component==1) {
        NSLog(@"%@",seletedProvince);
        NSString *provinceIndex = [NSString stringWithFormat: @"%ld", [self.pickerArray indexOfObject: seletedProvince]];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [_dict objectForKey: provinceIndex]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: seletedProvince]];
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
        self.thirdPickerArray = [cityDic objectForKey: [cityKeyArray objectAtIndex:0]];
        
        [pickerView reloadComponent:2];
        
        
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    [pickerView reloadComponent:2];
    
    
    
    seletedProvince = [self.pickerArray objectAtIndex:self.choooseRow];
    NSInteger selectedCityIndex = [self.piker selectedRowInComponent:1];
    seletedCity = [_subPickerArray objectAtIndex:selectedCityIndex];
    NSInteger selectedIndex = [self.piker selectedRowInComponent:2];
    seletedp = [_thirdPickerArray objectAtIndex:selectedIndex];
    
    NSString *msg = [NSString stringWithFormat:@"%@ %@ %@ ", seletedProvince,seletedCity,seletedp];
    [btn1 setTitle:msg forState:UIControlStateNormal];
    
    
}



- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component==FirstComponent) {
        return 90.0;
    }
    if (component==SubComponent) {
        return 120.0;
    }
    if (component==ThirdComponent) {
        return 100.0;
    }
    return 0;
}

//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    if (textField.text.length > 30)
//    {
//        [[LXAlterView sharedMyTools]createTishi:@"最多输入25个字"];
//        repPwdTextFild.text = [textField.text substringToIndex:25];
//    }
//    
//}
-(void)textViewDidChange:(UITextView *)textView
{
   // placeLabel.hidden=YES;
    {
        if (repPwdTextFild.text.length > 25) {
            
            repPwdTextFild.text = [textView.text substringToIndex:25];
            [[LXAlterView sharedMyTools]createTishi:@"最多输入25个字"];
        }
    }

}

//- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
//{
//    CGRect rect = [string boundingRectWithSize:CGSizeMake(windowContentWidth - 100, 8000)//限制最大的宽度和高度
//                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
//                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
//                                       context:nil];
//    
//    return rect.size;
//}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [repPwdTextFild resignFirstResponder];
    
    
    
    return YES;

}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [repPwdTextFild resignFirstResponder];
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

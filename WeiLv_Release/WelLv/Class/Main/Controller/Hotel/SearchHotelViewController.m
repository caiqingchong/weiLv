//
//  SearchHotelViewController.m
//  WelLv
//
//  Created by mac for csh on 15/9/23.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#define beginx 20.0f
#import "SearchHotelViewController.h"
#import "LXPlaneCalendarViewController.h"
#import "ZFJChooseDateView.h"
#import "JYCTools.h"
#import "LXTools.h"
#import "HotelHotCountyViewController.h"
#import "ZFJHotelListVC.h"
#import "HotelStarPriceControl.h"
@interface SearchHotelViewController ()
{
    UILabel *positionLab;
    NSString *enterdate;
    NSString *leavedate;
    BOOL flag;
}

@end

@implementation SearchHotelViewController
@synthesize locationManager,enterTimeLab,leaveTimeLab,daysLab,hotelTextField,Pricebutton;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"酒店"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    enterdate = @""; //入店日期
    leavedate = @""; //离电日期
    
    flag=true; //判断入店日期与离店日期选中是否符合规则
    
    [self initView];
}

-(void)initView{
    [self initFirstCell];
    [self initSecondCell];
    [self initThirdCell];
    [self initForthCell];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(beginx, 45+90+45+45+60, windowContentWidth-beginx*2,45);
    searchBtn.backgroundColor = kColor(55, 250, 162);
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    [searchBtn setTitle:@"查询" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter ;
    [searchBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.layer.cornerRadius = 5;
    [self.view addSubview:searchBtn];

}
-(void)search{
   //搜索 跳转列表页
    ZFJHotelListVC *vc = [[ZFJHotelListVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)initFirstCell{
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 0, windowContentWidth -beginx - 80, 45);
    button1.backgroundColor = [UIColor whiteColor];
    [button1 addTarget:self action:@selector(JumpToCountyList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake( ViewWidth(button1), 0, windowContentWidth - ViewWidth(button1),button1.frame.size.height);
    button2.backgroundColor = [UIColor clearColor];
    [button2 addTarget:self action:@selector(GetCurrentPosition) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UILabel *posLab = [[UILabel alloc] initWithFrame:CGRectMake(beginx, 0, 80, button1.frame.size.height)];
    posLab.text = @"位置";
    posLab.textAlignment = NSTextAlignmentLeft;
    posLab.textColor = [UIColor grayColor];
    posLab.font = [UIFont systemFontOfSize:16];
    [button1 addSubview:posLab];
    
    positionLab = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(posLab)+ViewWidth(posLab), 0, ViewWidth(button1)-15-15-15, button1.frame.size.height)];
    positionLab.textColor = [UIColor blackColor];
    positionLab.text = @"北京";
    positionLab.font = [UIFont systemFontOfSize:19];
    [button1 addSubview:positionLab];
    
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(button1)- 45, button1.frame.size.height/2-30/2, 45, 30)];
    [image2 setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    image2.userInteractionEnabled = NO;
    [button1 addSubview:image2];
    
    UIImageView *image3 = [[UIImageView alloc] initWithFrame:CGRectMake(80/2-14/2, 5, 14, 20)];
    [image3 setImage:[UIImage imageNamed:@"location"]];
    image3.userInteractionEnabled = NO;
    [button2 addSubview:image3];
    
    UILabel *myposLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 25+2.5, 80, 15)];
    myposLab.text = @"我的位置";
    myposLab.textAlignment = NSTextAlignmentCenter;
    myposLab.textColor = [UIColor grayColor];
    myposLab.font = [UIFont systemFontOfSize:12];
    [button2 addSubview:myposLab];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , 0.5, ViewHeight(button2))];
    line.backgroundColor = bordColor;
    line.alpha = 0.8;
    [button2 addSubview:line];

    UIImageView *imagev4 = [[UIImageView alloc] initWithFrame:CGRectMake(beginx, ViewHeight(button2)-0.5, windowContentWidth-beginx*2, 0.5)];
    imagev4.backgroundColor = bordColor;
    [self.view addSubview:imagev4];

}

-(void)GetCurrentPosition{
    [self locate];
}

-(void)JumpToCountyList{
    HotelHotCountyViewController *HotCounty = [[HotelHotCountyViewController alloc] init];
    HotCounty.hotelString = positionLab.text;
    HotCounty.delegate = self;
    [self.navigationController pushViewController:HotCounty animated:YES];
}

//代理方法
-(void)changeCountyTxt:(NSString *)astr{
    positionLab.text = astr;
}

#pragma mark - 定位和CoreLocation Delegate
- (void)locate
{
    if(!self.locationManager){
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 1000.0f;
    }
    
    if([CLLocationManager locationServicesEnabled]) {
        if ([[[UIDevice currentDevice] systemVersion] doubleValue] > 8.0)
        {
            [self.locationManager requestWhenInUseAuthorization];// 前台定位
            [self.locationManager requestAlwaysAuthorization];// 前后台同时定位
        }
        [self.locationManager startUpdatingLocation];
    }else {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  @"提示" message:@"定位不成功 ,请确认开启定位" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    NSLog(@"%@",currentLocation);
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             /*NSLog(@"%@",placemark.name);//中国河南省郑州市金水区未来路街道金水路
             NSLog(@"%@",placemark.thoroughfare);//金水路
             NSLog(@"%@",placemark.subThoroughfare);//(null)
             NSLog(@"%@",placemark.locality);//郑州市                     市
             NSLog(@"%@",placemark.subLocality);//金水区                  市的下一级
             NSLog(@"%@",placemark.subAdministrativeArea);//(null)       直辖市
             NSLog(@"%@",placemark.postalCode);//(null)
             NSLog(@"%@",placemark.ISOcountryCode);//CN
             NSLog(@"%@",placemark.country);//中国
             NSLog(@"%@",placemark.inlandWater);//(null)
             NSLog(@"%@",placemark.ocean);//(null)
             NSLog(@"%@",placemark.areasOfInterest);//(null)*/
             
             NSString *city = placemark.locality;
             if (!city) {
                 city = placemark.administrativeArea;
             }
             city = [city stringByAppendingString:placemark.thoroughfare];
             positionLab.text = city;
         }
         else if (error == nil && [array count] == 0)
         {
             NSLog(@"No results were returned.");
         }
         else if (error != nil)
         {
             NSLog(@"An error occurred = %@", error);
         }
     }];
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (error.code == kCLErrorDenied) {
    }
}

-(void)initSecondCell{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 45, windowContentWidth,90);
    button.backgroundColor = [UIColor clearColor];
   // [button addTarget:self action:@selector(ClickCalendar:) forControlEvents:UIControlEventTouchUpInside];
   // button.userInteractionEnabled = NO;
    button.tag = 100;
    [self.view addSubview:button];

    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(beginx, 10, 80, 30)];
    label1.text = @"入店日期";
    label1.textColor = [UIColor grayColor];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.font = [UIFont systemFontOfSize:16];
    [button addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(beginx, ViewHeight(button)-10-30, 80, 30)];
    label2.text = @"离店日期";
    label2.textColor = [UIColor grayColor];
    label2.textAlignment = NSTextAlignmentLeft;
    label2.font = [UIFont systemFontOfSize:16];
    [button addSubview:label2];
  
    NSDate * senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MM月dd日"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    NSDateFormatter *dateformatter1 =[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    enterdate = [dateformatter1 stringFromDate:senddate];
    leavedate = [self GetTomorrowDay:senddate atag:2];
    enterTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(label1)+ViewWidth(label1), 10, windowContentWidth -20 -80 -ViewX(label1)-ViewWidth(label1), (ViewHeight(button)-30)/2)];
    enterTimeLab.textColor = [UIColor blackColor];
    enterTimeLab.textAlignment = NSTextAlignmentLeft;
    enterTimeLab.text = locationString;
    enterTimeLab.font = [UIFont systemFontOfSize:19];
    [button addSubview:enterTimeLab];

    leaveTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(label1)+ViewWidth(label1), 50, windowContentWidth -20 -80 -ViewX(label1)-ViewWidth(label1), (ViewHeight(button)-30)/2)];
    leaveTimeLab.textColor = [UIColor blackColor];
    leaveTimeLab.textAlignment = NSTextAlignmentLeft;
    leaveTimeLab.text = [self GetTomorrowDay:senddate atag:1];
    leaveTimeLab.font = [UIFont systemFontOfSize:19];
    [button addSubview:leaveTimeLab];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = enterTimeLab.frame;
    button1.backgroundColor = [UIColor clearColor];
    button1.tag = 101;
    [button1 addTarget:self action:@selector(ClickCalendar:) forControlEvents:UIControlEventTouchUpInside];
    [button addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = leaveTimeLab.frame;;
    button2.backgroundColor = [UIColor clearColor];
    button2.tag = 102;
    [button2 addTarget:self action:@selector(ClickCalendar:) forControlEvents:UIControlEventTouchUpInside];
    [button addSubview:button2];

    daysLab= [[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth - beginx - 80, ViewHeight(button)/2- 40/2, windowContentWidth -20 -ViewX(leaveTimeLab)-ViewWidth(leaveTimeLab), 40)];
    daysLab.textColor = [UIColor blackColor];
    daysLab.text = @"1晚";
    daysLab.font = [UIFont systemFontOfSize:19];
    [button addSubview:daysLab];
    
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(button)-20-45+15, button.frame.size.height/2-30/2, 45, 30)];
    [image2 setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    image2.userInteractionEnabled = NO;
    [button addSubview:image2];
    
   UIImageView *imagev4 = [[UIImageView alloc] initWithFrame:CGRectMake(beginx,ViewY(button)+ViewHeight(button)-0.5, windowContentWidth-beginx*2, 0.5)];
    imagev4.backgroundColor = bordColor;
    [self.view addSubview:imagev4];

}

//获取明天日期
-(NSString *)GetTomorrowDay:(NSDate *)aDate atag:(int)aTag
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:aDate];
    [components setDay:([components day]+1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init] ;

    if (aTag == 1) {
        [dateday setDateFormat:@"MM月dd日"];
    }else if (aTag ==2){
        [dateday setDateFormat:@"yyyy-MM-dd"];
    }
    return [dateday stringFromDate:beginningOfWeek];
}

-(void)ClickCalendar:(UIButton *)btn{
 
    if (btn.tag == 101) {
        LXPlaneCalendarViewController *lxplaneCal=[[LXPlaneCalendarViewController alloc] init];
        [lxplaneCal setTrainToDay:365 ToDateforString:nil price:100];
        lxplaneCal.calendarblock= ^ (CalendarDayModel *model){
            NSString *date=[model toString];
            [self updateDate:date WithTag:1];
            if (flag) {
                date = [self datestrToDataStr:date];
                enterTimeLab.text = date;
            }
            
        };
        lxplaneCal.title = @"选择入店日期";
        [self.navigationController pushViewController:lxplaneCal animated:YES];
    }else if (btn.tag == 102){
        LXPlaneCalendarViewController *lxplaneCal=[[LXPlaneCalendarViewController alloc] init];
        [lxplaneCal setTrainToDay:365 ToDateforString:nil price:100];
        lxplaneCal.calendarblock= ^ (CalendarDayModel *model){
            NSString *date=[model toString];
            [self updateDate:date WithTag:2];
            if (flag) {
                date = [self datestrToDataStr:date];
                leaveTimeLab.text = date;
            }
        };
        lxplaneCal.title = @"选择离店日期";
        [self.navigationController pushViewController:lxplaneCal animated:YES];
    }
}

-(NSString *)datestrToDataStr:(NSString*)string{
   NSString* str = [string substringWithRange:NSMakeRange(5, 5)];
   str =[str stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
    str = [str stringByAppendingString:@"日"];
    return str;
}

-(void)updateDate:(NSString *)string WithTag:(int )index{
    if (index == 1) {
        enterdate = string;
        if (![leavedate isEqualToString:@""]) {
            //判断入店日期与离店日期之间的差值是否为负值或零
            if ([[LXTools getDateGap:enterdate toDate:leavedate] intValue]>0)
            {
                flag=true;
                daysLab.text = [NSString stringWithFormat:@"%@晚",[LXTools getDateGap:enterdate toDate:leavedate]];
          
            }
            else
            {
                 [[LXAlterView sharedMyTools]createTishi:@"入店日期不能大于离店日期"];
                flag=false;
            }
            
        }
    }else if(index == 2){
        leavedate = string;
        if (![enterdate isEqualToString:@""]) {
            
            if ([[LXTools getDateGap:enterdate toDate:leavedate] intValue]>0)
            {
                flag=true;
              daysLab.text = [NSString stringWithFormat:@"%@晚",[LXTools getDateGap:enterdate toDate:leavedate]];
            }
            else
            {
                 [[LXAlterView sharedMyTools]createTishi:@"离店日期必须大于入店日期"];
                flag=false;
            }
        }
    }

}

-(void)initThirdCell{
    hotelTextField = [[UITextField alloc] initWithFrame:CGRectMake(beginx, 45+90, windowContentWidth - beginx*2, 45)];
    hotelTextField.backgroundColor = [UIColor whiteColor];
    hotelTextField.placeholder = @"关键词/酒店名/地址";
    hotelTextField.textAlignment = NSTextAlignmentLeft;
    [hotelTextField setTintColor:[UIColor grayColor]];
    hotelTextField.font = [UIFont systemFontOfSize:19];
    hotelTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:hotelTextField];hotelTextField.delegate= self;
    
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(ViewX(hotelTextField)+ViewWidth(hotelTextField)-20-45+15, hotelTextField.frame.size.height/2-30/2, 45, 30)];
    [image2 setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    image2.userInteractionEnabled = NO;
    [hotelTextField addSubview:image2];
    
    UIImageView *imagev4 = [[UIImageView alloc] initWithFrame:CGRectMake(beginx,ViewY(hotelTextField)+ ViewHeight(hotelTextField)-0.5, windowContentWidth-beginx*2, 0.5)];
    imagev4.backgroundColor = bordColor;
    [self.view addSubview:imagev4];
    
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];

}

-(void)initForthCell{
    Pricebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    Pricebutton.frame = CGRectMake(beginx, 45+90+45, windowContentWidth-beginx*2,45);
    Pricebutton.titleLabel.font = [UIFont systemFontOfSize:19];
    [Pricebutton setTitle:@"价格/星级" forState:UIControlStateNormal];
    [Pricebutton setTitleColor:bordColor forState:UIControlStateNormal];
    Pricebutton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft ;
    [Pricebutton addTarget:self action:@selector(loadToPriceAndStarView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Pricebutton];
    
    //创建一个Label，为了回调显示“星级价格”值
    lblStarPrice=[[UILabel alloc] initWithFrame:CGRectMake(Begin_X+10, 45+90+45, windowContentWidth-beginx*2, 45)];
    lblStarPrice.font=[UIFont systemFontOfSize:19];
    lblStarPrice.text=@"";
    lblStarPrice.textColor=[UIColor blackColor];
    lblStarPrice.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:lblStarPrice];
    
    
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(ViewX(Pricebutton)+ ViewWidth(Pricebutton)-20-45+15, hotelTextField.frame.size.height/2-30/2, 45, 30)];
    [image2 setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    image2.userInteractionEnabled = NO;
    [Pricebutton addSubview:image2];
    
    
    cancelStarPrice=[UIButton buttonWithType:UIButtonTypeCustom];
    cancelStarPrice.frame=CGRectMake(ViewX(Pricebutton)+ViewWidth(Pricebutton),ViewY(Pricebutton)+8,45,30);
    cancelStarPrice.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [cancelStarPrice setImage:[UIImage imageNamed:@"5差号图标"] forState:UIControlStateNormal];
    [cancelStarPrice addTarget:self action:@selector(canStarPriceClick) forControlEvents:UIControlEventTouchUpInside];
    cancelStarPrice.hidden=true;
    [self.view addSubview:cancelStarPrice];
    
    
    UIImageView *imagev4 = [[UIImageView alloc] initWithFrame:CGRectMake(beginx,ViewY(Pricebutton)+ ViewHeight(Pricebutton)-0.5, windowContentWidth-beginx*2, 0.5)];
    imagev4.backgroundColor = bordColor;
    [self.view addSubview:imagev4];
}

- (void)addGes{
   
}

#pragma mark - 价格/星级 事件
-(void)loadToPriceAndStarView{
    
    HotelStarPriceControl *starPriceView=[[HotelStarPriceControl alloc] init];
    starPriceView.delegate=self;
    [starPriceView initWithValue:lblStarPrice.text];
    [self.view addSubview:starPriceView];
    [self addGes];
}
#pragma mark - 价格/星级 回调函数
-(void)result:(NSString *)resultValue
{
    if (![resultValue isEqualToString:@""]) {
        lblStarPrice.text=resultValue;
        [Pricebutton setTitle:@"" forState:UIControlStateNormal];
        cancelStarPrice.hidden=false;
        [self.view setNeedsDisplay];
    }else{
        lblStarPrice.text=@"";
        [Pricebutton setTitle:@"价格/星级" forState:UIControlStateNormal];
        cancelStarPrice.hidden=true;
    }
}

#pragma mark - 价格/星级 取消事件
-(void)canStarPriceClick{
    lblStarPrice.text=@"";
    [Pricebutton setTitle:@"价格/星级" forState:UIControlStateNormal];
    cancelStarPrice.hidden=true;
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [hotelTextField resignFirstResponder];
    return YES;
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [hotelTextField resignFirstResponder];
}

@end

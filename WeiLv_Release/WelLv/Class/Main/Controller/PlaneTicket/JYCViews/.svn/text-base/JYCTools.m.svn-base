//
//  JYCTools.m
//  WelLv
//
//  Created by lyx on 15/9/14.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCTools.h"

@implementation JYCTools
+(NSString *)getTomStrWithCurrentStr:(NSString *)str
{
    NSTimeInterval fromdate=[[LXTools getTimeIntervalWithDateStr:str] integerValue];
    
    NSDate *yeteDate;
    NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
    
    yeteDate = [LXTools getDateWithTimeInterval:[NSString stringWithFormat:@"%f",fromdate + oneDay]];
    
    NSString *tomStr=[LXTools getDateStrWithDate:yeteDate];
    return tomStr;


}
+(NSString *)getYesStrWithCurrenStr:(NSString *)str
{
//     NSDate *fromdate=[LXTools getDateWithDateStr:str];
//   
//     NSDate *yeteDate;
//     NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
//
//     yeteDate = [fromdate initWithTimeIntervalSince1970: -oneDay*1];
//   
//     NSString *yetStr=[LXTools getDateStrWithDate:yeteDate];
//    return yetStr;
    
    NSTimeInterval fromdate=[[LXTools getTimeIntervalWithDateStr:str] integerValue];
    
    NSDate *yeteDate;
    NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
    
    yeteDate = [LXTools getDateWithTimeInterval:[NSString stringWithFormat:@"%f",fromdate-oneDay]];
    
   NSString *yetStr=[LXTools getDateStrWithDate:yeteDate];
    return yetStr;
}

//通过数字返回星期几
+(NSString *)getWeekStringFromInteger:(int)week
{
    NSString *str_week;
    if (week>7) {
        week=1;
    }else if(week<1)
    {
        week=7;
    }
        
    switch (week) {
        case 1:
            str_week = @"周日";
            break;
        case 2:
            str_week = @"周一";
            break;
        case 3:
            str_week = @"周二";
            break;
        case 4:
            str_week = @"周三";
            break;
        case 5:
            str_week = @"周四";
            break;
        case 6:
            str_week = @"周五";
            break;
        case 7:
            str_week = @"周六";
            break;
    }
    return str_week;
}

+(int)getWeekFromWeekStr:(NSString *)str
{
    int a;
    if ([str isEqualToString:@"周日"]) {
        a=1;
    }else if([str isEqualToString:@"周一"])
    {
        a= 2;
    }else if([str isEqualToString:@"周二"])
    {
        a=3;
    }else if([str isEqualToString:@"周三"])
    {
       a=4;
    }else if([str isEqualToString:@"周四"])
    {
        a= 5;
    }else if([str isEqualToString:@"周五"])
    {
        a= 6;
    }else if([str isEqualToString:@"周六"])
    {
        a=7;
    }
    return a;
}
@end

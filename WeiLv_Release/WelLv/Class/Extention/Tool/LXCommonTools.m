//
//  LXCommonTools.m
//  WelLv
//
//  Created by 刘鑫 on 15/5/8.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "LXCommonTools.h"

@implementation LXCommonTools
+ (LXCommonTools*)sharedMyTools
{
    static LXCommonTools *sharedSVC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSVC = [[self alloc] init];
    });
    
    return sharedSVC;
}


#pragma mark --计算字符串高度
-(CGFloat)textHeight:(NSString *)str Afont:(CGFloat)font width:(CGFloat)width
{
    
    NSDictionary * textDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
    
    DLog(@"height=%f",rect.size.height);
    return rect.size.height+10;
}

//#pragma mark ---计算两个日期的差距(按天算)
//-(NSString *)getDateGap:(NSString *)last
//{
//    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
//    
//    [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式,这里可以设置成自己需要的格式
//    NSDate *lastDate =[dateFormat dateFromString:last];
//    
//    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    unsigned int unitFlags = NSDayCalendarUnit;
//    NSDateComponents *comps = [gregorian components:unitFlags fromDate:[[self getDate:self.traveModel.js_datetime] laterDate:[NSDate date]] toDate:lastDate options:0];
//    NSInteger days = [comps day];
//    NSString *dayS=[NSString stringWithFormat:@"%ld",(long)days];
//    return dayS;
//}

#pragma mark ---时间戳转换成时间字符串
-(NSString *)getDateStr:(NSString *)date
{
    NSString *str=date;//时间戳
    NSTimeInterval time=[str doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",detaildate);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    DLog(@"开始时间===%@",currentDateStr);
    return currentDateStr;
}

-(NSDate *)getDate:(NSString *)date
{
    NSString *str=date;//时间戳
    NSTimeInterval time=[str doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",detaildate);
    return detaildate;
}


@end

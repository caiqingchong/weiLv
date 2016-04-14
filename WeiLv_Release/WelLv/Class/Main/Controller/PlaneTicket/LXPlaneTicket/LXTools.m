//
//  LXTools.m
//  WelLv
//
//  Created by liuxin on 15/9/8.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "LXTools.h"

@implementation LXTools
#pragma mark --计算字符串高度
+(CGFloat)textHeight:(NSString *)str Afont:(CGFloat)font width:(CGFloat)width
{
    
    NSDictionary * textDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
    
    DLog(@"height=%f",rect.size.height);
    return rect.size.height+10;
}

#pragma mark ---------以下是时间转换工具---------
/**
 *时间戳转换成时间字符串
 */
#pragma mark ---时间戳转换成时间字符串
+(NSString *)getDateStrWithTimeInterval:(NSString *)date
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
    return currentDateStr;
}

/**
 *时间戳转换成NSDate
 */
#pragma mark ---时间戳转换成NSDate
+(NSDate *)getDateWithTimeInterval:(NSString *)date
{
    NSString *str=date;//时间戳
    NSTimeInterval time=[str doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",detaildate);
    return detaildate;
}

/**
 *NSDate转换成时间字符串
 */
+(NSString *)getDateStrWithDate:(NSDate *)date
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式
    
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}


/**
 *NSDate转换成时间戳
 */
+(NSString *)getTimeIntervalWithDate:(NSDate *)date
{
    NSString *timeint=[NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
    return timeint;
}


/**
 *时间字符串转换成时间戳
 */
+(NSString *)getTimeIntervalWithDateStr:(NSString *)dateStr
{
    NSDate *date = [self getDateWithDateStr:dateStr];
    NSString *timeint=[NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
    return timeint;
}


/**
 *时间字符串转换成NSDate
 */
+(NSDate *)getDateWithDateStr:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}

#pragma mark ---计算两个日期的差距(按天算)
+(NSString *)getDateGap:(NSString *)fromDateStr  toDate:(NSString *)toDateStr
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式,这里可以设置成自己需要的格式
    NSDate *fromDate =[dateFormat dateFromString:fromDateStr];//开始时间
    NSDate *lastDate =[dateFormat dateFromString:toDateStr];//截止时间

    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSDayCalendarUnit;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:fromDate toDate:lastDate options:0];
    NSInteger days = [comps day];
    NSString *dayS=[NSString stringWithFormat:@"%ld",(long)days];
    return dayS;
}

#pragma mark --------以上是时间转换工具---------

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


/**
 *json字符串转字典/数组
 */
+(id)JSONValue:(NSString *)jsonStr;
{
    NSData* data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error != nil) return nil;
    return result;
}


/**
 *字典转json
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

/**
 *数组转json
 */
+ (NSString*)arrayToJson:(NSArray *)arr

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}




@end

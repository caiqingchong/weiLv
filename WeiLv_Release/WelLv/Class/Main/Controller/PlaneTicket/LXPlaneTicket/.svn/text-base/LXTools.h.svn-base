//
//  LXTools.h
//  WelLv
//
//  Created by liuxin on 15/9/8.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXTools : NSObject

/**
 *计算字符串高度
 */
+(CGFloat)textHeight:(NSString *)str Afont:(CGFloat)font width:(CGFloat)width;


#pragma mark  -------时间格式转换------
/**
 *时间戳转换成时间字符串
 */
+(NSString *)getDateStrWithTimeInterval:(NSString *)date;


/**
 *时间戳转换成NSDate
 */
+(NSDate *)getDateWithTimeInterval:(NSString *)date;


/**
 *NSDate转换成时间字符串
 */
+(NSString *)getDateStrWithDate:(NSDate *)date;


/**
 *NSDate转换成时间戳
 */
+(NSString *)getTimeIntervalWithDate:(NSDate *)date;


/**
 *时间字符串转换成时间戳
 */
+(NSString *)getTimeIntervalWithDateStr:(NSString *)dateStr;


/**
 *时间字符串转换成NSDate
 */
+(NSDate *)getDateWithDateStr:(NSString *)dateStr;

/**
 *计算两个日期之间的间隔
 *传入开始时间，截止时间字符串。（格式：2015-09-24）
 */
+(NSString *)getDateGap:(NSString *)fromDateStr  toDate:(NSString *)toDateStr;

#pragma mark  -------json字符串，数组，字典转换------
/**
 *json字符串转字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 *json字符串转字典/数组
 */
+(id)JSONValue:(NSString *)jsonStr;

/**
 *字典转json
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

/**
 *数组转json
 */
+ (NSString*)arrayToJson:(NSArray *)arr;



@end

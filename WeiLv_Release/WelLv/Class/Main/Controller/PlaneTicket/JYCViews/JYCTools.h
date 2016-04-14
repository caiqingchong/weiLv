//
//  JYCTools.h
//  WelLv
//
//  Created by lyx on 15/9/14.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYCTools : NSObject
+(NSString *)getTomStrWithCurrentStr:(NSString *)str;
+(NSString *)getYesStrWithCurrenStr:(NSString *)str;
+(NSString *)getWeekStringFromInteger:(int)week;
+(int)getWeekFromWeekStr:(NSString *)str;
@end

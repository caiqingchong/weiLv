//
//  LXCommonTools.h
//  WelLv
//
//  Created by 刘鑫 on 15/5/8.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXCommonTools : NSObject

+ (LXCommonTools*)sharedMyTools;

#pragma mark --计算字符串高度
-(CGFloat)textHeight:(NSString *)str Afont:(CGFloat)font width:(CGFloat)width;

#pragma mark --  NSDateMethod
#pragma mark ---计算两个日期的差距(按天算)


@end

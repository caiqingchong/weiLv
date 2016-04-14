//
//  LXCustomTraveModel.m
//  WelLv
//
//  Created by 刘鑫 on 15/5/14.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "LXCustomTraveModel.h"

@implementation LXCustomTraveModel

#pragma mark ---自定义班期按时间重新排序
- (NSComparisonResult)sortByAge:(LXCustomTraveModel *)customTraveModel
{
    NSInteger date=[[self.date_time stringByReplacingOccurrencesOfString:@"-" withString:@""] integerValue];
    NSInteger date1=[[customTraveModel.date_time stringByReplacingOccurrencesOfString:@"-" withString:@""] integerValue];
    if (date1 < date) {
        return NSOrderedDescending;
    }else if (date1 > date){
        return NSOrderedAscending;
    }
    return NSOrderedSame;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end

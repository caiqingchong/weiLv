//
//  LXShipCalendarModel.m
//  WelLv
//
//  Created by 刘鑫 on 15/5/21.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "LXShipCalendarModel.h"

@implementation LXShipCalendarModel
- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end

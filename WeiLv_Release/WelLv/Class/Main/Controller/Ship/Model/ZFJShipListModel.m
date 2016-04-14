//
//  ZFJShipListModel.m
//  WelLv
//
//  Created by 张发杰 on 15/5/19.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJShipListModel.h"

@implementation ZFJShipListModel
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

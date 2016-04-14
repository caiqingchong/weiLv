//
//  LXShipProductModel.m
//  WelLv
//
//  Created by 刘鑫 on 15/5/23.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "LXShipProductModel.h"

@implementation LXShipProductModel
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

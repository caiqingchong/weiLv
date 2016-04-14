//
//  LXAdvertModel.m
//  WelLv
//
//  Created by 刘鑫 on 15/6/1.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "LXAdvertModel.h"

@implementation LXAdvertModel

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
    if ([key isEqualToString:@"goto"]){
        self.gotoDic = [LXTools dictionaryWithJsonString:value];
    }
}
@end

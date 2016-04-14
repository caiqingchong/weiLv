//
//  zxdDateModel.m
//  WelLv
//
//  Created by liuxin on 16/1/22.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "zxdDateModel.h"

@implementation zxdDateModel
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

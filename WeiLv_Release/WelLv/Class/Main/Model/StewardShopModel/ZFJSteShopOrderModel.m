//
//  ZFJSyeShopOrderModel.m
//  WelLv
//
//  Created by WeiLv on 15/10/26.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJSteShopOrderModel.h"

@implementation ZFJSteShopOrderModel

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

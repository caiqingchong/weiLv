//
//  CSHShopModel.m
//  WelLv
//
//  Created by mac for csh on 15/11/20.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "CSHShopModel.h"

@implementation CSHShopModel

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
    if ([key isEqualToString:@"id"]) {
        self.shopid = value;
    }
    
    if ([key isEqualToString:@"contact_phone"]) {
        self.contact = [LXTools JSONValue:value];
    }
    
}

@end

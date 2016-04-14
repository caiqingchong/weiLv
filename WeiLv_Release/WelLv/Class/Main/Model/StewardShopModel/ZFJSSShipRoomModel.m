//
//  ZFJSSShipRoomModel.m
//  WelLv
//
//  Created by WeiLv on 15/10/26.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJSSShipRoomModel.h"

@implementation ZFJSSShipRoomModel
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

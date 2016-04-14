//
//  zxdMemberModel.m
//  WelLv
//
//  Created by liuxin on 16/1/20.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "zxdMemberModel.h"

@implementation zxdMemberModel
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
    if([key isEqualToString:@"id"])
    {
        self.ZXDid = value;
    }
}
@end

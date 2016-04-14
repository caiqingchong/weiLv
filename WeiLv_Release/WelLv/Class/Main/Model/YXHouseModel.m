//
//  YXHouseModel.m
//  WelLv
//
//  Created by lyx on 15/4/18.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "YXHouseModel.h"

@implementation YXHouseModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"没有定义%@",key);
}

- (void)setSellers:(NSMutableArray *)sellers
{
    if (sellers == nil || sellers.count == 0) {
        _sellers = nil;
    }
    NSMutableArray *array = [NSMutableArray array];
    for (NSArray *dic in sellers)
    {
        [array addObject:JsonStringTransToObject(dic, @"YXMemberHouseData")];
    }
    _sellers = array;

}
@end

@implementation YXMemberHouseData

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"没有定义%@",key);
}

@end

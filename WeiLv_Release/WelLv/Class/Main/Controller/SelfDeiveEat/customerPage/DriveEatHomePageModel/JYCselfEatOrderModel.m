//
//  JYCselfEatOrderModel.m
//  WelLv
//
//  Created by lyx on 15/11/30.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCselfEatOrderModel.h"

@implementation JYCselfEatOrderModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"product"]) {
        NSMutableArray * arr = [NSMutableArray array];
        for (NSDictionary * dic in value) {
            pdModel * model = [pdModel alloc];
            [model setValuesForKeysWithDictionary:dic];
            [arr addObject:model];
        }
        self.productArr= arr;
    }
 
}
@end


@implementation pdModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
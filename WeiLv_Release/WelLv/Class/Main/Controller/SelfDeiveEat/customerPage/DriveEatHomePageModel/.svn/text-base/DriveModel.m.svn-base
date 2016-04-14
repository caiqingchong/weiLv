//
//  DriveModel.m
//  WelLv
//
//  Created by lyx on 15/11/6.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "DriveModel.h"

@implementation DriveModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"id"]){
        self.userid = value;
    }
    if ([key isEqualToString:@"offline_info"]) {
        NSMutableArray * arr = [NSMutableArray array];
        for (NSDictionary * dic in value) {
            offline_infoModel * model = [offline_infoModel alloc];
            [model setValuesForKeysWithDictionary:dic];
            [arr addObject:model];
        }
        self.offline_infoArr= arr;
    }
}
@end


@implementation offline_infoModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end

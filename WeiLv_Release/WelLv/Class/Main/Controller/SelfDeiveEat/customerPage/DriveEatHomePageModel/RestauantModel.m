//
//  Restauant.m
//  WelLv
//
//  Created by lyx on 15/11/13.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "RestauantModel.h"

@implementation RestauantModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"id"])
        self.userid = value;
}

@end

//
//  LXSingletonClass.m
//  WelLv
//
//  Created by liuxin on 15/9/2.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "LXSingletonClass.h"

@implementation LXSingletonClass


+(instancetype) shareInstance
{
    static LXSingletonClass *lx=nil;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        lx = [[LXSingletonClass alloc] init] ;
    }) ;
    return lx ;
}
@end

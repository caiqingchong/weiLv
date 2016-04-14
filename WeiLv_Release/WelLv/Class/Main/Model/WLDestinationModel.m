//
//  WLDestinationModel.m
//  WelLv
//
//  Created by wangning on 16/3/17.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "WLDestinationModel.h"
#import "UIDefines.h"

@implementation WLDestinationModel

- (instancetype)initWithDic:(NSDictionary*)dict{
    
    self = [super init];
    if (self) {
        
        
        self.d_name = dict[@"d_name"]?dict[@"d_name"]:@"";
        
        NSString *pinYin = [self transformMandarinToLatin:self.d_name];
        
        self.uperCharater = [[pinYin substringToIndex:1] uppercaseString];
        
        
    }
    return self;
}
+ (instancetype)modelWithDic:(NSDictionary*)dict{
    
    return [[self alloc]initWithDic:dict];
}

@end

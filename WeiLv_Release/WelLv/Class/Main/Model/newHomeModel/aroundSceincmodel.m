//
//  aroundSceincmodel.m
//  WelLv
//
//  Created by mac for csh on 15/11/6.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "aroundSceincmodel.h"

@implementation aroundSceincmodel
@synthesize title,src,link,width,height,descriptionn,gotoDic;

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
    if ([key isEqualToString:@"goto"]) {
        self.gotoDic = [LXTools dictionaryWithJsonString:value];
    }
    
    if ([key isEqualToString:@"description"]) {
        self.descriptionn = value;
    }
    
}
@end

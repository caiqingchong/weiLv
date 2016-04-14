//
//  WLUserStewardModel.m
//  WelLv
//
//  Created by WeiLv on 15/11/6.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "WLUserStewardModel.h"

@implementation WLUserStewardModel

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
        
        self.uid = value;
        
    }else if ([key isEqualToString:@"region_name"]) {
        
        if([value isKindOfClass:[NSDictionary class]])
        {
          self.regionName = [value objectForKey:@"region_name"];
        }
        else
        {
           self.regionName=@"";
        }
        
    }
}

@end

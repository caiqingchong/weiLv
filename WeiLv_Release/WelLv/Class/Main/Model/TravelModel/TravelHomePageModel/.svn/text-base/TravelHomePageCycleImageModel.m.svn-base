//
//  TravelHomePageCycleImageModel.m
//  WelLv
//
//  Created by 张子乾 on 16/1/12.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "TravelHomePageCycleImageModel.h"

@implementation TravelHomePageCycleImageModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"description"]) {
        self.Description = value;
    }else if([key isEqualToString:@"goto"]){
        self.gotoDic = [LXTools dictionaryWithJsonString:value];
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@--%@", self.src,self.title];
}


@end

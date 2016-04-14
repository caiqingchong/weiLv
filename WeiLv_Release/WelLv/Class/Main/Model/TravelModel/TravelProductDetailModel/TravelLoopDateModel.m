//
//  TravelLoopDateModel.m
//  WelLv
//
//  Created by 张子乾 on 16/1/24.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "TravelLoopDateModel.h"

@implementation TravelLoopDateModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"余位:%@--日期:%@--价格:%@", self.stock,self.date_time,self.adult];
}

@end

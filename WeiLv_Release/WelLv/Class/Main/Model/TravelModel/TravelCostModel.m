//
//  TravelCostModel.m
//  WelLv
//
//  Created by 张子乾 on 16/1/19.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "TravelCostModel.h"

@implementation TravelCostModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@--%@--%@", self.fee_include,self.fee_not_include,self.sign_way];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}


@end

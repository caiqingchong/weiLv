//
//  TravelJPLineModel.m
//  WelLv
//
//  Created by 张子乾 on 16/1/12.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "TravelJPLineModel.h"

@implementation TravelJPLineModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@--%@--%@--%@--%@", self.thumb,self.product_name,self.adult_price,self.city_id,self.gj_adult_rebate];
}


@end

//
//  TravelOrderDetailModel.m
//  WelLv
//
//  Created by 张子乾 on 16/1/24.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "TravelOrderDetailModel.h"

@implementation TravelOrderDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@--%@--%@--%@--%@--成人数:%ld--儿童数:%ld--%@", self.product_name,self.product_id,self.adult_price,self.child_price,self.f_time,self.adule,self.child,self.admin_type];
}


@end

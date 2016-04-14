//
//  TravelAffirmModel.m
//  WelLv
//
//  Created by 张子乾 on 16/1/29.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "TravelAffirmModel.h"

@implementation TravelAffirmModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@--%@--%@--%@--%@--%@", self.product_name,self.order_sn,self.order_price,self.adule,self.child,self.order_id];
}


@end

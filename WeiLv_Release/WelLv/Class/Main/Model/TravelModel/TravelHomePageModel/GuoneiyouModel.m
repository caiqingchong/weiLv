//
//  GuoneiyouModel.m
//  Lvyou
//
//  Created by 赵冉 on 16/1/12.
//  Copyright © 2016年 赵冉. All rights reserved.
//

#import "GuoneiyouModel.h"

@implementation GuoneiyouModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@--%@", self.product_name,self.timeTableArr];
}


@end

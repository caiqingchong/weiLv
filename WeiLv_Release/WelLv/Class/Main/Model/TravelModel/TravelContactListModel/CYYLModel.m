//
//  CYYLModel.m
//  WelLv
//
//  Created by 赵冉 on 16/1/19.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "CYYLModel.h"

@implementation CYYLModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@--%@--%@--%@--%@--%@", self.to_id,self.to_username,self.phone,self.id_type,self.id_number,self.sex];
}

@end

//
//  ShopLocationModel.m
//  WelLv
//
//  Created by mac for csh on 15/11/17.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ShopLocationModel.h"

@implementation ShopLocationModel


-(NSString *)description{
    return [NSString stringWithFormat:@"名字%@\n经度%@\n维度%@\n省%@\n市%@",self.shopDir,self.longitude,self.latitude,self.province,self.city];
}

@end

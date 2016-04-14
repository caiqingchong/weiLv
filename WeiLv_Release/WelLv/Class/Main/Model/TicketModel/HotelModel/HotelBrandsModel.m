//
//  HotelBrandsModel.m
//  WelLv
//
//  Created by 吴伟华 on 15/11/20.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "HotelBrandsModel.h"

@implementation HotelBrandsModel
-(instancetype)initWithDic:(NSDictionary *)dic
{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
@end

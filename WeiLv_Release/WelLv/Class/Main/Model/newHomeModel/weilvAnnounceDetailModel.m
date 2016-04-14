//
//  weilvAnnounceDetailModel.m
//  WelLv
//
//  Created by mac for csh on 15/11/26.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "weilvAnnounceDetailModel.h"

@implementation weilvAnnounceDetailModel

@synthesize news_id,title;

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end

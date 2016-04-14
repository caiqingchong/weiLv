//
//  weilvAnnounceModel.m
//  WelLv
//
//  Created by mac for csh on 15/11/26.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "weilvAnnounceModel.h"

@implementation weilvAnnounceModel
@synthesize news_id,title;
//@synthesize intro,content,cate_id,author,source,admin_id,thumb,push_time,update_time,is_delete,city_id,sort,tag;

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

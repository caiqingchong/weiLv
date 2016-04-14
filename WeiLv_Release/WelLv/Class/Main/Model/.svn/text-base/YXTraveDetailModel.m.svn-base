//
//  YXTraveDetailModel.m
//  WelLv
//
//  Created by lyx on 15/4/22.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "YXTraveDetailModel.h"

@implementation YXTraveDetailModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
   
   
    
    NSLog(@"没有定义%@",key);
}
- (void)setSchedule:(NSMutableArray *)schedule
{
    if (schedule == nil || schedule.count == 0) {
        _schedule = nil;
    }
    NSMutableArray *array = [NSMutableArray array];
    for (NSArray *dic in schedule)
    {
        [array addObject:JsonStringTransToObject(dic, @"YXSchedule")];
    }
    _schedule = array;
}

- (void)setAlbum_list:(NSMutableArray *)album_list
{
    if (album_list == nil || album_list.count == 0) {
        _album_list = nil;
    }
    NSMutableArray *array = [NSMutableArray array];
    for (NSArray *dic in album_list)
    {
        [array addObject:JsonStringTransToObject(dic, @"YXAlbum_list")];
    }
    _album_list = array;
}

-(void)setDeparture_info:(NSMutableArray *)departure_info
{
    if (departure_info == nil || departure_info.count == 0) {
        _departure_info = nil;
    }
    NSMutableArray *array = [NSMutableArray array];
    for (NSArray *dic in departure_info)
    {
        [array addObject:JsonStringTransToObject(dic, @"YXDeparture_info")];
    }
    _departure_info = array;
}
@end

@implementation YXSchedule

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"没有定义%@",key);
}

- (void)setSchedule_images:(NSMutableArray *)schedule_images
{
    if (schedule_images == nil ||schedule_images.count ==0)  {
        _schedule_images = nil;
    }
    NSMutableArray *array = [NSMutableArray array];
    for (NSArray *dic in schedule_images) {
        [array addObject:JsonStringTransToObject(dic,  @"YXAlbum_list")];
    }
    _schedule_images = array;
}

@end

@implementation YXAlbum_list

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"没有定义%@",key);
}


@end

@implementation YXDeparture_info

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"没有定义%@",key);
}


@end
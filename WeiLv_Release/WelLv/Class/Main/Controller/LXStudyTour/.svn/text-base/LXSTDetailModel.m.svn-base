//
//  LXSTDetailModel.m
//  WelLv
//
//  Created by 刘鑫 on 15/8/20.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "LXSTDetailModel.h"

@implementation LXSTDetailModel
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
        [array addObject:JsonStringTransToObject(dic, @"YXSchedule1")];
    }
    _schedule = array;
}

-(void)setAlbum:(NSMutableArray *)album
{
    if (album == nil || album.count == 0) {
        _album = nil;
    }
    NSMutableArray *array = [NSMutableArray array];
    for (NSArray *dic in album)
    {
        [array addObject:JsonStringTransToObject(dic, @"YXAlbum_list1")];
    }
    _album = array;
}


-(void)setDeparture_info:(NSMutableArray *)departure_info
{
    if (departure_info == nil || departure_info.count == 0) {
        _departure_info = nil;
    }
    NSMutableArray *array = [NSMutableArray array];
    for (NSArray *dic in departure_info)
    {
        [array addObject:JsonStringTransToObject(dic, @"YXDeparture_info1")];
    }
    _departure_info = array;
}

//出发日期（游学）
-(void)setTimetable:(NSMutableArray *)timetable
{
    if (timetable == nil || timetable.count == 0) {
        _timetable = nil;
    }
    NSMutableArray *array = [NSMutableArray array];
    for (NSArray *dic in timetable)
    {
        [array addObject:JsonStringTransToObject(dic, @"LXTimeTableModel")];
    }
    _timetable = array;
}

@end

@implementation YXSchedule1
@synthesize description = _description;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"没有定义%@",key);
}

-(void)setAblum:(NSMutableArray *)ablum
{
    if (ablum == nil ||ablum.count ==0)  {
        _ablum = nil;
    }
    NSMutableArray *array = [NSMutableArray array];
    for (NSArray *dic in ablum) {
        [array addObject:JsonStringTransToObject(dic,  @"YXAlbum_list1")];
    }
    _ablum = array;
}

//- (void)setSchedule_images:(NSMutableArray *)schedule_images
//{
//    if (schedule_images == nil ||schedule_images.count ==0)  {
//        _schedule_images = nil;
//    }
//    NSMutableArray *array = [NSMutableArray array];
//    for (NSArray *dic in schedule_images) {
//        [array addObject:JsonStringTransToObject(dic,  @"YXAlbum_list1")];
//    }
//    _schedule_images = array;
//}

@end

@implementation YXAlbum_list1

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"没有定义%@",key);
}


@end

@implementation YXDeparture_info1

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"没有定义%@",key);
}
@end


@implementation LXTimeTableModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"没有定义%@",key);
}
@end







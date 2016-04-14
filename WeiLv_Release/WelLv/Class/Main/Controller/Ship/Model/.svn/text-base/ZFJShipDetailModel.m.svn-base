//
//  ZFJShipDetailModel.m
//  WelLv
//
//  Created by 张发杰 on 15/5/19.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJShipDetailModel.h"

@implementation ZFJShipDetailModel
- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        //        NSArray * arr = [dic objectForKey:@"room"];
        //        for (NSDictionary * dict in arr) {
        //            ZFJShipRoom * shipRoom = [[ZFJShipRoom alloc]initWithDictionary:dict];
        //            [self.roomModelArr addObject:shipRoom];
        //        }
        
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    /*
     //NSLog(@"+++++9+9+%@ key = == %@", value, key);
     
     if ([key isEqual:@"room"]) {
     for (NSDictionary * dic in value) {
     ZFJShipRoom * shipRoom = [[ZFJShipRoom alloc]initWithDictionary:dic];
     //NSLog(@"房间名 ＝＝＝＝ %@", shipRoom.cabin_name);
     [self.roomModelArr addObject:shipRoom];
     }
     }
     if ([key isEqual:@"schedule"]) {
     for (NSDictionary * dic in value) {
     ZFJshipSchedule * shipShedule = [[ZFJshipSchedule alloc]initWithDictionary:dic];
     [self.scheduleModelArr addObject:shipShedule];
     }
     }
     if ([key isEqual:@"album"]) {
     for (NSDictionary * dic in value) {
     ZFJShipAlbum * shipAlbum = [[ZFJShipAlbum alloc]initWithDictionary:dic];
     [self.albumModelArr addObject:shipAlbum];
     }
     }
     */
}

- (NSMutableArray *)roomModelArr{
    if (_roomModelArr == nil) {
        self.roomModelArr = [NSMutableArray array];
    }
    return _roomModelArr;
}

- (NSMutableArray *)scheduleModelArr{
    if (_scheduleModelArr ==nil) {
        self.scheduleModelArr = [NSMutableArray array];
    }
    return _scheduleModelArr;
}
- (NSMutableArray *)albumModelArr{
    if (_albumModelArr == nil) {
        self.albumModelArr = [NSMutableArray array];
    }
    return _albumModelArr;
}



@end
@implementation ZFJShipRoom
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


@implementation ZFJshipSchedule

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
    if ([key isEqual:@"scenes"]) {
        for (NSDictionary *dic in value) {
            ZFJShipScenes * scenesModel = [[ZFJShipScenes alloc] initWithDictionary:dic];
            [self.scenesMoelArr addObject:scenesModel];
        }
    }
}

- (NSMutableArray *)scenesMoelArr{
    if (_scenesMoelArr) {
        self.scenesMoelArr = [NSMutableArray array];
    }
    return _scenesMoelArr;
}
@end

@implementation ZFJShipScenes

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


@implementation ZFJShipAlbum
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

@implementation ZFJShoreTraveModel

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


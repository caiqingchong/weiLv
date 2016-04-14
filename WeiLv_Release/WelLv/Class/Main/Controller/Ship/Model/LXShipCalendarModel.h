//
//  LXShipCalendarModel.h
//  WelLv
//
//  Created by 刘鑫 on 15/5/21.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXShipCalendarModel : NSObject

@property (nonatomic,copy)NSString *setoff_date;//时间戳
@property (nonatomic,copy)NSString *ymd;//时间
@property (nonatomic,copy)NSString *min_price;//底价

- (id)initWithDictionary:(NSDictionary *)dic;
@end

//
//  LXPlaneCalendarLogic.h
//  WelLv
//
//  Created by liuxin on 15/9/15.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalendarDayModel.h"
#import "NSDate+WQCalendarLogic.h"

@interface LXPlaneCalendarLogic : NSObject
- (NSMutableArray *)reloadCalendarView:(NSDate *)date  selectDate:(NSDate *)date1 needDays:(int)days_number customDateArray:(NSMutableArray *)array;
- (void)selectLogic:(CalendarDayModel *)day;
@end

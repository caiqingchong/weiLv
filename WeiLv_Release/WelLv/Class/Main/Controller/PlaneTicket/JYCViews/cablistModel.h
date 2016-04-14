//
//  cablistModel.h
//  WelLv
//
//  Created by lyx on 15/9/9.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cablistModel : NSObject
@property (nonatomic,copy)NSString *CabinName;
@property (nonatomic,copy)NSString *Discount;
@property (nonatomic,copy)NSString *Fare;
@property (nonatomic,copy)NSString *Sale;
@property (nonatomic,copy)NSString *YouHui;
@property (nonatomic,copy)NSString *TicketCount;
@property (nonatomic,copy)NSString *CabinKey;
@property (nonatomic,copy)NSString *Cabin;
@property (nonatomic,copy)NSString *IsTeHui;
@property (nonatomic,copy)NSString *IsSpe;
@property (nonatomic,copy)NSString *TuiGaiQian;
@property (nonatomic,copy)NSString *UserRate;
@property (nonatomic,copy)NSString *VTWorteTime;
@property (nonatomic,copy)NSString *WorkTime;
@property (nonatomic,copy)NSString *IsKx;
@property (nonatomic,copy)NSString *generalFare;
@property (nonatomic,copy)NSString *KxSiteID;
@property (nonatomic,copy)NSString *KxSpValue;
@property (nonatomic,copy)NSString *flight_info;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end

/*
"CabinKey": "8AFCFDFC6E496095",
"AirLineCode": "FM",
"Cabin": "R",
"CabinName": "经济舱",
"Discount": "60",
"IsTeHui": 0,
"Fare": "580",
"IsSpe": "1",
"IsSpePolicy": "0",
"Sale": "563",
"TicketCount": "4",
"TuiGaiQian": "\n",
"UserRate": "3.00",
"VTWorteTime": "08:30:00-22:00",
"WorkTime": "00:00-23:59",
"YouHui": "17",
"IsKx": 0,
"KxSiteID": "",
"KxSpValue": "",
"generalFare": "0",
"flight_info":*/

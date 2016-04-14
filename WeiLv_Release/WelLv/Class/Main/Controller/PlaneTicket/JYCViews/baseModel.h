//
//  baseModel.h
//  WelLv
//
//  Created by lyx on 15/9/9.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface baseModel : NSObject
@property (nonatomic,copy)NSString *CarrinerName;
@property (nonatomic,copy)NSString *StartPortName;
@property (nonatomic,copy)NSString *EndPortName;
@property (nonatomic,copy)NSString *FlightNo;
@property (nonatomic,copy)NSString *MinCabin;
@property (nonatomic,copy)NSString *MinDiscount;
@property (nonatomic,copy)NSString *MinFare;
@property (nonatomic,copy)NSString *MinTicketCount;
@property (nonatomic,copy)NSString *OffTime;
@property (nonatomic,copy)NSString *ArriveTime;

@property (nonatomic,copy)NSString *BookKey;
@property (nonatomic,copy)NSString *AirLineCode;
@property (nonatomic,copy)NSString *StartPort;
@property (nonatomic,copy)NSString *EndPort;
@property (nonatomic,copy)NSString *JoinDate;
@property (nonatomic,copy)NSString *StartT;
@property (nonatomic,copy)NSString *EndT;
@property (nonatomic,copy)NSString *ByPass;
@property (nonatomic,copy)NSString *Meat;
@property (nonatomic,copy)NSString *StaFare;
@property (nonatomic,copy)NSString *Oil;
@property (nonatomic,copy)NSString *Tax;
@property (nonatomic,copy)NSString *Distance;
@property (nonatomic,copy)NSString *PlaneType;
@property (nonatomic,copy)NSString *PlaneModel;
@property (nonatomic,copy)NSString *RunTime;
@property (nonatomic,copy)NSString *ETicket;
@property(nonatomic,strong)NSDictionary *s_airport;
@property(nonatomic,strong)NSDictionary *e_airport;

//@property (nonatomic,copy)NSString *CarrinerName;
//@property (nonatomic,copy)NSString *CarrinerName;
//@property (nonatomic,copy)NSString *CarrinerName;
//@property (nonatomic,copy)NSString *CarrinerName;

//12233
//54465
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end

@interface s_airportModel :NSObject
@property (nonatomic,copy) NSString *airport_id;
@property (nonatomic,copy) NSString *city_py;
@property (nonatomic,copy) NSString *city_code;
@property (nonatomic,copy) NSString *short_name;
@property (nonatomic,copy) NSString *city_prefix;
@property (nonatomic,copy) NSString *city_name;
@property (nonatomic,copy) NSString *airport_code;
@property (nonatomic,copy) NSString *name;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (id)initWithDictionary:(NSDictionary *)dic;
@end

@interface e_airportModel :NSObject
@property (nonatomic,copy) NSString *airport_id;
@property (nonatomic,copy) NSString *city_py;
@property (nonatomic,copy) NSString *city_code;
@property (nonatomic,copy) NSString *short_name;
@property (nonatomic,copy) NSString *city_prefix;
@property (nonatomic,copy) NSString *city_name;
@property (nonatomic,copy) NSString *airport_code;
@property (nonatomic,copy) NSString *name;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (id)initWithDictionary:(NSDictionary *)dic;
@end



/*"BookKey": "282BF1BAC3F2B725",
 "AirLineCode": "FM",
 "CarrinerName": "上海航空",
 "StartPortName": "郑州",
 "StartPort": "CGO",
 "EndPortName": "上海浦东",
 "EndPort": "PVG",
 "FlightNo": "FM9328",
 "JoinPort": "",
 "JoinDate": "0001-01-01",
 "MinCabin": "经济舱",
 "MinDiscount": "60",
 "MinFare": "563",
 "MinTicketCount": "4",
 "OffTime": "2015-09-25 08:05:00",
 "ArriveTime": "2015-09-25 09:40:00",
 "StartT": "M",
 "EndT": "T1",
 "ByPass": "1",
 "Meat": "0",
 "StaFare": 960,
 "Oil": 0,
 "Tax": 50,
 "Distance": 887,
 "PlaneType": "738",
 "PlaneModel": "中",
 "RunTime": "1小时35分钟",
 "ETicket": "0"*/
//
//  zxdMemberModel.h
//  WelLv
//
//  Created by liuxin on 16/1/20.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zxdMemberModel : NSObject
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * phoneNumber;
@property (nonatomic, copy) NSString * cID;
@property (nonatomic, copy) NSString * IDnumber;
@property (nonatomic, copy)NSString *ZXDid;
@property (nonatomic, copy)NSString *assistant_id;
@property (nonatomic, copy)NSString *create_time;
@property (nonatomic, copy)NSString *member_id;
@property (nonatomic, copy)NSString *tag;
@property (nonatomic, copy)NSString *phone;
@property (nonatomic, copy)NSString *qq;
@property (nonatomic, copy)NSString *visitor;
@property (nonatomic, copy)NSString *visitor_id;
- (id)initWithDictionary:(NSDictionary *)dic;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end

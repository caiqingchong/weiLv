//
//  DepositModel.h
//  WelLv
//
//  Created by lyx on 16/1/21.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DepositModel : NSObject
@property(nonatomic,copy)NSString *acc_name;
@property(nonatomic,copy)NSString *apply_time;
@property(nonatomic,copy)NSString *bank_name;
@property(nonatomic,copy)NSString *userid;
@property(nonatomic,copy)NSString *is_same_bank;
@property(nonatomic,copy)NSString *is_same_city;
@property(nonatomic,copy)NSString *sn;
@property(nonatomic,copy)NSString *state_text;
@property(nonatomic,copy)NSString *money;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
//"acc_name" = SHENFA014061780;
//"apply_time" = "2016-01-15 13:54:08";
//"bank_name" = "\U5e73\U5b89\U94f6\U884c";
//id = 2;
//"is_same_bank" = "\U8de8\U884c";
//"is_same_city" = "\U540c\U57ce";
//money = "9500.00";
//sn = 2;
//"state_text" = "\U8f6c\U8d26\U5931\U8d25";
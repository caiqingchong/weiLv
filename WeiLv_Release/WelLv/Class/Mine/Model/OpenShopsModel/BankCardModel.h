//
//  BankCardModel.h
//  WelLv
//
//  Created by mac for csh on 15/11/19.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankCardModel : NSObject

@property (nonatomic ,strong ) NSString *cardholder; //持卡人
@property (nonatomic ,strong ) NSString *bank_sn; //卡号
@property (nonatomic ,strong ) NSString *open_bank_name;//银行
@property (nonatomic ,strong ) NSString *open_bank_dir;//开户地区
@property (nonatomic ,strong ) NSString *open_brance_name;//支行名称

@end

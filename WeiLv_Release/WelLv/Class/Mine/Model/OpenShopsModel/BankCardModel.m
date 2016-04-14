//
//  BankCardModel.m
//  WelLv
//
//  Created by mac for csh on 15/11/19.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "BankCardModel.h"

@implementation BankCardModel



-(NSString *)description{
    return  [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n",self.cardholder,self.bank_sn,self.open_bank_name,self.open_bank_dir,self.open_brance_name];
}

@end

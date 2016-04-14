//
//  AddBankNameVC.h
//  WelLv
//
//  Created by lyx on 16/1/19.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
typedef void(^popBlock)(NSString *str);
@interface AddBankNameVC : XCSuperObjectViewController
@property(nonatomic,strong)popBlock block;
@property(nonatomic,copy)NSString *text;
@end

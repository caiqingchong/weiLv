//
//  BankCardViewController.h
//  WelLv
//
//  Created by liuxin on 15/11/4.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
#import "BankCardModel.h"

#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2
@interface BankCardViewController : XCSuperObjectViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
  //  NSMutableArray *_arrText;
    UIPickerView *picker;
    NSDictionary *areaDic;
    NSArray *province;
    NSArray *city;
    NSArray *district;
    NSString *selectedProvince;
    NSString *_strText;
    UIView *_PicView;
}
//@property(nonatomic,strong)NSMutableArray *arrText;
@property(nonatomic,strong)UIView *PicView;
//@property(nonatomic,strong)NSString *strText;
@property(nonatomic , assign)NSInteger arrayIndex;

@property(nonatomic , strong)BankCardModel *getmodel;
@end

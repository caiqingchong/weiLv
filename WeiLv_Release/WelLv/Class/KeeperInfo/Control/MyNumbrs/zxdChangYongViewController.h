//
//  zxdChangYongViewController.h
//  WelLv
//
//  Created by liuxin on 16/1/25.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2
@class zxdChangYongViewController;
@protocol zxdChangYongViewControllerDelegate <NSObject>

-(void)zxdVcBack:(zxdChangYongViewController *)zxdVC text1:(NSString *)str1 text2:(NSString *)str2 text3:(NSString *)str3 text4:(NSString *)str4 text5:(NSString *)str5 zxdBool:(NSInteger)type;

@end
@interface zxdChangYongViewController : XCSuperObjectViewController<UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIPickerView *picker;
    UIButton *button;
    
    NSDictionary *areaDic;
    NSArray *province;
    NSArray *city;
    NSArray *district;
    
    NSString *selectedProvince;
   
    
    


}
@property(nonatomic,assign)id<zxdChangYongViewControllerDelegate>delegate;
@property(nonatomic,strong)NSString *uid;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)NSString *frist;
@property(nonatomic,strong)NSString *second;

@property(nonatomic,strong)NSString *zxdcity1;
@property(nonatomic,strong)NSString *zxdcity2;
@property(nonatomic,strong)NSString *zxdcity3;
@property(nonatomic,strong)NSString *zxdStr1;
@property(nonatomic,strong)NSString *zxdStr2;
@property(nonatomic,strong)NSString *zxdStr3;


@end

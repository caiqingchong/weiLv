//
//  EducationalBGViewController.h
//  WelLv
//
//  Created by mac for csh on 15/7/27.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"

@interface EducationalBGViewController :  XCSuperObjectViewController<UIPickerViewDataSource,UIPickerViewDelegate>{
    NSArray *educationalArray;
    UIButton *btn1;
    UIView *pView;
    UIPickerView *picker;
    NSString *key;
    NSString *uid;
    NSString *keywords;
}
@property(nonatomic,strong) NSArray *educationalArray;
@property(nonatomic,strong) NSString *key;
@property(nonatomic,strong) NSString *uid;
@property(nonatomic,strong) NSString *keywords;

@end

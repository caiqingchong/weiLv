//
//  changeAdressViewController.h
//  WelLv
//
//  Created by mac for csh on 15/4/15.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"

@interface changeAdressViewController :XCSuperObjectViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate>{
    UIPickerView *piker;
    UIButton *btn2;//确定按钮
    UIButton *btn1;//选择日期按钮
    UITextView *repPwdTextFild;
    
    
    NSString *seletedProvince;
    NSString *seletedCity;
    NSString *seletedp;
}


@end

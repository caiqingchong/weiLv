//
//  ChangHhoroscopeViewController.h
//  WelLv
//
//  Created by mac for csh on 15/7/17.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"

@interface ChangHhoroscopeViewController : XCSuperObjectViewController<UIPickerViewDataSource,UIPickerViewDelegate>{
    NSMutableDictionary *infoDivtionary;
    UIButton *btn1;
    NSArray *names;
    UIView *pView;
    UIPickerView *picker;
    
    NSInteger horosInteger;
}


@end

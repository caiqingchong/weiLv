//
//  ChangEducationalViewController.h
//  WelLv
//
//  Created by mac for csh on 15/7/17.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"

@interface ChangEducationalViewController : XCSuperObjectViewController<UIPickerViewDataSource,UIPickerViewDelegate>{
     NSMutableDictionary *infoDivtionary;
     UIButton *btn1;
    NSArray *names;
    UIView *pView;
    UIPickerView *picker;
   }

@property(nonatomic,assign) NSString *eduString;

@end

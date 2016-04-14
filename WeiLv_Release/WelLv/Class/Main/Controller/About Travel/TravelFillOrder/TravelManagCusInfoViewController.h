//
//  TravelManagCusInfoViewController.h
//  WelLv
//
//  Created by 张子乾 on 16/2/17.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "CusInfoViewController.h"
#import "XCSuperObjectViewController.h"

@interface TravelManagCusInfoViewController : XCSuperObjectViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    UIButton *zjButton ;
    // UIView *bgChoiceView;
    NSArray *titArray;
    
    
    UITextField *namTextFild;
    UITextField *zjhTextFild;
    UITextField *phoneTextFild;
    UIPickerView *picker;
    UIView *pView;
    
    NSMutableArray *cusInfoArray;
}

@property (strong, nonatomic) UIView *bgimage;
@property (strong, nonatomic) UIButton *zjButton;
//@property (strong, nonatomic) UIView *bgChoiceView;

@property(nonatomic,strong) NSMutableArray *cusInfoArray;

@end

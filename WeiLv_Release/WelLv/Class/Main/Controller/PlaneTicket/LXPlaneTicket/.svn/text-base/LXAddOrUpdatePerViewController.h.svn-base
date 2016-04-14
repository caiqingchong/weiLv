//
//  LXAddOrUpdatePerViewController.h
//  WelLv
//
//  Created by liuxin on 15/9/10.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

typedef enum{
    add,
    updata
}addOrUpdataType;

#import <UIKit/UIKit.h>
#import "LXPlanePersonModel.h"

typedef void(^addOrUpdataBlock)(NSString *str);

@interface LXAddOrUpdatePerViewController : XCSuperObjectViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
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

@property(nonatomic) NSInteger btnIndex;
@property(nonatomic,strong) NSMutableArray *cusInfoArray;

@property (nonatomic,assign) addOrUpdataType addOrUpdata;
@property (nonatomic,strong) LXPlanePersonModel *personModel;
@property (nonatomic,copy) addOrUpdataBlock addOrUpdatablock;

@end

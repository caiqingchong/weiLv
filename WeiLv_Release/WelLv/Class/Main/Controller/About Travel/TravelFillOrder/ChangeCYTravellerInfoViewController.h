//
//  ChangeCYTravellerInfoViewController.h
//  WelLv
//
//  Created by 张子乾 on 16/1/29.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
#import "CYYLModel.h"

@interface ChangeCYTravellerInfoViewController : XCSuperObjectViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
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



//修改订单所需信息
@property (nonatomic,strong) NSString * tag;//出游人标记

@property (nonatomic, strong) NSString *order_IdStr;
@property (nonatomic,strong) NSMutableArray *detaillArray;
@property (nonatomic, strong) NSString *product_CategoryStr;

@property (nonatomic, strong) CYYLModel *travelerInfoModel;


@end

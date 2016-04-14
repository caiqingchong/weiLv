//
//  GuanJiaSelfInfoViewController.h
//  WelLv
//
//  Created by mac for csh on 15/5/14.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"
#import "DateView.h"

@interface GuanJiaSelfInfoViewController : XCSuperObjectViewController<UIScrollViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>{
    NSMutableDictionary *infoDivtionary;
    NSDictionary *infodic;
    
    UIImageView *headImageView;//头像
    UILabel *hometownLbl;      //籍贯
    UILabel *sexLabel;         //性别
    UILabel *QQLabel;          //QQ
    UILabel *emailLabel;       //邮箱
    UILabel *bornDayLabel;     //出生日期
    UILabel *horoscopeLabel;   //星座
    UILabel *educationalLabel; //学历;
    UILabel *occupationLabel;  //职业
    UILabel *regionLabel;      //居住地
    
    
 
   
}


@property (nonatomic ,strong) NSMutableDictionary *infoDivtionary;
@end

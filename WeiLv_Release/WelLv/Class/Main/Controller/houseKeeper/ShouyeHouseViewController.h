//
//  ShouyeHouseViewController.h
//  WelLv
//
//  Created by mac for csh on 15/11/4.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+BoxBlur.h"
#import "YXAutoEditVIew.h"
#import "YXHouseModel.h" 
#import "XCSuperObjectViewController.h"

@interface ShouyeHouseViewController : XCSuperObjectViewController
<UIAlertViewDelegate>
{
    UIScrollView *_scrollView;
    
}
@property (nonatomic,copy)NSString *houseID;                     //管家Id
@property (nonatomic,copy)NSString *houseName;                   //管家姓名
//@property (nonatomic,copy)NSString *travelConsultant;            //旅游顾问
//@property (nonatomic,copy)NSString *xinYongValue;                //信用值
//@property (nonatomic,copy)NSString *packageNumber;               //方案数
//@property (nonatomic,copy)NSString *totalScore;                  //综合评分
//@property (nonatomic,copy)NSString *imageStr;                    //管家头像
@property (nonatomic,assign)NSInteger isBind;                         //是否绑定     0未绑定

@property (nonatomic, assign) BOOL isNeedR;

@end

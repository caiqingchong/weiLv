//
//  HotelReserveSuccess.h
//  WelLv
//
//  Created by James on 15/12/7.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelReserveSuccess : XCSuperObjectViewController{

    //产品名称标题
    UILabel *lblProductNameTitle;
    
    //产品名称
    UILabel *lblProductName;
    
    //入住时间标题
    UILabel *lblHotelCheckTimeTitle;
    
    //入住时间
    UILabel *lblHotelCheckTime;
    
    //离店时间标题
    UILabel *lblHotelOutTimeTitle;
    
    //离店时间
    UILabel *lblHotelOutTime;
    
    //入住人标题
    UILabel *lblHotelCheckPersonTitle;
    
    //入住人
    UILabel *lblHotelCheckPerson;
    
    //最晚到店标题
    UILabel *lblHotelLatestTimeTitle;
    
    //最晚到底
    UILabel *lblHotelLastestTime;
    
    //早餐标题
    UILabel *lblHotelBreakFastTitle;
    
    //早餐
    UILabel *lblHotelBreakFast;
    
    //查看订单按钮
    UIButton *btnLookOrder;
    
    //返回首页
    UIButton *btnBackHome;
}
@property(nonatomic,strong)UIView *firstBackView;
@property(nonatomic,strong)UIView *secondBackView;
@property(nonatomic,strong)UIView *thirdBackView;

@end

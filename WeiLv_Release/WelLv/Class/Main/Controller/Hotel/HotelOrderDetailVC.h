//
//  HotelOrderDetailVC.h
//  WelLv
//
//  Created by James on 15/12/4.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelOrderDetailVC : XCSuperObjectViewController{
 
   //订单酒店名称
    UILabel *lblHotelName;
    
    //房间
    UILabel *lblHotelRoom;
    
    //入住时间标题
    UILabel *lblHotelCheckTimeTitle;
    
    //离店时间标题
    UILabel *lblHotelOutTimeTitle;
    
    //入住人标题
    UILabel *lblHotelCheckPersonTitle;
    
    
    //订单状态
    UILabel *lblHotelOrderStateTitle;
    
    //预定时间
    UILabel *lblHotelReserveTimeTitle;
    
    //订单总额
    UILabel *lblHotelTotalPriceTitle;
    
    
    //入住时间
    UILabel *lblHotelCheckTime;
    
    //离店时间
    UILabel *lblHotelOutTime;
    
    //入住人标题
    UILabel *lblHotelCheckPerson;

    //订单状态
    UILabel *lblHotelOrderState;
    
    //预定时间
    UILabel *lblHotelReserveTime;
    
    //订单总额
    UILabel *lblHotelTotalPrice;
    
    //查看明细按钮
    UIButton *btnShowDetail;
    
}
@property(nonatomic,strong)UIView *firstBackView;
@property(nonatomic,strong)UIView *secondBackView;
@property(nonatomic,strong)UIView *thirdBackView;
@end

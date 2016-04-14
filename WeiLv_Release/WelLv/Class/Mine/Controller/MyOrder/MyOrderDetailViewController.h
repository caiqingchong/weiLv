//
//  MyOrderDetailViewController.h
//  WelLv
//
//  Created by mac for csh on 15/5/5.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"
#import "payRequsestHandler.h"
#import "ZFJSteShopOrderModel.h"

@interface MyOrderDetailViewController : XCSuperObjectViewController<UIScrollViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    UIScrollView *_scrollView;//
    
    UILabel *placeLabel;
    UIView *lineDivider3;
}


@property (nonatomic,copy)NSString *adultNumber;     //成人人数 游学或旅游
@property (nonatomic,copy)NSString *childrenNumber;  //儿童人数 游学或旅游
@property (nonatomic,copy)NSString *adultPrice;     //成人价格  游学或旅游（游学是家长或老师）
@property (nonatomic,copy)NSString *childrenPrice;  //儿童价格  游学或旅游（游学是家长或老师）
@property (nonatomic,copy)NSString *visaPrice;      //签证价格
@property (nonatomic,copy)NSString *sellPrice;       //门票单价
@property (nonatomic,copy)NSString *totalPrice;      //总价格
@property (nonatomic,assign)  NSInteger totalPeople; //总人数
@property (nonatomic,copy)  NSString *timeString;    //出游时间
@property (nonatomic,copy)  NSString *timeStringG;   //下单（预定）时间
@property (nonatomic,copy)  NSString *titltString;   //产品标题
@property (nonatomic,copy)  NSString *startCity;     //出发城市
@property (nonatomic,copy)  NSString *realName;      //预定人名字
@property (nonatomic,copy)  NSString *phone;         //预订人电话
@property (nonatomic,assign)BOOL isTrave;            //是否是lvyou产品名称
@property (nonatomic,strong) NSMutableArray *personArray;//签证申请人数组
@property (nonatomic,strong) NSMutableArray *personArray2; //门票出游人数组
@property (nonatomic,assign) NSInteger stateInteger; //订单状态值
@property (nonatomic,assign) NSInteger payStatusInteger; //支付状态值
@property (nonatomic,assign) NSInteger confirmInteger; //首次确定预定状态值
@property (nonatomic,assign) NSInteger againConfirmInteger; //二次确定预定状态值
@property (nonatomic,assign) NSInteger payTypeInteger;     //游学支付方式 1全款 2定金
@property (nonatomic,assign) NSInteger payWayInteger;      //游学确认方式 1直接付款 2确认后付款
@property (nonatomic,assign) NSInteger earnest_statusInteger;//游学确认后支付定金支付状态 0未付 1已付
@property (nonatomic,copy)  NSString *earnest;         //游学定金金额
@property (nonatomic,copy)  NSString *YXTotalPrice;    //游学订单总额
@property (nonatomic,copy)  NSString *scondOderSN;    //二次支付订单总额
@property(nonatomic,copy)NSString *yoosure_earnest;


@property(nonatomic,copy)NSString *order_id;
@property(nonatomic,copy)NSString *cat_id;
@property(nonatomic,copy)NSString *member_id;
@property(nonatomic,copy)NSString *oneDayTime;
@property(nonatomic,copy)NSString *pepleNum;
@property(nonatomic,strong)ZFJSteShopOrderModel * model;
@end



@interface OrderTextFieldView : UIView

@property (nonatomic,strong)UITextField *nameTextField;
@property (nonatomic,strong)UITextField *phoneTextField;
@property (nonatomic,strong)UIButton *chooseTypeBut;
@property (nonatomic,strong)UILabel *chooseTypeLabel;

- (id)initWithFrame:(CGRect)frame placderName:(NSString *)name placderPhone:(NSString *)phone;
- (id)initWithFrame:(CGRect)frame placderName:(NSString *)name placderPhone:(NSString *)phone chooesType:(BOOL)type;
@end

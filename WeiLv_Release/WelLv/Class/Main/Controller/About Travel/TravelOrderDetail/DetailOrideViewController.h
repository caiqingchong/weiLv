//
//  DetailOrideViewController.h
//  WelLv
//
//  Created by 赵冉 on 16/1/18.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"

@interface DetailOrideViewController : XCSuperObjectViewController
@property(nonatomic,strong)UITableView * tablevc;
@property(nonatomic,strong)UIButton * Lowbutton;// 底部按钮
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,copy)NSString * str;
@property(nonatomic,strong)UILabel * NUm;//订单编号
@property(nonatomic,strong)UILabel * LINE1;//分隔栏
@property(nonatomic,strong)UILabel * LINE2;// 出诱人
@property(nonatomic,assign)NSInteger  num;// 出诱人人数
@property(nonatomic,strong)UILabel * LINE3;//分隔栏
@property(nonatomic,strong)UILabel * LINE4;//分隔栏
@property(nonatomic,strong)UILabel * lowvc;//最底部试图
@property(nonatomic,strong)UIButton * button;//出现隐藏按钮
@property(nonatomic,strong)UIView * Tongzivc;//出团通知
@property(nonatomic,strong)UIButton *buttonLodown;//下载  按钮
@property(nonatomic,strong)UILabel  *titi;// 下载标题
@property(nonatomic,strong)UIButton *imVc;//下载图片
@property(nonatomic,strong)UILabel *JIanJie;//简介
@property(nonatomic,strong)UIImageView *photovc;//通知提示
@property(nonatomic,strong)UILabel *la;//支付下面视图

//请求数据参数
@property(nonatomic,copy)NSString *order_id;
@property(nonatomic,copy)NSString *cat_id;
@property(nonatomic,copy)NSString *member_id;

@property(nonatomic,copy)NSString *notice_id;
//可隐藏按钮
@property(nonatomic,strong)UIButton * Dbutton;
@property (nonatomic,copy)NSString *Ttitle;//通知书状态
@property (nonatomic,copy)NSString *adultNumber;     //成人人数 旅游
@property (nonatomic,copy)NSString *childrenNumber;  //儿童人数 旅游
@property (nonatomic,copy)NSString *adultPrice;     //成人价格  旅游
@property (nonatomic,copy)NSString *childrenPrice;  //儿童价格  旅游

@property (nonatomic,copy)NSString *totalPrice;      //总价格
@property (nonatomic,assign)  NSInteger totalPeople; //总人数
@property (nonatomic,copy)  NSString *timeString;    //出游时间
@property (nonatomic,copy)  NSString *timeStringG;   //下单（预定）时间
@property (nonatomic,copy)  NSString *titltString;   //产品标题
@property (nonatomic,copy)  NSString *startCity;     //出发城市
@property (nonatomic,copy)  NSString *realName;      //预定人名字
@property (nonatomic,copy)  NSString *phone;         //预订人电话
@property (nonatomic,assign)BOOL isTrave;            //是否是lvyou产品名称


@property (nonatomic,assign) NSInteger stateInteger; //订单状态值
@property (nonatomic,assign) NSInteger payStatusInteger; //支付状态值
@property (nonatomic,assign) NSInteger confirmInteger; //首次确定预定状态值
@property (nonatomic,assign) NSInteger againConfirmInteger; //二次确定预定状态值


@property (nonatomic,strong) UIButton * ONEbutton;
@property (nonatomic,strong) UIButton * TWObutton;

@property (nonatomic,strong) UIButton * leftbutt;
@property (nonatomic,strong) UIButton * rightbutt;

@property(nonatomic,assign)BOOL select  ;// 支付方式判断

@property (nonatomic, copy) NSString *frontPageFlag;//判断从哪个页面跳转的标识

@property (nonatomic, copy) NSString *hideArrowFlag;

@end

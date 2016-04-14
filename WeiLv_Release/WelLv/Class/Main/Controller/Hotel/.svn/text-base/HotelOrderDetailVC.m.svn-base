//
//  HotelOrderDetailVC.m
//  WelLv
//
//  Created by James on 15/12/4.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "HotelOrderDetailVC.h"

@interface HotelOrderDetailVC ()

@end

@implementation HotelOrderDetailVC

#pragma mark - 初始化
- (void)viewDidLoad
{
    //父类初始化
    [super viewDidLoad];
    
    //设置当前视图背景颜色
    self.view.backgroundColor=[YXTools stringToColor:@"#F3F8FC"];
    
    //设置当前视图导航视图标题
    self.navigationItem.title=@"订单详情";
    
    //创建第一个背景视图模块
    [self createFirstBackView];
    
    //创建第二个背景视图模块
    [self createSecondBackView];
    
    //创建第三个背景视图模块
    [self createThirdBackView];
}

#pragma mark - 创建第一个背景视图模块
-(void)createFirstBackView{

    //创建视图大小尺寸
    self.firstBackView=[[UIView alloc] initWithFrame:CGRectMake(0,0,windowContentWidth,70)];
    //设备视图背景颜色
    self.firstBackView.backgroundColor=[UIColor whiteColor];
    //把第一个背景视图添加至当前视图
    [self.view addSubview:self.firstBackView];
    
    //创建酒店名称
    lblHotelName=[[UILabel alloc] initWithFrame:CGRectMake(ViewX(self.firstBackView)+10,ViewY(self.firstBackView)+10,windowContentWidth, 20)];
    //设置酒店名称字体大小
    lblHotelName.font=[UIFont systemFontOfSize:15];
    //酒店名称
    lblHotelName.text=@"如家快捷酒店（东大街店）";
    //添加至第一个背景视图
    [self.firstBackView addSubview:lblHotelName];
    
    //创建房间
    lblHotelRoom=[[UILabel alloc] initWithFrame:CGRectMake(ViewX(lblHotelName),ViewBelow(lblHotelName)+10,windowContentWidth,20)];
    //设置房间字体大小
    lblHotelRoom.font=[UIFont systemFontOfSize:12];
    //设置房间字体颜色
    lblHotelRoom.textColor=[YXTools stringToColor:@"#6f7378"];
    //房间
    lblHotelRoom.text=@"大床房 1间";
    //添加至第一个背景视图
    [self.firstBackView addSubview:lblHotelRoom];
    
}

#pragma mark - 创建第二个背景视图模块
-(void)createSecondBackView{
 
    //创建视图尺寸大小
    self.secondBackView=[[UIView alloc] initWithFrame:CGRectMake(ViewX(self.firstBackView),ViewBelow(self.firstBackView)+20,windowContentWidth,120)];
    //设置第视图背景颜色
    self.secondBackView.backgroundColor=[UIColor whiteColor];
    //把第二个背景视图添加至当前视图
    [self.view addSubview:self.secondBackView];
    
    //创建入住时间标题
    lblHotelCheckTimeTitle=[[UILabel alloc] initWithFrame:CGRectMake(ViewX(self.secondBackView)+10,10,80,20)];
    lblHotelCheckTimeTitle.font=[UIFont systemFontOfSize:15];
    lblHotelCheckTimeTitle.textColor=[YXTools stringToColor:@"#757578"];
    lblHotelCheckTimeTitle.text=@"入住时间：";
    [self.secondBackView addSubview:lblHotelCheckTimeTitle];
    
    //创建入住时间
    lblHotelCheckTime=[[UILabel alloc] initWithFrame:CGRectMake(ViewWidth(lblHotelCheckTimeTitle)+5,ViewY(lblHotelCheckTimeTitle),windowContentWidth-ViewWidth(lblHotelCheckTimeTitle),20)];
    lblHotelCheckTime.font=[UIFont systemFontOfSize:15];
    lblHotelCheckTime.text=@"2015-09-03 09:20";
    [self.secondBackView addSubview:lblHotelCheckTime];
    
    //创建分割线
    UIView *line1=[[UIView alloc] initWithFrame:CGRectMake(ViewX(lblHotelCheckTimeTitle)-10,ViewBelow(lblHotelCheckTimeTitle)+10,windowContentWidth,0.5)];
    line1.backgroundColor=[UIColor lightGrayColor];
    line1.alpha=0.5;
    [self.secondBackView addSubview:line1];
    
    //创建离店时间标题
    lblHotelOutTimeTitle=[[UILabel alloc] initWithFrame:CGRectMake(ViewX(line1)+10,ViewBelow(line1)+10,80, 20)];
    lblHotelOutTimeTitle.font=[UIFont systemFontOfSize:15];
    lblHotelOutTimeTitle.textColor=[YXTools stringToColor:@"#757578"];
    lblHotelOutTimeTitle.text=@"离店时间：";
    [self.secondBackView addSubview:lblHotelOutTimeTitle];
    
    //创建离店时间
    lblHotelOutTime=[[UILabel alloc] initWithFrame:CGRectMake(ViewWidth(lblHotelOutTimeTitle)+5,ViewY(lblHotelOutTimeTitle),windowContentWidth-ViewWidth(lblHotelOutTimeTitle),20)];
    lblHotelOutTime.font=[UIFont systemFontOfSize:15];
    lblHotelOutTime.text=@"2015-09-03 09:20";
    [self.secondBackView addSubview:lblHotelOutTime];
    
    //创建分割线
    UIView *line2=[[UIView alloc] initWithFrame:CGRectMake(ViewX(lblHotelOutTimeTitle)-10,ViewBelow(lblHotelOutTimeTitle)+10,windowContentWidth, 0.5)];
    line2.backgroundColor=[UIColor lightGrayColor];
    line2.alpha=0.5;
    [self.secondBackView addSubview:line2];
    
    //创建入住人标题
    lblHotelCheckPersonTitle=[[UILabel alloc] initWithFrame:CGRectMake(ViewX(line2)+10,ViewBelow(line2)+10,80,20)];
    lblHotelCheckPersonTitle.font=[UIFont systemFontOfSize:15];
    lblHotelCheckPersonTitle.textColor=[YXTools stringToColor:@"#757578"];
    lblHotelCheckPersonTitle.text=@"入住人：";
    [self.secondBackView addSubview:lblHotelCheckPersonTitle];
    
    //创建入住人
    lblHotelCheckPerson=[[UILabel alloc] initWithFrame:CGRectMake(ViewWidth(lblHotelCheckPersonTitle)+5,ViewY(lblHotelCheckPersonTitle),windowContentWidth-ViewWidth(lblHotelCheckPersonTitle), 20)];
    lblHotelCheckPerson.font=[UIFont systemFontOfSize:15];
    lblHotelCheckPerson.text=@"李月/张三丰/李晓明/顾向东";
    [self.secondBackView addSubview:lblHotelCheckPerson];
    
    
}

#pragma mark - 创建第三个背景视图模块
-(void)createThirdBackView{
    self.thirdBackView=[[UIView alloc] initWithFrame:CGRectMake(ViewX(self.secondBackView),ViewBelow(self.secondBackView)+20,windowContentWidth, 120)];
    self.thirdBackView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.thirdBackView];
    
    //创建订单状态标题
    lblHotelOrderStateTitle=[[UILabel alloc] initWithFrame:CGRectMake(ViewX(self.thirdBackView)+10,10,80,20)];
    lblHotelOrderStateTitle.font=[UIFont systemFontOfSize:15];
    lblHotelOrderStateTitle.textColor=[YXTools stringToColor:@"#757578"];
    lblHotelOrderStateTitle.text=@"订单状态：";
    [self.thirdBackView addSubview:lblHotelOrderStateTitle];
    
    //创建订单状态
    lblHotelOrderState=[[UILabel alloc] initWithFrame:CGRectMake(ViewWidth(lblHotelOrderStateTitle)+5,ViewY(lblHotelOrderStateTitle),windowContentWidth-ViewWidth(lblHotelOrderStateTitle),20)];
    lblHotelOrderState.font=[UIFont systemFontOfSize:15];
    lblHotelOrderState.text=@"已付款";
    [self.thirdBackView addSubview:lblHotelOrderState];

    //创建分割线
    UIView *line1=[[UIView alloc] initWithFrame:CGRectMake(ViewX(lblHotelOrderStateTitle)-10,ViewBelow(lblHotelOrderStateTitle)+10,windowContentWidth,0.5)];
    line1.backgroundColor=[UIColor lightGrayColor];
    line1.alpha=0.5;
    [self.thirdBackView addSubview:line1];
    
    //创建预定时间标题
    lblHotelReserveTimeTitle=[[UILabel alloc] initWithFrame:CGRectMake(ViewX(line1)+10,ViewBelow(line1)+10,80, 20)];
    lblHotelReserveTimeTitle.font=[UIFont systemFontOfSize:15];
    lblHotelReserveTimeTitle.textColor=[YXTools stringToColor:@"#757578"];
    lblHotelReserveTimeTitle.text=@"预定时间：";
    [self.thirdBackView addSubview:lblHotelReserveTimeTitle];

    //创建预定时间
    lblHotelReserveTime=[[UILabel alloc] initWithFrame:CGRectMake(ViewWidth(lblHotelReserveTimeTitle)+5,ViewY(lblHotelReserveTimeTitle),windowContentWidth-ViewWidth(lblHotelReserveTimeTitle),20)];
    lblHotelReserveTime.font=[UIFont systemFontOfSize:15];
    lblHotelReserveTime.text=@"2015-09-03";
    [self.thirdBackView addSubview:lblHotelReserveTime];
    
    //创建分割线
    UIView *line2=[[UIView alloc] initWithFrame:CGRectMake(ViewX(lblHotelReserveTimeTitle)-10,ViewBelow(lblHotelReserveTimeTitle)+10,windowContentWidth, 0.5)];
    line2.backgroundColor=[UIColor lightGrayColor];
    line2.alpha=0.5;
    [self.thirdBackView addSubview:line2];
    
    //创建入订单总额标题
    lblHotelTotalPriceTitle=[[UILabel alloc] initWithFrame:CGRectMake(ViewX(line2)+10,ViewBelow(line2)+10,80,20)];
    lblHotelTotalPriceTitle.font=[UIFont systemFontOfSize:15];
    lblHotelTotalPriceTitle.textColor=[YXTools stringToColor:@"#757578"];
    lblHotelTotalPriceTitle.text=@"订单总额：";
    [self.thirdBackView addSubview:lblHotelTotalPriceTitle];
    
    //创建订单总额
    lblHotelTotalPrice=[[UILabel alloc] initWithFrame:CGRectMake(ViewWidth(lblHotelTotalPriceTitle)+5,ViewY(lblHotelTotalPriceTitle),160, 20)];
    lblHotelTotalPrice.font=[UIFont systemFontOfSize:15];
    lblHotelTotalPrice.textColor=[YXTools stringToColor:@"#ff5d42"];
    lblHotelTotalPrice.text=@"￥3569";
    [self.thirdBackView addSubview:lblHotelTotalPrice];
    
    //创建查看明细按钮
    btnShowDetail=[UIButton buttonWithType:UIButtonTypeSystem];
    btnShowDetail.frame=CGRectMake(windowContentWidth-100,ViewY(lblHotelTotalPrice)-6,80,30);
    [btnShowDetail setTitle:@"查看明细" forState:UIControlStateNormal];
    btnShowDetail.backgroundColor=[YXTools stringToColor:@"#FF7273"];
    btnShowDetail.tintColor=[UIColor whiteColor];
    btnShowDetail.layer.masksToBounds=YES;
    btnShowDetail.layer.cornerRadius=5.0;
    [self.thirdBackView addSubview:btnShowDetail];
    
}


#pragma  mark - 内存警告
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

@end

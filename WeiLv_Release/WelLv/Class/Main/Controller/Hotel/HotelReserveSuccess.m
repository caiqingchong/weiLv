//
//  HotelReserveSuccess.m
//  WelLv
//
//  Created by James on 15/12/7.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "HotelOrderDetailVC.h"
#import "HotelReserveSuccess.h"

@implementation HotelReserveSuccess

#pragma mark - 初始化
- (void)viewDidLoad
{
    //初始化父类
    [super viewDidLoad];
    
    //设置当前视图背景颜色
    self.view.backgroundColor=[YXTools stringToColor:@"#F3F8FC"];
    
    //设置导航标题
    self.navigationItem.title=@"预订成功";
    
    //隐藏返回按钮
    self.backBtn.hidden=YES;
    
    //创建订单预定成功信息
    [self createOrderReserveSuccessMsg];
    
    //创建第一个背景视图
    [self createFirstBackView];
    
    //创建第二个背景视图
    [self createSecondBackView];
    
    //创建查看订单和返回首页按钮
    [self createLookOrderAndBackHome];
}

#pragma mark - 创建订单预定成功信息
-(void)createOrderReserveSuccessMsg{

    //创建完成状态图标
    UIImage *imageSuccess=[UIImage imageNamed:@"完成"];
    UIButton *btnSuccess=[UIButton buttonWithType:UIButtonTypeCustom];
    btnSuccess.frame=CGRectMake(20, 10,imageSuccess.size.width,imageSuccess.size.height);
    [btnSuccess setImage:imageSuccess forState:UIControlStateNormal];
    btnSuccess.userInteractionEnabled=false;
    [self.view addSubview:btnSuccess];
    
    //创建订单预定成功信息
    UILabel *lblRecSuccessMsg=[[UILabel alloc] initWithFrame:CGRectMake(ViewRight(btnSuccess)+5,-10,windowContentWidth-ViewWidth(btnSuccess)-30,85)];
    lblRecSuccessMsg.numberOfLines=2;
    lblRecSuccessMsg.font=[UIFont systemFontOfSize:18];
    lblRecSuccessMsg.text=@"您的订单已经预订成功，祝您有个愉快的旅程！";
    [self.view addSubview:lblRecSuccessMsg];
    
}

#pragma mark - 创建第一个背景视图
-(void)createFirstBackView{

    //创建第一个背景视图
    self.firstBackView=[[UIView alloc] initWithFrame:CGRectMake(0,60,windowContentWidth,40)];
    self.firstBackView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.firstBackView];
    
    //创建产品名称标题
    lblProductNameTitle=[[UILabel alloc] initWithFrame:CGRectMake(ViewX(self.firstBackView)+10,10,80, 20)];
    lblProductNameTitle.font=[UIFont systemFontOfSize:15];
    lblProductNameTitle.text=@"产品名称：";
    [self.firstBackView addSubview:lblProductNameTitle];
    
    //创建产品名称
    lblProductName=[[UILabel alloc] initWithFrame:CGRectMake(ViewRight(lblProductNameTitle),ViewY(lblProductNameTitle),windowContentWidth-ViewWidth(lblProductNameTitle)-10,20)];
    lblProductName.font=[UIFont systemFontOfSize:15];
    lblProductNameTitle.textAlignment=NSTextAlignmentRight;
    lblProductName.textColor=[YXTools stringToColor:@"#FF9600"];
    lblProductName.text=@"如家快捷酒店（东大街店）";
    [self.firstBackView addSubview:lblProductName];
    
}

#pragma mark - 创建第二个背景视图
-(void)createSecondBackView{

    //创建第二个背景视图
    self.secondBackView=[[UIView alloc] initWithFrame:CGRectMake(ViewX(self.firstBackView),ViewBelow(self.firstBackView)+20,windowContentWidth,200)];
    self.secondBackView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.secondBackView];
    
    //创建入住时间标题
    lblHotelCheckTimeTitle=[[UILabel alloc] initWithFrame:CGRectMake(ViewX(self.secondBackView)+10,10,80,20)];
    lblHotelCheckTimeTitle.font=[UIFont systemFontOfSize:15];
    lblHotelCheckTimeTitle.text=@"入住时间：";
    [self.secondBackView addSubview:lblHotelCheckTimeTitle];
    
    //创建入住时间
    lblHotelCheckTime=[[UILabel alloc] initWithFrame:CGRectMake(ViewRight(lblHotelCheckTimeTitle),ViewY(lblHotelCheckTimeTitle),windowContentWidth-ViewWidth(lblHotelCheckTimeTitle)-10,20)];
    lblHotelCheckTime.font=[UIFont systemFontOfSize:15];
    lblProductNameTitle.textAlignment=NSTextAlignmentRight;
    lblHotelCheckTime.textColor=[YXTools stringToColor:@"#FF9600"];
    lblHotelCheckTime.text=@"2015-04-05 09:20";
    [self.secondBackView addSubview:lblHotelCheckTime];
    
    //创建分割线
    UIView *line1=[[UIView alloc] initWithFrame:CGRectMake(ViewX(lblHotelCheckTimeTitle)-10,ViewBelow(lblHotelCheckTimeTitle)+10,windowContentWidth,0.5)];
    line1.backgroundColor=[UIColor lightGrayColor];
    line1.alpha=0.5;
    [self.secondBackView addSubview:line1];
    
    
    //创建离店时间标题
    lblHotelOutTimeTitle=[[UILabel alloc] initWithFrame:CGRectMake(ViewX(line1)+10,ViewBelow(line1)+10,80,20)];
    lblHotelOutTimeTitle.font=[UIFont systemFontOfSize:15];
    lblHotelOutTimeTitle.text=@"离店时间：";
    [self.secondBackView addSubview:lblHotelOutTimeTitle];
    
    //创建离店时间
    lblHotelOutTime=[[UILabel alloc] initWithFrame:CGRectMake(ViewWidth(lblHotelOutTimeTitle)+5,ViewY(lblHotelOutTimeTitle),windowContentWidth-ViewWidth(lblHotelOutTimeTitle),20)];
    lblHotelOutTime.font=[UIFont systemFontOfSize:15];
    lblHotelOutTime.textColor=[YXTools stringToColor:@"#FF9600"];
    lblHotelOutTime.text=@"2015-04-06 10:20";
    [self.secondBackView addSubview:lblHotelOutTime];
    
    //创建分割线
    UIView *line2=[[UIView alloc] initWithFrame:CGRectMake(ViewX(lblHotelOutTimeTitle)-10,ViewBelow(lblHotelOutTimeTitle)+10,windowContentWidth, 0.5)];
    line2.backgroundColor=[UIColor lightGrayColor];
    line2.alpha=0.5;
    [self.secondBackView addSubview:line2];
    
    //创建入住人标题
    lblHotelCheckPersonTitle=[[UILabel alloc] initWithFrame:CGRectMake(ViewX(line2)+10,ViewBelow(line2)+10,80,20)];
    lblHotelCheckPersonTitle.font=[UIFont systemFontOfSize:15];
    lblHotelCheckPersonTitle.text=@"入住人：";
    [self.secondBackView addSubview:lblHotelCheckPersonTitle];
    
    //创建入住人
    lblHotelCheckPerson=[[UILabel alloc] initWithFrame:CGRectMake(ViewWidth(lblHotelCheckPersonTitle)+5,ViewY(lblHotelCheckPersonTitle),windowContentWidth-ViewWidth(lblHotelCheckPersonTitle), 20)];
    lblHotelCheckPerson.font=[UIFont systemFontOfSize:15];
    lblHotelCheckPerson.textColor=[YXTools stringToColor:@"#FF9600"];
    lblHotelCheckPerson.text=@"李月/张三丰/李晓明/顾向东";
    [self.secondBackView addSubview:lblHotelCheckPerson];
    
    //创建分割线
    UIView *line3=[[UIView alloc] initWithFrame:CGRectMake(ViewX(lblHotelCheckPersonTitle)-10,ViewBelow(lblHotelCheckPersonTitle)+10,windowContentWidth, 0.5)];
    line3.backgroundColor=[UIColor lightGrayColor];
    line3.alpha=0.5;
    [self.secondBackView addSubview:line3];
    
    //创建最晚到店标题
    lblHotelLatestTimeTitle=[[UILabel alloc] initWithFrame:CGRectMake(ViewX(line3)+10,ViewBelow(line3)+10,80,20)];
    lblHotelLatestTimeTitle.font=[UIFont systemFontOfSize:15];
    lblHotelLatestTimeTitle.text=@"最晚到店：";
    [self.secondBackView addSubview:lblHotelLatestTimeTitle];
    
    //创建最晚到店
    lblHotelLastestTime=[[UILabel alloc] initWithFrame:CGRectMake(ViewWidth(lblHotelLatestTimeTitle)+5,ViewY(lblHotelLatestTimeTitle),windowContentWidth-ViewWidth(lblHotelLatestTimeTitle), 20)];
    lblHotelLastestTime.font=[UIFont systemFontOfSize:15];
    lblHotelLastestTime.textColor=[YXTools stringToColor:@"#FF9600"];
    lblHotelLastestTime.text=@"2015-10-01 02:00";
    [self.secondBackView addSubview:lblHotelLastestTime];

    //创建分割线
    UIView *line4=[[UIView alloc] initWithFrame:CGRectMake(ViewX(lblHotelLatestTimeTitle)-10,ViewBelow(lblHotelLatestTimeTitle)+10,windowContentWidth, 0.5)];
    line4.backgroundColor=[UIColor lightGrayColor];
    line4.alpha=0.5;
    [self.secondBackView addSubview:line4];
    
    //创建早餐标题
    lblHotelBreakFastTitle=[[UILabel alloc] initWithFrame:CGRectMake(ViewX(line4)+10,ViewBelow(line4)+10,80,20)];
    lblHotelBreakFastTitle.font=[UIFont systemFontOfSize:15];
    lblHotelBreakFastTitle.text=@"早餐：";
    [self.secondBackView addSubview:lblHotelBreakFastTitle];
    
    //创建早餐
    lblHotelBreakFast=[[UILabel alloc] initWithFrame:CGRectMake(ViewWidth(lblHotelBreakFastTitle)+5,ViewY(lblHotelBreakFastTitle),windowContentWidth-ViewWidth(lblHotelBreakFastTitle), 20)];
    lblHotelBreakFast.font=[UIFont systemFontOfSize:15];
    lblHotelBreakFast.textColor=[YXTools stringToColor:@"#FF9600"];
    lblHotelBreakFast.text=@"无早";
    [self.secondBackView addSubview:lblHotelBreakFast];

    
}

#pragma mark - 创建查看订单和返回首页按钮
-(void)createLookOrderAndBackHome{
   //声明按钮背景图
    UIImage *imageLookOrder=[UIImage imageNamed:@"查看订单"];
    UIImage *imageBackHome=[UIImage imageNamed:@"hotel_order_backhome"];
    
    //创建查看订单按钮
    btnLookOrder=[UIButton buttonWithType:UIButtonTypeCustom];
    btnLookOrder.frame=CGRectMake(ViewX(self.secondBackView)+10,ViewBelow(self.secondBackView)+30,windowContentWidth/2-20,imageLookOrder.size.height);
    btnLookOrder.tintColor=[UIColor whiteColor];
    [btnLookOrder setBackgroundImage:imageLookOrder forState:UIControlStateNormal];
    [btnLookOrder setTitle:@"查看订单" forState:UIControlStateNormal];
    [btnLookOrder addTarget:self action:@selector(LookOrderEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLookOrder];
    
    //创建返回首页按钮
    btnBackHome=[UIButton buttonWithType:UIButtonTypeCustom];
    btnBackHome.frame=CGRectMake(ViewRight(btnLookOrder)+20,ViewY(btnLookOrder),windowContentWidth/2-20,imageBackHome.size.height);
    btnBackHome.tintColor=[UIColor whiteColor];
    [btnBackHome setBackgroundImage:imageBackHome forState:UIControlStateNormal];
    [btnBackHome addTarget:self action:@selector(BackHomeEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btnBackHome setTitle:@"返回首页" forState:UIControlStateNormal];
    [self.view addSubview:btnBackHome];
    
}

#pragma mark - 查看订单 点击事件
-(void)LookOrderEvent:(UIButton *)sender{
  
    HotelOrderDetailVC *orderDetailPage=[[HotelOrderDetailVC alloc] init];
    [self.navigationController pushViewController:orderDetailPage animated:YES];
}

#pragma  mark - 返回首页 点击事件
-(void)BackHomeEvent:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma  mark - 内存警告
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

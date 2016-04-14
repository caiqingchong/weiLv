//
//  PlaneTicketViewController.m
//  WelLv
//
//  Created by mac for csh on 15/9/17.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "PlaneTicketViewController.h"
#import "LXCommonTools.h"
#import "YXAutoEditVIew.h"
#import "AFNetworking.h"
#import "MyOrderTableViewCOntroller.h"
#import "PartnerConfig.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "YXPaySuccessViewController.h"
#import "LXCommonTools.h"
#import "JYCreturnTicketVC.h"
#import "LXUserTool.h"

#import "WXApi.h"
#import "WXApiObject.h"

@interface PlaneTicketViewController (){
    NSString *titltString;
    NSString *timeStringG;//预定时间
    NSString *phone;
    NSString *totalPrice;
    NSString *passengerNUm;
    NSString *contacts;
    NSInteger stateInteger;
    NSInteger payStatusInteger;
    
    NSDictionary *flightsDic;
    NSArray *passengerArr;
    
    UIView *pricListView;
    UIView *lastView;
    
    payRequsestHandler *req;
    NSString *orderNum;
    UILabel *paystateLabel;
    UIButton *submitBtn;
    UIButton *cancelBtn;
    NSMutableArray *_btnViewArray;
    NSInteger _btnIndex;
    
    NSString *q_price;
    NSString *f_price;
    NSString *q_tax;
    NSString *f_tax;
    NSString *q_oil;
    NSString *f_oil;
    NSString *baoxiannum;
}

@end

@implementation PlaneTicketViewController
@synthesize order_id,cat_id,member_id;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"订单详情"];
    self.view.backgroundColor = BgViewColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateOrderPayResult:) name:ORDER_PAY_NOTIFICATION object:nil];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    [self initData];
}

-(void) initData{
    //请求数据
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *md5str = [NSString stringWithFormat:@"~0;id<zOD.{ll@]JKi(:%@",[[LXUserTool alloc] getUid]];
    md5str = [WXUtil md5:md5str];
    NSLog(@"order is %@ catid is %@ memberid is %@",order_id,cat_id,member_id);
    NSDictionary *parameters = @{@"order_id":order_id,@"cat_id":cat_id,@"member_id":[[LXUserTool alloc] getUid],@"wltoken":md5str};
    [manager POST:GetOrderInfoUrl parameters:parameters
     
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
              NSLog(@"dict = %@     \n   %@",dict,[dict objectForKey:@"msg"]);
              //判定是否是下架产品
              if(![[dict objectForKey:@"data"] isKindOfClass:[NSDictionary class]]){
                  [[LXAlterView sharedMyTools] createTishi:@"获取数据失败:)"];
              }else if (![[dict objectForKey:@"data"] objectForKey:@"order_sn"]) {
                  NSLog(@"订单已下架");
                  UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"很遗憾" message:@"该产品已下架，如有疑问请联系您的管家" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                  altView.tag = 1;
                  [altView show];
              }
              if ([[dict objectForKey:@"state"] integerValue] == 1) {
                  NSDictionary *dict1 = [dict objectForKey:@"data"];                                       //--------预定时间
                  NSString *BookTimeString = [dict1 objectForKey:@"create_time"];
                  NSTimeInterval bookTime = [BookTimeString doubleValue] ;
                  NSDate *detaildatee=[NSDate dateWithTimeIntervalSince1970:bookTime];
                  NSDateFormatter *dateFormatterr = [[NSDateFormatter alloc] init];
                  [dateFormatterr setDateFormat:@"yyyy-MM-dd"];
                  timeStringG = [dateFormatterr stringFromDate: detaildatee];
                  
                  totalPrice = [dict1 objectForKey:@"order_price"];                                          //-------- 订单总额
                  orderNum = [dict1 objectForKey:@"order_sn"];                                               //-------- 订单号
                  passengerNUm = [NSString stringWithFormat:@"%@",[dict1 objectForKey:@"num"]];              //-------- 订单人数
                  contacts = [dict1 objectForKey:@"contacts"];                                               //-------- 联系人
                  phone = [dict1 objectForKey:@"phone"];
                  
                  
                  flightsDic = [[NSDictionary alloc] init];
                  flightsDic = [dict1 objectForKey:@"flights"]; //[[dict1 objectForKey:@"flights"] objectFromJSONString];
                  passengerArr = [[NSArray alloc] init];
                  passengerArr = [dict1 objectForKey:@"passenger"];//[LXTools JSONValue:[dict1 objectForKey:@"passenger"]];
                  titltString = [dict1 objectForKey:@"product_name"];                                        //-------- 产品标题
                  
                  q_price = [[flightsDic objectForKey:@"q"] objectForKey:@"Sale"];
                  q_tax = [[flightsDic objectForKey:@"q"] objectForKey:@"Tax"];
                  q_oil = [[flightsDic objectForKey:@"q"] objectForKey:@"Oil"];
                  if (![flightsDic objectForKey:@"leixing"] || [[flightsDic objectForKey:@"leixing"] isEqualToString:@"往返"] || ![[flightsDic objectForKey:@"leixing"] isEqualToString:@"单程"]) {
                      f_price = [[flightsDic objectForKey:@"f"] objectForKey:@"Sale"];
                      f_tax = [[flightsDic objectForKey:@"f"] objectForKey:@"Tax"];
                      f_oil = [[flightsDic objectForKey:@"f"] objectForKey:@"Oil"];
                  }
                  baoxiannum = [dict1 objectForKey:@"baoxiannum"] ;
                  
                  
                  stateInteger = [[dict1 objectForKey:@"order_status"] integerValue];                         //--------订单状态
                  payStatusInteger = [[dict1 objectForKey:@"pay_status"] integerValue];                       //--------支付状态
                  
                  [self initView];
                  
                  // 支付状态未支付  ，订单状态新订单   并且产品的memberid == 当前登录人的uid
                  if(payStatusInteger == 0 && stateInteger != 11 && [self.member_id isEqualToString:[[LXUserTool alloc] getUid]]){
                      [self loadPayView];
                      //[self loadRefundView];
                  }else if(payStatusInteger == 1 && stateInteger != 11 && [self.member_id isEqualToString:[[LXUserTool alloc] getUid]]){
                      [self loadRefundView];
                  }
                  
              }else{
                  [[LXAlterView sharedMyTools] createTishi:@"获取数据失败"];
              }
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              
          }];
}

-(void)initView{
    float location = 0;
    if ([flightsDic objectForKey:@"leixing"] && [[flightsDic objectForKey:@"leixing"] isEqualToString:@"单程"]) {
        CGRect frame = CGRectMake(0, location, windowContentWidth, 45*3);
        NSString *title = [NSString stringWithFormat:@"单程 %@ %@",[[flightsDic objectForKey:@"q"] objectForKey:@"FlightNo"],[[flightsDic objectForKey:@"q"] objectForKey:@"CabinName"]];
        NSString *time = [[flightsDic objectForKey:@"q"] objectForKey:@"OffTime"];
        NSString *airport = [NSString stringWithFormat:@"%@-%@",[[[flightsDic objectForKey:@"q"] objectForKey:@"sport"] objectForKey:@"short_name"],[[[flightsDic objectForKey:@"q"] objectForKey:@"eport"] objectForKey:@"short_name"]];
        PlaneMessage *planeView = [[PlaneMessage alloc] initWithFrame:frame titleString:title timeString:time ariportString:airport];
        location = location +45*3;
        [_scrollView addSubview:planeView];
    }else /*if ([[flightsDic objectForKey:@"leixing"] isEqualToString:@"往返"])*/{
        CGRect frame1 = CGRectMake(0, location, windowContentWidth, 45*3);
        NSString *title1 = [NSString stringWithFormat:@"去程 %@ %@",[[flightsDic objectForKey:@"q"] objectForKey:@"FlightNo"],[[flightsDic objectForKey:@"q"] objectForKey:@"CabinName"]];
        NSString *time1 = [[flightsDic objectForKey:@"q"] objectForKey:@"OffTime"];
        NSString *airport1 = [NSString stringWithFormat:@"%@-%@",[[[flightsDic objectForKey:@"q"] objectForKey:@"sport"] objectForKey:@"short_name"],[[[flightsDic objectForKey:@"q"] objectForKey:@"eport"] objectForKey:@"short_name"]];
        PlaneMessage *planeView1 = [[PlaneMessage alloc] initWithFrame:frame1 titleString:title1 timeString:time1 ariportString:airport1];
        location = location +45*3;
        [_scrollView addSubview:planeView1];
        
        CGRect frame2 = CGRectMake(0, location, windowContentWidth, 45*3);
        NSString *title2 = [NSString stringWithFormat:@"返程 %@ %@",[[flightsDic objectForKey:@"f"] objectForKey:@"FlightNo"],[[flightsDic objectForKey:@"f"] objectForKey:@"CabinName"]];
        NSString *time2 = [[flightsDic objectForKey:@"f"] objectForKey:@"OffTime"];
        NSString *airport2 = [NSString stringWithFormat:@"%@-%@",[[[flightsDic objectForKey:@"f"] objectForKey:@"sport"] objectForKey:@"short_name"],[[[flightsDic objectForKey:@"f"] objectForKey:@"eport"] objectForKey:@"short_name"]];
        PlaneMessage *planeView2 = [[PlaneMessage alloc] initWithFrame:frame2 titleString:title2 timeString:time2 ariportString:airport2];
        location = location +45*3;
        [_scrollView addSubview:planeView2];
    }
    
    location = location+15;
    
    //订单编号
    UIView *orderNOlab = [[PlaneMessage alloc] initWithFrame:CGRectMake(0, location, windowContentWidth, 45) string1:@"订单编号：" string2:orderNum];
    [_scrollView addSubview:orderNOlab];
    location = location +45;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,location-0.5 , windowContentWidth, 0.5)];
    label.layer.borderColor = bordColor.CGColor;
    label.layer.borderWidth= 0.33;
    [_scrollView addSubview:label];
    
    
    //订单状态
    NSString *payStatusString = @"";
    if (payStatusInteger == 0 && stateInteger != 11) {
        payStatusString = @"待付款";
    }else if(payStatusInteger == 0 && stateInteger == 11){
        payStatusString = @"已取消";
    }else if(payStatusInteger == 1){
        payStatusString = @"已付款";
    }
    UIView *payStatelab = [[PlaneMessage alloc] initWithFrame:CGRectMake(0, location, windowContentWidth, 45) string1:@"订单状态：" string2:payStatusString];
    [_scrollView addSubview:payStatelab];
    location = location +45;
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0,location-0.5 , windowContentWidth, 0.5)];
    label1.layer.borderColor = bordColor.CGColor;
    label1.layer.borderWidth= 0.33;
    [_scrollView addSubview:label1];
    
    
    //预定时间
    UIView *timelab = [[PlaneMessage alloc] initWithFrame:CGRectMake(0, location, windowContentWidth, 45) string1:@"预定时间：" string2:timeStringG];
    [_scrollView addSubview:timelab];
    location = location +45;
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0,location-0.5 , windowContentWidth, 0.5)];
    label2.layer.borderColor = bordColor.CGColor;
    label2.layer.borderWidth= 0.33;
    [_scrollView addSubview:label2];
    
    //乘机人数
    UIView *numlab = [[PlaneMessage alloc] initWithFrame:CGRectMake(0, location, windowContentWidth, 45) string1:@"乘机人：" string2: passengerNUm];
    [_scrollView addSubview:numlab];
    location = location +45;
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0,location-0.5 , windowContentWidth, 0.5)];
    label3.layer.borderColor = bordColor.CGColor;
    label3.layer.borderWidth= 0.33;
    [_scrollView addSubview:label3];
    
    
    //订单总额
    UILabel *labe11 = [[UILabel alloc] initWithFrame:CGRectMake(Begin_X, location, windowContentWidth -Begin_X*2, 45)];
    labe11.font = [UIFont systemFontOfSize:16];
    labe11.backgroundColor = [UIColor whiteColor];
    labe11.textAlignment = NSTextAlignmentLeft;
    labe11.textColor = [UIColor grayColor];
    labe11.text = @"订单总额：";
    [_scrollView addSubview:labe11];
    
    UILabel *labe22= [[UILabel alloc] initWithFrame:CGRectMake(100, location, windowContentWidth -100, 45)];
    labe22.font = [UIFont systemFontOfSize:16];
    labe22.textAlignment = NSTextAlignmentLeft;
    labe22.textColor = [UIColor redColor];
    labe22.text = [NSString stringWithFormat:@"￥%@",totalPrice];
    [_scrollView addSubview:labe22];
    
    UIButton *buttonPrice = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonPrice setTitle:@"查看明细" forState:UIControlStateNormal];
    buttonPrice.backgroundColor = [UIColor redColor];
    buttonPrice.titleLabel.font = [UIFont systemFontOfSize:16];
    [buttonPrice setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonPrice.frame = CGRectMake(ViewWidth(_scrollView)-100, location +7,90 , 31);
    [buttonPrice.layer setCornerRadius:6.0];
    [buttonPrice addTarget:self action:@selector(PriceList) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:buttonPrice];
    
    location = location +45;
    location = location +15;
    
    
    //乘机人
    CGFloat hegiht;
    if (passengerArr.count<=3) {
        hegiht=40;
    }else if (passengerArr.count<=6 && passengerArr.count>3){
        hegiht=80;
    }else{
        hegiht=120;
    }
    YXAutoEditVIew *contactLable = [[YXAutoEditVIew alloc] initWithFrame:CGRectMake(0,location,windowContentWidth , hegiht)];
    contactLable.titleLable.text = @"乘机人:";
    contactLable.titleLable.textColor = [UIColor grayColor];
    contactLable.titleLable.font = [UIFont systemFontOfSize:16];
    contactLable.contentLabel.textAlignment = 2;
    contactLable.contentLabel.textColor = [UIColor orangeColor];
    contactLable.line.hidden=YES;
    [_scrollView addSubview:contactLable];
    
    CGFloat whit=windowContentWidth/4;
    for (int i =0; i<passengerArr.count; i++) {
        
        UIView *fareView=[[UIView alloc] initWithFrame:CGRectMake((windowContentWidth/4-15)+(i%3)*(whit), 5+(i/3)*35, whit-10, 30)];
        fareView.backgroundColor=kColor(76, 216, 134);
        [contactLable addSubview:fareView];
        
        UIImageView *image=[[UIImageView alloc] init];
        image.frame=CGRectMake(3, 7, 11, 16);
        image.image=[UIImage imageNamed:@"乘机人"];
        [fareView addSubview:image];
        
        UILabel *fareLab=[YXTools allocLabel:[[passengerArr objectAtIndex:i] valueForKey:@"pname"] font:systemFont(14) textColor:[UIColor whiteColor] frame:CGRectMake(20, 0, ViewWidth(fareView)-20, 30) textAlignment:0];
        [fareView addSubview:fareLab];
    }
    location = location + hegiht;
    
    
    //联系人
    UIView *contactslab = [[PlaneMessage alloc] initWithFrame:CGRectMake(0, location, windowContentWidth, 45) string1:@"联系人：" string2: contacts];
    [_scrollView addSubview:contactslab];
    location = location +45;
    
    
    
    _scrollView.contentSize = CGSizeMake(0, location +200);
    lastView = [[UIView alloc] initWithFrame:CGRectMake(0, location+15, ViewWidth(_scrollView), 0)];
    [_scrollView addSubview:lastView];
}

//查看明细
-(void)PriceList{
//    if (pricListView) {
//        [pricListView removeFromSuperview];
//    }
    pricListView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64)];
    pricListView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.8];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [self.view addSubview:pricListView];
    
    UIView *vieww = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(pricListView) -200-40, ViewWidth(pricListView), 200+40)];
    vieww.backgroundColor = [UIColor whiteColor];
    [pricListView addSubview:vieww];
    UILabel *label = [YXTools allocLabel:@"费用明细" font:systemFont(18) textColor: [UIColor orangeColor] frame:CGRectMake(0, 0, ViewWidth(vieww), 60) textAlignment:1];
    [vieww addSubview:label];
    if ([flightsDic objectForKey:@"leixing"] && [[flightsDic objectForKey:@"leixing"] isEqualToString:@"单程"]) {
        UILabel *label1 = [YXTools allocLabel:@"机票" font:systemFont(17) textColor: [UIColor grayColor] frame:CGRectMake(20, ViewY(label) + ViewHeight(label), ViewWidth(vieww)-40, 40) textAlignment:0];
        UILabel *label11 = [YXTools allocLabel:[NSString stringWithFormat:@"￥%@*%@",q_price,passengerNUm] font:systemFont(17) textColor: [UIColor blackColor] frame:CGRectMake(20, ViewY(label) + ViewHeight(label), ViewWidth(vieww)-40, 40) textAlignment:2];
        [vieww addSubview:label1];[vieww addSubview:label11];
        
        UILabel *label2 = [YXTools allocLabel:@"机建+燃油费" font:systemFont(17) textColor: [UIColor grayColor] frame:CGRectMake(20, ViewY(label1) + ViewHeight(label1), ViewWidth(vieww)-40, 40) textAlignment:0];
        float oilAndTax = ([q_tax floatValue] + [q_oil floatValue])*[passengerNUm integerValue];
        NSString *pstring = [NSString stringWithFormat:@"%.0f",oilAndTax];
        UILabel *label22 = [YXTools allocLabel:[NSString stringWithFormat:@"￥%@",pstring] font:systemFont(17) textColor: [UIColor blackColor] frame:CGRectMake(20, ViewY(label1) + ViewHeight(label1), ViewWidth(vieww)-40, 40) textAlignment:2];
        [vieww addSubview:label2];[vieww addSubview:label22];
        
        UILabel *label3 = [YXTools allocLabel:@"保险" font:systemFont(17) textColor: [UIColor grayColor] frame:CGRectMake(20, ViewY(label2) + ViewHeight(label2), ViewWidth(vieww)-40, 40) textAlignment:0];
        UILabel *label33 = [YXTools allocLabel:[NSString stringWithFormat:@"￥20*%@",baoxiannum] font:systemFont(17) textColor: [UIColor blackColor] frame:CGRectMake(20, ViewY(label2) + ViewHeight(label2), ViewWidth(vieww)-40, 40) textAlignment:2];
        [vieww addSubview:label3];[vieww addSubview:label33];
        
        UILabel *labelaaa = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewY(label3) + ViewHeight(label3), ViewWidth(_scrollView), 0.5)];
        labelaaa.layer.borderColor = [UIColor orangeColor].CGColor;
        labelaaa.layer.borderWidth= 1;
        [vieww addSubview:labelaaa];
        
        UILabel *label4 = [YXTools allocLabel:@"总额" font:systemFont(18) textColor: [UIColor blackColor] frame:CGRectMake(20, ViewY(labelaaa) + ViewHeight(labelaaa), ViewWidth(vieww)-40, 59) textAlignment:0];
        UILabel *label44 = [YXTools allocLabel:[NSString stringWithFormat:@"￥%@",totalPrice] font:systemFont(18) textColor: [UIColor redColor] frame:CGRectMake(20, ViewY(labelaaa) + ViewHeight(labelaaa), ViewWidth(vieww)-40, 59) textAlignment:2];
        [vieww addSubview:label4];[vieww addSubview:label44];
        
    }else{
        UILabel *label1 = [YXTools allocLabel:@"机票" font:systemFont(17) textColor: [UIColor grayColor] frame:CGRectMake(20, ViewY(label) + ViewHeight(label), ViewWidth(vieww)-40, 40) textAlignment:0];
        UILabel *label11 = [YXTools allocLabel:[NSString stringWithFormat:@"￥(%@+%@)*%@",q_price,f_price,passengerNUm] font:systemFont(17) textColor: [UIColor blackColor] frame:CGRectMake(20, ViewY(label) + ViewHeight(label), ViewWidth(vieww)-40, 40) textAlignment:2];
        [vieww addSubview:label1];[vieww addSubview:label11];
        
        UILabel *label2 = [YXTools allocLabel:@"机建+燃油费" font:systemFont(17) textColor: [UIColor grayColor] frame:CGRectMake(20, ViewY(label1) + ViewHeight(label1), ViewWidth(vieww)-40, 40) textAlignment:0];
        float oilAndTax = ([q_tax floatValue] + [q_oil floatValue] + [f_tax floatValue] + [f_oil floatValue])*[passengerNUm integerValue];
        NSString *pstring = [NSString stringWithFormat:@"%.0f",oilAndTax];
        UILabel *label22 = [YXTools allocLabel:[NSString stringWithFormat:@"￥%@",pstring] font:systemFont(17) textColor: [UIColor blackColor] frame:CGRectMake(20, ViewY(label1) + ViewHeight(label1), ViewWidth(vieww)-40, 40) textAlignment:2];
        [vieww addSubview:label2];[vieww addSubview:label22];
        
        UILabel *label3 = [YXTools allocLabel:@"保险" font:systemFont(17) textColor: [UIColor grayColor] frame:CGRectMake(20, ViewY(label2) + ViewHeight(label2), ViewWidth(vieww)-40, 40) textAlignment:0];
        UILabel *label33 = [YXTools allocLabel:[NSString stringWithFormat:@"￥(20+20)*%@",baoxiannum] font:systemFont(17) textColor: [UIColor blackColor] frame:CGRectMake(20, ViewY(label2) + ViewHeight(label2), ViewWidth(vieww)-40, 40) textAlignment:2];
        [vieww addSubview:label3];[vieww addSubview:label33];
        
        UILabel *labelaaa = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewY(label3) + ViewHeight(label3), ViewWidth(_scrollView), 0.5)];
        labelaaa.layer.borderColor = [UIColor orangeColor].CGColor;
        labelaaa.layer.borderWidth= 1;
        [vieww addSubview:labelaaa];
        
        UILabel *label4 = [YXTools allocLabel:@"总额" font:systemFont(18) textColor: [UIColor blackColor] frame:CGRectMake(20, ViewY(labelaaa) + ViewHeight(labelaaa), ViewWidth(vieww)-40, 59) textAlignment:0];
        UILabel *label44 = [YXTools allocLabel:[NSString stringWithFormat:@"￥%@",totalPrice] font:systemFont(18) textColor: [UIColor redColor] frame:CGRectMake(20, ViewY(labelaaa) + ViewHeight(labelaaa), ViewWidth(vieww)-40, 59) textAlignment:2];
        [vieww addSubview:label4];[vieww addSubview:label44];
        
    }
    
    
    
    
    
    
}
-(void)keyboardHide:(UITapGestureRecognizer *)tap{
    pricListView.hidden = YES;
}

-(void)loadRefundView{
    UIButton *refundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    refundBtn.frame = CGRectMake(50,ViewY(lastView)+5, windowContentWidth-100, 45);
    [refundBtn setTitle:@"退票" forState:UIControlStateNormal];
    refundBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    [refundBtn.layer setCornerRadius:6.0];
    [refundBtn setBackgroundColor:kColor(40, 115, 237)];//kColor(215, 221, 225)];
    [refundBtn addTarget:self action:@selector(refund) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:refundBtn];
}

-(void)refund{
    JYCreturnTicketVC *RefundVC = [[JYCreturnTicketVC alloc] init];
    RefundVC.passengerArr = passengerArr;
    RefundVC.orderNo = orderNum;
    [self.navigationController pushViewController:RefundVC animated:YES];
}


-(void)loadPayView{
    
    _btnViewArray = [[NSMutableArray alloc] init];
    NSArray *payArr = [NSArray arrayWithObjects:@"微信支付",@"支付宝支付", nil];
    NSArray *imageArr = [NSArray arrayWithObjects:@"icon_pay_wechat",@"ico_pay_alipay", nil];
    
    if (![WXApi isWXAppInstalled] ) {
        payArr = [NSArray arrayWithObjects:@"支付宝支付", nil];
        imageArr = [NSArray arrayWithObjects:@"ico_pay_alipay", nil];
    }
    
    for (int i = 0 ; i<payArr.count; i++) {
        UIButton *hotBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        hotBtn.frame = CGRectMake(0, ViewHeight(lastView)+ViewY(lastView) +45*i, windowContentWidth, 45);
        // hotBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        // hotBtn.layer.borderWidth = 0.5;
        hotBtn.backgroundColor = [UIColor whiteColor];
        hotBtn.tag = 100+i;
        [hotBtn.layer setCornerRadius:5.0];
        [hotBtn addTarget:self action:@selector(PayStyle:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:hotBtn];
        [_btnViewArray addObject:hotBtn];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ViewX(hotBtn) + ViewWidth(hotBtn) - 15-17, (ViewHeight(hotBtn)-17)/2, 17,17 )];
        if (i == 0) {
            imageView.image = [UIImage imageNamed:@"选中圆圈"];
            _btnIndex = 100;
        } else {
            imageView.image = [UIImage imageNamed:@"未选中圆圈"];
            
        }
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [hotBtn addSubview:imageView];
        
        UIImageView *imageView2 = [YXTools allocImageView:CGRectMake(20, 7, 30, 30) image:[UIImage imageNamed:[imageArr objectAtIndex:i]]];
        [hotBtn addSubview:imageView2];
        
        UILabel *title = [YXTools allocLabel:[payArr objectAtIndex:i] font:systemFont(15) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(imageView2)+ViewWidth(imageView2)+15, 5, 80, 35) textAlignment:0];
        [hotBtn addSubview:title];
        
        if (i==0) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(hotBtn)+ViewHeight(hotBtn)-0.5, windowContentWidth, 0.5)];
            line.backgroundColor = bordColor;
            [_scrollView addSubview:line];
        }
        
    }
    
    //确定支付按钮
    submitBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(windowContentWidth/2, windowContentHeight - 64-40, windowContentWidth/2, 40);
    [submitBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = systemFont(14);
    //[submitBtn setBackgroundImage:[UIImage imageNamed:@"qzddBtn"] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:kColor(253, 215, 66)];
    [submitBtn addTarget:self action:@selector(toPay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    
    //取消订单按钮
    
    cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, windowContentHeight - 64-40, windowContentWidth/2, 40);
    [cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelBtn setBackgroundColor:kColor(114, 115, 116)];//kColor(215, 221, 225)];
    [cancelBtn addTarget:self action:@selector(cancelOrder) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
    
}

-(void)cancelOrder{
    UIAlertView *alerV = [[UIAlertView alloc] initWithTitle:@"确定取消订单?" message:@"订单取消后您将不能继续支付" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alerV.tag = 2;
    [alerV show];
}

#pragma mark ------- alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",buttonIndex);
    switch (alertView.tag) {
        case 1:
            if (buttonIndex == 0) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            break;
            
        case 2:
            if (buttonIndex == 1) {
                //发送网络请求取消订单
                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                NSString *md5str = [NSString stringWithFormat:@"~0;id<zOD.{ll@]JKi(:%@",[[LXUserTool alloc] getUid]];
                md5str = [WXUtil md5:md5str];
                NSLog(@"%@",CancelPlaneOrderUrl     );
                NSDictionary *parameters = @{@"order_id":order_id,@"member_id":[[LXUserTool alloc] getUid]};
                [manager POST:CancelPlaneOrderUrl parameters:parameters
                      success:^(AFHTTPRequestOperation *operation,id responseObject) {
                          NSString *html = operation.responseString;
                          NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
                          NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
                          NSLog(@"%@",responseObject);
                          NSLog(@"dict = %@  \n msg = %@",dict,[dict objectForKey:@"msg"]);
                          if ([[dict objectForKey:@"error"] integerValue] == 0) {
                              //创建通知
                              NSNotification *notification =[NSNotification notificationWithName:@"Tongzhi" object:nil userInfo:[dict objectForKey:@"msg"]];
                              //通过通知中心发送通知
                              [[NSNotificationCenter defaultCenter] postNotification:notification];
                              
                              [self.navigationController popViewControllerAnimated:YES];
                          }
                          
                      }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                          
                          NSLog(@"Error: %@", error);
                          
                      }];
            }
            
            
        default:
            break;
    }
}

- (void)PayStyle:(UIButton *)sender
{
    _btnIndex = sender.tag;
    for (UIButton *btn in _btnViewArray) {
        UIImageView *view = btn.subviews[0];
        view.image = [UIImage imageNamed:@"未选中圆圈"];
    }
    UIImageView *view = sender.subviews[0];
    view.image = [UIImage imageNamed:@"选中圆圈"];
}
//确定付款按钮
- (void)toPay
{
    if (_btnIndex == 0) {
        [[LXAlterView sharedMyTools] createTishi:@"请选择支付方式"];
    }else if (_btnIndex == 100)
    {
        
        if (![WXApi isWXAppInstalled])
        {
            [self alikPay];
        }
        else
        {
            [self payOrder];  //微信支付
        }
        
    }else
    {
        [self alikPay];   //支付宝支付
    }
    
}

- (void)alikPay
{
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    
    NSString *body= [YXTools filterSpecialString:titltString];
    NSString *title = [YXTools filterSpecialString:titltString];
    if (body.length >512) {
        body = [body substringToIndex:512];
    }
    if (title.length > 128) {
        title = [title substringToIndex:128];
    }
    Order *order = [[Order alloc] init];
    order.partner = AlikPartnerID;
    order.seller = AlikSellerID;
    order.tradeNO = orderNum; //订单ID（由商家自行制定）
    
    order.productName = title; //商品标题
    order.productDescription = body; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",[totalPrice floatValue]]; //商品价格
    order.notifyURL =  ZFBNOTIFY_URL; //回调URL
    
    order.service = @"mobile.securitypay.pay";   //固定值
    order.paymentType = @"1";                    //支付类型。默认值为:1(商 品购买)。
    order.inputCharset = @"utf-8";               //固定编码
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    //    order.appenv = @"app";                   //支付来源
    
    //应用注册scheme,在WeiLv-Info.plist定义URL types
    NSString *appScheme = @"WeiLv";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(AlikPartnerPrivKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"支付结果__________%@",resultDic);
            NSString *errorCode = [resultDic objectForKey:@"resultStatus"];
            NSString *tishi = [resultDic objectForKey:@"memo"];
            if ([errorCode intValue] == 9000) {
                [self toNextSuccess];
                //                paystateLabel.text = @"[已支付]";
                //                submitBtn.alpha = 0.5;
                //                submitBtn.userInteractionEnabled = NO;
                tishi = @"支付成功";
            } else if ([errorCode intValue] == 8000) {
                tishi = @"正在处理中";
            }else if ([errorCode intValue] == 4000)
            {
                tishi = @"订单支付失败";
            }else if ([errorCode intValue] == 6001)
            {
                tishi = @"用户中途取消";
            }else if ([errorCode intValue] == 6002)
            {
                tishi = @"网络连接出错";
            }else
            {
                tishi = @"支付失败";
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果"
                                                            message:tishi
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            
        }];
    }
}
- (void)payOrder
{
    req = [[payRequsestHandler alloc]init];
    [req init:APP_ID mch_id:MCH_ID];
    [req setKey:PARTNER_ID];
    NSMutableDictionary *dict = [self sendPay_demo];
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        [self alert:@"提示信息" msg:@"支付失败"];
        NSLog(@"%@\n\n",debug);
    }else{
        NSLog(@"%@\n\n",[req getDebugifo]);
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        PayReq* request             = [[PayReq alloc] init];
        request.openID              = [dict objectForKey:@"appid"];
        request.partnerId           = [dict objectForKey:@"partnerid"];
        request.prepayId            = [dict objectForKey:@"prepayid"];
        request.nonceStr            = [dict objectForKey:@"noncestr"];
        request.timeStamp           = stamp.intValue;
        request.package             = [dict objectForKey:@"package"];
        request.sign                = [dict objectForKey:@"sign"];
        [WXApi safeSendReq:request];
    }
}

- ( NSMutableDictionary *)sendPay_demo
{
    srand( (unsigned)time(0) );
    NSString *noncestr  = [NSString stringWithFormat:@"%d", rand()];
    NSMutableDictionary *packageParams = [NSMutableDictionary dictionary];
    int money = [totalPrice floatValue]*100;
    
    NSString *body= [YXTools filterSpecialString:titltString];
    if (body.length >32) {
        body = [body substringToIndex:32];
    }
    NSString *totalFee = [NSString stringWithFormat:@"%d",money];
    [packageParams setObject: APP_ID             forKey:@"appid"];       //开放平台appid
    [packageParams setObject: MCH_ID             forKey:@"mch_id"];      //商户号
    [packageParams setObject: @"APP-001"        forKey:@"device_info"]; //支付设备号或门店号
    [packageParams setObject: noncestr          forKey:@"nonce_str"];   //随机串
    [packageParams setObject: @"APP"            forKey:@"trade_type"];  //支付类型，固定为APP
    [packageParams setObject: body        forKey:@"body"];        //订单描述，展示给用户
    [packageParams setObject: NOTIFY_URL        forKey:@"notify_url"];  //支付结果异步通知
    [packageParams setObject: orderNum           forKey:@"out_trade_no"];//商户订单号
    
    [packageParams setObject: @"127.0.0.1"    forKey:@"spbill_create_ip"];//发器支付的机器ip
    [packageParams setObject: totalFee       forKey:@"total_fee"];       //订单金额，单位为分
    
    NSString *prePayid;
    prePayid = [req sendPrepay:packageParams];
    
    if ( prePayid != nil) {
        NSString    *package, *time_stamp, *nonce_str;
        time_stamp  = [self genTimeStamp];
        nonce_str	= [WXUtil md5:time_stamp];
        package         = @"Sign=WXPay";
        
        NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
        [signParams setObject: APP_ID        forKey:@"appid"];
        [signParams setObject: nonce_str    forKey:@"noncestr"];
        [signParams setObject: package      forKey:@"package"];
        [signParams setObject: MCH_ID        forKey:@"partnerid"];
        [signParams setObject: time_stamp   forKey:@"timestamp"];
        [signParams setObject: prePayid     forKey:@"prepayid"];
        NSString *sign  = [req createMd5Sign:signParams];
        
        [signParams setObject: sign         forKey:@"sign"];
        return signParams;
        
    }
    return nil;
}

// 获取时间戳
- (NSString *)genTimeStamp
{
    return [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
}
//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
}

- (void)updateOrderPayResult:(NSNotification *)notification
{
    //    paystateLabel.text = @"[已支付]";
    //    submitBtn.alpha = 0.5;
    //    submitBtn.userInteractionEnabled = NO;
    
    [self toNextSuccess];
}

- (void)toNextSuccess
{
    // int number;
    YXPaySuccessViewController *payVC = [[YXPaySuccessViewController alloc] init];
    payVC.beginDate = [[flightsDic objectForKey:@"q"] objectForKey:@"OffTime"];
    
    payVC.number = [NSString stringWithFormat:@"%ld",(long)passengerNUm];
    
    payVC.productName = titltString;
    payVC.contactPerson = contacts;
    payVC.phone = phone;
    [self.navigationController pushViewController:payVC animated:YES];
}
@end


#pragma  mark- PlaneMessage
@implementation PlaneMessage

- (id)initWithFrame:(CGRect)frame titleString:(NSString *)title timeString:(NSString *)time ariportString:(NSString *)airport{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
        UILabel *titleLabel = [YXTools allocLabel:title font:systemFont(17) textColor:[UIColor blackColor] frame:CGRectMake(Begin_X, 5,windowContentWidth -Begin_X*2, 40) textAlignment:0];
        [self addSubview:titleLabel];
        
        UIView *timeLabel = [[PlaneMessage alloc] initWithFrame:CGRectMake(0, 45,windowContentWidth, 45)  string1:@"出发时间：" string2:time];
        UIView *poartLabel = [[PlaneMessage alloc] initWithFrame:CGRectMake(0, 90,windowContentWidth, 45) string1:@"起降机场：" string2:airport];
        [self addSubview:timeLabel];
        [self addSubview:poartLabel];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,45*2-0.5 , windowContentWidth, 0.5)];
        label.layer.borderColor = bordColor.CGColor;
        label.layer.borderWidth= 0.33;
        [self addSubview:label];
        
    }
    return self;
    
}

- (id)initWithFrame:(CGRect)frame string1:(NSString *)string1 string2:(NSString *)string2 {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame =frame;
        
        UILabel *labe1 = [[UILabel alloc] initWithFrame:CGRectMake(Begin_X, 0, windowContentWidth -Begin_X*2, 45)];
        labe1.font = [UIFont systemFontOfSize:16];
        labe1.textAlignment = NSTextAlignmentLeft;
        labe1.textColor = [UIColor grayColor];
        labe1.text = string1;
        [self addSubview:labe1];
        
        UILabel *labe2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, windowContentWidth -100, 45)];
        labe2.font = [UIFont systemFontOfSize:16];
        labe2.textAlignment = NSTextAlignmentLeft;
        labe2.textColor = [UIColor blackColor];
        labe2.text = string2;
        [self addSubview:labe2];
        
    }
    return self;
}

@end







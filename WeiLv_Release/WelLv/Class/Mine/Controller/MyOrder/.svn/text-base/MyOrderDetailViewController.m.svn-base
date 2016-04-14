//
//  MyOrderDetailViewController.m
//  WelLv
//
//  Created by mac for csh on 15/5/5.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "MyOrderDetailViewController.h"
#import "AFNetworking.h"
#import "MyOrderTableViewCOntroller.h"
#import "PartnerConfig.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "YXPaySuccessViewController.h"
#import "LXCommonTools.h"

#import "WXApi.h"
#import "WXApiObject.h"

@interface MyOrderDetailViewController()
{
    UIView *lastView;
    NSMutableArray *_btnViewArray;
    NSInteger _btnIndex;
    UIView *pricListView;
    
    payRequsestHandler *req;
    NSString *orderNum;        //订单号
    UILabel *paystateLabel;
    UIButton *submitBtn;
    UIButton *cancelBtn;
}
@property(nonatomic,strong)NSString *payStatusString;

@end



@implementation MyOrderDetailViewController
@synthesize adultNumber,childrenNumber,adultPrice,childrenPrice,visaPrice,sellPrice,totalPrice,isTrave,totalPeople,timeString,timeStringG,titltString,startCity,realName,phone,personArray,personArray2,stateInteger,payStatusInteger,confirmInteger,againConfirmInteger,payTypeInteger,payWayInteger,earnest_statusInteger,earnest,YXTotalPrice,scondOderSN,yoosure_earnest;
@synthesize order_id,cat_id,member_id;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"订单详情"];
    self.view.backgroundColor = BgViewColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateOrderPayResult:) name:ORDER_PAY_NOTIFICATION object:nil];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    DLog(@"%@",self.cat_id);
    //判定旅游单和签证单
    if ([cat_id integerValue] ==-11||[cat_id integerValue] ==1||[cat_id integerValue] ==-12||[cat_id integerValue] ==-13||[cat_id integerValue] ==-15||[cat_id integerValue]>4)
    {
        isTrave = YES;
    
    }
    else
    {
        isTrave = NO;
    }
        
    [self getList];

//    [self creatViewLast];
//       

}
-(void)creatViewLast
{
    if( ((([cat_id integerValue] == -2)||[cat_id integerValue] == 1)  || ([cat_id integerValue] == -11) || ([cat_id integerValue] == -12) || ([cat_id integerValue] == -13) || ([cat_id integerValue] == -15) || ([cat_id integerValue] ==5)  || ([cat_id integerValue] == 6) || ([cat_id integerValue] == 7) || ([cat_id integerValue] ==8) || ([cat_id integerValue] == 10) || ([cat_id integerValue] ==9) || ([cat_id integerValue] == -14) || ([cat_id integerValue] == 2896) || ([cat_id integerValue] == 2900) ||  ([cat_id integerValue] == 3) || ([cat_id integerValue] == -5))       && ((payWayInteger == 1 && payTypeInteger == 2 &&againConfirmInteger == 0 && earnest_statusInteger == 1)                                //直接支付-定金支付-定金已付待确认
                                       || ((payWayInteger == 2 && payTypeInteger ==1 && confirmInteger == 0) && (stateInteger == 90 || stateInteger == 91 || stateInteger == 92))                                                                //确认后支付-全额支付-待确认
                                       || (payWayInteger == 2 && payTypeInteger == 2 && confirmInteger == 0 && againConfirmInteger == 0 && earnest_statusInteger == 0)      //确认后支付-定金支付-待确认
                                       || (payWayInteger == 2 && payTypeInteger == 2 && confirmInteger == 1 && againConfirmInteger == 0 &&earnest_statusInteger == 1) || payWayInteger==2)){    //确认后支付-定金支付-定金已付待确认
        [submitBtn setTitle:@"确认后支付" forState:UIControlStateNormal];
    }
    else
    {
        
        [submitBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    }
    DLog(@"%@",self.payStatusString);
    if ([self.payStatusString isEqualToString:@"余额待确认"]) {
        [submitBtn setTitle:@"确认后支付" forState:UIControlStateNormal];
    }
    else if ([self.payStatusString isEqualToString:@"待确认"])
    {
        [submitBtn setTitle:@"确认后支付" forState:UIControlStateNormal];
    }
    else
    {
        [submitBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void) getList
{
    
    //请求数据
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *md5str = [NSString stringWithFormat:@"~0;id<zOD.{ll@]JKi(:%@",[[LXUserTool alloc] getUid]];
    md5str = [WXUtil md5:md5str];
    
    DLog(@"order is %@ catid is %@ memberid is %@",order_id,cat_id,member_id);
    NSDictionary *parameters = @{@"order_id":order_id,@"cat_id":cat_id,@"member_id":[[LXUserTool alloc] getUid],@"wltoken":md5str};
    DLog(@"%@",parameters);
    
    [manager POST:GetOrderInfoUrl parameters:parameters
    
          success:^(AFHTTPRequestOperation *operation,id responseObject)
          {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
            DLog(@"dict = %@     \n   %@",dict,[dict objectForKey:@"msg"]);
              //判定是否是下架产品
              if(![[dict objectForKey:@"data"] isKindOfClass:[NSDictionary class]])
              {
                  [[LXAlterView sharedMyTools] createTishi:@"获取数据失败:)"];
              }else if (![[dict objectForKey:@"data"] objectForKey:@"order_sn"])
              {
                  DLog(@"订单已下架");
                  UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"很遗憾" message:@"该产品已下架，如有疑问请联系您的管家" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                  altView.tag = 1;
                  [altView show];
              }
              if ([[dict objectForKey:@"state"] integerValue] == 1)
              {
                  NSDictionary *dict1 = [dict objectForKey:@"data"];                                          //--------预定时间
                  DLog(@"订单详情：%@",dict1);
                  NSString *BookTimeString = [dict1 objectForKey:@"create_time"];

                  NSTimeInterval bookTime = [BookTimeString doubleValue] ;
                  NSDate *detaildatee=[NSDate dateWithTimeIntervalSince1970:bookTime];
                  NSDateFormatter *dateFormatterr = [[NSDateFormatter alloc] init];
                  [dateFormatterr setDateFormat:@"yyyy-MM-dd"];
                  
                  timeStringG = [dateFormatterr stringFromDate: detaildatee];
                  DLog(@"%@",timeStringG);
                  
                  if (isTrave == NO)
                  {
                      if ([cat_id integerValue]== -1)
                      {                                                        //--------出游人数
                           totalPeople = [[dict1 objectForKey:@"num"] integerValue];        //门票
                      }
                      else if ([cat_id integerValue]== 2)
                      {
                          totalPeople = [[dict1 objectForKey:@"nums"] integerValue];        //签证
                      }
                      else if([cat_id integerValue]== 3)
                      {
                          totalPeople = [[dict1 objectForKey:@"adult_number"] integerValue];//游轮
                      }
                      else if([cat_id integerValue]== -2)
                      {
                          adultNumber = [dict1 objectForKey:@"teacher_num"];                //游学家长/老师
                          childrenNumber = [dict1 objectForKey:@"camper_num"];              //游学营员
                      }
                      
                      totalPrice = [dict1 objectForKey:@"order_price"];                                        //-------- 订单总额
                      
                      if ([cat_id integerValue]== 2)
                      {                                                         //-------- 订单单价
                          visaPrice = [dict1 objectForKey:@"visa_price"];   //签证单价
                      }
                      else if([cat_id integerValue] == -1)
                      {
                          sellPrice = [dict1 objectForKey:@"sellPrice"];    //门票单价
                      }
                      else if([cat_id integerValue] == -2)
                      {
                          adultPrice = [dict1 objectForKey:@"teacher_price"];   //游学单价家长/老师
                          childrenPrice = [dict1 objectForKey:@"camper_price"];  //游学单价营员
                      }
                      
                      titltString = [dict1 objectForKey:@"product_name"];                                      //-------- 产品标题
                      orderNum = [dict1 objectForKey:@"order_sn"];                                             //-------- 订单号

                      NSString *str = @"";
                      if([cat_id integerValue] == 2)
                      {                                                         //-------- 出游时间
                         str=[dict1 objectForKey:@"tour_time"];//签证
                      }
                      else if([cat_id integerValue] == 3 || [cat_id integerValue] ==-5)
                      {
                         str=[dict1 objectForKey:@"depart_date"];//游轮
                      }
                      else if([cat_id integerValue] == -2)
                      {
                          str=[dict1 objectForKey:@"setoff_time"];//游学

                      }
                      NSTimeInterval time=[str doubleValue];
                      NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
                      DLog(@"date:%@",detaildate);
                      //实例化一个NSDateFormatter对象
                      NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                      //设定时间格式,这里可以设置成自己需要的格式
                      [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                      timeString = [dateFormatter stringFromDate: detaildate];
                      if ([cat_id integerValue] == -1)
                      {            //门票
                          timeString = [dict1 objectForKey:@"date"];
                      }
                      
                      if ([cat_id integerValue ]== 2)
                      {                                                       //-------- 门票出游人或签证申请人
                          if (personArray)
                          {
                              [personArray removeAllObjects];              //签证
                          }
                          NSDictionary *dddd=[dict1 objectForKey:@"person_info"];
                          id jsonArr = [dddd objectForKey:@"people"];
                          if ([jsonArr isKindOfClass:[NSArray class]])
                          {
                              personArray = [NSMutableArray arrayWithArray:jsonArr];
                          }
                          else
                          {
                              personArray = [jsonArr objectFromJSONString];
                          }
                      }
                      else if([cat_id integerValue ] == -1)
                      {            //门票
                          if (personArray2)
                          {
                              [personArray2 removeAllObjects];
                          }
                          id jsonArr = [dict1 objectForKey:@"traveller"];
                          if ([jsonArr isKindOfClass:[NSArray class]])
                          {
                              personArray2 = [NSMutableArray arrayWithArray:jsonArr];
                          }
                          else
                          {
                              personArray2 = [jsonArr objectFromJSONString];
                          }
                      }
        
                      DLog(@"confirm: %@",[dict1 objectForKey:@"confirm"]);
                      DLog(@"again_confirm: %@",[dict1 objectForKey:@"again_confirm"]);
                      DLog(@"payStatusInteger: %ld",payStatusInteger);
                      DLog(@"stateInteger: %ld",stateInteger );
                  }
                  else if(isTrave == YES)
                  {
                      adultNumber = [NSString stringWithFormat:@"%@",[dict1 objectForKey:@"adule"]];         //--------成人数
                      childrenNumber = [NSString stringWithFormat:@"%@",[dict1 objectForKey:@"child"]];      //--------儿童数
//                       totalPeople = [adultNumber integerValue]+[childrenNumber integerValue];
                      adultPrice = [NSString stringWithFormat:@"%@",[dict1 objectForKey:@"adule_price"]];    //--------成人价
                      childrenPrice = [NSString stringWithFormat:@"%@",[dict1 objectForKey:@"child_price"]]; //--------儿童价
                      totalPrice = [NSString stringWithFormat:@"%@",[dict1 objectForKey:@"order_price"]];    //--------订单总额
                      titltString = [NSString stringWithFormat:@"%@",[dict1 objectForKey:@"product_name"]];  //--------产品标题
                       orderNum = [dict1 objectForKey:@"order_sn"];                                          //--------订单号
                      NSString *str;
                      if ([self.cat_id isEqualToString:@"5"]) {
                          str=self.oneDayTime;
                      }else{
                      str=[NSString stringWithFormat:@"%@",[dict1 objectForKey:@"f_time"]];
                      }
                          //--------出游时间
                      NSTimeInterval time=[str doubleValue];
                      //1452729600
                      DLog(@"%@",str);
                     
                      NSDate *detaildate2=[NSDate dateWithTimeIntervalSince1970:time];
                      //实例化一个NSDateFormatter对象
                      NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                      //设定时间格式,这里可以设置成自己需要的格式
                      [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                      timeString = [dateFormatter stringFromDate: detaildate2];
                      DLog(@"%@",timeString);
                  }
                  //预订人
                  realName= [NSString stringWithFormat:@"%@",[dict1 objectForKey:@"contacts"]];                    //--------预定人
                  phone = [NSString stringWithFormat:@"%@",[dict1 objectForKey:@"phone"]];
                 
                  stateInteger = [[dict1 objectForKey:@"order_status"] integerValue];                              //--------订单状态
                  payStatusInteger = [[dict1 objectForKey:@"pay_status"] integerValue];                            //--------支付状态
                  if(([cat_id integerValue] == -2) || ([cat_id integerValue] == 1)  || ([cat_id integerValue] == -11) || ([cat_id integerValue] == -12) || ([cat_id integerValue] == -13) || ([cat_id integerValue] == -15) || ([cat_id integerValue] ==5)  || ([cat_id integerValue] == 6) || ([cat_id integerValue] == 7) || ([cat_id integerValue] ==8) || ([cat_id integerValue] == 10) || ([cat_id integerValue] ==9) || ([cat_id integerValue] == -14) || ([cat_id integerValue] == 2896) || ([cat_id integerValue] == 2900) ||  ([cat_id integerValue] == 3) || ([cat_id integerValue] == -5))
                  {
                      confirmInteger = [[dict1 objectForKey:@"confirm"] integerValue];                             //--------游学订单是否确定
                      againConfirmInteger = [[dict1 objectForKey:@"again_confirm"] integerValue];                  //--------游学订单二次付款是否确定
                      payTypeInteger = [[dict1 objectForKey:@"yoosure_pay_type"] integerValue];                    //--------游学订单付款方式 1 全款  2 定金
                      payWayInteger = [[dict1 objectForKey:@"pay_way"] integerValue];                              //--------游学订单付款支付条件 1直接付款  2确认后付款
                      earnest_statusInteger = [[dict1 objectForKey:@"earnest_status"] integerValue];               //--------游学产品 定金付款 定金付款状态
                      if (payTypeInteger == 2)
                      {
                          earnest = [dict1 objectForKey:@"earnest"];
                          yoosure_earnest=[dict1 objectForKey:@"yoosure_earnest"];
                          //--------游学产品定金支付 定金金额
                          totalPeople = [childrenNumber integerValue] + [adultNumber integerValue];    //游学明细显示定金单价后的总人数
                          YXTotalPrice = totalPrice;
                          scondOderSN = [dict1 objectForKey:@"new_order_sn"];   //二次支付订单号
                          if (payTypeInteger == 1 || payStatusInteger == 1 || stateInteger == 11) {
                              totalPrice = YXTotalPrice;
                          }
                          else if (againConfirmInteger == 1)
                          {
                              totalPrice = [NSString stringWithFormat:@"%.2f",[YXTotalPrice doubleValue]-[earnest doubleValue] ];
                          }
                          else if (againConfirmInteger == 0)
                          {
                              totalPrice = [NSString stringWithFormat:@"%.2f",[earnest doubleValue] ];
                          }
                          if (earnest_statusInteger==0)
                          {
                              [LXSingletonClass shareInstance].isYouXue=YES;
                          }
                          else
                          {
                              [LXSingletonClass shareInstance].isYouXue=NO;
                          }
                          
                      }
                      else
                      {
                          [LXSingletonClass shareInstance].isYouXue=NO;
                      }
                  }
                  else
                  {
                      [LXSingletonClass shareInstance].isYouXue=NO;
                  }
                  
                  [self initView];
                 
                  // 支付状态未支付  ，订单状态新订单   并且产品的memberid == 当前登录人的uid
                  if(payStatusInteger == 0 && stateInteger != 11 && [self.member_id isEqualToString:[[LXUserTool alloc] getUid]])
                  {
                     [self loadPayView];
                  }
                  
              }
              else
              {
                  [[LXAlterView sharedMyTools] createTishi:@"获取数据失败"];
              }
              [self creatViewLast];
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              DLog(@"Error: %@", error);
              
          }];
}


//生成界面
-(void)initView
{
    float location = 5.0;
//标题
    placeLabel = [YXTools allocLabel:titltString font:systemBoldFont(18) textColor:[UIColor blackColor] frame:CGRectMake(Begin_X, location, ViewWidth(_scrollView)-Begin_X*2, 45) textAlignment:0];
    placeLabel.numberOfLines = 0;
    float titleLength = [[LXCommonTools sharedMyTools] textHeight:titltString Afont:18 width:ViewWidth(_scrollView)-Begin_X*2];
    if (titleLength > 45)
    {
        placeLabel.frame = CGRectMake(Begin_X, location, ViewWidth(_scrollView)-Begin_X*2, titleLength);
        location = location + titleLength;
    }
    else
    {
        location = location+45;
    }
    [_scrollView addSubview:placeLabel];
    

    //出发时间
    UILabel *label1 = [YXTools allocLabel:@"   出发时间:" font:systemFont(17) textColor:[UIColor grayColor] frame:CGRectMake(0, location, ViewWidth(_scrollView), 45) textAlignment:0];
    label1.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:label1];
    UILabel *label11 = [YXTools allocLabel:timeString font:systemFont(17) textColor:[UIColor blackColor] frame:CGRectMake(100, location, ViewWidth(_scrollView)-100, 45) textAlignment:0];
    [_scrollView addSubview:label11];
    location = location +45;
    
 
    //订单编号
    location = location +15;
    UILabel *label3 = [YXTools allocLabel:@"   订单编号:" font:systemFont(17) textColor:[UIColor grayColor] frame:CGRectMake(0, location, ViewWidth(_scrollView), 45) textAlignment:0];
    label3.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:label3];
    UILabel *label33 = [YXTools allocLabel:orderNum font:systemFont(17) textColor:[UIColor blackColor] frame:CGRectMake(100, location, ViewWidth(_scrollView)-100, 45) textAlignment:0];
    [_scrollView addSubview:label33];
    location = location +45;
     UILabel *label333 = [[UILabel alloc] initWithFrame:CGRectMake(0, location-0.33, ViewWidth(_scrollView), 0.33)];
     label333.layer.borderColor = kColor(212, 212, 212).CGColor;
     label333.layer.borderWidth= 0.33;
     [_scrollView addSubview:label333];
   
    if (payStatusInteger == 0 && stateInteger == 0 && stateInteger != 11)
    {
        self.payStatusString = @"待付款";
    }
    else if(payStatusInteger == 0 && stateInteger == 11)
    {
        self.payStatusString = @"已取消";
    }
    else if(payStatusInteger == 1 && (stateInteger == 0 || stateInteger == 1))
    {
        self.payStatusString = @"已付款";
    }
    else if(payStatusInteger == 0 && (stateInteger == 90 || stateInteger || stateInteger == 91 || stateInteger == 92))
    {
        self.payStatusString = @"待确认";
    }
    else if(payStatusInteger == 1 && stateInteger == 2)
    {
        self.payStatusString = @"已完成";
    }
    

    if (([cat_id integerValue]== -2)  || ([cat_id integerValue] == 1)  || ([cat_id integerValue] == -11) || ([cat_id integerValue] == -12) || ([cat_id integerValue] == -13) || ([cat_id integerValue] == -15) || ([cat_id integerValue] ==5)  || ([cat_id integerValue] == 6) || ([cat_id integerValue] == 7) || ([cat_id integerValue] ==8) || ([cat_id integerValue] == 10) || ([cat_id integerValue] ==9) || ([cat_id integerValue] == -14) || ([cat_id integerValue] == 2896) || ([cat_id integerValue] == 2900) ||  ([cat_id integerValue] == 3) || ([cat_id integerValue] == -5) || ([cat_id integerValue] == -1))
    {
        if (payStatusInteger == 0 && stateInteger == 11)
        {
            self.payStatusString = @"已取消";
        }
        else if (payWayInteger == 1)
        {
            if (payTypeInteger == 1)
            {
//                if (payStatusInteger == 0 && stateInteger !=11)
//                {
//                    self.payStatusString = @"待付款";
//                }
//                else if (payStatusInteger == 1)
//                {
//                    self.payStatusString = @"已付款";
//                }
                
                if (stateInteger == 90 || stateInteger == 92) {
                    self.payStatusString = @"待确认";
                }else if(stateInteger == 91){
                    self.payStatusString = @"余额待确认";
                }else if((stateInteger == 0 && earnest_statusInteger == 1) || (stateInteger == 1 && earnest_statusInteger == 1)){
                    self.payStatusString = @"余额未支付";
                } else if(stateInteger == 0 && payStatusInteger == 0 && earnest_statusInteger == 1){
                    self.payStatusString = @"待付款";
                }else if((stateInteger == 0 || stateInteger == 1) && payStatusInteger == 1){
                    self.payStatusString = @"已付款";
                }else if( stateInteger == 2 && payStatusInteger == 1){
                    self.payStatusString = @"已完成";
                }

                
            }
            else if (payTypeInteger == 2)
            {
//                if (earnest_statusInteger == 0 && payStatusInteger == 0 && stateInteger != 11)
//                {
//                     self.payStatusString = @"待付款";
//                }
//                else if (againConfirmInteger == 0 && earnest_statusInteger == 1 && payStatusInteger == 0 && stateInteger != 11)
//                {
//                    self.payStatusString = @"余额待确认";
//                }
//                else if (againConfirmInteger == 1 && earnest_statusInteger == 1 && payStatusInteger == 0 && stateInteger != 11)
//                {
//                    self.payStatusString = @"余额待付款";
//                }
//                else if (againConfirmInteger == 1 && earnest_statusInteger == 1 && payStatusInteger == 1 && stateInteger != 11)
//                {
//                    self.payStatusString = @"已付款";
//                }
                
                if (stateInteger == 90 || stateInteger == 92) {
                    self.payStatusString = @"待确认";
                }else if(stateInteger == 91){
                    self.payStatusString = @"余额待确认";
                }else if((stateInteger == 0 && earnest_statusInteger == 1) || (stateInteger == 1 && earnest_statusInteger == 1)){
                    self.payStatusString = @"余额未支付";
                } else if(stateInteger == 0 && payStatusInteger == 0 && earnest_statusInteger == 1){
                    self.payStatusString = @"待付款";
                }else if((stateInteger == 0 || stateInteger == 1) && payStatusInteger == 1){
                    self.payStatusString = @"已付款";
                }else if( stateInteger == 2 && payStatusInteger == 1){
                    self.payStatusString = @"已完成";
                }

            }
        }
        else if (payWayInteger == 2)
        {
            if (payTypeInteger == 1)
            {
//                if ((stateInteger == 90 || stateInteger == 91 || stateInteger == 92) && stateInteger != 11)
//                {
//                    self.payStatusString = @"待确认";
//                }
//                else if (payStatusInteger == 0 && stateInteger != 11)
//                {
//                    self.payStatusString = @"待付款";
//                }
//                else if (payStatusInteger == 1 && stateInteger != 11)
//                {
//                    self.payStatusString = @"已付款";
//                }
                
                if (stateInteger == 90 || stateInteger == 92) {
                    self.payStatusString = @"待确认";
                }else if(stateInteger == 91){
                    self.payStatusString = @"余额待确认";
                }else if((stateInteger == 0 && earnest_statusInteger == 1) || (stateInteger == 1 && earnest_statusInteger == 1)){
                    self.payStatusString = @"余额未支付";
                } else if(stateInteger == 0 && payStatusInteger == 0 && earnest_statusInteger == 1){
                    self.payStatusString = @"待付款";
                }else if((stateInteger == 0 || stateInteger == 1) && payStatusInteger == 1){
                    self.payStatusString = @"已付款";
                }else if( stateInteger == 2 && payStatusInteger == 1){
                    self.payStatusString = @"已完成";
                }

                
            }
            else if (payTypeInteger == 2)
            {
//                if (confirmInteger == 0 && againConfirmInteger == 0 && earnest_statusInteger == 0 && payStatusInteger == 0 && stateInteger !=11)
//                {
//                    self.payStatusString = @"待确认";
//                    // [submitBtn setTitle:@"确认支付" forState:UIControlStateNormal];
//                }
//                else if (confirmInteger == 1 && againConfirmInteger == 0 && earnest_statusInteger == 0 && payStatusInteger == 0 && stateInteger !=11)
//                {
//                    self.payStatusString = @"待付款";
//                }
//                if (confirmInteger == 1 && againConfirmInteger == 0 && earnest_statusInteger == 1 && payStatusInteger == 0 && stateInteger !=11)
//                {
//                    self.payStatusString = @"余额待确认";
//                }
//                if (confirmInteger == 1 && againConfirmInteger == 1 && earnest_statusInteger == 1 && payStatusInteger == 0 && stateInteger !=11)
//                {
//                    self.payStatusString = @"余额待付款";
//                }
//                if (confirmInteger == 1 && againConfirmInteger == 1 && earnest_statusInteger == 1 && payStatusInteger == 1 && stateInteger !=11)
//                {
//                    self.payStatusString = @"已付款";
//                }
                
                if (stateInteger == 90 || stateInteger == 92) {
                    self.payStatusString = @"待确认";
                }else if(stateInteger == 91){
                    self.payStatusString = @"余额待确认";
                }else if((stateInteger == 0 && earnest_statusInteger == 1) || (stateInteger == 1 && earnest_statusInteger == 1)){
                    self.payStatusString = @"余额未支付";
                } else if(stateInteger == 0 && payStatusInteger == 0 && earnest_statusInteger == 1){
                    self.payStatusString = @"待付款";
                }else if((stateInteger == 0 || stateInteger == 1) && payStatusInteger == 1){
                    self.payStatusString = @"已付款";
                }else if( stateInteger == 2 && payStatusInteger == 1){
                    self.payStatusString = @"已完成";
                }

                
            }
            else if(payTypeInteger==0)
            {
                self.payStatusString = @"待确认";
            }
        }
        else
        {
            self.payStatusString = @"付款方式状态异常,请联系客服";
        }
    }
    

    UILabel *label4 = [YXTools allocLabel:@"   订单状态:" font:systemFont(17) textColor:[UIColor grayColor] frame:CGRectMake(0, location, ViewWidth(_scrollView), 45) textAlignment:0];
    label4.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:label4];
    UILabel *label44 = [YXTools allocLabel:self.payStatusString font:systemFont(17) textColor:[UIColor blackColor] frame:CGRectMake(100, location, ViewWidth(_scrollView)-100, 45) textAlignment:0];
    [_scrollView addSubview:label44];
    location = location +45;
    UILabel *label444 = [[UILabel alloc] initWithFrame:CGRectMake(0, location-0.33, ViewWidth(_scrollView), 0.33)];
    label444.layer.borderColor = kColor(212, 212, 212).CGColor;
    label444.layer.borderWidth= 0.33;
    [_scrollView addSubview:label444];

   
//预定时间
    UILabel *label5 = [YXTools allocLabel:@"   预定时间:" font:systemFont(17) textColor:[UIColor grayColor] frame:CGRectMake(0, location, ViewWidth(_scrollView), 45) textAlignment:0];
    label5.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:label5];
    UILabel *label55 = [YXTools allocLabel:timeStringG font:systemFont(17) textColor:[UIColor blackColor] frame:CGRectMake(100, location, ViewWidth(_scrollView)-100, 45) textAlignment:0];
    [_scrollView addSubview:label55];
    location = location +45;
    UILabel *label555 = [[UILabel alloc] initWithFrame:CGRectMake(0, location-0.33, ViewWidth(_scrollView), 0.33)];
    label555.layer.borderColor = kColor(212, 212, 212).CGColor;
    label555.layer.borderWidth= 0.33;
    [_scrollView addSubview:label555];
   
    
//出游人数
    NSString *strNumber;
    if (isTrave == NO)
    {
        if ([cat_id integerValue] == -2)
        {
            strNumber = [NSString stringWithFormat:@"%d家长/老师 %d营员",[self.adultNumber intValue],[self.childrenNumber intValue]];
        }
        else
        {
            strNumber = [NSString stringWithFormat:@"%ld人",(long)totalPeople];
        }
    }
    else if(isTrave == YES)
    {
        if ([self.cat_id isEqualToString:@"5"])
        {
            strNumber=[NSString stringWithFormat:@"%lu人",[self.pepleNum integerValue]];
        }
        else
        {
           strNumber = [NSString stringWithFormat:@"%d成人%d儿童",[self.adultNumber intValue],[self.childrenNumber intValue]];
        }
    }

    UILabel *label6 = [YXTools allocLabel:@"   出游人数:" font:systemFont(17) textColor:[UIColor grayColor] frame:CGRectMake(0, location, ViewWidth(_scrollView), 45) textAlignment:0];
    label6.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:label6];
    UILabel *label66 = [YXTools allocLabel:strNumber font:systemFont(17) textColor:[UIColor blackColor] frame:CGRectMake(100, location, ViewWidth(_scrollView)-100, 45) textAlignment:0];
    [_scrollView addSubview:label66];
    location = location +45;
    UILabel *label666 = [[UILabel alloc] initWithFrame:CGRectMake(0, location-0.33, ViewWidth(_scrollView), 0.33)];
    label666.layer.borderColor = kColor(212, 212, 212).CGColor;
    label666.layer.borderWidth= 0.33;
    [_scrollView addSubview:label666];
    
    
//订单总额
    UILabel *label7 = [YXTools allocLabel:@"   应付金额:" font:systemFont(17) textColor:[UIColor grayColor] frame:CGRectMake(0, location, ViewWidth(_scrollView), 45) textAlignment:0];
    label7.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:label7];
    UILabel *label77 = [YXTools allocLabel:[NSString stringWithFormat:@"￥%@",totalPrice] font:systemFont(17) textColor:[UIColor redColor] frame:CGRectMake(100, location, ViewWidth(_scrollView)-100, 45) textAlignment:0];
    [_scrollView addSubview:label77];
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
    
    if ([cat_id integerValue]== 3) {
        buttonPrice.hidden = YES;
    }
    
    
//联系人
    location = location +15;
    UILabel *label8 = [YXTools allocLabel:@"   联系人:" font:systemFont(17) textColor:[UIColor grayColor] frame:CGRectMake(0, location, ViewWidth(_scrollView), 45) textAlignment:0];
    label8.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:label8];
    UILabel *label88 = [YXTools allocLabel:realName font:systemFont(17) textColor:[UIColor blackColor] frame:CGRectMake(100, location, ViewWidth(_scrollView)-100, 45) textAlignment:0];
    [_scrollView addSubview:label88];
    location = location +45;
    UILabel *label888 = [[UILabel alloc] initWithFrame:CGRectMake(0, location-0.33, ViewWidth(_scrollView), 0.33)];
     label888.layer.borderColor = kColor(212, 212, 212).CGColor;
     label888.layer.borderWidth= 0.33;
     [_scrollView addSubview:label888];


    UILabel *label9 = [YXTools allocLabel:@"   电话:" font:systemFont(17) textColor:[UIColor grayColor] frame:CGRectMake(0, location, ViewWidth(_scrollView), 45) textAlignment:0];
    label9.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:label9];
    UILabel *label99 = [YXTools allocLabel:phone font:systemFont(17) textColor:[UIColor blackColor] frame:CGRectMake(100, location, ViewWidth(_scrollView)-100, 45) textAlignment:0];
    [_scrollView addSubview:label99];
    location = location +45;

    
    

//出游人
    if ([cat_id integerValue]== 2 || [cat_id integerValue]== -1) {
        location = location +15;
        NSInteger totleNo;
        if (isTrave == NO) {
            totleNo = totalPeople;
        }else if(isTrave == YES){
            totleNo = [self.childrenNumber integerValue] + [self.adultNumber integerValue];
        }
        DLog(@"%@",personArray2);
        for ( int i = 0; i < totleNo ; i ++)
        {
            NSString *nameString = @"未填写";
            NSString *titnameString = @"   出游人:";
            if([cat_id integerValue]== 2)
            {
                titnameString = @"   申请人:";
                if ([[personArray objectAtIndex:i] objectForKey:@"name"] && ![[[personArray objectAtIndex:i] objectForKey:@"name"] isEqualToString:@"(null)"] )
                {
                    nameString = [[personArray objectAtIndex:i] objectForKey:@"name"];
                }
            }
            else if([cat_id integerValue]== -1)
            {
                titnameString = @"   出游人:";
                
                if (personArray2.count == 1) {
                    nameString = [personArray2.firstObject objectForKey:@"name"];
                    return;
                }else if ([[personArray2 objectAtIndex:i] objectForKey:@"name"] && ![[[personArray2 objectAtIndex:i] objectForKey:@"name"] isEqualToString:@"(null)"] )
                {
                    nameString = [[personArray2 objectAtIndex:i] objectForKey:@"name"];
                }
            }
            
            UILabel *labela = [YXTools allocLabel:titnameString font:systemFont(17) textColor:[UIColor grayColor] frame:CGRectMake(0, location, ViewWidth(_scrollView), 45) textAlignment:0];
            labela.backgroundColor = [UIColor whiteColor];
            [_scrollView addSubview:labela];
            UILabel *labelaa = [YXTools allocLabel:nameString font:systemFont(17) textColor:[UIColor blackColor] frame:CGRectMake(100, location, ViewWidth(_scrollView)-100, 45) textAlignment:0];
            [_scrollView addSubview:labelaa];
            UIButton *manageInfoBtn = [[UIButton alloc] initWithFrame:CGRectMake(ViewWidth(labela)+ViewX(labela)-15 -25, location+10, 25, 25)];

            [manageInfoBtn addTarget:self action:@selector(mangeInfo:) forControlEvents:UIControlEventTouchUpInside];
            manageInfoBtn.tag = i;
            [_scrollView addSubview:manageInfoBtn];
            location = location +45;
            if (i != totleNo - 1)
            {
                UILabel *labelaaa = [[UILabel alloc] initWithFrame:CGRectMake(0, location-0.33, ViewWidth(_scrollView), 0.33)];
                labelaaa.layer.borderColor = kColor(212, 212, 212).CGColor;
                labelaaa.layer.borderWidth= 0.33;
                [_scrollView addSubview:labelaaa];
                
            }
        }

    }
    

    
     _scrollView.contentSize= CGSizeMake(windowContentWidth, location +200);
       lastView = [[UIView alloc] initWithFrame:CGRectMake(0, location+15, ViewWidth(_scrollView), 0)];
    lastView.backgroundColor = bordColor;
    [_scrollView addSubview:lastView];
  
}

-(void)mangeInfo:(UIButton *)btn {
    DLog(@"%ld",btn.tag);
}

//查看明细
-(void)PriceList{
    if (pricListView)
    {
        [pricListView removeFromSuperview];
    }
    pricListView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64)];
    pricListView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.8];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [self.view addSubview:pricListView];
    
    UIView *vieww = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(pricListView) -200, ViewWidth(pricListView), 200)];
    vieww.backgroundColor = [UIColor whiteColor];
    [pricListView addSubview:vieww];
    UILabel *label = [YXTools allocLabel:@"费用明细" font:systemFont(18) textColor: [UIColor orangeColor] frame:CGRectMake(0, 0, ViewWidth(vieww), 60) textAlignment:1];
    [vieww addSubview:label];
    if ([cat_id integerValue] ==-11||[cat_id integerValue] ==1||[cat_id integerValue] ==-12||[cat_id integerValue] ==-13||[cat_id integerValue] ==-15||[cat_id integerValue]>4)
    {
        UILabel *label1 = [YXTools allocLabel:@"成人" font:systemFont(17) textColor: [UIColor grayColor] frame:CGRectMake(20, ViewY(label) + ViewHeight(label), ViewWidth(vieww)-40, 40) textAlignment:0];
         UILabel *label11 = [YXTools allocLabel:[NSString stringWithFormat:@"￥%@*%@",self.adultPrice,self.adultNumber] font:systemFont(17) textColor: [UIColor blackColor] frame:CGRectMake(20, ViewY(label) + ViewHeight(label), ViewWidth(vieww)-40, 40) textAlignment:2];
        [vieww addSubview:label1];[vieww addSubview:label11];
        
        UILabel *label2 = [YXTools allocLabel:@"儿童" font:systemFont(17) textColor: [UIColor grayColor] frame:CGRectMake(20, ViewY(label1) + ViewHeight(label1), ViewWidth(vieww)-40, 40) textAlignment:0];
        UILabel *label22 = [YXTools allocLabel:[NSString stringWithFormat:@"￥%@*%@",self.childrenPrice,self.childrenNumber] font:systemFont(17) textColor: [UIColor blackColor] frame:CGRectMake(20, ViewY(label1) + ViewHeight(label1), ViewWidth(vieww)-40, 40) textAlignment:2];
        [vieww addSubview:label2];[vieww addSubview:label22];
        
        UILabel *labelaaa = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewY(label2) + ViewHeight(label2), ViewWidth(_scrollView), 0.5)];
        labelaaa.layer.borderColor = [UIColor orangeColor].CGColor;
        labelaaa.layer.borderWidth= 1;
        [vieww addSubview:labelaaa];
        
        UILabel *label3 = [YXTools allocLabel:@"总额" font:systemFont(18) textColor: [UIColor blackColor] frame:CGRectMake(20, ViewY(labelaaa) + ViewHeight(labelaaa), ViewWidth(vieww)-40, 59) textAlignment:0];
        UILabel *label33 = [YXTools allocLabel:[NSString stringWithFormat:@"￥%@",self.totalPrice] font:systemFont(18) textColor: [UIColor redColor] frame:CGRectMake(20, ViewY(labelaaa) + ViewHeight(labelaaa), ViewWidth(vieww)-40, 59) textAlignment:2];
        [vieww addSubview:label3];[vieww addSubview:label33];
        
    }
    else if([cat_id integerValue] == 2)
    {
        UILabel *label1 = [YXTools allocLabel:@"签证" font:systemFont(17) textColor: [UIColor grayColor] frame:CGRectMake(20, ViewY(label) + ViewHeight(label), ViewWidth(vieww)-40, 40) textAlignment:0];
        UILabel *label11 = [YXTools allocLabel:[NSString stringWithFormat:@"￥%@*%ld",self.visaPrice,self.totalPeople] font:systemFont(17) textColor: [UIColor blackColor] frame:CGRectMake(20, ViewY(label) + ViewHeight(label), ViewWidth(vieww)-40, 40) textAlignment:2];
        [vieww addSubview:label1];[vieww addSubview:label11];
        
        UILabel *labelaaa = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewY(label1) + ViewHeight(label1), ViewWidth(vieww), 0.5)];
        labelaaa.layer.borderColor = [UIColor orangeColor].CGColor;
        labelaaa.layer.borderWidth= 1;
        [vieww addSubview:labelaaa];
        
        UILabel *label3 = [YXTools allocLabel:@"总额" font:systemFont(18) textColor: [UIColor blackColor] frame:CGRectMake(20, ViewY(labelaaa) + ViewHeight(labelaaa), ViewWidth(vieww)-40, 59) textAlignment:0];
        UILabel *label33 = [YXTools allocLabel:[NSString stringWithFormat:@"￥%@",self.totalPrice] font:systemFont(18) textColor: [UIColor redColor] frame:CGRectMake(20, ViewY(labelaaa) + ViewHeight(labelaaa), ViewWidth(vieww)-40, 59) textAlignment:2];
        [vieww addSubview:label3];[vieww addSubview:label33];
        
        [vieww setFrame:CGRectMake(0, ViewHeight(pricListView) -ViewY(label3)-ViewHeight(label3), ViewWidth(pricListView), ViewY(label3)+ViewHeight(label3))];
    }
    else if ([cat_id integerValue] == 3)
    {
        
    }
    else if ([cat_id integerValue] == -1)
    {
        UILabel *label1 = [YXTools allocLabel:@"门票" font:systemFont(17) textColor: [UIColor grayColor] frame:CGRectMake(20, ViewY(label) + ViewHeight(label), ViewWidth(vieww)-40, 40) textAlignment:0];
        UILabel *label11 = [YXTools allocLabel:[NSString stringWithFormat:@"￥%@*%ld",self.sellPrice,self.totalPeople] font:systemFont(17) textColor: [UIColor blackColor] frame:CGRectMake(20, ViewY(label) + ViewHeight(label), ViewWidth(vieww)-40, 40) textAlignment:2];
        [vieww addSubview:label1];[vieww addSubview:label11];
        
        UILabel *labelaaa = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewY(label1) + ViewHeight(label1), ViewWidth(vieww), 0.5)];
        labelaaa.layer.borderColor = [UIColor orangeColor].CGColor;
        labelaaa.layer.borderWidth= 1;
        [vieww addSubview:labelaaa];
        
        UILabel *label3 = [YXTools allocLabel:@"总额" font:systemFont(18) textColor: [UIColor blackColor] frame:CGRectMake(20, ViewY(labelaaa) + ViewHeight(labelaaa), ViewWidth(vieww)-40, 59) textAlignment:0];
        UILabel *label33 = [YXTools allocLabel:[NSString stringWithFormat:@"￥%@",self.totalPrice] font:systemFont(18) textColor: [UIColor redColor] frame:CGRectMake(20, ViewY(labelaaa) + ViewHeight(labelaaa), ViewWidth(vieww)-40, 59) textAlignment:2];
        [vieww addSubview:label3];[vieww addSubview:label33];
        
        [vieww setFrame:CGRectMake(0, ViewHeight(pricListView) -ViewY(label3)-ViewHeight(label3), ViewWidth(pricListView), ViewY(label3)+ViewHeight(label3))];
    }
    else if ([cat_id integerValue] == -2)
    {
        if (payTypeInteger == 1)
        {
            UILabel *label1 = [YXTools allocLabel:@"家长/老师" font:systemFont(17) textColor: [UIColor grayColor] frame:CGRectMake(20, ViewY(label) + ViewHeight(label), ViewWidth(vieww)-40, 40) textAlignment:0];
            UILabel *label11 = [YXTools allocLabel:[NSString stringWithFormat:@"￥%@*%@",self.adultPrice,self.adultNumber] font:systemFont(17) textColor: [UIColor blackColor] frame:CGRectMake(20, ViewY(label) + ViewHeight(label), ViewWidth(vieww)-40, 40) textAlignment:2];
            [vieww addSubview:label1];[vieww addSubview:label11];
            
            UILabel *label2 = [YXTools allocLabel:@"营员" font:systemFont(17) textColor: [UIColor grayColor] frame:CGRectMake(20, ViewY(label1) + ViewHeight(label1), ViewWidth(vieww)-40, 40) textAlignment:0];
            UILabel *label22 = [YXTools allocLabel:[NSString stringWithFormat:@"￥%@*%@",self.childrenPrice,self.childrenNumber] font:systemFont(17) textColor: [UIColor blackColor] frame:CGRectMake(20, ViewY(label1) + ViewHeight(label1), ViewWidth(vieww)-40, 40) textAlignment:2];
            [vieww addSubview:label2];[vieww addSubview:label22];
            
            UILabel *labelaaa = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewY(label2) + ViewHeight(label2), ViewWidth(_scrollView), 0.5)];
            labelaaa.layer.borderColor = [UIColor orangeColor].CGColor;
            labelaaa.layer.borderWidth= 1;
            [vieww addSubview:labelaaa];
            
            UILabel *label3 = [YXTools allocLabel:@"总额" font:systemFont(18) textColor: [UIColor blackColor] frame:CGRectMake(20, ViewY(labelaaa) + ViewHeight(labelaaa), ViewWidth(vieww)-40, 59) textAlignment:0];
            UILabel *label33 = [YXTools allocLabel:[NSString stringWithFormat:@"￥%@",self.totalPrice] font:systemFont(18) textColor: [UIColor redColor] frame:CGRectMake(20, ViewY(labelaaa) + ViewHeight(labelaaa), ViewWidth(vieww)-40, 59) textAlignment:2];
            [vieww addSubview:label3];[vieww addSubview:label33];
        }
        else if (payTypeInteger == 2)
        {
            UILabel *label1 = [YXTools allocLabel:@"家长/老师" font:systemFont(17) textColor: [UIColor grayColor] frame:CGRectMake(20, ViewY(label) + ViewHeight(label), ViewWidth(vieww)-40, 40) textAlignment:0];
            UILabel *label11 = [YXTools allocLabel:[NSString stringWithFormat:@"￥%@*%@",self.yoosure_earnest,self.adultNumber] font:systemFont(17) textColor: [UIColor blackColor] frame:CGRectMake(20, ViewY(label) + ViewHeight(label), ViewWidth(vieww)-40, 40) textAlignment:2];
            [vieww addSubview:label1];[vieww addSubview:label11];
            
            UILabel *label2 = [YXTools allocLabel:@"营员" font:systemFont(17) textColor: [UIColor grayColor] frame:CGRectMake(20, ViewY(label1) + ViewHeight(label1), ViewWidth(vieww)-40, 40) textAlignment:0];
            UILabel *label22 = [YXTools allocLabel:[NSString stringWithFormat:@"￥%@*%@",self.yoosure_earnest,self.childrenNumber] font:systemFont(17) textColor: [UIColor blackColor] frame:CGRectMake(20, ViewY(label1) + ViewHeight(label1), ViewWidth(vieww)-40, 40) textAlignment:2];
            [vieww addSubview:label2];[vieww addSubview:label22];
            

            UILabel *labelaaa = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewY(label2) + ViewHeight(label2), ViewWidth(_scrollView), 0.5)];
            labelaaa.layer.borderColor = [UIColor orangeColor].CGColor;
            labelaaa.layer.borderWidth= 1;
            [vieww addSubview:labelaaa];
            
            UILabel *label3 = [YXTools allocLabel:@"总额" font:systemFont(18) textColor: [UIColor blackColor] frame:CGRectMake(20, ViewY(labelaaa) + ViewHeight(labelaaa), ViewWidth(vieww)-40, 59) textAlignment:0];
           //如果有定金支付，则总金额显示定金支付
            UILabel *label33 = [YXTools allocLabel:[NSString stringWithFormat:@"￥%@",self.earnest] font:systemFont(18) textColor: [UIColor redColor] frame:CGRectMake(20, ViewY(labelaaa) + ViewHeight(labelaaa), ViewWidth(vieww)-40, 59) textAlignment:2];
            [vieww addSubview:label3];[vieww addSubview:label33];
            
            vieww.frame = CGRectMake(0, ViewHeight(pricListView) -200 , ViewWidth(pricListView), 200);
        }
        
        
    }
    
}

-(void)keyboardHide:(UITapGestureRecognizer *)tap
{
    pricListView.hidden = YES;
    
}

-(void)loadPayView
{
    _btnViewArray = [[NSMutableArray alloc] init];
    NSArray *payArr = [NSArray arrayWithObjects:@"微信支付",@"支付宝支付", nil];
    NSArray *imageArr = [NSArray arrayWithObjects:@"icon_pay_wechat",@"ico_pay_alipay", nil];
    
    if (![WXApi isWXAppInstalled] )
    {
        payArr = [NSArray arrayWithObjects:@"支付宝支付", nil];
        imageArr = [NSArray arrayWithObjects:@"ico_pay_alipay", nil];
    }

    for (int i = 0 ; i<payArr.count; i++)
    {
        UIButton *hotBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        hotBtn.frame = CGRectMake(0, ViewHeight(lastView)+ViewY(lastView) +45*i, windowContentWidth, 45);

        hotBtn.backgroundColor = [UIColor whiteColor];
        hotBtn.tag = 100+i;
        [hotBtn.layer setCornerRadius:5.0];
        [hotBtn addTarget:self action:@selector(PayStyle:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:hotBtn];
        [_btnViewArray addObject:hotBtn];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ViewX(hotBtn) + ViewWidth(hotBtn) - 15-17, (ViewHeight(hotBtn)-17)/2, 17,17 )];
        if (i == 0)
        {
            imageView.image = [UIImage imageNamed:@"选中圆圈"];
            _btnIndex = 100;
        }
        else
        {
            imageView.image = [UIImage imageNamed:@"未选中圆圈"];
            
        }
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [hotBtn addSubview:imageView];
        
        UIImageView *imageView2 = [YXTools allocImageView:CGRectMake(20, 7, 30, 30) image:[UIImage imageNamed:[imageArr objectAtIndex:i]]];
        [hotBtn addSubview:imageView2];
        
        UILabel *title = [YXTools allocLabel:[payArr objectAtIndex:i] font:systemFont(15) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(imageView2)+ViewWidth(imageView2)+15, 5, 80, 35) textAlignment:0];
        [hotBtn addSubview:title];
        
        if (i==0)
        {
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
    DLog(@"%ld",buttonIndex);
    switch (alertView.tag)
    {
        case 1:
            if (buttonIndex == 0)
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
            break;
            
        case 2:
            if (buttonIndex == 1)
            {
                //发送网络请求取消订单
                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                NSString *md5str = [NSString stringWithFormat:@"~0;id<zOD.{ll@]JKi(:%@",[[LXUserTool alloc] getUid]];
                md5str = [WXUtil md5:md5str];
                DLog(@"%@",CancelOrderUrl);
                NSDictionary *parameters = @{@"order_id":order_id,@"wltoken":md5str,@"member_id":member_id};
                [manager POST:CancelOrderUrl parameters:parameters
                      success:^(AFHTTPRequestOperation *operation,id responseObject) {
                          NSString *html = operation.responseString;
                          NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
                          NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
                          DLog(@"%@",responseObject);
                          DLog(@"dict = %@  \n msg = %@",dict,[dict objectForKey:@"msg"]);
                          
                          //创建通知
                          NSNotification *notification =[NSNotification notificationWithName:@"Tongzhi" object:nil userInfo:[dict objectForKey:@"msg"]];
                          //通过通知中心发送通知
                          [[NSNotificationCenter defaultCenter] postNotification:notification];
                          [self.navigationController popViewControllerAnimated:YES];
                        
                        
                      }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                          
                          DLog(@"Error: %@", error);
                          
                      }];
            }

            
        default:
            break;
    }
}

- (void)PayStyle:(UIButton *)sender
{
    _btnIndex = sender.tag;
    for (UIButton *btn in _btnViewArray)
    {
        UIImageView *view = btn.subviews[0];
        view.image = [UIImage imageNamed:@"未选中圆圈"];
    }
    UIImageView *view = sender.subviews[0];
    view.image = [UIImage imageNamed:@"选中圆圈"];
}
//确定付款按钮
- (void)toPay
{
    if([[[LXUserTool alloc] getuserGroup] isEqualToString:@"assistant"] && ([cat_id integerValue] == 1 || (4 <= [cat_id integerValue] && [cat_id integerValue] <= 10) ) )
    {
        [[LXAlterView alloc]createTishi:@"管家身份不能付款"];
    }
    else if( (([cat_id integerValue] == 1)  || ([cat_id integerValue] == -11) || ([cat_id integerValue] == -12) || ([cat_id integerValue] == -13) || ([cat_id integerValue] == -15) || ([cat_id integerValue] ==5)  || ([cat_id integerValue] == 6) || ([cat_id integerValue] == 7) || ([cat_id integerValue] ==8) || ([cat_id integerValue] == 10) || ([cat_id integerValue] ==9) || ([cat_id integerValue] == -14) || ([cat_id integerValue] == 2896) || ([cat_id integerValue] == 2900) ||  ([cat_id integerValue] == 3) || ([cat_id integerValue] == -5))       && ((payWayInteger == 1 && payTypeInteger == 2 &&againConfirmInteger == 0 && earnest_statusInteger == 1)                                //直接支付-定金支付-定金已付待确认
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           || (payWayInteger == 2 && payTypeInteger ==1 && confirmInteger == 0)                                                                 //确认后支付-全额支付-待确认
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           || (payWayInteger == 2 && payTypeInteger == 2 && confirmInteger == 0 && againConfirmInteger == 0 && earnest_statusInteger == 0)      //确认后支付-定金支付-待确认
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           || (payWayInteger == 2 && payTypeInteger == 2 && confirmInteger == 1 && againConfirmInteger == 0 &&earnest_statusInteger == 1) || payWayInteger==2))
    {    //确认后支付-定金支付-定金已付待确认
        [[LXAlterView alloc]createTishi:@"请耐心等待订单确认后才可付款"];
    }else if ([cat_id integerValue] == -2)
    {
        if (stateInteger == 0 || (stateInteger == 1 && earnest_statusInteger == 1)) {
            if (_btnIndex == 0)
            {
                [[LXAlterView sharedMyTools] createTishi:@"请选择支付方式"];
            }
            else if (_btnIndex == 100)
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

        }else{
           [[LXAlterView alloc]createTishi:@"请耐心等待订单确认后才可付款"]; 
        }
    }
    else
    {
        if (_btnIndex == 0)
        {
            [[LXAlterView sharedMyTools] createTishi:@"请选择支付方式"];
        }
        else if (_btnIndex == 100)
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
}

- (void)alikPay
{
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    
    NSString *body= [YXTools filterSpecialString:self.titltString];
    NSString *title = [YXTools filterSpecialString:self.titltString];
    if (body.length >512) {
        body = [body substringToIndex:512];
    }
    if (title.length > 128) {
        title = [title substringToIndex:128];
    }
    Order *order = [[Order alloc] init];
    order.partner = AlikPartnerID;
    order.seller = AlikSellerID;
    
    if (payTypeInteger == 2 && earnest_statusInteger == 1 && againConfirmInteger == 1) {
        order.tradeNO = scondOderSN;
    }else{
        order.tradeNO = orderNum; //订单ID（由商家自行制定）
    }
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
             DLog(@"支付结果__________%@",resultDic);
            NSString *errorCode = [resultDic objectForKey:@"resultStatus"];
            NSString *tishi = [resultDic objectForKey:@"memo"];
            if ([errorCode intValue] == 9000)
            {
                [self toNextSuccess];
//                paystateLabel.text = @"[已支付]";
//                submitBtn.alpha = 0.5;
//                submitBtn.userInteractionEnabled = NO;
                tishi = @"支付成功";
            }
            else if ([errorCode intValue] == 8000)
            {
                tishi = @"正在处理中";
            }
            else if ([errorCode intValue] == 4000)
            {
                tishi = @"订单支付失败";
            }
            else if ([errorCode intValue] == 6001)
            {
                tishi = @"用户中途取消";
            }
            else if ([errorCode intValue] == 6002)
            {
                tishi = @"网络连接出错";
            }
            else
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
    if(dict == nil)
    {
        //错误提示
        NSString *debug = [req getDebugifo];
        [self alert:@"提示信息" msg:@"支付失败"];
        DLog(@"%@\n\n",debug);
    }
    else
    {
        DLog(@"%@\n\n",[req getDebugifo]);
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
    
    NSString *body= [YXTools filterSpecialString:self.titltString];
    if (body.length >32)
    {
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
    
    if (payTypeInteger == 2 && earnest_statusInteger == 1 && againConfirmInteger == 1)
    {
        [packageParams setObject: scondOderSN           forKey:@"out_trade_no"];
    }
    else
    {
        [packageParams setObject: orderNum           forKey:@"out_trade_no"];//商户订单号
    }
    [packageParams setObject: @"127.0.0.1"    forKey:@"spbill_create_ip"];//发器支付的机器ip
    [packageParams setObject: totalFee       forKey:@"total_fee"];       //订单金额，单位为分
    
    NSString *prePayid;
    prePayid = [req sendPrepay:packageParams];
    
    if ( prePayid != nil)
    {
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
    [self toNextSuccess];
}

- (void)toNextSuccess
{
    int number;
    
    YXPaySuccessViewController *payVC = [[YXPaySuccessViewController alloc] init];
    payVC.beginDate = timeString;
    if(isTrave == YES)
    {
        number = [adultNumber intValue]+[childrenNumber intValue];
        payVC.number = [NSString stringWithFormat:@"%d",number];
    }
    else
    {
        payVC.number = [NSString stringWithFormat:@"%ld",(long)totalPeople];
    }
    payVC.productName = self.titltString;
    payVC.contactPerson = realName;
    payVC.phone = phone;
    [self.navigationController pushViewController:payVC animated:YES];
}
@end

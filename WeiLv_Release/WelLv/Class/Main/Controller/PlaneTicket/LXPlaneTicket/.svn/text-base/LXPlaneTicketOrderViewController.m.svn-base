//
//  LXPlaneTicketOrderViewController.m
//  WelLv
//
//  Created by liuxin on 15/9/9.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
#define planeInfoViewHeight 160

#import "LXPlaneTicketOrderViewController.h"
#import "LXPlaneInfoView.h"
//#import "LXBaseModel.h"
#import "LXPlanePersonModel.h"

//#import "FastLoginAndResgistrViewController.h"
#import "LoginAndRegisterViewController.h"
//#import "CusInfoViewController.h"
#import "LXCusInfoViewController.h"
#import "ZFJMyMemberListVC.h"
#import "YXWebDetailViewController.h"
#import "LXCContactViewController.h"

#import "cablistModel.h"
#import "baseModel.h"
#import "LXPlaneOrderModel.h"

#import "QXBModelTool.h"
#import "LXPlaneOrderPayViewController.h"

@interface LXPlaneTicketOrderViewController ()
<UIScrollViewDelegate,UITextFieldDelegate,LXCusInfoViewControllerDelegate,ZFJMyMemberListVCDelegate>
{
    UIView *_view1;
    UIView *_view2;
    UIView *_view3;
    OrderTextFieldView *bookView;
    UIButton *agreeBtn;
    UIView *bottomView;
    UIButton *detailBtn;
    UIButton *tiaokuangBtn;
    UILabel *_priceLabel;
    BOOL _isAgree;
    BOOL _isBuySafety;
    CGFloat _totalPrice;
    NSString *_totalPrice1;
    NSString *_jiyouPrice;
    NSUInteger _fareNumber;
    UIImageView *_tishiImage1;
    NSMutableArray *_fareArray;
    NSMutableArray *_planeOrderInfoArray;
    NSDictionary *_flightsDic;
}

@end

@implementation LXPlaneTicketOrderViewController


- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self initData];
    
   
}

-(void)initData
{
    self.title=@"填写订单";
    //self.planeInfoArray=[[NSMutableArray alloc] initWithCapacity:0];
    DLog(@"model--%ld",self.planeInfoArray.count);
    _isBuySafety=YES;
    _fareArray=[[NSMutableArray alloc] initWithCapacity:0];
    _planeOrderInfoArray=[[NSMutableArray alloc] initWithCapacity:0];
     [self sendRequest];
}

-(void)initView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    _scrollView.backgroundColor = BgViewColor;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    //[self initPlaneInfo];
    
    
}

-(void)sendRequest
{
   // DLog(@"------%@",self.planeInfoArray);
    NSDictionary *parameters;
    for (int i=0; i<self.planeInfoArray.count/2; i++) {
        
        if (self.planeInfoArray.count/2==1) {
            baseModel *model = [[baseModel alloc] init];
            cablistModel *cabModel = [[cablistModel alloc] init];
            model=[self.planeInfoArray objectAtIndex:0];
            cabModel=self.planeInfoArray[1];
            s_airportModel *sModel=[[s_airportModel alloc] initWithDictionary:model.s_airport];
            e_airportModel *eModel=[[e_airportModel alloc] initWithDictionary:model.e_airport];
            parameters=@{@"type":@"1",@"s":sModel.city_code,@"e":eModel.city_code,@"sd":[model.OffTime substringWithRange:NSMakeRange(0, 10)],@"flightno":model.FlightNo,@"cabin":cabModel.Cabin};
            
        }else if(self.planeInfoArray.count/2==2){
            //去程
            baseModel *model = [[baseModel alloc] init];
            cablistModel *cabModel = [[cablistModel alloc] init];
            model=[self.planeInfoArray objectAtIndex:0];
            cabModel=self.planeInfoArray[1];
            s_airportModel *sModel=[[s_airportModel alloc] initWithDictionary:model.s_airport];
            e_airportModel *eModel=[[e_airportModel alloc] initWithDictionary:model.e_airport];
            
            //返程
            baseModel *model1 = [[baseModel alloc] init];
            cablistModel *cabModel1 = [[cablistModel alloc] init];
            model1=[self.planeInfoArray objectAtIndex:2];
            cabModel1=self.planeInfoArray[3];
            
            parameters=@{@"type":@"2",@"s":sModel.city_code,@"e":eModel.city_code,@"sd":[model.OffTime substringWithRange:NSMakeRange(0, 10)],@"flightno":model.FlightNo,@"cabin":cabModel.Cabin,@"fsd":[model1.OffTime substringWithRange:NSMakeRange(0, 10)],@"fflightno":model1.FlightNo,@"fcabin":cabModel1.Cabin};
            
        }
    }
    DLog(@"pardic=%@",parameters);
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:PlaneShoworderinfo parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
              NSLog(@"ssss  = %@",dict);
              //[QXBModelTool createJsonModelWithDictionary:[[[dict objectForKey:@"data"] objectForKey:@"q"] objectForKey:@"sport"] modelName:@"sportModel"];
              
              //[QXBModelTool createJsonModelWithDictionary:[[[dict objectForKey:@"data"] objectForKey:@"q"] objectForKey:@"eport"] modelName:@"eportModel"];
              
              if ([[dict objectForKey:@"state"] integerValue]==1) {
                  
                  _flightsDic = [[NSDictionary alloc] initWithDictionary:[dict objectForKey:@"data"]];
                  if ([[[dict objectForKey:@"data"] objectForKey:@"leixing"] isEqualToString:@"单程"]) {
                      //单程
                      LXPlaneOrderModel *orderModel=[[LXPlaneOrderModel alloc] initWithDictionary:[[dict objectForKey:@"data"] objectForKey:@"q"]];
                      [_planeOrderInfoArray addObject:orderModel];
                  }else{
                      //去程
                      LXPlaneOrderModel *orderModel=[[LXPlaneOrderModel alloc] initWithDictionary:[[dict objectForKey:@"data"] objectForKey:@"q"]];
                      [_planeOrderInfoArray addObject:orderModel];
                      
                      //返程
                      LXPlaneOrderModel *orderModel1=[[LXPlaneOrderModel alloc] initWithDictionary:[[dict objectForKey:@"data"] objectForKey:@"f"]];
                      [_planeOrderInfoArray addObject:orderModel1];
                      
                  }
                  
                  [self initPlaneInfo];
                  [self initFareView];
                  
                  [self initBottomView];
              }
              
              [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
             
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              NSLog(@"Error: %@", error);
              
          }];
}

#pragma mark 机票信息view
-(void)initPlaneInfo
{
    //机票信息
    _view1=[[UIView alloc] init];
    _view1.frame=CGRectMake(0, 15, windowContentWidth, planeInfoViewHeight*(self.planeInfoArray.count/2)+30);
    _view1.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:_view1];
    
    //NSString *totalPrice1;
   // NSString *jiyouPrice;
    for (int i=0; i<_planeOrderInfoArray.count; i++) {
//        baseModel *model = [[baseModel alloc] init];
//        cablistModel *cabModel = [[cablistModel alloc] init];
//        if (i==0) {
//            model=[self.planeInfoArray objectAtIndex:0];
//            cabModel=self.planeInfoArray[1];
//            _totalPrice1=cabModel.Sale;
//            _jiyouPrice=[NSString stringWithFormat:@"%ld",[model.Oil integerValue]+[model.Tax integerValue]];
//        }else if(i==1){
//            model=[self.planeInfoArray objectAtIndex:2];
//            cabModel=self.planeInfoArray[3];
//            _totalPrice1=[NSString stringWithFormat:@"%ld",[_totalPrice1 integerValue]+[cabModel.Sale integerValue]];
//            _jiyouPrice=[NSString stringWithFormat:@"%ld",[model.Oil integerValue]+[model.Tax integerValue]+[_jiyouPrice integerValue]];
//        }
        LXPlaneOrderModel *model=[_planeOrderInfoArray objectAtIndex:i];
        _totalPrice1=[NSString stringWithFormat:@"%ld",[_totalPrice1 integerValue]+[model.Sale integerValue]];
        _jiyouPrice=[NSString stringWithFormat:@"%ld",[model.Oil integerValue]+[model.Tax integerValue]+[_jiyouPrice integerValue]];
        NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"LXPlaneInfoView"owner:self options:nil];
        LXPlaneInfoView *planeInfoView = [nibView objectAtIndex:0];
        planeInfoView.frame=CGRectMake(0, planeInfoViewHeight*i+1*i, windowContentWidth, planeInfoViewHeight);
        [planeInfoView setPlaneView:model planeType:i];
        planeInfoView.planeImage.frame=CGRectMake((windowContentWidth-30)/2, 64, 30, 30);
        planeInfoView.planeTypeLab.frame=CGRectMake((windowContentWidth-40)/2, ViewY(planeInfoView.leaveAirdromeLab), 40, 30);
        [_view1 addSubview:planeInfoView];
    }
    
    NSString *str=[NSString stringWithFormat:@"票价：    <span style=color:#E53333;>￥%@</span>",_totalPrice1];
    UILabel *planePriceLab=[[UILabel alloc] init];
    planePriceLab.frame=CGRectMake(15, ViewHeight(_view1)-30, 120, 30);
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    planePriceLab.attributedText = attributedString;
    planePriceLab.font=[UIFont systemFontOfSize:15];
    planePriceLab.userInteractionEnabled=YES;
    [_view1 addSubview:planePriceLab];
    
    UIImageView *tishiImage=[YXTools allocImageView:CGRectMake(37, 7, 15, 15) image:[UIImage imageNamed:@"提示"]];
    [planePriceLab addSubview:tishiImage];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tishiTap)];
    [planePriceLab addGestureRecognizer:tap];
    
    _tishiImage1=[YXTools allocImageView:CGRectMake(ViewX(_view1)+40, ViewY(_view1)+ViewHeight(_view1)-5, 210, 30) image:[UIImage imageNamed:@"提示文字"]];
    _tishiImage1.hidden=YES;
    [_scrollView addSubview:_tishiImage1];
    [_scrollView bringSubviewToFront:self.view];
    
    UILabel *tishiLab=[YXTools allocLabel:@"暂不支持儿童（12周岁以下）预订" font:systemFont(13) textColor:[UIColor whiteColor] frame:CGRectMake(5, 2, ViewWidth(_tishiImage1), ViewHeight(_tishiImage1)) textAlignment:0];
    [_tishiImage1 addSubview:tishiLab];
    
    
    NSString *str1=[NSString stringWithFormat:@"机/油：<span style=color:#E53333;>￥%@</span>",_jiyouPrice];
    UILabel *planePriceLab1=[[UILabel alloc] init];
    planePriceLab1.frame=CGRectMake(ViewX(planePriceLab)+ViewWidth(planePriceLab), ViewHeight(_view1)-30, 120, 30);
    NSAttributedString *attributedString1 = [[NSAttributedString alloc] initWithData:[str1 dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    planePriceLab1.attributedText = attributedString1;
    planePriceLab1.font=[UIFont systemFontOfSize:15];
    
    [_view1 addSubview:planePriceLab1];
    
    
}

-(void)tishiTap
{
    if (_tishiImage1.hidden==YES) {
        _tishiImage1.hidden=NO;
    }else{
        _tishiImage1.hidden=YES;
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _tishiImage1.hidden=YES;
}

#pragma mark 乘机人view
-(void)initFareView
{
    //乘机人
    _view2=[[UIView alloc] init];
    _view2.frame=CGRectMake(0, ViewY(_view1)+ViewHeight(_view1)+15, windowContentWidth, 45);
    _view2.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:_view2];
    [_scrollView sendSubviewToBack:_view2];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addFareTap)];
    [_view2 addGestureRecognizer:tap];
    
    UILabel *fareLab=[[UILabel alloc] initWithFrame:CGRectMake(15, 10, 60, 25)];
    fareLab.text=@"乘机人";
    [_view2 addSubview:fareLab];
    
    UILabel *fareLab1=[[UILabel alloc] initWithFrame:CGRectMake(ViewY(fareLab)+ViewWidth(fareLab), 10, 200, 25)];
    fareLab1.text=@"(请确保乘机人姓名、证件号填写正确)";
    fareLab1.font=[UIFont systemFontOfSize:12];
    fareLab1.textColor=[UIColor grayColor];
    [_view2 addSubview:fareLab1];
    
    UIButton *addFareBtn=[YXTools allocButton:nil textColor:nil nom_bg:[UIImage imageNamed:@"添加"] hei_bg:nil frame:CGRectMake(windowContentWidth-35, 13, 20, 20)];
    addFareBtn.tag=1;
    [addFareBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_view2 addSubview:addFareBtn];
    
    
    //航空意外险
    _view3=[[UIView alloc] init];
    _view3.frame=CGRectMake(0, ViewY(_view2)+ViewHeight(_view2)+15, windowContentWidth, 45);
    _view3.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:_view3];
    
    UILabel *titleLab=[[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 25)];
    titleLab.text=@"航空意外险";
    [_view3 addSubview:titleLab];
    
    UILabel *priceLab=[[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth-150, 10, 100, 25)];
    priceLab.text=@"￥20/份";
    [_view3 addSubview:priceLab];
    
    UIButton *selectSafetyBtn=[YXTools allocButton:nil textColor:nil nom_bg:[UIImage imageNamed:@"选中圆圈"] hei_bg:nil frame:CGRectMake(windowContentWidth-35, 13, 20, 20)];
    selectSafetyBtn.tag=2;
    selectSafetyBtn.selected=YES;
    [selectSafetyBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_view3 addSubview:selectSafetyBtn];
    
}

-(void)initBottomView
{
    bookView = [[OrderTextFieldView alloc] initWithFrame:CGRectMake(0, ViewHeight(_view3)+ViewY(_view3)+15, windowContentWidth, 160) placderName:@"请输入联系人姓名" placderPhone:@"请输入手机号"];
    bookView.contactImagV.image = [UIImage imageNamed:@"order联系人"];
    bookView.phoneImagV.image = [UIImage imageNamed:@"手机号"];
    bookView.nameTextField.delegate = self;
    bookView.phoneTextField.delegate = self;
    bookView.phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    bookView.tag = 201;
    [_scrollView addSubview:bookView];
    //hjxqBtn常用联系人
    UIButton *contactBtn = [YXTools allocButton:@"常用联系人" textColor:[UIColor whiteColor] nom_bg:[UIImage imageNamed:@"咨询"] hei_bg:nil frame:CGRectMake( 70, 100, windowContentWidth-140, 35)];
    [contactBtn addTarget:self action:@selector(selectedContact) forControlEvents:UIControlEventTouchUpInside];
    contactBtn.titleLabel.font = systemBoldFont(15);
    contactBtn.layer.cornerRadius = 5.0;
    [bookView addSubview:contactBtn];
    
    
    agreeBtn = [YXTools allocButton:@"" textColor:[UIColor whiteColor] nom_bg:nil hei_bg:nil frame:CGRectMake(Begin_X,ViewHeight(bookView)+ViewY(bookView)+20,125,30)];
    agreeBtn.tag = 1;
    [agreeBtn addTarget:self action:@selector(clickAgree:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:agreeBtn];
    UIImageView *leftView = [YXTools allocImageView:CGRectMake(0, 5, 20, 20) image:[UIImage imageNamed:@"已同意"]];
    [agreeBtn addSubview:leftView];
    
    UILabel *tishiLabel = [YXTools allocLabel:@"我已阅读并接受" font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(ViewWidth(leftView)+ViewX(leftView)+5, 0, 100, 30) textAlignment:2];
    [agreeBtn addSubview:tishiLabel];
    
    tiaokuangBtn = [YXTools allocButton:@"《微旅平台预定重要条款》" textColor:[UIColor redColor] nom_bg:nil hei_bg:nil frame:CGRectMake(ViewWidth(agreeBtn)+ViewX(agreeBtn),ViewY(agreeBtn),175,30)];
    tiaokuangBtn.tag = 2;
    tiaokuangBtn.titleLabel.font = systemFont(14);
    [tiaokuangBtn addTarget:self action:@selector(clickAgree:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:tiaokuangBtn];
    
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ControllerViewHeight - 40, windowContentWidth, 40)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    detailBtn = [YXTools allocButton:@"" textColor:[UIColor whiteColor] nom_bg:nil hei_bg:nil frame:CGRectMake(Begin_X, 0, windowContentWidth/2-10, 40)];
    [detailBtn addTarget:self action:@selector(orderDetail:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:detailBtn];
    
    _priceLabel = [YXTools allocLabel:@"订单总额￥0" font:systemBoldFont(14) textColor:[UIColor redColor] frame:CGRectMake(0, 0, windowContentWidth/2-35, 40) textAlignment:1];
    [detailBtn addSubview:_priceLabel];
    _priceLabel.text = [NSString stringWithFormat:@"订单总额￥0"];
    
    UIImageView *imageView = [YXTools allocImageView:CGRectMake(ViewWidth(_priceLabel)+ViewX(_priceLabel), ViewY(_priceLabel), 15, 40) image:[UIImage imageNamed:@"订单明细按钮"]];
    [detailBtn addSubview:imageView];
    
    UIButton *submitBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(ViewWidth(detailBtn)+ViewX(detailBtn), 0, windowContentWidth/2, 40);
    [submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = systemFont(14);
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"gjbd"] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitOrder) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:submitBtn];
    
    _scrollView.contentSize = CGSizeMake(0, ViewHeight(agreeBtn)+ViewY(agreeBtn)+150);
    
}

#pragma mark -- 提交订单
-(void)submitOrder
{
    if (_fareArray.count>0) {
        
        OrderTextFieldView *v = (OrderTextFieldView *)[self.view viewWithTag:201];
        if ([YXTools stringIsNotNullTrim:v.nameTextField.text] || [YXTools stringIsNotNullTrim:v.phoneTextField.text]) {
            [[LXAlterView sharedMyTools] createTishi:@"请完善联系人信息"];
            return;
        }
        if (![YXTools isValidateMobile:v.phoneTextField.text]) {
            [[LXAlterView sharedMyTools] createTishi:@"请输入正确的手机号"];
            return;
        }
        
        LXUserTool * userTool = [[LXUserTool alloc] init];
        
        if ([userTool getUid] == nil) {
            LoginAndRegisterViewController * fastLoginVC = [[LoginAndRegisterViewController alloc] init];
            [self.navigationController pushViewController:fastLoginVC animated:YES];
            return;
        }
        
        NSString *isBuySaf=_isBuySafety==YES?@"1":@"0";
        NSDictionary *passengerDic;
        NSMutableArray *passengArr=[[NSMutableArray alloc] initWithCapacity:0];
        DLog(@"乘机人信息=%@",[_fareArray objectAtIndex:0]);
        for (LXPlanePersonModel *planeModel in _fareArray) {
            
                passengerDic=@{@"addto":@"1",
                                @"idno":planeModel.card_no,
                              @"idtype":planeModel.card_type,
                              @"isunum":isBuySaf,
                              @"mobile":planeModel.mobile,
                               @"pname":planeModel.name,
                               @"ptype":@"1",
                             };
            [passengArr addObject:passengerDic];
        }

        NSString *token = @"~0;id<zOD.{ll@]JKi(:";
        NSString *token1 = [token stringByAppendingString:[userTool getUid]];
        
        NSDictionary *parameters=@{@"member_id":[userTool getUid],
                                       @"cname":bookView.nameTextField.text,
                                     @"cmobile":bookView.phoneTextField.text,
                                         @"tel":[userTool getPhone],
                                       @"email":[userTool getEmail],
                                 @"create_time":[NSString stringWithFormat:@"%ld",
                                                   (long)[[NSDate date] timeIntervalSince1970]],
                                       @"group":[userTool getuserGroup],
                                @"order_source":@"iOS",
                                           @"b":isBuySaf,
                                   @"flights":[self dictionaryToJson:_flightsDic],
                                   @"passenger":[self arrayToJson:passengArr],
                                   @"wltoken":[WXUtil md5:token1],
                                       };
        //DLog(@"提交的内容=%@",parameters);
        [[XCLoadMsg sharedLoadMsg:self] hideAll];
        [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:submitPlaneOrder parameters:parameters
              success:^(AFHTTPRequestOperation *operation,id responseObject) {
                  NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                  DLog(@"dict=%@,ssss  = %@,",dict,[[dict objectForKey:@"info"] objectForKey:@"flight"]);
                  //DLog(@"提交订单返回信息  = %@,%@",dict,[dict objectForKey:@"msg"]);
                  
                  [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
                  
                  if ( dict.count!=0 && [[dict objectForKey:@"error"] integerValue]==0) {
                      //[[LXAlterView sharedMyTools] createTishi:@"订单提交成功!"];
                      
                      NSMutableArray *planeOrderArr=[[NSMutableArray alloc] initWithCapacity:0];
                      NSString *place;
                      NSDictionary *flightDic=[LXTools  dictionaryWithJsonString:[[dict objectForKey:@"info"] objectForKey:@"flight"]];
                      DLog(@"------%@",[flightDic objectForKey:@"leixing"]);
                      if ([[flightDic objectForKey:@"leixing"] isEqualToString:@"单程"]) {
                          //单程
                          LXPlaneOrderModel *orderModel=[[LXPlaneOrderModel alloc] initWithDictionary:[flightDic objectForKey:@"q"]];
                          place=[NSString stringWithFormat:@"%@--%@",orderModel.StartPortName,orderModel.EndPortName];
                          [planeOrderArr addObject:orderModel];
                      }else{
                          //去程
                          LXPlaneOrderModel *orderModel=[[LXPlaneOrderModel alloc] initWithDictionary:[flightDic objectForKey:@"q"]];
                          [planeOrderArr addObject:orderModel];
                          
                          place=[NSString stringWithFormat:@"%@--%@(往返)",orderModel.StartPortName,orderModel.EndPortName];
                          
                          //返程
                          LXPlaneOrderModel *orderModel1=[[LXPlaneOrderModel alloc] initWithDictionary:[flightDic objectForKey:@"f"]];
                          [planeOrderArr addObject:orderModel1];
                          
                      }
                      
                      //乘机人
                      NSArray *arr=[LXTools JSONValue:[[dict objectForKey:@"info"] objectForKey:@"passenger"]];
                      NSMutableArray *passengerArr=[[NSMutableArray alloc] initWithCapacity:0];
                      for (int i=0; i<arr.count; i++) {
                          NSDictionary *dic=[arr objectAtIndex:i];
                          //LXPlanePersonModel *model=[[LXPlanePersonModel alloc] initWithDictionary:dic];
                          
                          [passengerArr addObject:[dic objectForKey:@"pname"]];
                          
                      }
                      
                      NSNumber *orderid=[[dict objectForKey:@"info"] objectForKey:@"orderid"];
                      
                      LXPlaneOrderPayViewController *planeOrderVc=[[LXPlaneOrderPayViewController alloc] init];
                      planeOrderVc.planeOrderInfoArray=planeOrderArr;
                      planeOrderVc.fareInfoArray=passengerArr;
                      planeOrderVc.contactPersonName=bookView.nameTextField.text;
                      planeOrderVc.contactPersonPhone=bookView.phoneTextField.text;
                      planeOrderVc.amount=[[dict objectForKey:@"info"] objectForKey:@"amount"];
                      planeOrderVc.baoxian=[[dict objectForKey:@"info"] objectForKey:@"baoxian"];
                      planeOrderVc.sale=[[dict objectForKey:@"info"] objectForKey:@"sale"];
                      planeOrderVc.taxoil=[[dict objectForKey:@"info"] objectForKey:@"taxoil"];
                      planeOrderVc.ordersn=[[dict objectForKey:@"info"] objectForKey:@"ordersn"];
                      planeOrderVc.place=place;
                      planeOrderVc.orderId=[NSString stringWithFormat:@"%@",orderid];
                      [self.navigationController pushViewController:planeOrderVc animated:YES];
                      
                      
                  }else{
                      
                      
                      [[LXAlterView sharedMyTools] createTishi:@"订单提交失败，请重试"];
                      
                      [self.navigationController popViewControllerAnimated:YES];
                  }
                  
                  
                  
              }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                  [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
                  NSLog(@"Error: %@", error);
                  [[LXAlterView sharedMyTools] createTishi:@"订单提交失败，请重试"];
              }];

    }else{
        [[LXAlterView sharedMyTools] createTishi:@"请添加乘机人"];
    }
}

#pragma mark -- 订单详细
- (void)orderDetail:(UIButton *)sender
{
    sender.userInteractionEnabled = NO;
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-40)];
    grayView.backgroundColor = [UIColor blackColor];
    grayView.alpha = 0.5;
    grayView.tag = 350;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteSearchView)];
    [grayView addGestureRecognizer:ges];
    [[YXTools getApp].window addSubview:grayView];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, windowContentHeight-190, windowContentWidth, 150)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.tag = 450;
    [[YXTools getApp].window addSubview:whiteView];

    
    UILabel *areaLabel =  [YXTools allocLabel:@"费用明细" font:systemFont(15) textColor:[UIColor orangeColor] frame:CGRectMake(0, 10, ViewWidth(whiteView), 30) textAlignment:1];
    [whiteView addSubview:areaLabel];
    
    NSString *price1;
    for (int i=0; i<_planeOrderInfoArray.count; i++) {
        if (_planeOrderInfoArray.count==1) {
            LXPlaneOrderModel *model=[_planeOrderInfoArray objectAtIndex:i];
            price1=[NSString stringWithFormat:@"￥%@*%ld",model.Sale,_fareArray.count];
        }else if (_planeOrderInfoArray.count == 2 ){
            LXPlaneOrderModel *model=[_planeOrderInfoArray objectAtIndex:0];
            LXPlaneOrderModel *model1=[_planeOrderInfoArray objectAtIndex:1];
            price1=[NSString stringWithFormat:@"￥(%@+%@)*%ld",model.Sale,model1.Sale,_fareArray.count];
        }
        
    }
    
    NSArray *nameArr=@[@"乘机人",@"机/油",@"航空意外险"];
    //price1=[NSString stringWithFormat:@"￥999*%ld",_fareArray.count];
    NSString *price2=[NSString stringWithFormat:@"￥%@*%ld",_jiyouPrice,_fareArray.count];
    NSString *price3=[NSString stringWithFormat:@"￥20*%ld",_fareArray.count];
    NSArray *priceArr=@[price1,price2,price3];
    for (int i=0; i<nameArr.count; i++) {
        UILabel *nameLab=[YXTools allocLabel:[nameArr objectAtIndex:i] font:systemFont(15) textColor:[UIColor grayColor] frame:CGRectMake(15, ViewY(areaLabel)+ViewHeight(areaLabel)+20+i*30, 100, 25) textAlignment:0];
        [whiteView addSubview:nameLab];
        
        UILabel *priceLab=[YXTools allocLabel:[priceArr objectAtIndex:i] font:systemFont(15) textColor:[UIColor blackColor] frame:CGRectMake(windowContentWidth-115, ViewY(areaLabel)+ViewHeight(areaLabel)+20+i*30, 100, 25) textAlignment:0];
        [whiteView addSubview:priceLab];
        
    }

}

#pragma mark ---- dictionaryToJson

- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
- (NSString*)arrayToJson:(NSArray *)arr

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}



- (void)deleteSearchView
{
    detailBtn.userInteractionEnabled = YES;
    UIView *v = (UIView *)[[YXTools getApp].window viewWithTag:350];
    [v removeFromSuperview];
    
    UIView *v1 = (UIView *)[[YXTools getApp].window viewWithTag:450];
    [v1 removeFromSuperview];
}

- (void)clickAgree:(UIButton *)sender
{
    if (sender.tag == 1)
    {
        UIImageView *leftView = [sender.subviews objectAtIndex:0];
        if (_isAgree)
        {
            leftView.image = [UIImage imageNamed:@"不同意"];
        }else
        {
            leftView.image = [UIImage imageNamed:@"已同意"];
        }
        _isAgree = !_isAgree;
        
    }else
    {
        YXWebDetailViewController *webVC = [[YXWebDetailViewController alloc] init];
        webVC.WebTitle = @"重要条款";
        webVC.webContent = @"<p> <strong><span style=‘font-size:16px;’>特别提示：</span></strong>微旅平台的产品均由具备资质的产品供应商提供。产品供应商充分借用微旅平台，推出全方位的产品，产品的行程安排以及合同签订都是由合作产品供应商为您提供。 微旅平台作为您获取产品的地点，本协议的签署并不意味着微旅平台成为产品交易的参与者，对前述交易微旅平台仅提供技术支持，不对供应商行为的合法性、有效性及产品的真实性、合法性及有效性作任何明示或暗示的担保。在预订微旅平台的产品前，请您仔细阅读本须知，并注意本须知及产品页面中的其它重要条款也作为双方协议的补充内容。当您开始预订微旅平台产品时，即表明您已经仔细阅读并接受本协议的所有条款。</p><p><strong>第一条 相关概念及注解</strong></p><p> 1、旅游产品：以旅游酒店+交通+景点+餐饮+旅游用车+导游服务+签证（出境游）为核心，行程、交通方式、食宿标准、游览项目均有固定安排，既有专业导游带您游览经典景区，又不含任何强制购物和自费的项目。<br />2、签证产品：目前只针对持有中国大陆地区因私护照的客人提供服务，主要包含代为预约、签证材料制作整理、翻译或使领馆允许的代送服务。<br />3、邮轮产品：指海洋上的定线、定期航行的大型客运轮船，它是由包括有形的（如邮轮、邮轮服务设施、游乐项目等）和无形的（邮轮服务、游客感受等）两部分组成。<br />4、旅游消费者：指通过微旅平台预订由旅游供应商提供的旅游产品的用户，用户在微旅平台上预订旅游产品成功后，用户和旅游供应商之间建立合同关系。</p><p><strong>第二条 旅游产品内容及其标准</strong></p><p>1、旅游产品内容主要包含：目的地接待服务及其他服务。具体产品的最终包含内容以确认的订单约定内容为准。<br />2、微旅平台关于旅游产品的行程推荐仅为友情提示，不能作为约定条款。<br />3、旅游产品中约定的产品和服务内容，均为经过微旅平台严格考评筛选出的具备相关资质的旅游供应商提供，微旅平台只对其经营资质的合法性承担责任，不对其在您消费过程中可能涉及的具体产品和服务内容承担责任。</p><p><strong>第三条 签证产品内容及其标准</strong></p><p>1、签证产品是以客人提供所需的材料为前提。网上公布的所需材料为使领馆要求每位申请人提供的必备材料。使领馆根据个人的不同情况可能会要求增补其它材料时，申请人应及时提供效真实的材料。一旦增补材料，不能在原受理时间内出签，客人的行程可能会受影响。鉴于，上述情形并非供应商所能控制，客人因此产生的损失，供应商不承担任何赔偿责任。<br />2、如申请人办签过程中，领馆对申请人进行行政审核导致未能及时出签或拒绝出签的，申请人应及时告知供应商，客人应承担因此产生的全部损失，但供应商将协助申请人减少损失。<br />3、提供所有材料并不意味着使领馆一定颁发签证。如遇使领馆拒签，供应商所收的全部费用不予以退还。</p><p><strong>第四条 产品价格</strong></p><p>微旅平台展示的产品价格均为实际价格，您预订的所有产品价格，均以微旅平台上显示的金额为准。</p><p><strong>第五条 订单生效</strong></p><p>1、您在微旅平台上预订产品，并通过第三方支付完成付款后，您的订单立即生效。但如您未按要求完成支付，而此时微旅平台为您预留的产品价格、内容或标准等有发生变化，微旅平台对此不承担任何责任。 订单生效，即代表您与产品供应商的合作意向已经达成，你的变更、解除产品等的需求，将受到本协议第五条、第六条等相关条款的约束。订购合同成立后，您应按订单中约定的时间和上车地点出发。如您未按约定出发，则视您的这种行为构成违约，您应承担由此导致的损失并按照约定支付违约金。</p><p><strong>第六条 您主动更改已生效订单</strong></p><p> 订单生效后，您若需要更改该订单内的任何项目，请务必在旅游行程开始前通知您的更改需求。我们会尽量满足您的需求，但您必须全额承担因变更带来的损失及可能增加的费用。若您所预订的产品在目的地停留的日期部分或全部处在国家法定节假日或其它部分国际性、国家性、地方性重大节日期间，鉴于资源的特殊状况，已生效订单不可进行任何更改。</p><p><strong>第七条 您主动解除已生效订单</strong></p><p>1、旅游产品订单生效后，您因个人原因不能出行造成违约，须按照下列标准承担违约责任：<br />在行程开始前7日以内提出取消订单的按下列标准扣除必要的费用：<br />国内游订单：<br />1）行程开始前6日至4日，按旅游费用总额的20%；<br />2）行程开始前3日至1日，按旅游费用总额的40%；<br />3）行程开始当日，按旅游费用总额的60%。<br />出境游（含港澳台）订单：<br />在行程开始前30日以内提出解除合同的，按下列标准扣除必要的费用：<br />1）行程开始前29日至15日，按旅游费用总额的5%；<br />2）行程开始前14日至7日，按旅游费用总额的20%；<br />3）行程开始前6日至4日，按旅游费用总额的50%；<br />4）行程开始前3日至1日，按旅游费用总额的60%；<br />5）行程开始当日，按旅游费用总额的70%。</p><p>2、邮轮产品订单生效后，您因个人原因不能出行造成违约，须按照下列标准承担违约责任：<br />1）开航前90天前（含第90天）内通知取消,收2000元/人损失;<br />2）开航前89天至45天前（含第45天）内通知取消,收取团款的50%;<br />3）开航前44天至15天前（含第15天）内通知取消，收取团款的80%;<br />4）开航前14天（含第14天）内通知取消,或没有在开航时准时出现,或在开航后无论以任何理由放弃旅行,其必须支付100%团费。</p><p>3、签证产品订单生效后，您因个人原因不能出行造成违约，须按照下列标准承担违约责任：<br />订单生效后，若要主动解除已生效订单，您必须及时通知供应商解除所做预订，包括放弃整张订单、减少办理人数，同时您还须承担供应商处理该订单已经支出的其它必要费用：<br />已付款的订单，如未产生签证费用的，将全额退款。如已产生签证费用，所有费用将不予退还。</p><p><strong>第八条 因供应商原因取消您的已生效订单</strong></p><p>1、在您按要求付清旅游产品费用后，如因供应商原因，致使您旅游产品不能成行而取消的，供应商应须按照下列标准承担违约责任：<br />国内游订单：<br />在行程开始前7日以内提出解除合同的，或者旅游消费者在行程开始前7日以内收到旅游供应商不能成团通知，不同意转团、延期出行和改签线路的，旅游供应商应向旅游消费者退还已收取的全部旅游费用，并按下列标准向旅游消费者支付违约金： <br />1）行程开始前6日至4日，支付旅游费用总额10%的违约金；<br />2）行程开始前3日至1日，支付旅游费用总额15%的违约金；<br />3）行程开始当日，支付旅游费用总额20%的违约金。<br />出境游（含港澳台）订单：<br />在行程开始前30日以内提出解除合同的，或者旅游消费者在行程开始前30日以内收到旅游供应商不能成团通知，不同意转团、延期出行和改签线路的，旅游供应商应向旅游消费者退还已收取的全部旅游费用（不得扣除签证／签注等费用），并按下列标准向旅游者支付违约金：<br />1）行程开始前29日至15日，支付旅游费用总额2%的违约金；<br />2）行程开始前14日至7日，支付旅游费用总额5%的违约金；<Br />3）行程开始前6日至4日，支付旅游费用总额10%的违约金；<br />4）行程开始前3日至1日，支付旅游费用总额15%的违约金；<br />5）行程开始当日，支付旅游费用总额20%的违约金。<br />如按上述比例支付的违约金不足以赔偿旅游者的实际损失，旅行社应当按实际损失对旅游者予以赔偿；具体参见各省旅游局格式合同条款。</p><p>2、在您按要求付清所有签证费用后，如因供应商原因，致使您的签证无法办理而取消或不能按时出签的，供应商应当立即通知您，无条件退返您已支付的所有费用。  </p><p><strong>第九条 旅游产品使用权的变更</strong></p><p> 在您按要求付清旅游产品费用后，在行程开始前，须经旅游供应商同意，您可以将您预订的当地游产品使用权转让或赠送给具有参加本次旅游产品活动条件的第三人。变更后如有费用增加，须由您全额承担，否则旅游供应商有权拒绝您的变更要求。</p><p><strong>第十条 您的权利和义务</strong></p><p> 1、您应确保出行人身体条件适合本次外出旅游度假，如出行人为孕妇或有心脏病、高血压、呼吸系统疾病等病史，请在征得医院专业医生同意后出行。<br />2、您保证提供给微旅平台的证件、通讯联络方式等相关资料均真实有效。<br />3、度假期间，您应尊重当地的宗教信仰、民族习惯和风土人情，自觉保护当地自然环境。<br />4、您须通过微旅平台预订并通过微旅平台页面支付全部旅游款。但相关款项将直接汇入微旅平台帐户。如您需要退款请直接联系微旅平台为您配置的旅行管家，旅行管家将协助您完成退款事宜。<br />5、您在旅游过程中如对旅游供应商的服务质量有异议，应积极与旅游供应商沟通，争取在旅游过程中解决。<br />6、您可以选择通过微旅平台或旅游供应商电话进行投诉。<br />7、如您不遵守本须知的规定，恶意干扰微旅平台的正常运营，恶意预订、更改或退订旅游产品，微旅平台保留追究您个人责任的权利。</p><p><strong>第十一条 相关责任</strong></p><p> 您在旅游中出现下列情况，微旅平台应协助办理，结果由您承担。<br />1、您在旅游中应注意人身财产安全，妥善保管自己的证件及行李物品， 如果发生人身意外、伤害或随身携带行李物品遗失、被盗、被抢等情况，微旅平台会积极协助办理，但无赔偿之责任；补办证件所产生的费用，由您自行承担。解决的依据应以相关机构的规定为准。您必须保留有关单据和证明文件。<br />2、您违反相关国家或地区的法律、法规而被罚、被拘留及被追究其他刑事、民事责任的，您应依法承担相关责任和费用。</p><p><strong>第十二条 不可抗力</strong></p><p> 1、旅游产品：以旅游酒店+交通+景点+餐饮+旅游用车+导游服务+签证（出境游）为核<br />心，行程、交通方式、食宿标准、游览项目均有固定安排，既有专业导游带您游览经典景区，又不含任何强制购物和自费的项目。<br />2、旅游消费者：指通过微旅平台预订由旅游供应商提供的旅游产品的微信用户，微信用户在微旅平台上预订旅游产品成功后，用户和旅游供应商之间建立合同关系。</p><p><strong>第十一条 不可抗力</strong></p><p> 1、因不可抗力(包括地震、台风、雷击、雪灾、水灾、火灾等自然原因,以及战争、政府行为、黑客攻击、电信部门技术管制等原因)和意外事件等原因不能履行或不能继续履行已生效订单约定内容的，双方均不承担违约责任，但法律另有规定的除外。<br />2、如果由于临时调价而导致的产品价格上涨，对于已成交的订单，不再向您收取涨价费用；对于已确认但未付款和未确认的订单，则以最新发布的价格为准。</p><p><strong>第十三条 关于旅行责任保险</strong></p><p>1、 责任险是对因旅行社责任引起的游客人身伤亡、财产遭受的损失及由此发生的相关费用的赔偿，对于游客，在实际发生意外时，“责任险”保障的主要是旅行社对游客出游期间依法应承担的各种民事赔偿责任，而这种责任由法院或相关仲裁机构裁决。这意味着意外发生后，旅行社是不包揽一切的，它只承担自己的责任。由于游客自身原因或其他方原因出险由游客自行负责，旅行社只提供道义上的协助。为了使游客获得更为全面的保障，我们强烈建议游客出游时根据个人意愿和需要自行投保个人险种。<br />2、 游客参加旅行社组织的旅游活动过程中，因旅行社原因引起的游客人身伤亡和财产损失，旅行社依据《旅行社投保旅行社责任保险的规定》承担责任。 <br />3、 游客参加旅行社组织的旅游活动过程中，由于游客个人过错导致的人身伤亡和财产损失，以及由此导致需支出的各种费用，旅行社不承担赔偿责任。<br />4、 游客在自行终止旅行社安排的旅游行程后，或在不参加双方约定的活动而自行活动的时间内，发生的人身、财产损害，旅行社不承担赔偿责任。</p>";
        [self.navigationController pushViewController:webVC animated:YES];
    }
}


- (void)selectedContact
{
    if ([[LXUserTool alloc] getUid] == nil) {
        
        LoginAndRegisterViewController * fastLoginVC = [[LoginAndRegisterViewController alloc] init];
        [self.navigationController pushViewController:fastLoginVC animated:YES];
        return;
        
    }
    if ([[[LXUserTool alloc] getuserGroup] isEqualToString:@"member"]) {
        LXCusInfoViewController *infoVC = [[LXCusInfoViewController alloc] init];
        infoVC.delegate = self;
        [self.navigationController pushViewController:infoVC animated:YES];
    }else
    {
        ZFJMyMemberListVC *myMemberVc=[[ZFJMyMemberListVC alloc] init];
        myMemberVc.backTitle = @"会员";
        myMemberVc.delegate = self;
        [self.navigationController pushViewController:myMemberVc animated:YES];
        
    }
    
}

-(void)addFareTap
{
    //增加乘机人
    if ([[LXUserTool alloc] getUid] == nil) {
        
        LoginAndRegisterViewController * fastLoginVC = [[LoginAndRegisterViewController alloc] init];
        [self.navigationController pushViewController:fastLoginVC animated:YES];
        return;
    }
    
    LXCContactViewController *lxccVc=[[LXCContactViewController alloc] init];
    lxccVc.blockArray=^(NSMutableArray *array){
        
        _fareArray = [NSMutableArray arrayWithArray:array];
        
        
         _priceLabel.text=[NSString stringWithFormat:@"订单总额￥%ld",([_totalPrice1 integerValue]+[_jiyouPrice integerValue]+20)*array.count];
        
        [self addFraeView];
        
       
    };
    [self.navigationController pushViewController:lxccVc animated:YES];
}



-(void)btnClick:(UIButton *)btn
{
    if (btn.tag==1) {
        //增加乘机人
        if ([[LXUserTool alloc] getUid] == nil) {
            
            LoginAndRegisterViewController * fastLoginVC = [[LoginAndRegisterViewController alloc] init];
            [self.navigationController pushViewController:fastLoginVC animated:YES];
            return;
        }
        
        LXCContactViewController *lxccVc=[[LXCContactViewController alloc] init];
        lxccVc.blockArray=^(NSMutableArray *array){
            _fareArray=[NSMutableArray arrayWithArray:array];
             _priceLabel.text=[NSString stringWithFormat:@"订单总额￥%ld",([_totalPrice1 integerValue]+[_jiyouPrice integerValue]+20)*array.count];
            [self addFraeView];
            
        };
        [self.navigationController pushViewController:lxccVc animated:YES];
        
        
    }else if (btn.tag==2){
        //是否选择航空意外险
        
        if (btn.selected==YES) {
           // btn.selected=NO;
            _isBuySafety=NO;
            [btn setBackgroundImage:[UIImage imageNamed:@"未选中圆圈"] forState:UIControlStateNormal];
            _priceLabel.text=[NSString stringWithFormat:@"订单总额￥%ld",([_totalPrice1 integerValue]+[_jiyouPrice integerValue]+20)*_fareNumber-_fareNumber*20];
        }else{
            //btn.selected=YES;
            _isBuySafety=YES;
            [btn setBackgroundImage:[UIImage imageNamed:@"选中圆圈"] forState:UIControlStateNormal];
            _priceLabel.text=[NSString stringWithFormat:@"订单总额￥%ld",([_totalPrice1 integerValue]+[_jiyouPrice integerValue]+20)*_fareNumber];
        }
        btn.selected=!btn.selected;
    }
}

-(void)addFraeView
{
    
    for (UIView *view in [_view2 subviews]) {
        if (view.tag>=100) {
            [view removeFromSuperview];
        }
    }
    
    _view2.frame=CGRectMake(0, ViewY(_view1)+ViewHeight(_view1)+15, windowContentWidth, 45+75*_fareArray.count);
    _fareNumber=_fareArray.count;
    NSArray *cartTypeArray=@[ @"身份证",
                              @"护照",
                              @"港澳通行证",
                              @"台胞证"];
    
    for (int i=0; i<_fareArray.count; i++) {
        
        LXPlanePersonModel *model=[_fareArray objectAtIndex:i];
        
        UIView *fareView=[[UIView alloc] initWithFrame:CGRectMake(0, 45+75*i, windowContentWidth, 75)];
        fareView.backgroundColor=[UIColor whiteColor];
        fareView.tag=i+100;
        [_view2 addSubview:fareView];
        
        UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, .5)];
        line.backgroundColor=TableLineColor;
        [fareView addSubview:line];
        
        UIButton *delBtn=[YXTools allocButton:nil textColor:nil nom_bg:nil hei_bg:nil frame:CGRectMake(10, 15, 45, 45)];
        [delBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        delBtn.tag=i+10;
        [delBtn addTarget:self action:@selector(delBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [fareView addSubview:delBtn];
        
        UILabel *nameLab=[YXTools allocLabel:model.name font:systemFont(15) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(delBtn)+ViewWidth(delBtn)+10, 7, 200, 25) textAlignment:0];
        [fareView addSubview:nameLab];
        
        UILabel *cartTypeLab=[YXTools allocLabel:[cartTypeArray objectAtIndex:[model.card_type integerValue]] font:systemFont(15) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(delBtn)+ViewWidth(delBtn)+10, ViewY(nameLab)+ViewHeight(nameLab), 60, 25) textAlignment:0];
        [fareView addSubview:cartTypeLab];
        
        UILabel *cardNumLab=[YXTools allocLabel:model.card_no font:systemFont(15) textColor:[UIColor grayColor] frame:CGRectMake(ViewX(cartTypeLab)+ViewWidth(cartTypeLab)+10, ViewY(cartTypeLab), 200, 25) textAlignment:0];
        [fareView addSubview:cardNumLab];
        
    }
    
    _view3.frame=CGRectMake(0, ViewY(_view2)+ViewHeight(_view2)+15, windowContentWidth, 45);
    bookView.frame=CGRectMake(0, ViewHeight(_view3)+ViewY(_view3)+15, windowContentWidth, 160);
    agreeBtn.frame=CGRectMake(Begin_X,ViewHeight(bookView)+ViewY(bookView)+20,125,30);
    tiaokuangBtn.frame=CGRectMake(ViewWidth(agreeBtn)+ViewX(agreeBtn),ViewY(agreeBtn),175,30);
    _scrollView.contentSize = CGSizeMake(0, ViewHeight(agreeBtn)+ViewY(agreeBtn)+150);
}

#pragma  mark -- 删除乘机人
-(void)delBtnClick:(UIButton *)btn
{
    [_fareArray removeObjectAtIndex:btn.tag-10];
//    for (UIView *view in [_view2 subviews]) {
//        if (view.tag>=100) {
//            [view removeFromSuperview];
//        }
//    }
    [self addFraeView];
    
//    UIView *fareView=(UIView *)[_view2 viewWithTag:btn.tag+90];
//    [fareView removeFromSuperview];
//    
//    _fareNumber--;
//    DLog(@"_fareNumber=%lu",_fareNumber);
//    _view2.frame=CGRectMake(0, ViewY(_view1)+ViewHeight(_view1)+15, windowContentWidth, 45+75*_fareNumber);
//    _view3.frame=CGRectMake(0, ViewY(_view2)+ViewHeight(_view2)+15, windowContentWidth, 45);
//    bookView.frame=CGRectMake(0, ViewHeight(_view3)+ViewY(_view3)+15, windowContentWidth, 160);
//    agreeBtn.frame=CGRectMake(Begin_X,ViewHeight(bookView)+ViewY(bookView)+20,125,30);
//    tiaokuangBtn.frame=CGRectMake(ViewWidth(agreeBtn)+ViewX(agreeBtn),ViewY(agreeBtn),175,30);
//    _scrollView.contentSize = CGSizeMake(0, ViewHeight(agreeBtn)+ViewY(agreeBtn)+150);
    
    _priceLabel.text=[NSString stringWithFormat:@"订单总额￥%ld",([_totalPrice1 integerValue]+[_jiyouPrice integerValue]+20)*_fareNumber];
}

#pragma mark ZFJMyMemberListVCDelegate
- (void)getMember:(MyMembersModel *)dic
{
    OrderTextFieldView *v = (OrderTextFieldView *)[self.view viewWithTag:201];
    if (dic.realname == nil) {
        v.nameTextField.text = dic.username;
        
    } else {
        v.nameTextField.text = dic.realname;
        
    }
    v.phoneTextField.text = dic.phone;
}

#pragma mark CusInfoViewControllerDelegate
- (void)getContact:(NSDictionary *)dic
{
    OrderTextFieldView *v = (OrderTextFieldView *)[self.view viewWithTag:201];
    v.nameTextField.text = [dic objectForKey:@"to_username"];
    v.phoneTextField.text = [dic objectForKey:@"phone"];
    [self.view endEditing:YES];
    [v.nameTextField resignFirstResponder];
    [v.phoneTextField resignFirstResponder];
}

#pragma mark - textField协议方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    return YES;
}

//当键盘出现或改变时调用
- (void)keyboardShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    //_scrollView.contentOffset = CGPointMake(_scrollView.frame.origin.x, windowContentHeight-_scrollView.frame.origin.y-height);
    bottomView.frame = CGRectMake(0, windowContentHeight-40-64-height, windowContentWidth, 40);
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    bottomView.frame = CGRectMake(0, windowContentHeight-40-64, windowContentWidth, 40);
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _scrollView.contentOffset = CGPointMake(_scrollView.frame.origin.x, [textField superview].frame.origin.y - 30);
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    OrderTextFieldView *v = (OrderTextFieldView *)[self.view viewWithTag:201];
    if (textField == v.phoneTextField) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    
    //当用户按下ruturn，把焦点从textField移开那么键盘就会消失了
    
    [textField resignFirstResponder];
    
    return YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

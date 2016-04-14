//
//  YXVisaPayViewController.m
//  WelLv
//
//  Created by lyx on 15/4/9.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "YXVisaPayViewController.h"
#import "PartnerConfig.h"
#import "Order.h"
#import "DataSigner.h"
#import "YXPaySuccessViewController.h"

@interface YXVisaPayViewController ()<UIAlertViewDelegate>
{
    payRequsestHandler *req;
    UILabel *statuLabel;
    UIButton *submitBtn;
    UIButton *cancelBtn;

    
    UIScrollView *_scrollView;
}
@end

@implementation YXVisaPayViewController
@synthesize place = _place,price = _price,orderId = _orderId,contact = _contact,tel = _tel;


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isStudyTour==YES && [self.pay_type integerValue]==2) {
        // 定金支付
        [LXSingletonClass shareInstance].isYouXue=YES;
    }else{
        [LXSingletonClass shareInstance].isYouXue=NO;
    }
    self.view.backgroundColor = BgViewColor;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight - 64 - 40)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(windowContentWidth, windowContentHeight);
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:ORDER_PAY_NOTIFICATION object:nil];
    self.title = @"订单详情";
    [self initView];
}

-(void)initView
{
    UILabel *placeLabel = [YXTools allocLabel:self.place font:systemBoldFont(15) textColor:[UIColor blackColor] frame:CGRectMake(Begin_X, Begin_X, windowContentWidth-Begin_X*2, 30) textAlignment:0];
    placeLabel.numberOfLines = 0;
    CGSize size=[self sizeWithString:self.place font:systemBoldFont(15)];
    [placeLabel setFrame:CGRectMake(Begin_X, Begin_X, ViewWidth(_scrollView)-Begin_X*2, size.height)];
    placeLabel.numberOfLines = 0;
    [_scrollView addSubview:placeLabel];
    
    YXAutoEditVIew *orderIdLable = [[YXAutoEditVIew alloc] initWithFrame:CGRectMake(0,ViewY(placeLabel)+ViewHeight(placeLabel)+10,windowContentWidth , 40)];
    orderIdLable.titleLable.text = @"订单编号:";
    [orderIdLable setContentText:self.orderId];
    orderIdLable.line.hidden = YES;
    orderIdLable.contentLabel.textColor = [UIColor orangeColor];
    orderIdLable.contentLabel.textAlignment=2;
    [_scrollView addSubview:orderIdLable];
    
    YXAutoEditVIew *beginDate = [[YXAutoEditVIew alloc] initWithFrame:CGRectMake(0,ViewY(orderIdLable)+ViewHeight(orderIdLable)+20,windowContentWidth , 40)];
    beginDate.titleLable.text = @"出行日期:";
    NSString *timeStr=[self.time substringWithRange:NSMakeRange(0, 10)];
   
    [beginDate setContentText:timeStr];
    beginDate.contentLabel.textAlignment = 2;
    beginDate.contentLabel.textColor = [UIColor orangeColor];
    [_scrollView addSubview:beginDate];
    
    YXAutoEditVIew *numberLable = [[YXAutoEditVIew alloc] initWithFrame:CGRectMake(0,ViewY(beginDate)+ViewHeight(beginDate),windowContentWidth , 40)];
    numberLable.titleLable.text = @"成员:";
    NSString *str=@"";
    if (_isVisa) {
        str= [NSString stringWithFormat:@"%d人",[self.adultNum intValue]];
    }else{
        if (_isStudyTour) {
            if ([YXTools stringIsNotNullTrim:self.childNum]) {
                
                str= [NSString stringWithFormat:@"%d家长/老师",[self.adultNum intValue]];
            }else if ([YXTools stringIsNotNullTrim:self.adultNum])
            {
                str= [NSString stringWithFormat:@"%@营员",self.childNum];
            }else
            {
                str= [NSString stringWithFormat:@"%@家长/老师  %@营员",self.adultNum,self.childNum];
            }
            
        }
        else
        {
            if ([self judgeString:self.childNum]&&[self judgeString: self.adultNum])
            {
                str= [NSString stringWithFormat:@"%@成人%@儿童",self.adultNum,self.childNum];
                
                //str= [NSString stringWithFormat:@"%d儿童",[self.childNum intValue]];
            } else if (![self judgeString:self.childNum]&&[self judgeString: self.adultNum]) {
                str= [NSString stringWithFormat:@"%d成人",[self.adultNum intValue]];
            }
            else if ([self judgeString:self.childNum]&&![self judgeString: self.adultNum])
            {
                str= [NSString stringWithFormat:@"%@儿童",self.childNum];
            }
        }
        
    }





    [numberLable setContentText:str];
    numberLable.contentLabel.textAlignment = 2;
    numberLable.contentLabel.textColor = [UIColor orangeColor];
    numberLable.line.hidden = YES;
    [_scrollView addSubview:numberLable];
    
    YXAutoEditVIew *contactLable = [[YXAutoEditVIew alloc] initWithFrame:CGRectMake(0,ViewY(numberLable)+ViewHeight(numberLable)+20,windowContentWidth , 40)];
    contactLable.titleLable.text = @"联系人:";
    [contactLable setContentText:self.contact];
    contactLable.contentLabel.textAlignment = 2;
    contactLable.contentLabel.textColor = [UIColor orangeColor];
    [_scrollView addSubview:contactLable];
    
    YXAutoEditVIew *phoneLable = [[YXAutoEditVIew alloc] initWithFrame:CGRectMake(0,ViewY(contactLable)+ViewHeight(contactLable),windowContentWidth , 40)];
    phoneLable.titleLable.text = @"手机号:";
    [phoneLable setContentText:self.tel];
    phoneLable.contentLabel.textAlignment = 2;
    phoneLable.line.hidden = YES;
    phoneLable.contentLabel.textColor = [UIColor orangeColor];
    [_scrollView addSubview:phoneLable];

    
    
    YXAutoEditVIew *costDetailLable = [[YXAutoEditVIew alloc] initWithFrame:CGRectMake(0,ViewY(phoneLable)+ViewHeight(phoneLable)+20,windowContentWidth,40)];
    costDetailLable.titleLable.text = @"费用明细:";

   
    [costDetailLable.line setFrame:CGRectMake(0, 39.5, windowContentWidth, 0.5)];


    [_scrollView addSubview:costDetailLable];
    
    
    
    YXAutoEditVIew *priceLable = [[YXAutoEditVIew alloc] initWithFrame:CGRectMake(0,ViewBelow(costDetailLable),windowContentWidth , 40)];
    priceLable.titleLable.text = @"产品总价:";
    [priceLable setContentText:[NSString stringWithFormat:@"￥%@",self.price]];
    priceLable.contentLabel.textAlignment = 2;
    priceLable.contentLabel.textColor = [UIColor orangeColor];
    [_scrollView addSubview:priceLable];
    
    YXAutoEditVIew *totalLable = [[YXAutoEditVIew alloc] initWithFrame:CGRectMake(0,ViewY(priceLable)+ViewHeight(priceLable),windowContentWidth ,40)];
    totalLable.titleLable.text = @"总计:";
    [totalLable setContentText:[NSString stringWithFormat:@"￥%@",self.price]];
    totalLable.contentLabel.textAlignment = 2;
    totalLable.contentLabel.textColor = [UIColor orangeColor];
    totalLable.line.hidden=YES;
    [_scrollView addSubview:totalLable];
    
    if ([self.pay_type integerValue]==2) {
        priceLable.titleLable.text = @"产品定金:";
       // totalLable.hidden=YES;
    }

    
        if ([[[LXUserTool alloc] getuserGroup] isEqualToString:@"assistant"]/* && (_isStudyTour==YES || _isTicket==YES||_isVisa==YES)) */|| [[[LXUserTool alloc] getuserGroup] isEqualToString:@"member"]){
        //会员可以支付。管家只能支付游学或者门票//根据测试最新测试，管家也可以下 签证的产品
        NSArray *payArr = [NSArray arrayWithObjects:@"微信支付",@"支付宝支付", nil];
        NSArray *imageArr = [NSArray arrayWithObjects:@"icon_pay_wechat",@"ico_pay_alipay", nil];
        
        if (![WXApi isWXAppInstalled] ) {
            payArr = [NSArray arrayWithObjects:@"支付宝支付", nil];
            imageArr = [NSArray arrayWithObjects:@"ico_pay_alipay", nil];
            
        }
        
    
        _btnViewArray = [[NSMutableArray alloc] init];
        for (int i = 0 ; i<payArr.count; i++) {
            UIButton *hotBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            hotBtn.frame = CGRectMake(0, ViewHeight(totalLable)+ViewY(totalLable)+20 +46*i, windowContentWidth, 45);
            hotBtn.backgroundColor = [UIColor whiteColor];
            hotBtn.tag = i+100;
            [hotBtn addTarget:self action:@selector(PayStyle:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:hotBtn];
            [_btnViewArray addObject:hotBtn];
            if (i==0) {
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(hotBtn)+ViewHeight(hotBtn), windowContentWidth, 0.5)];
                line.backgroundColor = bordColor;
                [_scrollView addSubview:line];
            }
            
            UIImageView *imageView2 = [YXTools allocImageView:CGRectMake(15, 0, 30, ViewHeight(hotBtn)) image:[UIImage imageNamed:[imageArr objectAtIndex:i]]];
            [hotBtn addSubview:imageView2];
            
            UILabel *title = [YXTools allocLabel:[payArr objectAtIndex:i] font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(imageView2)+ViewWidth(imageView2)+10, 0, 80, ViewHeight(hotBtn)) textAlignment:0];
            [hotBtn addSubview:title];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(hotBtn) - 30, (ViewHeight(hotBtn)-15)/2, 15,15 )];
            if (i == 0) {
                imageView.image = [UIImage imageNamed:@"选中圆圈"];
                _btnIndex = 100;
            } else {
                imageView.image = [UIImage imageNamed:@"未选中圆圈"];
                
            }
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [hotBtn addSubview:imageView];
        }
        
        UILabel *tishiLabel = [YXTools allocLabel:@"请尽快完成支付，逾时系统将自动取消订单" font:systemFont(13) textColor:[UIColor lightGrayColor] frame:CGRectMake(Begin_X, ViewHeight(totalLable)+ViewY(totalLable)+30+46*payArr.count, ViewWidth(placeLabel), 20) textAlignment:0];
        [_scrollView addSubview:tishiLabel];
        _scrollView.contentSize = CGSizeMake(0, ViewY(tishiLabel)+ViewHeight(tishiLabel)+20);
        
        cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(0, windowContentHeight - 64-40, windowContentWidth/2, 40);
        [cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancelBtn setBackgroundColor:kColor(215, 221, 225)];
        [cancelBtn addTarget:self action:@selector(cancelOrder) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:cancelBtn];
        
        submitBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        submitBtn.frame = CGRectMake(windowContentWidth/2, windowContentHeight - 64-40, windowContentWidth/2, 40);
        
            if (_isShip) {
                if ([[NSString stringWithFormat:@"%@",_order_statu] isEqualToString:@"0"] || [[NSString stringWithFormat:@"%@",_order_statu] isEqualToString:@"1"]) {
                    [submitBtn setTitle:@"确认支付" forState:UIControlStateNormal];
                    [submitBtn setBackgroundImage:[UIImage imageNamed:@"qzddBtn"] forState:UIControlStateNormal];
                }else{
                    [submitBtn setTitle:@"等待确认" forState:UIControlStateNormal];
                    submitBtn.userInteractionEnabled = NO;
                    [submitBtn setBackgroundColor:[UIColor grayColor]];
                }

            }else{
                
                if ([_order_statu integerValue] == 90 || [_order_statu integerValue] == 91 || [_order_statu integerValue] == 92 ) {
                    [submitBtn setTitle:@"等待确认" forState:UIControlStateNormal];
                    submitBtn.userInteractionEnabled = NO;
                    [submitBtn setBackgroundColor:[UIColor grayColor]];
                }else{
                    [submitBtn setTitle:@"确认支付" forState:UIControlStateNormal];
                    [submitBtn setBackgroundImage:[UIImage imageNamed:@"qzddBtn"] forState:UIControlStateNormal];
                }

            }
            
        submitBtn.titleLabel.font = systemFont(14);
        
        [submitBtn addTarget:self action:@selector(toPay) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submitBtn];

    }else{
        UILabel *tishiLabel = [YXTools allocLabel:@"请尽快完成支付，逾时系统将自动取消订单" font:systemFont(13) textColor:[UIColor lightGrayColor] frame:CGRectMake(Begin_X, ViewHeight(totalLable)+ViewY(totalLable)+20, ViewWidth(placeLabel), 20) textAlignment:0];
        [_scrollView addSubview:tishiLabel];
        _scrollView.frame = CGRectMake(0, 0, windowContentWidth, ControllerViewHeight);
        _scrollView.contentSize = CGSizeMake(0, ViewY(tishiLabel)+ViewHeight(tishiLabel)+20);
    }
    
    
    
}

-(void)cancelOrder{
    UIAlertView *alerV = [[UIAlertView alloc] initWithTitle:@"确定取消订单?" message:@"订单取消后您将不能继续支付" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alerV.tag=1;
    [alerV show];
}

#pragma mark ------- alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",buttonIndex);
    if (alertView.tag==1) {
        if (buttonIndex == 1) {
            //发送网络请求取消订单
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            NSString *md5str = [NSString stringWithFormat:@"~0;id<zOD.{ll@]JKi(:%@",[[LXUserTool alloc] getUid]];
            md5str = [WXUtil md5:md5str];
            NSLog(@"%@",CancelOrderUrl);
            NSDictionary *parameters = @{@"order_id":self.dingdanId,@"wltoken":md5str,@"member_id":self.memberId};
            [manager POST:CancelOrderUrl parameters:parameters
                  success:^(AFHTTPRequestOperation *operation,id responseObject) {
                       [[LXAlterView alloc] createTishi:@""];
                      NSString *html = operation.responseString;
                      NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
                      NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
//                      [[LXAlterView alloc] createTishi:[dict objectForKey:@"msg"]];
                      DLog(@"%@",responseObject);
                      DLog(@"dict = %@  \n msg = %@",dict,[dict objectForKey:@"msg"]);
                      [self.navigationController popViewControllerAnimated:YES];
                       [[LXAlterView sharedMyTools]createTishi:@"取消成功"];
                      
                  }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                      
                     DLog(@"Error: %@", error);
                      
                  }];
        }
    }else if (alertView.tag == 2){
       
        [self.navigationController popViewControllerAnimated:YES];
         [[LXAlterView sharedMyTools] createTishi:@"取消成功"];
    }
    
    
}

- (void)PayStyle:(UIButton *)sender
{
    _btnIndex = sender.tag;
    
    for (UIButton *btn in _btnViewArray) {
        UIImageView *view = btn.subviews[2];
        view.image = [UIImage imageNamed:@"未选中圆圈"];
    }
    UIImageView *view = sender.subviews[2];
    view.image = [UIImage imageNamed:@"选中圆圈"];
    
}

- (void)toPay
{
        if (_btnIndex == 0)
        {
            [[LXAlterView sharedMyTools] createTishi:@"请选择支付方式"];
        }
        else if ([_order_statu integerValue] == 90 || [_order_statu integerValue] == 91 || [_order_statu integerValue] == 92 )
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请等待商家确认后继续付款" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
            alert.tag=2;
            [alert show];
        }
        else if(_btnIndex == 100)
        {
            if (![WXApi isWXAppInstalled])
            {
                [self alikPay];
            }
            else
            {
                [self payOrder];
                
            }
        }
        else
        {
            [self alikPay];
        }
    
    
}




- (void)alikPay
{
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    
    NSString *body= [YXTools filterSpecialString:self.place];
    NSString *title = [YXTools filterSpecialString:self.place];
    if (body.length >512)
    {
        body = [body substringToIndex:512];
    }
    if (title.length > 128)
    {
        title = [title substringToIndex:128];
    }
    Order *order = [[Order alloc] init];
    order.partner = AlikPartnerID;
    order.seller = AlikSellerID;
    order.tradeNO = self.orderId; //订单ID（由商家自行制定）
    order.productName = title; //商品标题
    order.productDescription = body; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",[self.price floatValue]]; //商品价格
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
            NSString *errorCode = [resultDic objectForKey:@"resultStatus"];
            NSString *tishi = [resultDic objectForKey:@"memo"];
            if ([errorCode intValue] == 9000)
            {
                [self backSuccessViewController];
                tishi = @"支付成功";
            }
            else if ([errorCode intValue] == 8000) {
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
                                                            message: tishi
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
        NSLog(@"%@\n\n",debug);
    }
    else
    {
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
    int money = [self.price floatValue]*100;
    
   
    NSString *body= [YXTools filterSpecialString:self.place];
    if (body.length >32)
    {
        body = [body substringToIndex:32];
    }

    NSString *totalFee = [NSString stringWithFormat:@"%d",money];
    [packageParams setObject: APP_ID             forKey:@"appid"];       //开放平台appid
    [packageParams setObject: MCH_ID             forKey:@"mch_id"];      //商户号
    [packageParams setObject: @"APP-001"         forKey:@"device_info"]; //支付设备号或门店号
    [packageParams setObject: noncestr           forKey:@"nonce_str"];   //随机串
    [packageParams setObject: @"APP"             forKey:@"trade_type"];  //支付类型，固定为APP
    [packageParams setObject: body               forKey:@"body"];        //订单描述，展示给用户
    [packageParams setObject: NOTIFY_URL         forKey:@"notify_url"];  //支付结果异步通知
    [packageParams setObject: self.orderId       forKey:@"out_trade_no"];//商户订单号
    [packageParams setObject: @"127.0.0.1"       forKey:@"spbill_create_ip"];//发器支付的机器ip
    [packageParams setObject: totalFee           forKey:@"total_fee"];       //订单金额，单位为分
    
    //获取prepayId（预支付交易会话标识）
    NSString *prePayid;
    prePayid= [req sendPrepay:packageParams];
    
    if ( prePayid != nil)
    {
        //获取到prepayid后进行第二次签名
        NSString    *package, *time_stamp, *nonce_str;
        //设置支付参数
        time_stamp  = [self genTimeStamp];
        nonce_str	= [WXUtil md5:time_stamp];
        package         = @"Sign=WXPay";
        //第二次签名参数列表
        NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
        [signParams setObject: APP_ID        forKey:@"appid"];
        [signParams setObject: nonce_str    forKey:@"noncestr"];
        [signParams setObject: package      forKey:@"package"];
        [signParams setObject: MCH_ID        forKey:@"partnerid"];
        [signParams setObject: time_stamp   forKey:@"timestamp"];
        [signParams setObject: prePayid     forKey:@"prepayid"];
        NSString *sign  = [req createMd5Sign:signParams];
        
        //添加签名
        [signParams setObject: sign         forKey:@"sign"];
                //返回参数列表
        return signParams;
        
    }
    else
    {

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

- (void)getOrderPayResult:(NSNotification *)notification
{
    //    statuLabel.text = @"已支付";
    //    submitBtn.alpha = 0.5;
    //    submitBtn.userInteractionEnabled = NO;
    [self backSuccessViewController];
}

- (void)backSuccessViewController
{
    YXPaySuccessViewController *payVC = [[YXPaySuccessViewController alloc] init];
    payVC.beginDate = self.time;
    payVC.number = self.renshu;
    payVC.productName = self.place;
    payVC.contactPerson = self.contact;
    payVC.phone = self.tel;
    [self.navigationController pushViewController:payVC animated:YES];

}
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(windowContentWidth -20, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
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

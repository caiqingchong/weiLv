//
//  LXPlaneOrderPayViewController.m
//  WelLv
//
//  Created by liuxin on 15/9/16.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "LXPlaneOrderPayViewController.h"
#import "PartnerConfig.h"
#import "Order.h"
#import "DataSigner.h"
#import "YXPaySuccessViewController.h"
#import "LXPlaneOrderModel.h"

@interface LXPlaneOrderPayViewController ()<UIAlertViewDelegate>
{
    payRequsestHandler *req;
    UILabel *statuLabel;
    UIButton *submitBtn;
    UIButton *cancelBtn;
    
    
    UIScrollView *_scrollView;
    NSMutableArray *_btnViewArray;
    NSInteger _btnIndex;
}
@end

@implementation LXPlaneOrderPayViewController


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    [_scrollView addSubview:placeLabel];
    
    YXAutoEditVIew *orderIdLable = [[YXAutoEditVIew alloc] initWithFrame:CGRectMake(0,ViewY(placeLabel)+ViewHeight(placeLabel)+10,windowContentWidth , 40)];
    orderIdLable.titleLable.text = @"订单编号:";
    [orderIdLable setContentText:self.ordersn];
    orderIdLable.line.hidden = YES;
    orderIdLable.contentLabel.textColor = [UIColor orangeColor];
    [_scrollView addSubview:orderIdLable];
    
    //机票信息
    NSArray *arr=@[@"去程",@"返程"];
    NSArray *arr1=@[@"去程时间",@"返程时间"];
    YXAutoEditVIew *numberLable;
    for (int i=0; i<self.planeOrderInfoArray.count; i++) {
        LXPlaneOrderModel *model=[self.planeOrderInfoArray objectAtIndex:i];
        sportModel *smodel=[[sportModel alloc] initWithDictionary:model.sport];
        eportModel *emodel=[[eportModel alloc] initWithDictionary:model.eport];
        
        UILabel *airNameLab = [YXTools allocLabel:[NSString stringWithFormat:@"%@  %@  %@",[arr objectAtIndex:i],model.FlightNo,model.CabinName] font:systemBoldFont(15) textColor:[UIColor blackColor] frame:CGRectMake(Begin_X, ViewY(orderIdLable)+ViewHeight(orderIdLable)+130*i+10, windowContentWidth-Begin_X*2, 30) textAlignment:0];
        airNameLab.numberOfLines = 0;
        [_scrollView addSubview:airNameLab];
        
        YXAutoEditVIew *beginDate = [[YXAutoEditVIew alloc] initWithFrame:CGRectMake(0,ViewY(airNameLab)+ViewHeight(airNameLab)+10,windowContentWidth , 40)];
        beginDate.titleLable.text = [arr1 objectAtIndex:i];
        [beginDate setContentText:model.OffTime];
        beginDate.contentLabel.textAlignment = 2;
        beginDate.contentLabel.textColor = [UIColor orangeColor];
        [_scrollView addSubview:beginDate];
        
        
        numberLable = [[YXAutoEditVIew alloc] initWithFrame:CGRectMake(0,ViewY(beginDate)+ViewHeight(beginDate)+1,windowContentWidth , 40)];
        numberLable.titleLable.text = @"起降机场:";
        [numberLable setContentText:[NSString stringWithFormat:@"%@-%@",smodel.name,emodel.name]];
        numberLable.contentLabel.textAlignment = 2;
        numberLable.contentLabel.textColor = [UIColor orangeColor];
        numberLable.line.hidden = YES;
        [_scrollView addSubview:numberLable];
        
    }
    
    CGFloat hegiht;
    if (self.fareInfoArray.count<=3) {
        hegiht=40;
    }else if (self.fareInfoArray.count<=6 && self.fareInfoArray.count>3){
        hegiht=80;
    }else{
        hegiht=120;
    }
    YXAutoEditVIew *contactLable = [[YXAutoEditVIew alloc] initWithFrame:CGRectMake(0,ViewY(numberLable)+ViewHeight(numberLable)+20,windowContentWidth , hegiht)];
    contactLable.titleLable.text = @"乘机人:";
    contactLable.contentLabel.textAlignment = 2;
    contactLable.contentLabel.textColor = [UIColor orangeColor];
    contactLable.line.hidden=YES;
    [_scrollView addSubview:contactLable];
    
    CGFloat whit=windowContentWidth/4;
    for (int i =0; i<self.fareInfoArray.count; i++) {
        
        UIView *fareView=[[UIView alloc] initWithFrame:CGRectMake((windowContentWidth/4-15)+(i%3)*(whit), 5+(i/3)*35, whit-10, 30)];
        fareView.backgroundColor=kColor(76, 216, 134);
        [contactLable addSubview:fareView];
        
        UIImageView *image=[[UIImageView alloc] init];
        image.frame=CGRectMake(3, 7, 11, 16);
        image.image=[UIImage imageNamed:@"乘机人"];
        [fareView addSubview:image];
        
        UILabel *fareLab=[YXTools allocLabel:[self.fareInfoArray objectAtIndex:i] font:systemFont(14) textColor:[UIColor whiteColor] frame:CGRectMake(20, 0, ViewWidth(fareView)-20, 30) textAlignment:0];
        //fareLab.backgroundColor=kColor(76, 216, 134);
        [fareView addSubview:fareLab];
        
    }
    
    YXAutoEditVIew *phoneLable = [[YXAutoEditVIew alloc] initWithFrame:CGRectMake(0,ViewY(contactLable)+ViewHeight(contactLable)+1,windowContentWidth , 40)];
    phoneLable.titleLable.text = @"联系人:";
    [phoneLable setContentText:self.contactPersonName];
    phoneLable.contentLabel.textAlignment = 2;
    phoneLable.line.hidden = YES;
    phoneLable.contentLabel.textColor = [UIColor orangeColor];
    [_scrollView addSubview:phoneLable];
    
    
    YXAutoEditVIew *costDetailLable = [[YXAutoEditVIew alloc] initWithFrame:CGRectMake(0,ViewY(phoneLable)+ViewHeight(phoneLable)+20,windowContentWidth , 40)];
    costDetailLable.titleLable.text = @"费用明细";
    costDetailLable.line.hidden=YES;
    [_scrollView addSubview:costDetailLable];
    
    
    YXAutoEditVIew *totalLable;
    NSArray *priceNameArray=@[@"机票：",@"机建+燃油费：",@"保险：",@"总计："];
    NSArray *priceArray=@[self.sale,self.taxoil,self.baoxian,self.amount];
    for (int i=0; i<priceArray.count; i++) {
        totalLable = [[YXAutoEditVIew alloc] initWithFrame:CGRectMake(0,ViewY(costDetailLable)+ViewHeight(costDetailLable)+1+40*i,windowContentWidth , 40)];
        totalLable.titleLable.text = [priceNameArray objectAtIndex:i];
        [totalLable setContentText:[NSString stringWithFormat:@"￥%@",[priceArray objectAtIndex:i]]];
        totalLable.contentLabel.textAlignment = 2;
        totalLable.contentLabel.textColor = [UIColor orangeColor];
        [_scrollView addSubview:totalLable];
    }

        //会员可以支付。管家只能支付游学或者门票
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
        [submitBtn setTitle:@"确认支付" forState:UIControlStateNormal];
        [submitBtn setBackgroundImage:[UIImage imageNamed:@"qzddBtn"] forState:UIControlStateNormal];
        
        
        submitBtn.titleLabel.font = systemFont(14);
        
        [submitBtn addTarget:self action:@selector(toPay) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submitBtn];
        
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
            NSDictionary *parameters = @{@"order_id":self.ordersn,@"wltoken":md5str,@"member_id":[[LXUserTool alloc] getUid]};
            [manager POST:CancelOrderUrl parameters:parameters
                  success:^(AFHTTPRequestOperation *operation,id responseObject) {
                      NSString *html = operation.responseString;
                      NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
                      NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
                      [[LXAlterView alloc] createTishi:[dict objectForKey:@"msg"]];
                      NSLog(@"%@",responseObject);
                      NSLog(@"dict = %@  \n msg = %@",dict,[dict objectForKey:@"msg"]);
                      
                      [self.navigationController popToRootViewControllerAnimated:YES];
                      
                  }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                      
                      NSLog(@"Error: %@", error);
                      
                  }];
        }
    }else if (alertView.tag == 2){
        [self.navigationController popToRootViewControllerAnimated:YES];
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
    
    //    if ([[[LXUserTool alloc] getuserGroup] isEqualToString:@"assistant"]) {
    //        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"管家不能支付" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
    //        //alert.tag=2;
    //        [alert show];
    //    }else{
    if (_btnIndex == 0) {
        [[LXAlterView sharedMyTools] createTishi:@"请选择支付方式"];
    }
    else if(_btnIndex == 100)
    {
        if (![WXApi isWXAppInstalled]) {
            [self alikPay];
        } else {
            [self payOrder];
            
        }
        

    }else
    {
        [self alikPay];
    }
    //   }
    
    
}




- (void)alikPay
{
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    
    NSString *body= [YXTools filterSpecialString:self.place];
    NSString *title = [YXTools filterSpecialString:self.place];
    if (body.length >512) {
        body = [body substringToIndex:512];
    }
    if (title.length > 128) {
        title = [title substringToIndex:128];
    }
    Order *order = [[Order alloc] init];
    order.partner = AlikPartnerID;
    order.seller = AlikSellerID;
    order.tradeNO = self.orderId; //订单ID（由商家自行制定）
    order.productName = title; //商品标题
    order.productDescription = body; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",[self.amount floatValue]]; //商品价格
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
            if ([errorCode intValue] == 9000) {
                //                statuLabel.text = @"已支付";
                //                submitBtn.alpha = 0.5;
                //                submitBtn.userInteractionEnabled = NO;
                [self backSuccessViewController];
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
    int money = [self.amount floatValue]*100;
    
    
    NSString *body= [YXTools filterSpecialString:self.place];
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
    [packageParams setObject: self.orderId           forKey:@"out_trade_no"];//商户订单号
    [packageParams setObject: @"127.0.0.1"    forKey:@"spbill_create_ip"];//发器支付的机器ip
    [packageParams setObject: totalFee       forKey:@"total_fee"];       //订单金额，单位为分
    
    //获取prepayId（预支付交易会话标识）
    NSString *prePayid;
    prePayid            = [req sendPrepay:packageParams];
    
    if ( prePayid != nil) {
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
        
    }else{
        //        [debugInfo appendFormat:@"获取prepayid失败！\n"];
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
     LXPlaneOrderModel *model=[self.planeOrderInfoArray objectAtIndex:0];
    
    YXPaySuccessViewController *payVC = [[YXPaySuccessViewController alloc] init];
    payVC.beginDate = model.OffTime;
    payVC.number = [NSString stringWithFormat:@"%lu",(unsigned long)self.fareInfoArray.count];
    payVC.productName = self.place;
    payVC.contactPerson = self.contactPersonName;
    payVC.phone = self.contactPersonPhone;
    [self.navigationController pushViewController:payVC animated:YES];
    
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

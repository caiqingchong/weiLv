//
//  PaymentViewController.m
//  FillOrder
//
//  Created by WeiLv on 16/1/14.
//  Copyright © 2016年 WeiLv. All rights reserved.
//

#import "PaymentViewController.h"

#import "PayTopView.h"

#import "PayNextView.h"
#import "TravelOrderDetailModel.h"
#import "TravelAffirmModel.h"

#import "PartnerConfig.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "YXPaySuccessViewController.h"
#import "LXCommonTools.h"
#import "payRequsestHandler.h"

#import "WXApi.h"
#import "WXApiObject.h"

#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface PaymentViewController ()

{
    payRequsestHandler *req;
}

@property (nonatomic,strong) PayTopView *topView;

@property (nonatomic,strong) PayNextView *nextView;

@property (nonatomic,strong) UIScrollView *scrollView;

//转动菊花
@property (nonatomic,strong) MBProgressHUD *HUD;


//判断选中状态
@property (nonatomic,assign) BOOL isSelected;

@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title =@"支付订单";
   

    
    [self layoutPageView];
    
}

/**
 *  页面布局
 */
- (void)layoutPageView{
    
    //添加滚动视图
    self.scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.scrollView.contentSize = CGSizeMake(UISCREEN_WIDTH, UISCREEN_HEIGHT);
    self.scrollView.backgroundColor = [UIColor colorWithRed:222/255.0 green:229/255.0 blue:235/255.0 alpha:1];
    [self.view addSubview:self.scrollView];
    
    //添加 PayTopView
    self.topView = [[PayTopView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT /3)];
    self.topView.backgroundColor = [UIColor whiteColor];
    
    //补充数据
    self.topView.titleLable.text = [NSString stringWithFormat:@"<%@>",self.affirmModel.product_name];
    //出发城市
    if ([self.affirmModel.route_type isEqualToString:@"-15"]) {
        self.topView.cityLable.text = [NSString stringWithFormat:@"出发城市:全国"];
    }else{
        self.topView.cityLable.text = [NSString stringWithFormat:@"出发城市:%@",self.affirmModel.f_city_name];
    }
    //订单编号
    self.topView.numberLable.text = [NSString stringWithFormat:@"订单编号:%@",self.affirmModel.order_sn];
    //出发日期
    self.topView.dateLable.text = [NSString stringWithFormat:@"出发日期:%@",self.affirmModel.f_time];
    //出游人数
    self.topView.peopleLable.text = [NSString stringWithFormat:@"出游人数:%@成人 %@儿童",self.affirmModel.adule,self.affirmModel.child];
    //订单总额
//    self.topView.countLable.text = [NSString stringWithFormat:@"¥:%@",self.affirmModel.order_price];
   // self.topView.priceLable.textColor = [UIColor blackColor];
    self.topView.priceLable.text = [NSString stringWithFormat:@"订单总额:  ¥ %@",self.orderPrice];
     NSMutableAttributedString *colorText = [[NSMutableAttributedString alloc] initWithString:self.topView.priceLable.text];
    NSRange blackRange = NSMakeRange([self.topView.priceLable.text rangeOfString:@"订单总额:"].location, [self.topView.priceLable.text rangeOfString:@"订单总额:"].length);
    [colorText addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:blackRange];
    [self.topView.priceLable setAttributedText:colorText];
    [self.topView.priceLable sizeToFit];

    [self.scrollView addSubview:self.topView];
    
    //添加 PayNextView
    self.nextView = [[PayNextView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame) + UISCREEN_WIDTH / 26, UISCREEN_WIDTH, UISCREEN_HEIGHT / 14.5 * 2)];
    //添加关联事件
    [self.nextView.payBtn addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.nextView.weiBtn addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.nextView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.nextView];
    
#pragma mark ---- 判断是否有微信支付 ----
    if (![WXApi isWXAppInstalled]) {
        [self.nextView setFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame) + UISCREEN_WIDTH / 26, UISCREEN_WIDTH, UISCREEN_HEIGHT / 14.5)];
        self.nextView.weiBtn.userInteractionEnabled = NO;
        self.nextView.weiBtn.hidden = YES;
        self.nextView.wxImage.hidden = YES;
        UILabel *weiLabel = (UILabel *)[self.nextView viewWithTag:501];
        weiLabel.hidden = YES;
        self.nextView.secondBtn.hidden = YES;
        self.nextView.firstLable.hidden = YES;
    }
    
    //确认支付按钮
    self.isSelected = YES;
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    payButton.tag = 112;
    payButton.frame = CGRectMake(UISCREEN_WIDTH / 36, CGRectGetMaxY(self.nextView.frame) + UISCREEN_HEIGHT / 27, UISCREEN_WIDTH - UISCREEN_WIDTH / 36 * 2, UISCREEN_HEIGHT / 14.5);
    [payButton setTitle:@"确认支付" forState:UIControlStateNormal];
    payButton.titleLabel.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 18.5];
    payButton.backgroundColor = [UIColor orangeColor];
    //添加关联事件
    [payButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:payButton];
    
    
}

/**
 *  Button 点击事件
 */
- (void)clickButtonAction:(UIButton *)button{
 
    if (button.tag == 110 || button.tag == 111)
    {
        if (_isSelected)
        {
            [self.nextView.firstBtn setBackgroundImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
            [self.nextView.secondBtn setBackgroundImage:[UIImage imageNamed:@"选中按钮"] forState:UIControlStateNormal];
        }
        else
        {
            [self.nextView.firstBtn setBackgroundImage:[UIImage imageNamed:@"选中按钮"] forState:UIControlStateNormal];
            [self.nextView.secondBtn setBackgroundImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
           
        }
         _isSelected = !_isSelected;
        
    }
    else if(button.tag == 112)
    {
        if (_isSelected)
        {
//            self.HUD.labelText = @"正在进入支付宝支付状态,请稍候";
//            [self setProgressHUD];
            [self alikPay];
            
        }
        else
        {
            if (![WXApi isWXAppInstalled])
            {
//                self.HUD.labelText = @"正在进入支付宝支付状态,请稍候";
//                [self setProgressHUD];
                [self alikPay];
            }
            else
            {
//                self.HUD.labelText = @"正在进入微信支付状态,请稍候";
//                [self setProgressHUD];
                [self payOrder];
                
            }
        }

    }

}

//添加加载
-(void)setProgressHUD
{
    self.HUD = [[MBProgressHUD alloc]initWithView:self.view];
    _HUD.frame = self.view.bounds;
    _HUD.minSize = CGSizeMake(100, 100);
    _HUD.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_HUD];
    [_HUD show:YES];
}


#pragma mark ------------------ 支付宝支付 -----------------------
- (void)alikPay
{
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
#pragma mark - 产品名称
    NSString *body= [YXTools filterSpecialString:self.affirmModel.product_name];
    NSString *title = [YXTools filterSpecialString:self.affirmModel.product_name];
    if (body.length >512) {
        body = [body substringToIndex:512];
    }
    if (title.length > 128) {
        title = [title substringToIndex:128];
    }
    Order *order = [[Order alloc] init];
    order.partner = AlikPartnerID;
    order.seller = AlikSellerID;
    
#pragma mark - 订单ID
    order.tradeNO = self.affirmModel.order_sn; //订单ID（由商家自行制定）
    
    order.productName = title; //商品标题
    order.productDescription = body; //商品描述
    
#pragma mark - 订单总价
    order.amount = [NSString stringWithFormat:@"%.2f",[self.orderPrice floatValue]]; //商品价格
//    order.amount = @"0.01";
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
            [self.HUD removeFromSuperview];
            NSLog(@"支付结果__________%@",resultDic);
            NSString *errorCode = [resultDic objectForKey:@"resultStatus"];
            NSString *tishi = [resultDic objectForKey:@"memo"];
            if ([errorCode intValue] == 9000)
            {
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
                                                            message:tishi
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            
        }];
    }
}

#pragma mark ----------------------微信支付--------------------------------
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
    int money = [self.orderPrice floatValue]*100;
    
    
    NSString *body= [YXTools filterSpecialString:self.affirmModel.product_name];
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
    [packageParams setObject: self.affirmModel.order_sn       forKey:@"out_trade_no"];//商户订单号
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
    [self backSuccessViewController];
}

- (void)backSuccessViewController
{
    int PersonNumber=[self.affirmModel.adule intValue]+[self.affirmModel.child intValue];;
    
    YXPaySuccessViewController *payVC = [[YXPaySuccessViewController alloc] init];
    payVC.beginDate = self.affirmModel.f_time;
    payVC.number =[NSString stringWithFormat:@"%d",PersonNumber];
    payVC.productName = self.affirmModel.product_name;
    payVC.contactPerson = self.affirmModel.orderContactPersonName;
    payVC.phone = self.affirmModel.orderContactPhone;
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end

//
//  JYCvisaOrderVC.m
//  WelLv
//
//  Created by lyx on 15/11/20.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCvisaOrderVC.h"
#import "PartnerConfig.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "YXPaySuccessViewController.h"
#import "WXUtil.h"
#import "JYCpaysucessVC.h"
#import "APService.h"
//#import "LXUserTool.h"
#define macurl      [NSString stringWithFormat:@"%@/api/orderApi/orderInfo",WLHTTP]
@interface JYCvisaOrderVC ()
{
    UIScrollView *scrollow;
    NSMutableArray *_btnViewArr;
    NSInteger _btnIndex;
    AFHTTPRequestOperationManager *manager;
    
}
@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation JYCvisaOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"支付订单";
    self.view.backgroundColor=BgViewColor;
    scrollow=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64-40)];
    scrollow.backgroundColor=[UIColor clearColor];
    [self.view addSubview:scrollow];
    [self createUI];
}
-(void)createUI
{
    UIView *nameView=[[UIView alloc]initWithFrame:CGRectMake(0, 10, windowContentWidth, 40)];
    nameView.backgroundColor=[UIColor whiteColor];
    [scrollow addSubview:nameView];
    
    UILabel *nameLabel=[YXTools allocLabel:self.partner_shop_name font:systemFont(18) textColor:[UIColor blackColor] frame:CGRectMake(Begin_X, 0, windowContentWidth-2*Begin_X, 40) textAlignment:0];
    nameLabel.numberOfLines=0;
    [nameView addSubview:nameLabel];
    UIView *tioajianView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(nameView)+10, windowContentWidth, 160)];
    tioajianView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:tioajianView];
    NSMutableArray *arr1=[NSMutableArray arrayWithObjects:@"就餐时间",@"就餐人数",@"餐位要求",@"备注", nil];
    for (int i=0; i<4; i++) {
        UILabel *leftLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, i*40, 80, 40)];
        leftLabel.textColor=[UIColor blackColor];
        leftLabel.font=systemFont(18);
        leftLabel.text=[NSString stringWithFormat:@"%@",arr1[i]];
        [tioajianView addSubview:leftLabel];
        UILabel *rightLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(leftLabel)+20, i*40, windowContentWidth-110, 40)];
        rightLabel.textColor=[UIColor orangeColor];
        rightLabel.font=systemFont(18);
        rightLabel.text=[NSString stringWithFormat:@"%@",self.arr[i]];
        [tioajianView addSubview:rightLabel];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 39+i*40, windowContentWidth, 1)];
        line.backgroundColor=bordColor;
        [tioajianView addSubview:line];
        if (i==3) {
            line.hidden=YES;
        }
    }
    UIView *hejiView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(tioajianView)+10, windowContentWidth, 40)];
    hejiView.backgroundColor=[UIColor whiteColor];
    [scrollow addSubview:hejiView];
    UILabel *hejiLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
    hejiLabel.textColor=[UIColor blackColor];
    hejiLabel.font=systemFont(18);
    hejiLabel.text=@"费用总计:";
    [hejiView addSubview:hejiLabel];
    UILabel *numberLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(hejiLabel), 0, 80, 40)];
    numberLabel.font=systemFont(18);
    numberLabel.textColor=[UIColor redColor];
    numberLabel.text=[NSString stringWithFormat:@"%@",self.hejiStr];
    [hejiView addSubview:numberLabel];
   
    NSArray *payArr = [NSArray arrayWithObjects:@"支付宝支付", nil];
    NSArray *imageArr = [NSArray arrayWithObjects:@"ico_pay_alipay", nil];
     _btnViewArr = [[NSMutableArray alloc] init];
    for (int i = 0 ; i<payArr.count; i++) {
        UIButton *hotBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        hotBtn.frame = CGRectMake(0, ViewBelow(hejiView)+10+40*i, windowContentWidth, 40);
        hotBtn.backgroundColor = [UIColor whiteColor];
        hotBtn.tag = i+100;
        [hotBtn addTarget:self action:@selector(PayStyle:) forControlEvents:UIControlEventTouchUpInside];
        [scrollow addSubview:hotBtn];
        [_btnViewArr addObject:hotBtn];
        if (i==0) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,ViewBelow(hotBtn)-1, windowContentWidth, 1)];
            line.backgroundColor = bordColor;
            [scrollow addSubview:line];
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

    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, windowContentHeight-64-40, windowContentWidth, 40)];
    btn.backgroundColor=[UIColor orangeColor];
    [btn addTarget:self action:@selector(toPay) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"确认支付" forState:UIControlStateNormal];
    [btn setTintColor:[UIColor whiteColor]];
    [self.view addSubview:btn];
}
-(void)PayStyle:(UIButton *)button
{
    _btnIndex = button.tag;
    
    for (UIButton *btn in _btnViewArr) {
        UIImageView *view = btn.subviews[2];
        view.image = [UIImage imageNamed:@"未选中圆圈"];
    }
    UIImageView *view = button.subviews[2];
    view.image = [UIImage imageNamed:@"选中圆圈"];

}
-(void)toPay
{
    
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString * memberId = [[[LXUserTool alloc] init] getUid];
    NSString *token1 = [token stringByAppendingString:memberId];
    
    NSDictionary *parameters = @{@"order_id":self.order_id,@"model_id":@"-6",@"where_field":@"driving_order_id",@"is_extend":@"-1"};
    NSLog(@"贾玉川%@",self.order_id);
    NSString *str=[[WLSingletonClass defaultWLSingleton]wlDictionaryToJson:parameters];
    NSDictionary *dict=@{@"datajson":str,@"wltoken":[WXUtil md5:token1],@"member_id":memberId};
   // [self setProgressHud];
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:macurl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"++++%@----",dict);
        
        if ([dict[@"state"]integerValue]==1) {
            [_hud hide:YES];
           // NSDictionary *dict2=dict[@"data"];
            Order *order = [[Order alloc] init];
            order.partner = AlikPartnerID;
            order.seller = AlikSellerID;
            NSString *trade=[NSString stringWithFormat:@"driving%@",self.sn];
            //NSLog(@"%@",trade);
            order.tradeNO = trade; //订单ID（由商家自行制定）
            order.productName = self.bTitle; //商品标题
            order.productDescription = self.bTitle; //商品描述
            order.amount = [NSString stringWithFormat:@"%.2f",0.01]; //商品价格[dict2[@"price"] floatValue]
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
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_hud hide:YES];
    }];


    
   
}
//- (void)alikPay
//{
//    /*
//     *生成订单信息及签名
//     */
//    //将商品信息赋予AlixPayOrder的成员变量
//    
////   NSString *body= [YXTools filterSpecialString:self.bTitle];
////    NSString *title = [YXTools filterSpecialString:self.bTitle];
////    if (body.length >512) {
////        body = [body substringToIndex:512];
////    }
////    if (title.length > 128) {
////        title = [title substringToIndex:128];
////    }
//    Order *order = [[Order alloc] init];
//    order.partner = AlikPartnerID;
//    order.seller = AlikSellerID;
//    order.tradeNO = self.order_id; //订单ID（由商家自行制定）
//    order.productName = self.bTitle; //商品标题
//    order.productDescription = self.bTitle; //商品描述
//    order.amount = [NSString stringWithFormat:@"%.2f",0.01]; //商品价格
//    order.notifyURL =  ZFBNOTIFY_URL; //回调URL
//    
//    order.service = @"mobile.securitypay.pay";   //固定值
//    order.paymentType = @"1";                    //支付类型。默认值为:1(商 品购买)。
//    order.inputCharset = @"utf-8";               //固定编码
//    order.itBPay = @"30m";
//    order.showUrl = @"m.alipay.com";
//    //    order.appenv = @"app";                   //支付来源
//    
//    //应用注册scheme,在WeiLv-Info.plist定义URL types
//    NSString *appScheme = @"WeiLv";
//    
//    //将商品信息拼接成字符串
//    NSString *orderSpec = [order description];
//    
//    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(AlikPartnerPrivKey);
//    NSString *signedString = [signer signString:orderSpec];
//    
//    //将签名成功字符串格式化为订单字符串,请严格按照该格式
//    NSString *orderString = nil;
//    if (signedString != nil) {
//        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                       orderSpec, signedString, @"RSA"];
//        
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            NSString *errorCode = [resultDic objectForKey:@"resultStatus"];
//            NSString *tishi = [resultDic objectForKey:@"memo"];
//            if ([errorCode intValue] == 9000) {
//                //                statuLabel.text = @"已支付";
//                //                submitBtn.alpha = 0.5;
//                //                submitBtn.userInteractionEnabled = NO;
//                [self backSuccessViewController];
//                tishi = @"支付成功";
//            } else if ([errorCode intValue] == 8000) {
//                tishi = @"正在处理中";
//            }else if ([errorCode intValue] == 4000)
//            {
//                tishi = @"订单支付失败";
//            }else if ([errorCode intValue] == 6001)
//            {
//                tishi = @"用户中途取消";
//            }else if ([errorCode intValue] == 6002)
//            {
//                tishi = @"网络连接出错";
//            }else
//            {
//                tishi = @"支付失败";
//            }
//            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果"
//                                                            message: tishi
//                                                           delegate:self
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil, nil];
//            [alert show];
//            
//            
//        }];
//    }
//}
//数据加载完成之前显示转动的菊花圈
- (void)setProgressHud
{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"审核中...";
    [self.view addSubview:_hud];
    [_hud show:YES];
}

- (void)backSuccessViewController
{
    JYCpaysucessVC *payVC = [[JYCpaysucessVC alloc] init];
    payVC.beginDate = [NSString stringWithFormat:@"%@",self.come_time];
    payVC.number = self.nums;
    payVC.productName = self.partner_shop_name;
    payVC.contactPerson = self.contacts;
    payVC.phone = self.phone;
    [self.navigationController pushViewController:payVC animated:YES];

}
//-(NSString *)returnStrFromSeconds:(double)seconds
//{
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: date];
//    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
//    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//    //用[NSDate date]可以获取系统当前时间
//    NSString *currentDateStr = [formatter stringFromDate:localeDate];
//    return currentDateStr;
//}

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

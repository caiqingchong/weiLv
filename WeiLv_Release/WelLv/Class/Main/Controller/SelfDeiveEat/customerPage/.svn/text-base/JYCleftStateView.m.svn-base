//
//  JYCleftStateView.m
//  WelLv
//
//  Created by lyx on 15/11/23.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
#import "WXUtil.h"
#import "JYCleftStateView.h"
#import "TimeLogModel.h"
#import "JYCcommentVC.h"
#import "LoginAndRegisterViewController.h"


#define cancelUrl   [NSString stringWithFormat:@"%@/api/orderApi/newCancelOrder",WLHTTP]
@interface JYCleftStateView()<UIActionSheetDelegate>

{
    AFHTTPRequestOperationManager *manager;
    UIScrollView *scrollView;
    
   
}
@property(nonatomic,strong)NSDictionary *downDict;
@property(nonatomic,strong)NSMutableArray *timeLog;
@property(nonatomic,copy)NSString *orderId;
@property(nonatomic,strong)NSMutableArray *productArr;
@end
@implementation JYCleftStateView
- (id)initWithFrame:(CGRect)frame and:(NSMutableDictionary *)dict with:(NSMutableArray *)arr
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor whiteColor];
        _timeLog=[[NSMutableArray alloc]init];
        _productArr=[[NSMutableArray alloc]init];
        _timeLog=arr;
        self.downDict=dict;
        self.orderId=dict[@"driving_order_id"];
        NSLog(@"%@",dict);
        NSMutableArray *arr2=[[NSMutableArray alloc]init];
        arr2=self.downDict[@"products"];
        for (NSDictionary *dict in arr2) {
            productsModel *model=[[productsModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [self.productArr addObject:model];
        }

      [self initUI];
    }
    return self;
}
-(void)initUI
{
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64-40-50)];
    scrollView.backgroundColor=BgViewColor;
    [self addSubview:scrollView];
    scrollView.contentSize=CGSizeMake(windowContentWidth, windowContentHeight+100);
    UIView *leftLine=[[UIView alloc]initWithFrame:CGRectMake(40, 0, 1, windowContentHeight+500)];
    leftLine.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:leftLine];
   
    int pay_status=[self.downDict[@"pay_status"] intValue];
    int order_status=[self.downDict[@"order_status"] intValue];
    //订单没有支付成功时的页面
    if (pay_status==1) {
       
    if (order_status!=2&&order_status!=4&&order_status!=5&&order_status!=9) {
        
        
        UIImageView *circleView=[[UIImageView alloc]initWithFrame:CGRectMake(31.5, 44, 17, 17)];
        circleView.layer.cornerRadius=8.5;
        circleView.image=[UIImage imageNamed:@"椭圆实心"];
        [scrollView addSubview:circleView];

        UIImageView *rightView=[[UIImageView alloc]initWithFrame:CGRectMake(ViewRight(circleView)+5, 20, windowContentWidth-51-10, 65)];
        rightView.image=[UIImage imageNamed:@"兑换框"];
        [scrollView addSubview:rightView];
        UILabel *leftLbael=[[UILabel alloc]initWithFrame:CGRectMake(10, 22.5,100, 20)];
        leftLbael.text=@"待支付";
        leftLbael.font=systemFont(15);
        leftLbael.textColor=[UIColor blackColor];
        [rightView addSubview:leftLbael];
        for (int i=0;i<self.timeLog.count; i++){
            UIImageView *circleView=[[UIImageView alloc]initWithFrame:CGRectMake(34, 141+i*95, 12, 12)];
            circleView.layer.cornerRadius=6;
            circleView.image=[UIImage imageNamed:@"椭圆圈"];
            [scrollView addSubview:circleView];
            
            UIImageView *rightView=[[UIImageView alloc]initWithFrame:CGRectMake(ViewRight(circleView)+5, 115+i*95, windowContentWidth-51-10, 65)];
            rightView.image=[UIImage imageNamed:@"接单框"];
            [scrollView addSubview:rightView];
            TimeLogModel *model2=[[TimeLogModel alloc]init];
            model2=self.timeLog[i];
            UILabel *leftLbael=[[UILabel alloc]initWithFrame:CGRectMake(10, 22.5,100, 20)];
            leftLbael.text=[NSString stringWithFormat:@"%@",[self returnStrWithStatus:model2.status :self.downDict[@"pay_status"]]];
            leftLbael.font=systemFont(15);
            leftLbael.textColor=[UIColor blackColor];
            [rightView addSubview:leftLbael];
            UILabel *rightLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(leftLbael)+10, 22.5, (ViewWidth(rightView)-20)/2, 20)];
            
            rightLabel.textColor=[UIColor grayColor];
            NSString *str=[self returnStrFromSeconds:[model2.time doubleValue]];
            NSLog(@"%@",str);
            rightLabel.text=[NSString stringWithFormat:@"%@",str];
            rightLabel.textAlignment=NSTextAlignmentRight;
            rightLabel.font=systemFont(12);
            [rightView addSubview:rightLabel];

        }
     
        UIView *botomView=[[UIView alloc]initWithFrame:CGRectMake(0, windowContentHeight-64-40-50,windowContentWidth,50)];
        botomView.backgroundColor=[UIColor whiteColor];
        [self addSubview:botomView];
        UIImageView *cancelView=[[UIImageView alloc]initWithFrame:CGRectMake(19, 4, windowContentWidth-40+2, 42)];
        cancelView.image=[UIImage imageNamed:@"评价框"];
        [botomView addSubview:cancelView];
        UIButton *cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 5, windowContentWidth-40, 40)];
        [cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.tag=106;
        [botomView addSubview:cancelBtn];
        
        
       }else
       {
           UIImageView *circleView=[[UIImageView alloc]initWithFrame:CGRectMake(31.5, 44, 17, 17)];
           circleView.layer.cornerRadius=8.5;
           circleView.image=[UIImage imageNamed:@"椭圆实心"];
           [scrollView addSubview:circleView];
           
           UIImageView *rightView=[[UIImageView alloc]initWithFrame:CGRectMake(ViewRight(circleView)+5, 20, windowContentWidth-51-10, 65)];
           rightView.image=[UIImage imageNamed:@"兑换框"];
           [scrollView addSubview:rightView];
           UILabel *leftLbael=[[UILabel alloc]initWithFrame:CGRectMake(10, 22.5,100, 20)];
           TimeLogModel *model2=[[TimeLogModel alloc]init];
           model2=self.timeLog[0];
           
           leftLbael.text=[NSString stringWithFormat:@"%@",[self returnStrWithStatus:model2.status:self.downDict[@"pay_status"]]];
           leftLbael.font=systemFont(15);
           leftLbael.textColor=[UIColor blackColor];
           [rightView addSubview:leftLbael];
           
           UILabel *rightLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(leftLbael)+10, 22.5, (ViewWidth(rightView)-20)/2, 20)];
           rightLabel.textColor=[UIColor grayColor];
           NSString *str=[self returnStrFromSeconds:[model2.time doubleValue]];
           
           rightLabel.text=[NSString stringWithFormat:@"%@",str];
           rightLabel.textAlignment=NSTextAlignmentRight;
           rightLabel.font=systemFont(12);
           [rightView addSubview:rightLabel];
           for (int i=1;i<self.timeLog.count; i++) {
               UIImageView *circleView=[[UIImageView alloc]init];
               
               circleView=[[UIImageView alloc]initWithFrame:CGRectMake(34, 45.5+i*95, 12, 12)];
               circleView.layer.cornerRadius=6;
               circleView.image=[UIImage imageNamed:@"椭圆圈"];
               [scrollView addSubview:circleView];
               UIImageView *rightView=[[UIImageView alloc]initWithFrame:CGRectMake(ViewRight(circleView)+5, 20+i*95, windowContentWidth-51-10, 65)];
               rightView.image=[UIImage imageNamed:@"接单框"];
               [scrollView addSubview:rightView];
               
               TimeLogModel *model2=[[TimeLogModel alloc]init];
               model2=self.timeLog[i];
               
               UILabel *leftLbael=[[UILabel alloc]initWithFrame:CGRectMake(10, 22.5,100, 20)];
               leftLbael.text=[NSString stringWithFormat:@"%@",[self returnStrWithStatus:model2.status :self.downDict[@"pay_status"]]];
               leftLbael.font=systemFont(15);
               leftLbael.textColor=[UIColor blackColor];
               [rightView addSubview:leftLbael];
               UILabel *rightLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(leftLbael)+10, 22.5, (ViewWidth(rightView)-20)/2, 20)];
               rightLabel.textColor=[UIColor grayColor];
               NSString *str=[self returnStrFromSeconds:[model2.time doubleValue]];
               
               rightLabel.text=[NSString stringWithFormat:@"%@",str];
               rightLabel.textAlignment=NSTextAlignmentRight;
               rightLabel.font=systemFont(12);
               [rightView addSubview:rightLabel];
           }
           [scrollView setFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64-40)];
       }
    }  else  if(pay_status==2){
        UIImageView *circleView=[[UIImageView alloc]initWithFrame:CGRectMake(31.5, 44, 17, 17)];
        circleView.layer.cornerRadius=8.5;
        circleView.image=[UIImage imageNamed:@"椭圆实心"];
        [scrollView addSubview:circleView];
        
        UIImageView *rightView=[[UIImageView alloc]initWithFrame:CGRectMake(ViewRight(circleView)+5, 20, windowContentWidth-51-10, 65)];
        rightView.image=[UIImage imageNamed:@"兑换框"];
        [scrollView addSubview:rightView];
        UILabel *leftLbael=[[UILabel alloc]initWithFrame:CGRectMake(10, 22.5,100, 20)];
        TimeLogModel *model2=[[TimeLogModel alloc]init];
        model2=self.timeLog[0];
        
        leftLbael.text=[NSString stringWithFormat:@"%@",[self returnStrWithStatus:model2.status:self.downDict[@"pay_status"]]];
        leftLbael.font=systemFont(15);
        leftLbael.textColor=[UIColor blackColor];
        [rightView addSubview:leftLbael];
        
        UILabel *rightLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(leftLbael)+10, 22.5, (ViewWidth(rightView)-20)/2, 20)];
        rightLabel.textColor=[UIColor grayColor];
        NSString *str=[self returnStrFromSeconds:[model2.time doubleValue]];
        
        rightLabel.text=[NSString stringWithFormat:@"%@",str];
        rightLabel.textAlignment=NSTextAlignmentRight;
        rightLabel.font=systemFont(12);
        [rightView addSubview:rightLabel];
        for (int i=1;i<self.timeLog.count; i++) {
            UIImageView *circleView=[[UIImageView alloc]init];
            
            circleView=[[UIImageView alloc]initWithFrame:CGRectMake(34, 46+i*95, 12, 12)];
            circleView.layer.cornerRadius=6;
            circleView.image=[UIImage imageNamed:@"椭圆圈"];
            [scrollView addSubview:circleView];
            UIImageView *rightView=[[UIImageView alloc]initWithFrame:CGRectMake(ViewRight(circleView)+5, 20+i*95, windowContentWidth-51-10, 65)];
            rightView.image=[UIImage imageNamed:@"接单框"];
            [scrollView addSubview:rightView];
            
            TimeLogModel *model2=[[TimeLogModel alloc]init];
            model2=self.timeLog[i];
            
            UILabel *leftLbael=[[UILabel alloc]initWithFrame:CGRectMake(10, 22.5,100, 20)];
            leftLbael.text=[NSString stringWithFormat:@"%@",[self returnStrWithStatus:model2.status :self.downDict[@"pay_status"]]];
            leftLbael.font=systemFont(15);
            leftLbael.textColor=[UIColor blackColor];
            [rightView addSubview:leftLbael];
            UILabel *rightLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(leftLbael)+10, 22.5, (ViewWidth(rightView)-20)/2, 20)];
            rightLabel.textColor=[UIColor grayColor];
            NSString *str=[self returnStrFromSeconds:[model2.time doubleValue]];
            
            rightLabel.text=[NSString stringWithFormat:@"%@",str];
            rightLabel.textAlignment=NSTextAlignmentRight;
            rightLabel.font=systemFont(12);
            [rightView addSubview:rightLabel];
        }

        TimeLogModel *model3=[[TimeLogModel alloc]init];
        model3=self.timeLog[0];
        NSLog(@"%@",model3.status);
        if ([model3.status intValue]==0) {
            UIView *botomView=[[UIView alloc]initWithFrame:CGRectMake(0, windowContentHeight-64-40-50,windowContentWidth,50)];
            botomView.backgroundColor=[UIColor whiteColor];
            [self addSubview:botomView];
            UIImageView *cancelView=[[UIImageView alloc]initWithFrame:CGRectMake(19, 4, windowContentWidth-40+2, 42)];
            cancelView.image=[UIImage imageNamed:@"评价框"];
            
            [botomView addSubview:cancelView];
            UIButton *cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 5, windowContentWidth-40, 40)];
            [cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [cancelBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
             cancelBtn.tag=101;
            [cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
           
            
            [botomView addSubview:cancelBtn];
           
        }else if([model3.status intValue]==1)
        {
            UIView *botomView=[[UIView alloc]initWithFrame:CGRectMake(0, windowContentHeight-64-40-50,windowContentWidth,50)];
            botomView.backgroundColor=[UIColor whiteColor];
            [self addSubview:botomView];
            UIImageView *leftImage=[[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 128, 40)];
            leftImage.image=[UIImage imageNamed:@"申请延期"];
            [botomView addSubview:leftImage];
            UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(21, 6, 126, 38)];
            [leftBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [leftBtn setTitle:@"申请延期" forState:UIControlStateNormal];
            [leftBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            leftBtn.tag=102;
            [botomView addSubview:leftBtn];
            UIImageView *rightView=[[UIImageView alloc]initWithFrame:CGRectMake(windowContentWidth-20-128, 5, 128, 40)];
            rightView.image=[UIImage imageNamed:@"申请撤单"];
            [botomView addSubview:rightView];
            UIButton *rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(ViewX(rightView)+1, 6, 126, 38)];
            [rightBtn setTitle:@"申请撤单" forState:UIControlStateNormal];
            [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            rightBtn.tag=105;
            [botomView addSubview:rightBtn];
        }else if([model3.status intValue]==2||[model3.status intValue]==3||[model3.status intValue]==11)
        {
            UIView *botomView=[[UIView alloc]initWithFrame:CGRectMake(0, windowContentHeight-64-40-50,windowContentWidth,50)];
            botomView.backgroundColor=[UIColor whiteColor];
            [self addSubview:botomView];
            UIImageView *cancelView=[[UIImageView alloc]initWithFrame:CGRectMake(19, 4, windowContentWidth-40+2, 42)];
            cancelView.image=[UIImage imageNamed:@"评价框"];
            [botomView addSubview:cancelView];
            UIButton *cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 5, windowContentWidth-40, 40)];
            [cancelBtn setTitle:@"申请退款" forState:UIControlStateNormal];
            [cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            cancelBtn.tag=103;
            [cancelBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [botomView addSubview:cancelBtn];
        }else if([model3.status intValue]==10)
        {
            UIView *botomView=[[UIView alloc]initWithFrame:CGRectMake(0, windowContentHeight-64-40-50,windowContentWidth,50)];
            botomView.backgroundColor=[UIColor whiteColor];
            [self addSubview:botomView];
            UIImageView *cancelView=[[UIImageView alloc]initWithFrame:CGRectMake(19, 4, windowContentWidth-40+2, 42)];
            cancelView.image=[UIImage imageNamed:@"评价框"];
            [botomView addSubview:cancelView];
            UIButton *cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 5, windowContentWidth-40, 40)];
            [cancelBtn setTitle:@"评价" forState:UIControlStateNormal];
            [cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            cancelBtn.tag=104;
            [cancelBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [botomView addSubview:cancelBtn];
        }else{
       
           [scrollView setFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64-40)];
        }
    }
    
   
    
    
}
-(void)btnClick:(UIButton *)button
{
    if (button.tag==101) {
       
        NSLog(@"123456");
       [self cancelOrder];
    }else if(button.tag==102)
    {
    UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"咨询店家" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"手机" otherButtonTitles:nil, nil];
            [actionsheet showInView:self];
    }else if(button.tag==105)
    {
        UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"咨询店家" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"手机" otherButtonTitles:nil, nil];
        [actionsheet showInView:self];
    }else if(button.tag==103)
    {
       [self cancelOrder];
    }else if(button.tag==104)
    {
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:self.productArr,@"1",self.orderId,@"2",self.downDict,@"3", nil];
        
        if ([self.delegate respondsToSelector:@selector(clickToPush:)]) {
            [self.delegate performSelector:@selector(clickToPush:) withObject:dic];
        }
        
    }else if(button.tag==106)
    {
         [self cancelOrder];
    }
}
#pragma mark  UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0){
        
        NSDictionary *dic=self.downDict[@"partner"];
        
        NSString *str=dic[@"main_phone"];
        NSLog(@"%@",str);
        NSString * telString = [NSString stringWithFormat:@"tel:%@", str];
        NSURL * telUrl = [NSURL URLWithString:telString];
        [[UIApplication sharedApplication] openURL:telUrl];
    }
    
}

-(NSString *)returnStrFromSeconds:(double)seconds
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [formatter stringFromDate:date];
    return currentDateStr;
}
-(NSString *)returnStrWithStatus:(NSString *)status :(NSString *)payStatus
{
    NSString *str;
    switch ([status intValue]) {
        case 0:
            str= @"等待商家接单";
            break;
        case 1:
            str= @"商家已接单";
            break;
        case 2:
            if([payStatus intValue]==2)
            {
              str= @"支付成功";

            }else if([payStatus intValue]==1){
            str= @"商家拒单";
            }
            break;
        case 3:
            str= @"订单超时";
            break;
        case 4:
            str= @"订单取消";
            break;
        case 5:
            str= @"自动取消";
            break;
        case 6:
            str= @"退款中";
            break;
        case 7:
            str= @"退款成功";
            break;
        case 8:
            str= @"退款失败";
            break;
        case 9:
            str= @"商户撤单";
            break;
        case 10:
            str= @"已核销";
            break;
        case 11:
            str= @"订单过期";
            break;

        default:
            break;
    }
    return str;
}
-(void)cancelOrder
{
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString * memberId = [[WLSingletonClass defaultWLSingleton]wlUserID];
    NSString *token1 = [token stringByAppendingString:memberId];
    //暂时没有合适状态的订单 无法测试
    NSDictionary *parameters = @{@"order_id":self.orderId,@"model_id":@"-6",@"operation_type":@"member"};
    
    NSString *str=[[WLSingletonClass defaultWLSingleton]wlDictionaryToJson:parameters];
    NSDictionary *dict=@{@"datajson":str,@"wltoken":[WXUtil md5:token1],@"member_id":memberId};
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:EatCancelUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dict);
        if ([dict[@"state"]intValue]==1) {
           [[LXAlterView sharedMyTools]createTishi:@"退单成功"];
        }else{
            
            NSLog(@"%@",dict[@"msg"]);
            //[[LXAlterView sharedMyTools]createTishi:@"退单失败,请稍后再试"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[LXAlterView sharedMyTools]createTishi:@"网络请求失败，请稍后再试"];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  JYCMyAccount.m
//  WelLv
//
//  Created by lyx on 16/1/15.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "JYCMyAccount.h"
#import "JYCDepositVC.h"
#import "JYCDepositDetailVC.h"
@interface JYCMyAccount()
{
   double add;
    //画圆的半径
   double radius;
   float top;
   float with;
}
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *timer2;
@property (nonatomic, strong) CAShapeLayer *shapeLayer2;
@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation JYCMyAccount

#pragma mark - 视图即将显示
-(void)viewWillAppear:(BOOL)animated
{
    //初始化网络数据
    [self initLoadData];
    
      //创建我的账户环形图像
    // [self initCircle];
    
    
    allowCount.text=@"";
    unallowCount.text=@"";
    
   

}

#pragma mark - 初始化
- (void)viewDidLoad
{
    //初始化父视图
    [super viewDidLoad];
 
    //设置视图背景颜色
    self.view.backgroundColor=[YXTools stringToColor:@"#262A37"];
    // 初始化导航区域
    [self initNavigationSection];
    

    //重构父类方法，防止左右滑动跳转
    [self addGes];

}
#pragma mark - 重构父类方法，防止左右滑动跳转
-(void)addGes
{
    
}
-(void)btnClick
{
   
    JYCDepositDetailVC *vc=[[JYCDepositDetailVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 初始化实体数据
-(void)initData
{
    //实体字段初始化
    total=@"0.00";//总账户
    active=@"";//可提现金额
    inactive=@"";//冻结金额
    top_total=@"0.00";//单日可提现最大金额
    top_times=@"0";//单日可提现次数
    i_percent=0;//可冻结金额百分比
    //self.imageActiveLines=[UIImage imageNamed:@"ActiveLines"]; //可提现金额折线图
    //self.imageInActiveLines=[UIImage imageNamed:@"InActiveLines"]; //冻结金额折线图
    
}


#pragma mark - 请求网络数据
-(void)initLoadData
{
    //初始化实体数据
    [self initData];
    [self setProgressHud];
    //参数初始化
    NSString *md5str = [NSString stringWithFormat:@"~0;id<zOD.{ll@]JKi(:%@",[[LXUserTool alloc] getUid]];
    md5str = [WXUtil md5:md5str];
    NSDictionary *parameters = @{@"member_id":[[LXUserTool alloc] getUid],@"group_name":[[LXUserTool alloc] getuserGroup],@"_token":md5str};

    //请求数据
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
  
    [manager POST:get_own_money_Url parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
              if ([[dict objectForKey:@"flag"] integerValue] == 1)
              {
                  [_hud hide:YES];
                  NSDictionary *dict1 = [dict objectForKey:@"data"];
                  //判断总账户是否为空
                  if ([dict1 objectForKey:@"total"]!=nil)
                  {
                      total=[NSString stringWithFormat:@"%@",[dict1 objectForKey:@"total"]];
                  }
                  
                  //判断可提现金额是否为空
                  if ([dict1 objectForKey:@"active"]!=nil)
                  {
                      active=[NSString stringWithFormat:@"%@",[dict1 objectForKey:@"active"]];
                  }
                  
                  //判断冻结金额是否为空
                  if ([dict1 objectForKey:@"inactive"]!=nil)
                  {
                      inactive=[NSString stringWithFormat:@"%@",[dict1 objectForKey:@"inactive"]];
                  }
                  
                  //判断单日可提现最大金额
                  if ([dict1 objectForKey:@"top_total"]!=nil)
                  {
                      top_total=[NSString stringWithFormat:@"%@",[dict1 objectForKey:@"top_total"]];
                  }
                  
                  //单日可提现次数
                  if ([dict1 objectForKey:@"top_times"]!=nil)
                  {
                      top_times=[NSString stringWithFormat:@"%@",[dict1 objectForKey:@"top_times"]];
                  }
                  
                  //计算弧度
                  if (![total isEqual:@"0.00"])
                  {
                      i_percent=[active floatValue]/[total floatValue];
                  }
               }
              else
              {
                  [[LXAlterView sharedMyTools] createTishi:[dict objectForKey:@"msg"]];
                  [_hud hide:YES];
              }
        //请求不成功也要创建，这样数据请求不成功时显示0
         //计算可提现与冻结各占的比例
         float activePresent=[active floatValue]/[total floatValue];
         float inactivePresent=[inactive floatValue]/[total floatValue];
         
        //重绘我的账户环形图像
        [self initCircleWith:activePresent and:inactivePresent];
        [self createBotomView];
         //创建底部提现按钮区域
        [self initBottomCashSection];
      }
      failure:^(AFHTTPRequestOperation *operation,NSError *error) {
          DLog(@"Error: %@", error);
          [[LXAlterView sharedMyTools] createTishi:@"网络请求失败!"];
          [_hud hide:YES];
      }];
}

- (void)setProgressHud
{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"加载中...";
    
    [self.view addSubview:_hud];
    [_hud show:YES];
}

#pragma mark - 初始化导航区域
-(void)initNavigationSection
{
    self.navigationController.navigationBarHidden=YES;
    self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan=NO;
    //创建导航视图区域视图
    self.navigationView=[[UIView alloc] initWithFrame:CGRectMake(0,20,windowContentWidth,44)];
    //设置导航视图背景颜色
    self.navigationView.backgroundColor=[UIColor clearColor];
    
    //创建左侧导航按钮
    UIButton *backImage=[[UIButton alloc]initWithFrame:CGRectMake(10,7, 16, 26)];
    [backImage setBackgroundImage:[UIImage imageNamed:@"cash_leftback"] forState:UIControlStateNormal];
    //把左侧导航按钮添加至导航视图上

    [self.navigationView addSubview:backImage];
    //使返回键容易触发
    UIButton *clickBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [self.navigationView addSubview:clickBtn];
    //设置左侧导航按钮事件
    [clickBtn addTarget:self action:@selector(backEvent) forControlEvents:UIControlEventTouchUpInside];
    //创建导航标题
    UILabel *lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth/2-50,0,100,44)];
    //设置导航标题
    lblTitle.text=@"我的账户";
    //设置标题字体颜色
    lblTitle.textColor=[UIColor whiteColor];
    //设置标题字体大小
    lblTitle.font=systemBoldFont(22);
    //把标题控件添加至导航视图上
    [self.navigationView addSubview:lblTitle];
    
    //创建提现明细标签
    UIButton *lblbCash=[[UIButton alloc] initWithFrame:CGRectMake(windowContentWidth-100,2,100,44)];
    //设置提现明细标签标题
    [lblbCash setTitle:@"提现明细" forState:UIControlStateNormal];
    
    //设置提现明细标签字体颜色
    [lblbCash setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    //设置提现明细标签字体大小
    lblbCash.titleLabel.font=[UIFont systemFontOfSize:17];
    [lblbCash addTarget:self action:@selector(lblbClick) forControlEvents:UIControlEventTouchUpInside];
   
    //把提现明细标签添加至导航视图上
    [self.navigationView addSubview:lblbCash];
    
    //把导航视图添加至当前视图上
    [self.view addSubview:self.navigationView];
}


#pragma mark - 创建提现环形比例图形区域
-(void)initCircleWith:(float)activePersent and:(float)inactivePersent
{
    //创建圆弧
    if (iPhone6p) {
        distance=100;
        radius=115;
        top=75;
        with=50;
    }else if (iPhone5){
        distance=68;
        radius=90;
        top=45;
        with=35;
    }else if (iPhone6){
        distance=85;
        radius=105;
        top=65;
        with=40;
    }else if (iPhone4S){
        distance=50;
        radius=80;
        top=30;
        with=30;
    }
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = CGRectMake(windowContentWidth/2, 64+top+radius, 0, 0);
    //self.shapeLayer.position =
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
     //设置线条的宽度和颜色
    self.shapeLayer.lineWidth = with;
    self.shapeLayer.strokeColor = [YXTools stringToColor:@"#ff9a66"].CGColor;
    //设置stroke起始点
    self.shapeLayer.strokeStart = 0;
    self.shapeLayer.strokeEnd = 0;
    add = 0.1;
    self.shapeLayer2 = [CAShapeLayer layer];
    self.shapeLayer2.frame = CGRectMake(windowContentWidth/2, 64+top+radius, 0, 0);
    self.shapeLayer2.fillColor = [UIColor clearColor].CGColor;
     //设置线条的宽度和颜色
    self.shapeLayer2.lineWidth = with;
    self.shapeLayer2.strokeColor = [YXTools stringToColor:@"#50e1f2"].CGColor;
    self.shapeLayer2.strokeStart = 0;
    self.shapeLayer2.strokeEnd = 0;
     //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    if (activePersent==0.0&&inactivePersent==0.0) {
       [circlePath addArcWithCenter:CGPointMake(0,0) radius:radius startAngle:M_PI*1.5-activePersent*M_PI endAngle:M_PI*1.5+2*M_PI clockwise:YES];
    }else{
    [circlePath addArcWithCenter:CGPointMake(0,0) radius:radius startAngle:M_PI*1.5-activePersent*M_PI endAngle:M_PI*1.5+activePersent*M_PI clockwise:YES];
    }
    circlePath.lineJoinStyle=kCGLineJoinRound;
    [[UIColor redColor] setStroke];
    [circlePath stroke];
    
    UIBezierPath *circlePath2 = [UIBezierPath bezierPath];
    if (activePersent==0.0&&inactivePersent!=0.0) {
     [circlePath2 addArcWithCenter:CGPointMake(0,0) radius:radius startAngle: M_PI*1.5+activePersent*M_PI endAngle:1.5*M_PI+2*M_PI clockwise:YES];
    }else if (activePersent>0.0){
   
    [circlePath2 addArcWithCenter:CGPointMake(0,0) radius:radius startAngle: M_PI*1.5+activePersent*M_PI endAngle:1.5*M_PI-activePersent*M_PI clockwise:YES];
    }
    circlePath2.lineJoinStyle=kCGLineJoinRound;
    [[UIColor yellowColor] setStroke];
    [circlePath2 stroke];
     //让贝塞尔曲线与CAShapeLayer产生联系
    self.shapeLayer.path = circlePath.CGPath;
    self.shapeLayer2.path = circlePath2.CGPath;
      //添加并显示
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth/2-((radius*2-with)/2),64+radius+top-(radius*2-with)/2, (radius*2-with+2), (radius*2-with+2))];
    label.backgroundColor=[UIColor whiteColor];
    label.layer.cornerRadius=(radius*2-with-2)/2;
    label.clipsToBounds=YES;
    label.font=[UIFont systemFontOfSize:20];
    label.textColor=[YXTools stringToColor:@"#ff6600"];
    label.text=[NSString stringWithFormat:@"总金额(元)\n%0.2f",[total floatValue]];
    label.numberOfLines=0;
    label.textAlignment=1;
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:label.text];
    
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:18.0]
     
                          range:NSMakeRange(0, 6)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[YXTools stringToColor:@"#777b7e"]
     
                          range:NSMakeRange(0, 6)];
    
    label.attributedText = AttributedStr;
    [self.view addSubview:label];
    [self.view.layer addSublayer:self.shapeLayer];
    [self.view.layer addSublayer:self.shapeLayer2];
    [self start];

}
- (void)circleAnimationTypeOne
{
   
    if(self.shapeLayer.strokeStart == 0){
        self.shapeLayer.strokeEnd += add;
    }
    
    if ((int)self.shapeLayer.strokeEnd==1) {
        [_timer invalidate];
        
    }
}
- (void)circleAnimationTypeTwo
{
      if(self.shapeLayer2.strokeStart == 0){
        self.shapeLayer2.strokeEnd += add;
    }
    
    if ((int)self.shapeLayer2.strokeEnd==1) {
        [_timer2 invalidate];
       
    }
}
-(void)start{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                              target:self
                                            selector:@selector(circleAnimationTypeOne)
                                            userInfo:nil
                                             repeats:YES];
    
    _timer2 = [NSTimer scheduledTimerWithTimeInterval:0.1
                                               target:self
                                             selector:@selector(circleAnimationTypeTwo)
                                             userInfo:nil
                                              repeats:YES];
    

}
#pragma mark --创建底部视图
-(void)createBotomView
{
    UILabel *line1=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+top+radius*2+distance, windowContentWidth, 1)];
    line1.backgroundColor=[UIColor colorWithRed:82/255.0 green:88/255.0 blue:100/255.0 alpha:1];
    [self.view addSubview:line1];
    
    UILabel *allowView=[[UILabel alloc]initWithFrame:CGRectMake(12, ViewBelow(line1)+12, 16, 16)];
    allowView.backgroundColor=[YXTools stringToColor:@"#ff9a66"];
    [self.view addSubview:allowView];
    
    UILabel *allowLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(allowView)+5, ViewY(allowView), 80, 16)];
    allowLabel.text=@"可提现金额";
    allowLabel.textColor=[UIColor colorWithRed:82/255.0 green:88/255.0 blue:100/255.0 alpha:1];
    allowLabel.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:allowLabel];
    
    allowCount=[[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth-10-150, ViewY(allowLabel), 150, 16)];
    allowCount.textColor=[UIColor whiteColor];
    allowCount.textAlignment=NSTextAlignmentRight;
    allowCount.font=[UIFont systemFontOfSize:15];
    allowCount.text=[NSString stringWithFormat:@"¥%0.2f",[active floatValue]];
    [self.view addSubview:allowCount];
    
    UILabel *line2=[[UILabel alloc]initWithFrame:CGRectMake(10, ViewBelow(line1)+40, windowContentWidth-10, 1)];
    line2.backgroundColor=[UIColor colorWithRed:82/255.0 green:88/255.0 blue:100/255.0 alpha:1];
    [self.view addSubview:line2];
    
    UILabel *unallowView=[[UILabel alloc]initWithFrame:CGRectMake(12, ViewBelow(line2)+12, 16, 16)];
    unallowView.backgroundColor=[YXTools stringToColor:@"#50e1f2"];
    [self.view addSubview:unallowView];
    
    UILabel *unallowLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(unallowView)+5, ViewY(unallowView), 80, 16)];
    unallowLabel.text=@"冻结金额";
    unallowLabel.font=[UIFont systemFontOfSize:15];
    unallowLabel.textColor=[UIColor colorWithRed:82/255.0 green:88/255.0 blue:100/255.0 alpha:1];
    [self.view addSubview:unallowLabel];
    
    unallowCount=[[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth-10-150, ViewY(unallowLabel), 150, 16)];
    unallowCount.textColor=[UIColor whiteColor];
    unallowCount.textAlignment=NSTextAlignmentRight;
    unallowCount.font=[UIFont systemFontOfSize:15];
    unallowCount.text=[NSString stringWithFormat:@"¥%0.2f",[inactive floatValue]];
    [self.view addSubview:unallowCount];
    
    UILabel *line3=[[UILabel alloc]initWithFrame:CGRectMake(0, ViewBelow(line2)+40, windowContentWidth, 1)];
    line3.backgroundColor=[UIColor colorWithRed:82/255.0 green:88/255.0 blue:100/255.0 alpha:1];
    [self.view addSubview:line3];

}


#pragma mark - 创建底部提现按钮区域
-(void)initBottomCashSection
{
    UIButton *btnCash=[[UIButton alloc] initWithFrame:CGRectMake(0,windowContentHeight-50,windowContentWidth,50)];
    [btnCash setTitle:@"提现" forState:UIControlStateNormal];
    btnCash.titleLabel.font=systemBoldFont(24);
    if ([total floatValue]==0.0)
    {
       [btnCash setBackgroundColor:[YXTools stringToColor:@"#abb4bc"]];
    }else if ([total floatValue]>0.0)
    {
       [btnCash setBackgroundColor:[YXTools stringToColor:@"#ff9a66"]];
    }
    [btnCash addTarget:self action:@selector(cashEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCash];
}


#pragma mark - 左侧返回按钮事件
-(void)backEvent
{
    self.navigationController.navigationBarHidden=NO;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 底部提现按钮事件
-(void)cashEvent
{
    //total为0时，点击提现不让进入下个页面，但是提现纪录仍然可以看
    if ([total floatValue]==0.0) {
        return;
    }
    
    self.navigationController.navigationBarHidden=NO;
    JYCDepositVC *DeVC=[[JYCDepositVC alloc]init];
    DeVC.maxAmount=active;
    DeVC.maxNumber=top_times;
    DeVC.singleAmount=top_total;
    [self.navigationController pushViewController:DeVC animated:YES];
}
#pragma mark -提现明细点击时间
-(void)lblbClick
{
    self.navigationController.navigationBarHidden=NO;
    


    JYCDepositDetailVC *vc=[[JYCDepositDetailVC alloc]init];

    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 内存警告
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

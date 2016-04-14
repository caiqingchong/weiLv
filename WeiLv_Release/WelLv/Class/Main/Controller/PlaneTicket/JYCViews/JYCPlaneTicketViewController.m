//
//  JYCPlaneTicketViewController.m
//  WelLv
//
//  Created by lyx on 15/9/2.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#define BannerHegit 150*HeightScale
#define LeftBeginX 20
#import "JYCPlaneTicketViewController.h"
#import "YXBannerView.h"
#import "YXTools.h"
#import "YXLocationManage.h"
#import "JYCPlaneCityListViewController.h"
#import "JYCTicketVC.h"
#import "LXPlaneCalendarViewController.h"
#import "JYCInfomationVC.h"
#import "JYCreturnTicketVC.h"
#import "LXGetCityIDTool.h"
//#import "JYCHouseDetailVC.h"
@interface JYCPlaneTicketViewController ()<EScrollerViewDelegate>
{
    YXBannerView *_bannerView;
    UISegmentedControl *segmentControl;
    UIButton *leftTimeBtn;
    UIButton *rightTimeBtn;
    UILabel *rightTimeLabel;
    UIButton *leftCityBtn;
    UIButton *rightCityBtn;
    UIButton *planeBtn;
    UIScrollView *_scrollView;
    UILabel *leftTimeLabel;//
    UIView *rightLine4;//返程时右侧出现的下划线
    UIView *allLine;//单程时出现的一长根下划线
    NSString *_startTimeStr;//保存时间
    NSString *_backTimeStr;//保存时间
    NSUInteger integerWeek;//保存NSUInteger型的星期传给下个页面 单程的时候
    NSUInteger integerWeek2;//保存NSUInteger型的星期传给下个页面 返程的时候
    NSMutableArray *_adArray;//轮播图广告数组
}
@property(nonatomic,copy)NSString *startTimeStr;
@property(nonatomic,copy)NSString *backTimeStr;
@property(nonatomic,copy)NSString *testStr;//保存左侧 星期几
@property(nonatomic,copy)NSString *rightStr;//保存右侧  星期几

@end

@implementation JYCPlaneTicketViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
//    rightTimeBtn.hidden=YES;
//    rightTimeLabel.hidden=YES;
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //self.title= @"机票";
    self.navigationItem.title=@"机票";
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    [self.view addSubview:_scrollView];
    [_scrollView setContentSize:CGSizeMake(0, windowContentHeight+100)];
    rightTimeBtn.hidden=YES;
    
    rightLine4.hidden=YES;
    leftTimeLabel.hidden=YES;
    [self initHeaderView];

    [self UISegmentControl];
    [self createView];
    [self initData];
}
-(void)initData
{
    _adArray = [[NSMutableArray alloc]init];
    NSString *url=AdvertUrl(@"115", [[WLSingletonClass defaultWLSingleton] wlCityId]);
    NSLog(@"%@",url);
    [self  sendRequestWithAurl:url];
}
-(void)sendRequestWithAurl:(NSString *)url
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
      
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //DLog(@"机票广告===%@",array);
        if (array != nil) {
            for (int i=0; i<array.count; i++) {
                LXAdvertModel *detailModel = [[LXAdvertModel alloc] init];
                NSDictionary *dic=[array objectAtIndex:i];
                [detailModel setValuesForKeysWithDictionary:dic];
                [_adArray addObject:detailModel];
            }

        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[LXAlterView sharedMyTools]createTishi:@"网络请求失败，请稍后再试"];
        NSLog(@"下载失败");
    }];

}
-(void)initHeaderView
{
    UIView *hearderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth,BannerHegit)];
    
    
//    NSArray *arr = [NSArray  array];
//    arr = [NSArray arrayWithObjects:@"banner1",@"banner2",@"banner3", nil];
    NSMutableArray *arr = [NSMutableArray  array];
    for (int i=0; i<_adArray.count; i++){
        LXAdvertModel *model=[_adArray objectAtIndex:i];
        NSString *imageUrl=[NSString stringWithFormat:@"%@%@",WLHTTP,model.src];
        [arr addObject:imageUrl];
    }

    if (_bannerView != nil)
    {
        [_bannerView removeFromSuperview];
    }
    _bannerView = [[YXBannerView alloc] initWithFrameRect:CGRectMake(0, 0, windowContentWidth, BannerHegit) ImageArray:arr];
    //NSLog(@"%@",arr);
    _bannerView.delegate = self;
    [hearderView addSubview:_bannerView];
    [_scrollView addSubview:hearderView];
}

- (void)UISegmentControl
{
    NSArray *items = @[@"单程",@"往返"];
    segmentControl = [[UISegmentedControl alloc] initWithItems:items];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:16.0],NSFontAttributeName,nil];
    [segmentControl setTitleTextAttributes:dic forState:UIControlStateNormal];
    segmentControl.tintColor = [UIColor orangeColor];
    //segmentControl.momentary = YES; // 点击之后，马上效果回来（渲染消失）
    segmentControl.frame = CGRectMake(LeftBeginX, BannerHegit+10,windowContentWidth-LeftBeginX*2, 40);
    
    segmentControl.selectedSegmentIndex = 0;
    [segmentControl addTarget:self action:@selector(segmentControlAction:) forControlEvents:UIControlEventValueChanged];
    [_scrollView addSubview:segmentControl];
}

#pragma mark --segmentControlAction
-(void)segmentControlAction:(id)sender
{
    switch ([sender selectedSegmentIndex]) {
        case 0:
        {
            rightTimeBtn.hidden=YES;
            rightTimeLabel.hidden=NO;
            rightLine4.hidden=YES;
            leftTimeLabel.hidden=YES;
            allLine.hidden=NO;
            if (leftTimeLabel.hidden==YES&&rightTimeLabel.hidden==NO) {
                rightTimeLabel.text=self.testStr;
            }

        }
            break;
         case 1:
        {
            leftTimeLabel.hidden=NO;
            rightTimeBtn.hidden=NO;
            rightTimeLabel.hidden=NO;
            allLine.hidden=YES;
            rightTimeBtn.hidden=NO;
            rightLine4.hidden=NO;
            
            if (leftTimeLabel.hidden==NO&&rightTimeLabel.hidden==NO) {
                rightTimeLabel.text=self.rightStr;
            }
            

        }
            break;
        default:
            break;
    }
}
#pragma mark -- cteateView
-(void)createView
{
    float w=100;
    float space=windowContentWidth-LeftBeginX*2-w*2;
    UILabel *leftLabel=[[UILabel alloc]initWithFrame:CGRectMake(LeftBeginX,segmentControl.frame.origin.y+50, 80, 30)];
    
    leftLabel.text=@"出发城市";
    leftLabel.textColor=[UIColor grayColor];
    [_scrollView addSubview:leftLabel];
    UILabel *rightLabel=[[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth-LeftBeginX-ViewWidth(leftLabel)+13,segmentControl.frame.origin.y+50, 80, 30)];
    
    rightLabel.text=@"目的城市";
    rightLabel.textColor =[UIColor grayColor];
    [_scrollView addSubview:rightLabel];
    
    NSString *str;
     if ([CLLocationManager authorizationStatus] !=  kCLAuthorizationStatusAuthorized && [CLLocationManager authorizationStatus] !=  kCLAuthorizationStatusAuthorizedWhenInUse) {
          str=@"郑州";
     }else {
         str=[YXLocationManage shareManager].city;
     }
    
    leftCityBtn=[YXTools allocButton:str textColor:[UIColor blackColor] nom_bg:nil hei_bg:nil frame:CGRectMake(LeftBeginX, ViewY(leftLabel)+ViewHeight(leftLabel)+10,100, 40)];
    //leftCityBtn.titleEdgeInsets = UIEdgeInsetsMake(5,-50, 5,5);
    leftCityBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    leftCityBtn.titleLabel.textAlignment=0;
    [leftCityBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    leftCityBtn.tag=1001;
    
    [_scrollView addSubview:leftCityBtn];
    rightCityBtn=[YXTools allocButton:@""textColor:[UIColor blackColor] nom_bg:nil hei_bg:nil frame:CGRectMake(LeftBeginX+80+space+13, ViewY(rightLabel)+ViewHeight(rightLabel)+10,100,40)];
    //rightCityBtn.titleEdgeInsets = UIEdgeInsetsMake(5,5,5,-70);
    rightCityBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightCityBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    rightCityBtn.tag=1002;
    
    [_scrollView addSubview:rightCityBtn];
  
    UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(LeftBeginX, ViewY(leftCityBtn)+ViewHeight(leftCityBtn)+3, (windowContentWidth-2*LeftBeginX-50)/2, 0.5)];
    leftLine.backgroundColor = bordColor;
    
    [_scrollView addSubview:leftLine];
    UIView *rightLine =[[UIView alloc]initWithFrame:CGRectMake(ViewRight(leftLine)+41,ViewY(leftCityBtn)+ViewHeight(leftCityBtn)+3 ,(windowContentWidth-2*LeftBeginX-41)/2 , 0.5)];
    rightLine.backgroundColor =bordColor;
    [_scrollView addSubview:rightLine];
    planeBtn=[YXTools allocButton:nil textColor:nil nom_bg:nil hei_bg:nil frame:CGRectMake(ViewX(leftLine)+ViewWidth(leftLine),ViewY(leftLine)-41, 41, 41)];
    [planeBtn setBackgroundImage:[UIImage imageNamed:@"航向"] forState:UIControlStateNormal];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(ViewX(planeBtn)+5, ViewY(planeBtn)+ViewHeight(planeBtn)/2-5, 27, 9)];
    imageView.image=[UIImage imageNamed:@"departing"];
    [_scrollView addSubview:imageView];
    
    //planeBtn.layer.cornerRadius=25;
    planeBtn.tag=1003;
    [planeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:planeBtn];
    leftTimeBtn=[YXTools allocButton:@"出发日期" textColor:[UIColor blackColor] nom_bg:nil hei_bg:nil frame:CGRectMake(LeftBeginX, ViewY(leftLine)+0.5+10, 80, 40)];
    leftTimeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //leftTimeBtn.tag=1004;
    [leftTimeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:leftTimeBtn];
    
    leftTimeLabel=[YXTools allocLabel:@"" font:systemFont(13) textColor:[UIColor blackColor] frame:CGRectMake(ViewRight(leftLine)-50,ViewY(leftLine)+0.5+9, 40, 40) textAlignment:1];
    
    leftTimeLabel.hidden=YES;
    [_scrollView addSubview:leftTimeLabel];
    //透明button覆盖上面  增加左侧日历的点击区域
    UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(LeftBeginX, ViewY(leftLine)+0.5+5, windowContentWidth-2*LeftBeginX,45)];
    btn1.tag=1004;
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btn1];
    
    rightTimeBtn=[YXTools allocButton:@"返回日期" textColor:[UIColor blackColor] nom_bg:nil hei_bg:nil frame:CGRectMake(ViewX(leftLine)+ViewWidth(leftLine)+50,ViewY(rightLine)+0.5+10 ,80,40)];
    rightTimeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    rightTimeBtn.tag=1005;
    rightTimeBtn.hidden=YES;
    [rightTimeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollView addSubview:rightTimeBtn];
    rightTimeLabel=[YXTools allocLabel:@"" font:systemFont(12) textColor:[UIColor blackColor] frame:CGRectMake(ViewRight(rightLabel)-50,ViewY(rightLine)+0.5+9, 40, 40) textAlignment:1];
    //rightTimeLabel.hidden=YES;
    [_scrollView addSubview:rightTimeLabel];
    UIView *leftLine3 = [[UIView alloc] initWithFrame:CGRectMake(LeftBeginX, ViewY(leftTimeBtn)+ViewHeight(leftTimeBtn)+3, (windowContentWidth-2*LeftBeginX-50)/2, 0.5)];
    leftLine3.backgroundColor = bordColor;
    
    [_scrollView addSubview:leftLine3];
    rightLine4 =[[UIView alloc]initWithFrame:CGRectMake(LeftBeginX+(windowContentWidth-2*LeftBeginX-50)/2+50,ViewY(rightTimeBtn)+ViewHeight(rightTimeBtn)+3 ,(windowContentWidth-2*LeftBeginX-50)/2 , 0.5)];
    rightLine4.backgroundColor =bordColor;
    [_scrollView addSubview:rightLine4];
    allLine=[[UIView alloc]initWithFrame:CGRectMake(LeftBeginX, ViewY(rightLine4),windowContentWidth-2*LeftBeginX, 0.5)];
    allLine.backgroundColor =bordColor;
    [_scrollView addSubview:allLine];
    UIButton *searchBtn=[YXTools allocButton:@"搜索机票" textColor:[UIColor whiteColor] nom_bg:[UIImage imageNamed:@"咨询"] hei_bg:nil frame:CGRectMake(LeftBeginX, ViewY(leftLine3)+0.5+20, (windowContentWidth-2*LeftBeginX), 40)];
//    searchBtn.backgroundColor=[UIColor colorWithRed:57/255.0 green:246/255.0 blue:177/255.0 alpha:1.0];
    searchBtn.tag=1006;
    //searchBtn.layer.cornerRadius=8;
    [searchBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:searchBtn];
    //UIButton *infomationBtn=[YXTools allocButton:nil textColor:nil nom_bg:nil hei_bg:nil frame:CGRectMake(windowContentWidth-LeftBeginX-ViewWidth(searchBtn)/3,ViewY(searchBtn)+ViewHeight(searchBtn)+10,ViewWidth(searchBtn)/3,30)];
    UIImageView *leftImage=[[UIImageView alloc]initWithFrame:CGRectMake(windowContentWidth-LeftBeginX-78-17,ViewY(searchBtn)+ViewHeight(searchBtn)+10,15, 15)];
    leftImage.image=[UIImage imageNamed:@"Info"];
    [_scrollView addSubview:leftImage];
    UIButton *infomationBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    infomationBtn.frame=CGRectMake(windowContentWidth-LeftBeginX-78,ViewY(searchBtn)+ViewHeight(searchBtn)+2,78,30);
   
    //infomationBtn.imageEdgeInsets = UIEdgeInsetsMake(2,2,2,infomationBtn.titleLabel.bounds.size.width);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
    [infomationBtn setTitle:@"机票服务信息" forState:UIControlStateNormal];
    infomationBtn.titleLabel.font = [UIFont systemFontOfSize:13];//title字体大小
    infomationBtn.titleLabel.textAlignment = 0;//设置title的字体居中
    [infomationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //infomationBtn.titleEdgeInsets = UIEdgeInsetsMake(5,5, 5,5);
    
    infomationBtn.tag=1007;
    
    [infomationBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:infomationBtn];
    
    
    
}

#pragma mark EscrollViewDelegate
-(void)EScrollerViewDidClicked:(NSUInteger)index
{
    NSLog(@"_____________%lu",(unsigned long)index);
    if (_adArray.count>0) {
        LXAdvertModel *model=[_adArray objectAtIndex:index-1];
        if ([model.link hasPrefix:@"https://"] || [model.link hasPrefix:@"http://"]) {
            NSString *url=[model.link stringByReplacingOccurrencesOfString:@"android" withString:@"ios"];
            DLog(@"点击了-%@",url);
            LXSpecialViewController *specialVc=[[LXSpecialViewController alloc] init];
            specialVc.loadUrl=url;
            specialVc.title=model.title;
            [self.navigationController pushViewController:specialVc animated:YES];
        }else{
            DLog(@"没有连接");
        }
        
    }else{
        
        
    }

}
#pragma mark BtnClick
-(void)btnClick:(UIButton *)btn
{
   
    if (btn.tag==1001) {
        JYCPlaneCityListViewController * planeCityView = [[JYCPlaneCityListViewController alloc] initWithAddress:^(NSString *cityAddress) {
           [btn setTitle:cityAddress forState:UIControlStateNormal];
            
        }];
       
        planeCityView.title=@"请选择出发城市";
        [self.navigationController pushViewController:planeCityView animated:YES];
    }else if(btn.tag==1002){
        JYCPlaneCityListViewController * planeCityView = [[JYCPlaneCityListViewController alloc] initWithAddress:^(NSString *cityAddress) {
            [btn setTitle:cityAddress forState:UIControlStateNormal];
            

        }];
        planeCityView.title=@"请选择目的城市";
        [self.navigationController pushViewController:planeCityView animated:YES];
    }else if (btn.tag==1003)
    {
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        rotationAnimation.duration = 0.5;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = 1;
        [planeBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        [UIView commitAnimations];
        
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame=leftCityBtn.frame;
            leftCityBtn.frame=rightCityBtn.frame;
            rightCityBtn.frame=frame;
            UIButton *btn=leftCityBtn;
            leftCityBtn=rightCityBtn;
            rightCityBtn=btn;
            NSInteger  a=leftCityBtn.contentHorizontalAlignment;//交换他们的对其方式
            leftCityBtn.contentHorizontalAlignment=rightCityBtn.contentHorizontalAlignment;
            rightCityBtn.contentHorizontalAlignment=a;
        } completion:^(BOOL finished) {
            
        }];
    }else if (btn.tag == 1004){
        LXPlaneCalendarViewController *lxplaneCal=[[LXPlaneCalendarViewController alloc] init];
        [lxplaneCal setTrainToDay:365 ToDateforString:nil price:100];
        lxplaneCal.calendarblock= ^ (CalendarDayModel *model){
            self.startTimeStr=[model toString];
            self.testStr=[model getWeek];
            integerWeek =model.week;
            NSString *str=[[model toString] substringWithRange:NSMakeRange(5, 5)];
            [leftTimeBtn setTitle:str forState:UIControlStateNormal];
            leftTimeLabel.text=self.testStr;
            if (leftTimeLabel.hidden==YES&&rightTimeLabel.hidden==NO) {
                rightTimeLabel.text=self.testStr;
             }
            };
       
        [self.navigationController pushViewController:lxplaneCal animated:YES];
    }else if (btn.tag==1005)
    {
        
        LXPlaneCalendarViewController *lxplaneCal=[[LXPlaneCalendarViewController alloc] init];
        [lxplaneCal setTrainToDay:365 ToDateforString:nil price:100];
        lxplaneCal.calendarblock= ^ (CalendarDayModel *model){
            segmentControl.selectedSegmentIndex=1;
            self.backTimeStr=[model toString];
            self.rightStr=[model getWeek];
            integerWeek2=model.week;
            NSString *str=[[model toString] substringWithRange:NSMakeRange(5, 5)];
            [btn setTitle:str forState:UIControlStateNormal];
            rightTimeLabel.text=self.rightStr;

        };
        [self.navigationController pushViewController:lxplaneCal animated:YES];
    }else if (btn.tag==1006){
        JYCTicketVC *TicketVC=[[JYCTicketVC alloc]init];
        
        if ([segmentControl selectedSegmentIndex]==0) {
            
            if([leftCityBtn.titleLabel.text isEqualToString:rightCityBtn.titleLabel.text])
            {
                [[LXAlterView sharedMyTools]createTishi:@"出发城市与到达城市不能一样"];
            }else if (([self judgeString:leftCityBtn.titleLabel.text])&&([self judgeString:rightCityBtn.titleLabel.text])&&([self judgeString:leftTimeBtn.titleLabel.text])&&(![leftTimeBtn.titleLabel.text isEqualToString:@"出发日期"])) {
                //NSLog(@"%@",rightCityBtn.titleLabel.text);
                TicketVC.startCity =leftCityBtn.titleLabel.text;
                TicketVC.endCity=rightCityBtn.titleLabel.text;
                TicketVC.startTime=self.startTimeStr;
                TicketVC.isSingle=YES;
                TicketVC.singleWeek=rightTimeLabel.text;//这个时候周几在右边放
                TicketVC.receiveWeek=integerWeek;//传值下个页面 进行计算使用
                [self.navigationController pushViewController:TicketVC animated:YES];
            } else{
                [[LXAlterView sharedMyTools]createTishi:@"请把信息填写完整"];

            }
        
        }else if([segmentControl selectedSegmentIndex]==1){
            if([leftCityBtn.titleLabel.text isEqualToString:rightCityBtn.titleLabel.text])
            {
                 [[LXAlterView sharedMyTools]createTishi:@"出发城市与到达城市不能一样"];
            }
            else if([leftTimeBtn.titleLabel.text isEqualToString:rightTimeBtn.titleLabel.text]){
                
                 [[LXAlterView sharedMyTools]createTishi:@"出发日期与返回日期不能一样"];
            }else if([leftTimeBtn.titleLabel.text compare:rightTimeBtn.titleLabel.text]==NSOrderedDescending)
            {
                [[LXAlterView sharedMyTools]createTishi:@"返回日期不能早于出发日期"];
            }else if(([self judgeString:leftCityBtn.titleLabel.text])&&([self judgeString:rightCityBtn.titleLabel.text])&&([self judgeString:leftTimeBtn.titleLabel.text])&&(![leftTimeBtn.titleLabel.text isEqualToString:@"出发日期"])&&(![rightTimeBtn.titleLabel.text isEqualToString:@"返回日期"]))
                  
            {
                
                    TicketVC.startCity =leftCityBtn.titleLabel.text;
                    TicketVC.endCity=rightCityBtn.titleLabel.text;
                    TicketVC.startTime=self.startTimeStr;
                    TicketVC.backTime=self.backTimeStr;
                    TicketVC.isSingle=NO;
                    TicketVC.singleWeek=leftTimeLabel.text;//这个时候周几在左边放
                    TicketVC.backWeek=rightTimeLabel.text;
                    TicketVC.receiveWeek=integerWeek;//传值下个页面 进行计算使用
                    TicketVC.backReceiveWeek=integerWeek2;////传值下个页面 进行计算使用
                    [self.navigationController pushViewController:TicketVC animated:YES];
            }else{
            
            [[LXAlterView sharedMyTools]createTishi:@"请把信息填写完整"];
            
        }
    }
    
      }else if(btn.tag==1007)
    {
        //NSLog(@"111");
//        
//       JYCreturnTicketVC *VC=[[JYCreturnTicketVC alloc]init];
//        [self.navigationController pushViewController:VC animated:YES];
       // JYCHouseDetailVC *VC=[[JYCHouseDetailVC alloc]init];
        
        JYCInfomationVC *InfoVC=[[JYCInfomationVC alloc]init];
        [self.navigationController pushViewController:InfoVC animated:YES];
          //[[LXAlterView sharedMyTools] createTishi:@""];
    }

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

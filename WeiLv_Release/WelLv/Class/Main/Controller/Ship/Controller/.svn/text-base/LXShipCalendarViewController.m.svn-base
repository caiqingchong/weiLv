//
//  LXShipCalendarViewController.m
//  WelLv
//
//  Created by lx on 15/7/31.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
#define M_Canlendar_View_HEIGHT 60*6+65 //日历图高度；

#import "LXShipCalendarViewController.h"
#import "LXShipCalendarView.h"
#import "LXShipCalendarModel.h"
#import "ZFJShipDetailVC.h"

@interface LXShipCalendarViewController ()

@property (nonatomic, strong) LXShipCalendarView *LxShipCalendar;
@property (nonatomic ,strong) UIScrollView *calendarScrollView;
@end

@implementation LXShipCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"邮轮日历";
    self.view.backgroundColor=[UIColor whiteColor];
    DLog(@"数组-%@",self.ShipCalendarArray);
    [self initView];
}

-(void)initView
{
    self.calendarScrollView=[[UIScrollView alloc] init];
    self.calendarScrollView.frame=CGRectMake(0, 0, windowContentWidth, windowContentHeight);
    //scrollView.scrollEnabled=NO;
    self.calendarScrollView.userInteractionEnabled=YES;
    [self.view addSubview:self.calendarScrollView];
    
    //日历控件
    __block LXShipCalendarViewController *shipVc=self;
    self.LxShipCalendar=[[LXShipCalendarView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 0)];
    NSInteger cellNumber= [self.LxShipCalendar getShipCalendarArray:self.ShipCalendarArray];
    CGFloat collectheight;
    if (cellNumber == 35)
    {
        collectheight=M_Canlendar_View_HEIGHT-60;
    }else if (cellNumber== 42)
    {
        collectheight=M_Canlendar_View_HEIGHT;
    }
    self.LxShipCalendar.frame=CGRectMake(0,0, windowContentWidth, collectheight);
    //CGRect rectNav = self.navigationController.navigationBar.frame;
    [self.calendarScrollView addSubview:self.LxShipCalendar];

    self.LxShipCalendar.blockProduct_id=^(NSString *product_id)
    {
        //点击预订
        ZFJShipDetailVC * dtailVC = [[ZFJShipDetailVC alloc] init];
        dtailVC.product_id = product_id;
        [shipVc.navigationController pushViewController:dtailVC animated:YES];
    };
    self.LxShipCalendar.calendarViewHeight=^(CGFloat calendarViewHeight)
    {
        DLog(@"日历高度----%f,屏幕高度-----%f",calendarViewHeight,windowContentHeight);
        shipVc.LxShipCalendar.frame=CGRectMake(0, 0, windowContentWidth, calendarViewHeight);
      
        shipVc.calendarScrollView.contentSize=CGSizeMake(windowContentWidth, calendarViewHeight+64);
        if (shipVc.calendarScrollView.contentSize.height>windowContentHeight) {
            shipVc.calendarScrollView.contentOffset=CGPointMake(0, shipVc.calendarScrollView.contentSize.height-windowContentHeight);
        }
        
        
    };

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

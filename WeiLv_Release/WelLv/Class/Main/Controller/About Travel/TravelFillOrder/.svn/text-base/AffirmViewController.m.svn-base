//
//  AffirmViewController.m
//  FillOrder
//
//  Created by WeiLv on 16/1/25.
//  Copyright © 2016年 WeiLv. All rights reserved.
//
#import "NTViewController.h"
#import "AffirmViewController.h"

#import "PayTopView.h"

#import "AffirmView.h"
#import "MyOrderTableViewCOntroller.h"
#import "TravelAffirmModel.h"

#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface AffirmViewController ()

@property (nonatomic,strong) PayTopView *payView;

@property (nonatomic,strong) AffirmView *affirmView;

@end

@implementation AffirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:222/255.0 green:229/255.0 blue:235/255.0 alpha:1];
    self.title = @"支付订单";
    [self layoutPage];
    
    [self addLeftAndRightItem];
    
    // Do any additional setup after loading the view.
}

#pragma mark ******添加左右 Item ******
- (void)addLeftAndRightItem{
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(BackItemAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(RightItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(240/255.) green:(145/255.) blue:(40/255.) alpha:1];
}

#pragma mark ********Item 关联事件 *********
- (void)BackItemAction:(UIBarButtonItem *)leftItem{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)RightItemAction:(UIBarButtonItem *)rightItem{
   
    NTViewController *ntv = (NTViewController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
    ntv.selectedIndex = 2;
    [ntv seleBtnIndex:2];
    self.tabBarController.selectedIndex = 2;
    [self.navigationController popToRootViewControllerAnimated:NO];

    
    
}

#pragma mark ********页面布局*-**********
- (void)layoutPage{
    
    
    self.affirmView = [[AffirmView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT / 4.76)];
    self.affirmView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.affirmView];
    
    //添加 TopView
    //添加 PayTopView
    self.payView = [[PayTopView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.affirmView.frame) + UISCREEN_HEIGHT / 43.69, UISCREEN_WIDTH, UISCREEN_HEIGHT /3)];
    
    //名称
    self.payView.titleLable.text = [NSString stringWithFormat:@"<%@>",self.affirmModel.product_name];
    //订单编号
    self.payView.numberLable.text = [NSString stringWithFormat:@"订单编号:%@",self.affirmModel.order_sn];
    //出发城市
    if ([self.affirmModel.route_type isEqualToString:@"-15"]) {
         self.payView.cityLable.text = [NSString stringWithFormat:@"出发城市:全国"];
    }else{
         self.payView.cityLable.text = [NSString stringWithFormat:@"出发城市:%@",self.affirmModel.f_city_name];
    }
    //出发日期
   // NSString *dataTime = [self getDateStr:self.affirmModel.f_time];
    self.payView.dateLable.text = [NSString stringWithFormat:@"出发日期:%@",self.affirmModel.f_time];
    //出游人数
    self.payView.peopleLable.text = [NSString stringWithFormat:@"出游人数:%@成人 %@儿童",self.affirmModel.adule,self.affirmModel.child];
    //订单总额
    self.payView.priceLable.text = [NSString stringWithFormat:@"订单总额:￥%@",self.affirmModel.order_price];
    //
    NSMutableAttributedString *colorText = [[NSMutableAttributedString alloc] initWithString:self.payView.priceLable.text];
   // NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:@"注册"].location, [[noteStr string] rangeOfString:@"注册"].length);
   // [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRange];
    NSRange blackRange = NSMakeRange([self.payView.priceLable.text rangeOfString:@"订单总额:"].location, [self.payView.priceLable.text rangeOfString:@"订单总额:"].length);
    [colorText addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:blackRange];
    [self.payView.priceLable setAttributedText:colorText];
    [self.payView.priceLable sizeToFit];
    self.payView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.payView];
    
}


#pragma mark ---时间戳转换成时间字符串
-(NSString *)getDateStr:(NSString *)date
{
    NSString *str=date;//时间戳
    NSTimeInterval time=[str doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //    NSLog(@"date:%@",detaildate);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    //    DLog(@"开始时间===%@",currentDateStr);
    return currentDateStr;
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

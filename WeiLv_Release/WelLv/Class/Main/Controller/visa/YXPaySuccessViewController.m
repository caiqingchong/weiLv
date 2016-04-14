//
//  YXPaySuccessViewController.m
//  WelLv
//
//  Created by lyx on 15/6/29.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "YXPaySuccessViewController.h"

@interface YXPaySuccessViewController ()
{
    UIScrollView *_scrollView;
}
@end

@implementation YXPaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:232/255.0 green:237/255.0 blue:241/255.0 alpha:1];
    self.backBtn.hidden = YES;
    self.title = @"购买成功";
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
//    self.productName = @"kdsj大家看法了宝贵的代理费；";
//    self.beginDate = @"2015年4月5日";
//    self.number = @"5人";
//    self.contactPerson = @"刘先生";
//    self.phone = @"15093357817";
    [self initView];
}

- (void)initView
{
    UIImageView *succImage = [YXTools allocImageView:CGRectMake(Begin_X, 20, 40, 30) image:[UIImage imageNamed:@"完成"]];
    [_scrollView addSubview:succImage];
    
    UILabel *tishi = [YXTools allocLabel:@"您的订单已经预定成功，祝您有个愉快的旅程！" font:systemFont(15) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(succImage)+ViewWidth(succImage), ViewY(succImage), windowContentWidth-Begin_X*2-ViewWidth(succImage), 40) textAlignment:0];
    tishi.numberOfLines = 0;
    [_scrollView addSubview:tishi];
    if ([LXSingletonClass shareInstance].isYouXue==YES) {
        tishi.text=@"您己完成定金支付，待销售商确认后，支付余款。";
    }else{
        tishi.text=@"您的订单已经预定成功，祝您有个愉快的旅程！";
    }
    
    
    YXAutoEditVIew *productLable = [[YXAutoEditVIew alloc] initWithFrame:CGRectMake(0,ViewY(tishi)+ViewHeight(tishi)+10,windowContentWidth , 40)];
    productLable.titleLable.text = @"产品名称:";
    [productLable setContentText:self.productName];
    productLable.line.hidden = YES;
    productLable.contentLabel.textColor = [UIColor orangeColor];
    [_scrollView addSubview:productLable];
    
    YXAutoEditVIew *dateLable = [[YXAutoEditVIew alloc] initWithFrame:CGRectMake(0,ViewY(productLable)+ViewHeight(productLable)+20,windowContentWidth , 40)];
    dateLable.titleLable.text = @"出行日期:";
    [dateLable setContentText:self.beginDate];
    dateLable.contentLabel.textAlignment = 2;
    dateLable.contentLabel.textColor = [UIColor orangeColor];
    [_scrollView addSubview:dateLable];
    
    YXAutoEditVIew *numberLable = [[YXAutoEditVIew alloc] initWithFrame:CGRectMake(0,ViewY(dateLable)+ViewHeight(dateLable)+1,windowContentWidth , 40)];
    numberLable.titleLable.text = @"出行人数:";
    [numberLable setContentText:[NSString stringWithFormat:@"%@人",self.number]];
    numberLable.contentLabel.textAlignment = 2;
    numberLable.contentLabel.textColor = [UIColor orangeColor];
    [_scrollView addSubview:numberLable];
    
    YXAutoEditVIew *contactLable = [[YXAutoEditVIew alloc] initWithFrame:CGRectMake(0,ViewY(numberLable)+ViewHeight(numberLable),windowContentWidth , 40)];
    contactLable.titleLable.text = @"订单联系人:";
    [contactLable setContentText:self.contactPerson];
    contactLable.contentLabel.textAlignment = 2;
    contactLable.contentLabel.textColor = [UIColor orangeColor];
    [_scrollView addSubview:contactLable];
    
    YXAutoEditVIew *phoneLable = [[YXAutoEditVIew alloc] initWithFrame:CGRectMake(0,ViewY(contactLable)+ViewHeight(contactLable)+1,windowContentWidth , 40)];
    phoneLable.line.hidden = YES;
    phoneLable.titleLable.text = @"电话:";
    [phoneLable setContentText:self.phone];
    phoneLable.contentLabel.textAlignment = 2;
    phoneLable.contentLabel.textColor = [UIColor orangeColor];
    [_scrollView addSubview:phoneLable];
    
   
    UIButton *backBtn = [YXTools allocButton:@"返回首页" textColor:[UIColor whiteColor] nom_bg: [UIImage imageNamed:@"返回首页"] hei_bg:nil frame:CGRectMake(30, ViewY(phoneLable)+ViewHeight(phoneLable)+30, windowContentWidth - 30*2, 40)];
    [backBtn addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:backBtn];
    
    _scrollView.contentSize = CGSizeMake(0, ViewHeight(backBtn)+ViewY(backBtn)+150);
}

- (void)backHome
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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

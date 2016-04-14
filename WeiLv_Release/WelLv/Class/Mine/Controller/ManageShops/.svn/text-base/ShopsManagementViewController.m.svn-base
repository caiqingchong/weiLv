//
//  ShopsManagementViewController.m
//  WelLv
//
//  Created by mac for csh on 15/10/28.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ShopsManagementViewController.h"
#import "IncomesDetailsViewController.h"
#import "OpenShopViewController.h"
#import "WXUtil.h"
#import "CSHMyShopListVC.h"
#import "CommissionTableViewController.h"


@interface ShopsManagementViewController ()
{

}
@property(nonatomic,strong)UILabel *total;
@property(nonatomic,strong)UILabel *commission;
@property(nonatomic,strong)UILabel *todayIncome;

@end

@implementation ShopsManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BgViewColor ;
    self.navigationItem.title = @"商铺管理";
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
    
    [self initFiirstView];
    [self initSecondView];
    [self initThirdView];
    
    
    NSString *url = GetIncomeDetailURL;
    NSString *md5str = [NSString stringWithFormat:@"~0;id<zOD.{ll@]JKi(:%@",[[LXUserTool alloc] getUid]];
    md5str = [WXUtil md5:md5str];
    NSDictionary *parameters =@{@"assistant_id":[[LXUserTool alloc] getUid],@"wltoken":md5str};
    [self loadDataWithUrl:url Parameters:parameters];
}

-(void)initFiirstView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth , 130)];
    bgView.backgroundColor = kColor(250, 121, 11);
    [_scrollView addSubview:bgView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 50)];
    lab.backgroundColor = [UIColor clearColor];
    lab.text = @"我的商户在位率累计赚了";
    lab.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    lab.textColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:lab];
    
    self.total = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, windowContentWidth, 50)];
    self.total.backgroundColor = [UIColor clearColor];
    self.total.text = @"￥0.00";
    self.total.font = [UIFont systemFontOfSize:27];
    self.total.textColor = [UIColor whiteColor];
    self.total.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:self.total];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:bgView.frame];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(JumpToseeDetail:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 1;
    [bgView addSubview:btn];
    
}

-(void)initSecondView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 130, windowContentWidth , 70)];
    bgView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:bgView];
    
    
    UILabel *leftlab = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, windowContentWidth/2-25, 25)];
    leftlab.backgroundColor = [UIColor clearColor];
    leftlab.text = @"可提现返佣";
    leftlab.font = [UIFont systemFontOfSize:16];
    leftlab.textColor = [UIColor grayColor];
    leftlab.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:leftlab];

    self.commission = [[UILabel alloc] initWithFrame:CGRectMake(25, 30, windowContentWidth/2-25, 40)];
    self.commission.backgroundColor = [UIColor clearColor];
    self.commission.text = @"￥0.00";
    self.commission.font = [UIFont systemFontOfSize:19];
    self.commission.textColor = [UIColor redColor];
    self.commission.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:self.commission];
    
    UIButton *btnn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth/2, 70)];
    btnn.backgroundColor = [UIColor clearColor];
    [btnn addTarget:self action:@selector(JumpToseeDetail:) forControlEvents:UIControlEventTouchUpInside];
    btnn.tag = 5;
    [bgView addSubview:btnn];
    
    
    UILabel *rightLab = [[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth/2+25, 10, windowContentWidth/2-25, 25)];
    rightLab.backgroundColor = [UIColor clearColor];
    rightLab.text = @"今日收入";
    rightLab.font = [UIFont systemFontOfSize:16];
    rightLab.textColor = [UIColor grayColor];
    rightLab.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:rightLab];
    
    self.todayIncome = [[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth/2+25, 30, windowContentWidth/2-25, 40)];
    self.todayIncome.backgroundColor = [UIColor clearColor];
    self.todayIncome.text = @"￥0.00";
    self.todayIncome.font = [UIFont systemFontOfSize:19];
    self.todayIncome.textColor = [UIColor redColor];
    self.todayIncome.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:self.todayIncome];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(windowContentWidth/2, 0, windowContentWidth/2, 70)];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(JumpToseeDetail:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 2;
    [bgView addSubview:btn];

}

-(void)initThirdView{
    NSArray * arr = @[@"开户",@"查看我的商户"];
    for (int i = 0; i< arr.count; i++) {
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn1 setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        btn1.titleLabel.font = [UIFont systemFontOfSize:17];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//设置button文字靠左距离
        btn1.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [btn1 setBackgroundColor:[UIColor whiteColor]];
        btn1.tag = i+3;
        [btn1 addTarget:self action:@selector(JumpToseeDetail:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn1];
        if (i == 0) {
            btn1.frame = CGRectMake( 0, 130+70+15, windowContentWidth, 45);
        }else if(i == 1){
            btn1.frame = CGRectMake( 0, 130+70+15+45+15, windowContentWidth, 40);
        }
        
        UIImageView *IGV = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(btn1)-45 , ViewHeight(btn1)/2-15, 45, 30)];
        [IGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
        [btn1 addSubview:IGV];
        

    }
}


-(void)loadDataWithUrl:(NSString *)url Parameters:(NSDictionary *)parameters{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters
     
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
              if ([[dict objectForKey:@"state"] integerValue] ==1) {
                  NSDictionary *dict1 = [dict objectForKey:@"data"];
                  
//                  self.total.text = [NSString stringWithFormat:@"%@",[dict1 objectForKey:@"finance"]];
//                 self.commission.text = [NSString stringWithFormat:@"%@",[dict1 objectForKey:@"income"]];
//                  self.todayIncome.text = [NSString stringWithFormat:@"%@",[dict1 objectForKey:@"today_income"]];
                  
                  NSString * sss= [NSString stringWithFormat:@"%.2f",[[dict1 objectForKey:@"finance"] floatValue]];
                  self.commission.text = [NSString stringWithFormat:@"￥%@",[[self countNumAndChangeformat:[sss substringToIndex:sss.length-3]] stringByAppendingString:[sss substringFromIndex:sss.length-3]]];

                  NSString *sss2 = [NSString stringWithFormat:@"%.2f",[[dict1 objectForKey:@"income"] floatValue]];
                  self.total.text = [NSString stringWithFormat:@"￥%@",[[self countNumAndChangeformat:[sss2 substringToIndex:sss2.length-3]] stringByAppendingString:[sss2 substringFromIndex:sss2.length-3]]];
                  
                  NSString *sss3 = [NSString stringWithFormat:@"%.2f",[[dict1 objectForKey:@"today_income"] floatValue]];
                  self.todayIncome.text = [NSString stringWithFormat:@"￥%@",[[self countNumAndChangeformat:[sss3 substringToIndex:sss3.length-3]] stringByAppendingString:[sss3 substringFromIndex:sss3.length-3]]];

              }else{
                  [[LXAlterView sharedMyTools] createTishi:[dict objectForKey:@"msg"]];
              }
              NSLog(@"xxxxxxx = %@",dict);
              NSLog(@"Success: %@", [dict objectForKey:@"msg"] );
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              
          }];
    
}

//添加收入逗号格式
-(NSString *)countNumAndChangeformat:(NSString *)num{
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {   count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}

//跳转
-(void)JumpToseeDetail:(id )sender{
    UIButton *btn = (UIButton *)sender;
    NSLog(@"btn.tag = %ld",(long)btn.tag);
    
    if (btn.tag == 1) {
        //累计收益
        IncomesDetailsViewController * idVC = [[IncomesDetailsViewController alloc] init];
        idVC.navigationItem.title = @"累计收益";
        idVC.conditionStr = @"累计收益";
        [self.navigationController pushViewController:idVC animated:YES];
    }else if(btn.tag == 2) {
        //今日收入
        IncomesDetailsViewController * idVC = [[IncomesDetailsViewController alloc] init];
        idVC.navigationItem.title = @"今日收入";
        idVC.conditionStr = @"今日收入";
        //btn.backgroundColor = kColor(218, 223, 227);
        [self.navigationController pushViewController:idVC animated:YES];
    }else if(btn.tag == 3) {
        //开店
        OpenShopViewController *osVC = [[OpenShopViewController alloc] init];
        [self.navigationController pushViewController:osVC animated:YES];
    }else if(btn.tag == 4) {
        //查看我的商户
        CSHMyShopListVC *vc = [[CSHMyShopListVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(btn.tag == 5) {
        //今日收入-跳返佣明细
        CommissionTableViewController *vc = [[CommissionTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }

    
}




@end

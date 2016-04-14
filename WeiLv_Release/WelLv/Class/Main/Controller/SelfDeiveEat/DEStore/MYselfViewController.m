//
//  MYselfViewController.m
//  WelLv
//
//  Created by liuxin on 15/11/6.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//
#import "ZxdBankViewController.h"
#import "BankCardViewController.h"
#import "zxdOrderViewController.h"
#import "SeladViewController.h"
#import "MYselfViewController.h"
#import "ShowFoodViewController.h"
#import "YXHouseDetailViewController.h"
#import "DDViewController.h"
@interface MYselfViewController ()
{
}
@property(nonatomic,strong)UILabel *total;
@property(nonatomic,strong)UILabel *commission;
@property(nonatomic,strong)UILabel *todayIncome;
@property(nonatomic,strong)NSMutableArray *zxdArr;
@property(nonatomic,strong) MBProgressHUD *zxdHudMY;
@end

@implementation MYselfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zxdArr = [NSMutableArray arrayWithObjects:@"0",@"0",@"",@"已绑定",@"", nil];
    self.navigationItem.title = @"商户管理";
    self.view.backgroundColor = BgViewColor;
    [self download];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
    [self creatViewhead];
    [self creatView2];
    [self creatView3];
       // Do any additional setup after loading the view.
}
-(void)creatViewhead
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 130)];
    bgView.backgroundColor = kColor(250, 121, 11);
    [_scrollView addSubview:bgView];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 50)];
    lab.backgroundColor = [UIColor clearColor];
    lab.text = @"累计营收";
    lab.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    lab.textColor = [UIColor whiteColor];
    lab.textAlignment  = NSTextAlignmentCenter;
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
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 1;
    [bgView addSubview:btn];
}
-(void)creatView2
{
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 130, windowContentWidth, 70)];
    bgview.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:bgview];
    UILabel *leftlab = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, windowContentWidth/2-25, 25)];
    leftlab.backgroundColor = [UIColor clearColor];
    leftlab.text = @"可提现返佣";
    leftlab.font = [UIFont systemFontOfSize:16];
    leftlab.textColor = [UIColor grayColor];
    leftlab.textAlignment = NSTextAlignmentLeft;
    [bgview addSubview:leftlab];
    self.commission = [[UILabel alloc] initWithFrame:CGRectMake(25, 30, windowContentWidth/2-25, 40)];
    self.commission.backgroundColor = [UIColor clearColor];
    self.commission.text = @"￥0.00";
    self.commission.font = [UIFont systemFontOfSize:19];
    self.commission.textColor = [UIColor redColor];
    self.commission.textAlignment = NSTextAlignmentLeft;
    [bgview addSubview:self.commission];
    
    UILabel *rightlab = [[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth/2+25, 10, windowContentWidth/2-25, 25)];
    rightlab.backgroundColor = [UIColor clearColor];
    rightlab.text = @"今日收入";
    rightlab.font = [UIFont systemFontOfSize:16];
    rightlab.textColor = [UIColor grayColor];
    rightlab.textAlignment = NSTextAlignmentLeft;
    [bgview addSubview:rightlab];
    self.todayIncome = [[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth/2+25, 30, windowContentWidth/2-25, 40)];
    self.todayIncome.backgroundColor = [UIColor clearColor];
    self.todayIncome.text = @"￥0.00";
    self.todayIncome.font = [UIFont systemFontOfSize:19];
    self.todayIncome.textColor = [UIColor redColor];
    self.todayIncome.textAlignment = NSTextAlignmentLeft;
    [bgview addSubview:self.todayIncome];
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(windowContentWidth/2, 0, windowContentWidth/2, 70)];
    btn2.backgroundColor = [UIColor clearColor];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag = 2;
    [bgview addSubview:btn2];
    UILabel *zxdLabel = [[UILabel alloc] init];
    zxdLabel.frame = CGRectMake(windowContentWidth/2, 5, 1, 60);
    zxdLabel.backgroundColor = BgViewColor;
    [bgview addSubview:zxdLabel];
    
}
-(void)creatView3
{
    NSArray *arr = @[@"我发布的商品",@"我卖出的",@"我得管家",@"我得银行卡"];
    for (int i =0; i<arr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//设置button文字靠做距离
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.tag = i+3;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:btn];
        
        if (i==0) {
            btn.frame = CGRectMake(0, 130+70+15, windowContentWidth, 45);
        }
        else if(i==1){
            btn.frame = CGRectMake(0, 130+70+15+45, windowContentWidth, 45);
        }
        else if (i==2){
            btn.frame = CGRectMake(0, 130+70+15+90+15, windowContentWidth, 45);
        }
        else if (i==3){
            btn.frame = CGRectMake(0, 130+70+15+90+15+45+15, windowContentWidth, 45);
        }
        else{}
        UIImageView *IGV = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(btn)-45 , ViewHeight(btn)/2-15, 45, 30)];
        
        [IGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
        [btn addSubview:IGV];
        UILabel *labelRight = [[UILabel alloc] init];
        labelRight.text = self.zxdArr[i];
        labelRight.tag = 61+i;
        labelRight.textAlignment = NSTextAlignmentRight;
        labelRight.font = [UIFont systemFontOfSize:15];
        labelRight.frame = CGRectMake(windowContentWidth-100-30, ViewHeight(btn)/2-15, 100, 30);
        [btn addSubview:labelRight];
    }
    UILabel *labelLine = [[UILabel alloc] init];
    labelLine.frame = CGRectMake(5, 130+70+15+45, windowContentWidth-10, 1);
    labelLine.backgroundColor = BgViewColor;
    [_scrollView addSubview:labelLine];

}

-(void)btnClick:(UIButton *)btn
{
    if (btn.tag == 1) {
        BankCardViewController *bk = [[BankCardViewController alloc] init];
        [self.navigationController pushViewController:bk animated:YES];
        DLog(@"+++++%ld",btn.tag);
    }
    else if (btn.tag == 2)
    {
        DLog(@"+++++%ld",btn.tag);
    }
    else if (btn.tag == 3)
    {
        ShowFoodViewController *show = [[ShowFoodViewController alloc] init];
        [self.navigationController pushViewController:show animated:YES];
        DLog(@"+++++%ld",btn.tag);
    }
    else if (btn.tag == 4)
    {
        DDViewController *dView = [[DDViewController alloc] init];
        dView.deOrderType = WLDEStoreOrderTypeMyOrder;
        //zxdOrderViewController *order = [[zxdOrderViewController alloc] init];
        [self.navigationController pushViewController:dView animated:YES];
//        SeladViewController *zxdSview = [[SeladViewController alloc] init];
//        zxdSview.navigationItem.title = @"卖出的商品";
//        [self.navigationController pushViewController:zxdSview animated:YES];
        DLog(@"+++++%ld",btn.tag);
    }
    else if (btn.tag == 5)
    {
        YXHouseDetailViewController *yh = [[YXHouseDetailViewController alloc] init];
        [self.navigationController pushViewController:yh animated:YES];
        DLog(@"+++++%ld",btn.tag);
    }
    else if (btn.tag == 6)
    {
        ZxdBankViewController *zxdBank = [[ZxdBankViewController alloc] init];
        [self.navigationController pushViewController:zxdBank animated:YES];
        DLog(@"+++++%ld",btn.tag);
    }
    else
    {
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -下载
-(void)download
{
    //NSLog(@"page === %ld", pag);
    //NSString *page = [NSString stringWithFormat:@"%ld",pag];
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString *member_id = [LXUserTool sharedUserTool].getUid;
    NSString * shopId = [[WLSingletonClass defaultWLSingleton] wlDEShopID];
    NSString *token1 = [token stringByAppendingString:shopId];
    NSDictionary *parameters = @{@"shopId":shopId,
                                 @"wltoken":[WXUtil md5:token1],
                                 @"member_id":member_id,
                                 };
    
    NSString *zxdUrl = [NSString stringWithFormat:@"%@/%@",WLHTTP,@"api/drivingShop/drivingPartnerShopManage"];
    NSLog(@"par=%@",parameters);
    [self sendWith:zxdUrl dict:parameters];
}
-(void)sendWith:(NSString *)url dict:(NSDictionary *)dict
{
    [self setHud:@"正在下载,,,"];
    __weak typeof(self)weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];;
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"msg ==== %@",dict);
        self.zxdHudMY.labelText = dict[@"msg"];
        self.zxdHudMY.hidden = YES;
        if ([dict objectForKey:@"data"] && [[dict objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *zxdDict = dict[@"data"];
            self.total.text = [NSString stringWithFormat:@"￥%@",[zxdDict objectForKey:@"total_revenue"]];
            self.commission.text = [NSString stringWithFormat:@"￥%@",[zxdDict objectForKey:@"account_balance"]];
            self.todayIncome.text = [NSString stringWithFormat:@"￥%@",[zxdDict objectForKey:@"cur_date_revenue"]];
            
            UILabel *label1 = (UILabel *)[self.view viewWithTag:61];//我发布的商品
            label1.text =[NSString stringWithFormat:@"%@",[zxdDict objectForKey:@"product_num"]];
            UILabel *label2 = (UILabel *)[self.view viewWithTag:62];//我卖出的
            label2.text = [NSString stringWithFormat:@"%@",[zxdDict objectForKey:@"order_num"]];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertViewFail = [[UIAlertView alloc] initWithTitle:@"下载失败" message:@"请检查您的网路是否正常" delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertViewFail show];
        
        
        
    }];
}
-(void)setHud:(NSString *)str
{
    
    self.zxdHudMY = [[MBProgressHUD alloc] initWithView:self.view];
    self.zxdHudMY.frame = self.view.bounds;
    self.zxdHudMY.minSize = CGSizeMake(100, 100);
    self.zxdHudMY.mode = MBProgressHUDModeIndeterminate;
    self.zxdHudMY.labelText = str;
    [_scrollView addSubview:self.zxdHudMY];
    // [_zxdTableView bringSubviewToFront:self.zxdHud];
    [self.zxdHudMY show:YES];
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

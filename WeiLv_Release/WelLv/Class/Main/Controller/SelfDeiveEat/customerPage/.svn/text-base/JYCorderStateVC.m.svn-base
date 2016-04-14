//
//  JYCorderStateVC.m
//  WelLv
//
//  Created by lyx on 15/11/23.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCorderStateVC.h"
#import "JYCleftStateView.h"
#import "JYCRightDetailView.h"
#import "JYCcommentVC.h"
#import "TimeLogModel.h"
#import "LoginAndRegisterViewController.h"

@interface JYCorderStateVC ()<UIScrollViewDelegate,clickBtndelegate>
{
    UIView *chooeseLine;
    AFHTTPRequestOperationManager *manager;
}
@property(nonatomic,strong)UIView *chooseView;
@property (nonatomic, strong) UIButton *tempBut;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableDictionary *downDict;
@property(nonatomic,strong)NSMutableArray *timeLog;
@property(nonatomic,strong)NSMutableArray *productArr;
@property(nonatomic,strong)NSDictionary *partnerDict;
@property (nonatomic, strong) MBProgressHUD * hud;
@end

@implementation JYCorderStateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
     _timeLog=[[NSMutableArray alloc]init];
     _productArr=[[NSMutableArray alloc]init];
   
    self.scrollView= [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, windowContentWidth, windowContentHeight-64-40)];
    self.scrollView.delegate=self;
    [self.view addSubview:self.scrollView];
    
    [self createTopView];
    [self initData];
   // [self createScrollView];
}

-(void)initData
{
    NSString * user_id = [[[LXUserTool alloc] init] getUid];;
        if (user_id == nil) {
            LoginAndRegisterViewController * vc = [[LoginAndRegisterViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
    
    
    
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString * memberId =[[WLSingletonClass defaultWLSingleton] wlUserID];
    NSString *token1 = [token stringByAppendingString:memberId];
    
    NSDictionary *parameters = @{@"order_id":self.orderId,@"model_id":@"-6",@"where_field":@"driving_order_id",@"is_extend":@"1"};
    
    NSString *str=[[WLSingletonClass defaultWLSingleton]wlDictionaryToJson:parameters];
    NSDictionary *dict=@{@"datajson":str,@"wltoken":[WXUtil md5:token1],@"member_id":memberId};
    [self setProgressHud];
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:EatOrderDetailUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"++++%@----",dict);
        self.downDict=dict[@"data"];
        self.partnerDict=self.downDict[@"partner"];
        if ([dict[@"state"]integerValue]==1) {
           
            [_hud hide:YES];
            NSMutableArray *arr1=[[NSMutableArray alloc]init];
            arr1=self.downDict[@"timeLog"];
            for (NSDictionary *dict in arr1) {
                TimeLogModel *model=[[TimeLogModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [self.timeLog addObject:model];
            }
            NSMutableArray *arr2=[[NSMutableArray alloc]init];
            arr2=self.downDict[@"products"];
            for (NSDictionary *dict in arr2) {
                productsModel *model=[[productsModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [self.productArr addObject:model];
            }
        }
        self.title=self.partnerDict[@"partner_shop_name"];
        [self createScrollView];
     
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
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

-(void)createTopView
{
    self.chooseView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, 40)];
    self.chooseView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.chooseView];
    NSArray * chooseTitleArr = @[@"订单状态", @"订单详情"];
    
    for (int i = 0; i < chooseTitleArr.count; i++) {
        UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i==0) {
            but.frame = CGRectMake(60, 0, 80, ViewHeight(self.chooseView));
            [but setTitle:[chooseTitleArr objectAtIndex:i] forState:UIControlStateNormal];
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [but addTarget:self action:@selector(chooseBut:) forControlEvents:UIControlEventTouchUpInside];
            but.tag=101+i;
            but.backgroundColor = [UIColor whiteColor];
            [but setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            self.tempBut = but;
        }else if(i==1){
            but.frame = CGRectMake(ViewWidth(self.chooseView)-60-80, 0, 80, ViewHeight(self.chooseView));
            [but setTitle:[chooseTitleArr objectAtIndex:i] forState:UIControlStateNormal];
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [but addTarget:self action:@selector(chooseBut:) forControlEvents:UIControlEventTouchUpInside];
            but.tag=101+i;
            but.backgroundColor = [UIColor whiteColor];
        }
        [self.chooseView addSubview:but];
        
    }
    chooeseLine = [[UIView alloc] initWithFrame:CGRectMake(60, 40 - 2.5, 80, 2)];
    chooeseLine.backgroundColor = [UIColor orangeColor];
    UIView *botomLine=[[UIView alloc]initWithFrame:CGRectMake(0, 40-1, windowContentWidth, 1)];
    botomLine.backgroundColor=bordColor;
    [self.chooseView addSubview:chooeseLine];
    [self.chooseView addSubview:botomLine];

}
- (void)chooseBut:(UIButton *)button{
    if (self.tempBut==button) {
        return;
    }
   
   
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width*(button.tag-101), 0)animated:YES];
  
    chooeseLine.frame = CGRectMake(ViewX(button), ViewHeight(self.chooseView) - 2.5, ViewWidth(button), 2);
   
    if (![button isEqual:self.tempBut]){
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.tempBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    self.tempBut = button;
  
}
-(void)createScrollView
{
    JYCleftStateView *leftView=[[JYCleftStateView alloc]initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) and:self.downDict with:self.timeLog];
    leftView.delegate=self;
    [self.scrollView addSubview:leftView];
    JYCRightDetailView *rightView=[[JYCRightDetailView alloc]initWithFrame:CGRectMake(self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)and:self.downDict with:self.productArr];
    [self.scrollView addSubview:rightView];
    
    [self.scrollView  setContentSize:CGSizeMake(2*self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    [self.scrollView setBounces:NO];
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float tmp = self.scrollView.contentOffset.x/self.scrollView.frame.size.width;
    
    UIButton *btn1 = (UIButton *)[self.chooseView viewWithTag:101+tmp];
    btn1.selected=YES;
    [btn1 setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    UIButton *btn2=(UIButton *)[self.chooseView viewWithTag:102-tmp];
    btn2.selected=NO;
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    chooeseLine.frame = CGRectMake(ViewX(btn1), ViewHeight(self.chooseView) - 2.5, ViewWidth(btn1), 2);
    self.tempBut=btn1;
    
    
}

-(void)clickToPush:(NSDictionary *)dict
{
    JYCcommentVC *vc=[[JYCcommentVC alloc]init];
    vc.rArr=dict[@"1"];
    vc.driveOrderId=dict[@"2"];
    vc.dict=dict[@"3"];
    [self.navigationController pushViewController:vc
                                         animated:YES];
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

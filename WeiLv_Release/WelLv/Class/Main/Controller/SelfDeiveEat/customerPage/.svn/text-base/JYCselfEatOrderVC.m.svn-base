//
//  JYCselfEatOrderVC.m
//  WelLv
//
//  Created by lyx on 15/11/28.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCselfEatOrderVC.h"
#import "JYCselfEatCell.h"
#import "JYCselfEatOrderModel.h"
#import "JYCorderStateVC.h"


@interface JYCselfEatOrderVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *imageView;
    BOOL up;
    UIView *backgroundView;
    AFHTTPRequestOperationManager *manager;
    UIButton *lastBtn;
    //int page;
    int type;
    }
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *baseArr;
@property (nonatomic, strong) MBProgressHUD * hud;
@property(nonatomic,assign)int page;

@end

@implementation JYCselfEatOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _page=0;
    type=1;
    self.view.backgroundColor=BgViewColor;
    _baseArr=[[NSMutableArray alloc]init];
    UIButton *titleBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120, 20)];
    [titleBtn setTitle:@"自驾吃订单" forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    imageView=[[UIImageView alloc]initWithFrame:CGRectMake(105, 7, 11, 6)];
    imageView.image=[UIImage imageNamed:@"按钮向上"];
    [titleBtn addSubview:imageView];
    self.navigationItem.titleView=titleBtn;
     [self initUI];
   // [self initData];
    [self addRefreshing];
    [self createButton];
    [self addGes];
    
}
-(NSString *)returnToken
{
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString * memberId =[[WLSingletonClass defaultWLSingleton] wlUserID];
    
    NSString *token1 = [token stringByAppendingString:memberId];
    return token1;
}
- (void)addRefreshing {
    NSMutableArray *imageAray=[NSMutableArray array];
    for (int i=0; i<2; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"单独-logo%d.png", i+2]];
        [imageAray addObject:image];
    }
    //-----------下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    
    __weak JYCselfEatOrderVC * weakSelf = self;
    [self.tableView addGifHeaderWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // NSLog(@"**********");
            [weakSelf.baseArr removeAllObjects];
            //NSString *url=[Url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
           
            if (type==1) {
                weakSelf.page=0;
                NSArray *arr=[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"6",@"7",@"8",@"9",@"10", @"11",nil];
                NSDictionary *parameters = @{@"p":@(weakSelf.page),@"model_id":@"-6",@"order_status":arr,@"operation_type":@"member",@"pay_status":@""};
                
                NSString *str=[[WLSingletonClass defaultWLSingleton]wlDictionaryToJson:parameters];
                NSDictionary *dict=@{@"datajson":str,@"wltoken":[WXUtil md5:[weakSelf returnToken]],@"member_id":[[WLSingletonClass defaultWLSingleton]wlUserID]};
                NSLog(@"加%@",dict);
               [weakSelf sentWith:dict];
            }else if(type==2){
                weakSelf.page=0;
                NSArray *arr=[NSArray arrayWithObjects:@"0",nil];
                NSDictionary *parameters = @{@"p":@(weakSelf.page),@"model_id":@"-6",@"order_status":arr,@"operation_type":@"member_id",@"pay_status":@"1"};
                
                NSString *str=[[WLSingletonClass defaultWLSingleton]wlDictionaryToJson:parameters];
                NSDictionary *dict=@{@"datajson":str,@"wltoken":[WXUtil md5:[weakSelf returnToken]],@"member_id":[[WLSingletonClass defaultWLSingleton]wlUserID]};
                [weakSelf sentWith:dict];

            }else if(type==3)
            {
                weakSelf.page=0;
                NSArray *arr=[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"9",@"10",@"11",nil];
                NSDictionary *parameters = @{@"p":@(weakSelf.page),@"model_id":@"-6",@"order_status":arr,@"operation_type":@"member",@"pay_status":@"2"};
                
                NSString *str=[[WLSingletonClass defaultWLSingleton]wlDictionaryToJson:parameters];
                NSDictionary *dict=@{@"datajson":str,@"wltoken":[WXUtil md5:[weakSelf returnToken]],@"member_id":[[WLSingletonClass defaultWLSingleton]wlUserID]};
                NSLog(@"加%@",dict);
                
                [weakSelf sentWith:dict];
            }else if(type==4)
            {
                weakSelf.page=0;
                NSArray *arr=[NSArray arrayWithObjects:@"6",@"7",@"8",nil];
                NSDictionary *parameters = @{@"p":@(weakSelf.page),@"model_id":@"-6",@"order_status":arr,@"operation_type":@"member",@"pay_status":@"2"};
                
                NSString *str=[[WLSingletonClass defaultWLSingleton]wlDictionaryToJson:parameters];
                NSDictionary *dict=@{@"datajson":str,@"wltoken":[WXUtil md5:[weakSelf returnToken]],@"member_id":[[WLSingletonClass defaultWLSingleton]wlUserID]};
                [weakSelf sentWith:dict];

            }
           
            // weakSelf.tableView.footer.hidden=YES;
        });
    }];
    // 设置普通状态的动画图片
    [self.tableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self.tableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self.tableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateRefreshing];
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
    // 马上进入刷新状态
   [self.tableView.gifHeader beginRefreshing];
    
    
    [self.tableView.footer setState:MJRefreshFooterStateIdle];
    
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}
-(void)addGes
{
    
}
//-(void)initData
//{
//    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
//    NSString * memberId =[[WLSingletonClass defaultWLSingleton] wlUserID];
//    
//    NSString *token1 = [token stringByAppendingString:memberId];
//    NSArray *arr=[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"6",@"7",@"8",@"9",@"10", @"11",nil];
//    NSDictionary *parameters = @{@"p":@"0",@"model_id":@"-6",@"order_status":arr,@"operation_type":@"member"};
//    
//    NSString *str=[[WLSingletonClass defaultWLSingleton]wlDictionaryToJson:parameters];
//    NSDictionary *dict=@{@"datajson":str,@"wltoken":[WXUtil md5:token1],@"member_id":memberId};
//    [self sentWith:dict];
//    
//
//}
-(void)initUI
{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64)];
       // _tableView.backgroundColor=BgViewColor;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=BgViewColor;
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth,windowContentHeight-64)];
    backgroundView.backgroundColor=[UIColor colorWithWhite:0.2 alpha:0.5];
    [self.view addSubview:backgroundView];
    backgroundView.hidden=YES;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [backgroundView addGestureRecognizer:tap];

}
-(void)tapClick:(id)sender
{
    backgroundView.hidden=YES;
   
}
-(void)createButton
{
    NSArray *arr=[NSArray arrayWithObjects:@"全部",@"待付款",@"已付款",@"退款单", nil];
    for (int i=0; i<arr.count; i++) {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0+i*40,windowContentWidth, 40)];
        [backgroundView addSubview:button];
        button.tag=1001+i;
        button.backgroundColor=[UIColor whiteColor];
        [button addTarget:self action:@selector(selectBtnLClick:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 40)];
        label.textColor=[UIColor blackColor];
        label.text=[NSString stringWithFormat:@"%@",arr[i]];
        label.font=systemFont(18);
        [button addSubview:label];
        UIImageView *rightView=[[UIImageView alloc]initWithFrame:CGRectMake(windowContentWidth-25, 12.5, 15, 15)];
        rightView.image=[UIImage imageNamed:@"选中圆圈"];
        rightView.tag=200+i;
        rightView.hidden=YES;
        [button addSubview:rightView];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 39, windowContentWidth, 1)];
        line.backgroundColor=bordColor;
        [button addSubview:line];
    }
    

    
}
-(void)selectBtnLClick:(UIButton *)button
{
   
   // lastBtn=nil;
    UIImageView *imageview=(UIImageView *)[[lastBtn subviews]objectAtIndex:1];
    imageview.hidden=YES;
    lastBtn=button;

    if (button.tag==1001) {
        type=1;
        self.page=0;
        NSArray *arr=[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"6",@"7",@"8",@"9",@"10", @"11",nil];
        NSDictionary *parameters = @{@"p":@(self.page),@"model_id":@"-6",@"order_status":arr,@"operation_type":@"member",@"pay_status":@""};
        
        NSString *str=[[WLSingletonClass defaultWLSingleton]wlDictionaryToJson:parameters];
        NSDictionary *dict=@{@"datajson":str,@"wltoken":[WXUtil md5:[self returnToken]],@"member_id":[[WLSingletonClass defaultWLSingleton]wlUserID]};
        NSLog(@"加%@",dict);
        [self sentWith:dict];
 
    backgroundView.hidden=YES;
    up=NO;
    }else if(button.tag==1002)
    {
       
       type=2;
        self.page=0;
        NSArray *arr=[NSArray arrayWithObjects:@"0",nil];
        NSDictionary *parameters = @{@"p":@(self.page),@"model_id":@"-6",@"order_status":arr,@"operation_type":@"member",@"pay_status":@"1"};
        
        NSString *str=[[WLSingletonClass defaultWLSingleton]wlDictionaryToJson:parameters];
        NSDictionary *dict=@{@"datajson":str,@"wltoken":[WXUtil md5:[self returnToken]],@"member_id":[[WLSingletonClass defaultWLSingleton]wlUserID]};
        [self sentWith:dict];
        
       
        backgroundView.hidden=YES;
        up=NO;
    }else if(button.tag==1003)
    {
        type=3;
        self.page=0;
        NSArray *arr=[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"9",@"10",@"11",nil];
        NSDictionary *parameters = @{@"p":@(self.page),@"model_id":@"-6",@"order_status":arr,@"operation_type":@"member",@"pay_status":@"2"};
        
        NSString *str=[[WLSingletonClass defaultWLSingleton]wlDictionaryToJson:parameters];
        NSDictionary *dict=@{@"datajson":str,@"wltoken":[WXUtil md5:[self returnToken]],@"member_id":[[WLSingletonClass defaultWLSingleton]wlUserID]};
        NSLog(@"加%@",dict);

        [self sentWith:dict];
        backgroundView.hidden=YES;
        up=NO;
    }else if(button.tag==1004)
    {
        type=4;
        self.page=0;
        NSArray *arr=[NSArray arrayWithObjects:@"6",@"7",@"8",nil];
        NSDictionary *parameters = @{@"p":@(self.page),@"model_id":@"-6",@"order_status":arr,@"operation_type":@"member",@"pay_status":@"2"};
        
        NSString *str=[[WLSingletonClass defaultWLSingleton]wlDictionaryToJson:parameters];
        NSDictionary *dict=@{@"datajson":str,@"wltoken":[WXUtil md5:[self returnToken]],@"member_id":[[WLSingletonClass defaultWLSingleton]wlUserID]};
        [self sentWith:dict];

        
        backgroundView.hidden=YES;
        up=NO;
    }


}
-(void)btnClick:(UIButton *)button
{
    imageView.image=up?[UIImage imageNamed:@"按钮向上"]:[UIImage imageNamed:@"按钮-副本"];
    backgroundView.hidden=up?YES:NO;
    up=!up;
    if (backgroundView.hidden==NO) {
       UIImageView *imageview=(UIImageView *)[[lastBtn subviews]objectAtIndex:1];
       imageview.hidden=NO;
    }
}

-(void)sentWith:(NSDictionary *)dict
{
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   [self setProgressHud];
    
    [manager POST:EatMineOrderUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject){
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"++++%@----",dict);
       
       
        if ([dict[@"state"] intValue]==1) {
            
        [_hud hide:YES];
        NSDictionary *dict2=dict[@"data"];
        NSMutableArray *arr=[NSMutableArray array];
        arr=dict2[@"lists"];
        if (arr.count==0) {
            [[LXAlterView sharedMyTools] createTishi:@"加载完毕,没有更多内容"];
             [self.tableView.footer endRefreshing];
            return;
        }
            if (self.page==0) {
            [self.baseArr removeAllObjects];
            }
           
        for (NSDictionary *di in arr) {
            JYCselfEatOrderModel *model=[[JYCselfEatOrderModel alloc]init];
            [model setValuesForKeysWithDictionary:di];
            [self.baseArr addObject:model];
        }
        
    
        }else{
            NSLog(@"%@",dict[@"msg"]);
            [_hud hide:YES];
            [[LXAlterView sharedMyTools] createTishi:@"您请求的订单没数据"];
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
        }
        [self loadMore];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        
        [_hud hide:YES];
        
    }];

}
-(void)loadMore
{
   __weak typeof(self)weakSelf=self;
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"++++++");
           
            //NSString *url=[macurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            //NSDictionary *dict=nil;
            if (type==1) {
                weakSelf.page=weakSelf.page+1;
                NSArray *arr=[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"6",@"7",@"8",@"9",@"10", @"11",nil];
                NSDictionary *parameters = @{@"p":@(weakSelf.page),@"model_id":@"-6",@"order_status":arr,@"operation_type":@"member",@"pay_status":@""};
                
                NSString *str=[[WLSingletonClass defaultWLSingleton]wlDictionaryToJson:parameters];
                NSDictionary *dict=@{@"datajson":str,@"wltoken":[WXUtil md5:[weakSelf returnToken]],@"member_id":[[WLSingletonClass defaultWLSingleton]wlUserID]};
                NSLog(@"加%@",dict);
                [weakSelf sentWith:dict];
            }else if(type==2){
                 weakSelf.page=weakSelf.page+1;
                NSArray *arr=[NSArray arrayWithObjects:@"0",nil];
                NSDictionary *parameters = @{@"p":@(weakSelf.page),@"model_id":@"-6",@"order_status":arr,@"operation_type":@"member",@"pay_status":@"1"};
                
                NSString *str=[[WLSingletonClass defaultWLSingleton]wlDictionaryToJson:parameters];
                NSDictionary *dict=@{@"datajson":str,@"wltoken":[WXUtil md5:[weakSelf returnToken]],@"member_id":[[WLSingletonClass defaultWLSingleton]wlUserID]};
                [weakSelf sentWith:dict];
                
            }else if(type==3)
            {
                 weakSelf.page=weakSelf.page+1;
                NSArray *arr=[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"9",@"10",@"11",nil];
                NSDictionary *parameters = @{@"p":@(weakSelf.page),@"model_id":@"-6",@"order_status":arr,@"operation_type":@"member",@"pay_status":@"2"};
                
                NSString *str=[[WLSingletonClass defaultWLSingleton]wlDictionaryToJson:parameters];
                NSDictionary *dict=@{@"datajson":str,@"wltoken":[WXUtil md5:[weakSelf returnToken]],@"member_id":[[WLSingletonClass defaultWLSingleton]wlUserID]};
                NSLog(@"加%@",dict);
                
                [weakSelf sentWith:dict];
            }else if(type==4)
            {
                 weakSelf.page=weakSelf.page+1;
                NSArray *arr=[NSArray arrayWithObjects:@"6",@"7",@"8",nil];
                NSDictionary *parameters = @{@"p":@(weakSelf.page),@"model_id":@"-6",@"order_status":arr,@"operation_type":@"member",@"pay_status":@"2"};
                
                NSString *str=[[WLSingletonClass defaultWLSingleton]wlDictionaryToJson:parameters];
                NSDictionary *dict=@{@"datajson":str,@"wltoken":[WXUtil md5:[weakSelf returnToken]],@"member_id":[[WLSingletonClass defaultWLSingleton]wlUserID]};
                [weakSelf sentWith:dict];
                
            }
            
            
        });
        
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.baseArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    JYCselfEatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[JYCselfEatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.backgroundColor=BgViewColor;
   cell.selectionStyle=  UITableViewCellSeparatorStyleNone;
    cell.model=self.baseArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return 194.5;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JYCselfEatOrderModel *model=self.baseArr[indexPath.row];
    NSLog(@"%@",model);
    JYCorderStateVC *vc=[[JYCorderStateVC alloc]init];
    vc.orderId=model.driving_order_id;
    [self.navigationController pushViewController:vc animated:YES];
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

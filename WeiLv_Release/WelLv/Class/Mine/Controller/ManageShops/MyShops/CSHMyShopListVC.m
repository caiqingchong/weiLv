//
//  CSHMyShopListVC.m
//  WelLv
//
//  Created by mac for csh on 15/11/20.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "CSHMyShopListVC.h"
#import "CSHShopModel.h"
#import "CSHShopCell.h"
#import "WXUtil.h"
#import "ButtonWithImage.h"
#import "CSHAduitViewController.h"

@interface CSHMyShopListVC ()
{
    UIButton *chooseBtn;
    UIView *chooseView;
    UIView* chooseView1;
    UITableView *_tableView;
    NSMutableArray *shopArray;
    
    int _currentPage;
    //int _offset;
    NSString *stasusStr;
    
}

@end

@implementation CSHMyShopListVC

-(void)viewWillAppear:(BOOL)animated{
    if (chooseBtn.hidden == YES) {
        chooseBtn.hidden =NO;
        [self loadNewData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的商户";
    BackBtn *_backBtn = [[BackBtn alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    _backBtn.leftView.image = [UIImage imageNamed:@"back"];
    [_backBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    
    shopArray = [NSMutableArray array];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight -NavHeight)];
    _tableView.tableFooterView=[[UIView alloc] init];//去掉多余的cell
    _tableView.delegate = self; _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self initData];
    
    
    NSMutableArray *imageAray=[NSMutableArray array];
    for (int i=0; i<2; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"单独-logo%d.png", i+2]];
        [imageAray addObject:image];
    }
     //-----------下拉刷新
     // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
     [_tableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
     
     // 设置普通状态的动画图片
     [_tableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateIdle];
     // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
     [_tableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStatePulling];
     
     // 设置正在刷新状态的动画图片
     [_tableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateRefreshing];
     // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
     
     // 马上进入刷新状态
     [_tableView.gifHeader beginRefreshing];
    
    //----------上拉加载更多
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadLastData)];
    

    chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [chooseBtn setBackgroundColor:[UIColor clearColor]];
    [chooseBtn setBackgroundImage:[UIImage imageNamed:@"订单1-自驾吃"] forState:UIControlStateNormal];
    chooseBtn.frame = CGRectMake(ViewWidth(self.navigationController.navigationBar)/2+25, ViewHeight(self.navigationController.navigationBar)/2-32/2, 40, 32);
    [chooseBtn addTarget:self action:@selector(loadChooseView) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:chooseBtn];
}

-(void)loadChooseView{
    NSArray *arr =[[NSArray alloc] initWithObjects:@"全部商户",@"已开通",@"待审核", nil];
    if (!chooseView) {
        chooseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
        chooseView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
        [self.view addSubview:chooseView];
        chooseView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 45*arr.count)];
        chooseView1.backgroundColor = [UIColor whiteColor];
        [chooseView addSubview:chooseView1];
        for (int i = 0; i<arr.count; i++) {
            ButtonWithImage *btn = [[ButtonWithImage alloc] initWithFrame:CGRectMake(0, 45*i, windowContentWidth, 45)];
            if( i == 0){
                btn.imageV.hidden =NO;
            }
            btn.textLabel.text = [arr objectAtIndex:i];
            btn.tag = i;
            [btn addTarget:self action:@selector(Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [chooseView1 addSubview:btn];
           /* if (i != arr.count -1) {
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 45*i+45-0.5, windowContentWidth, 0.5)];
                line.backgroundColor = bordColor;
                [chooseView1 addSubview:line];
            }*/
            
        }
        [chooseBtn setBackgroundImage:[UIImage imageNamed:@"订单2-自驾吃"] forState:UIControlStateNormal];
    }else if(chooseView && chooseView.hidden == YES){
        chooseView.hidden = NO;
        [chooseBtn setBackgroundImage:[UIImage imageNamed:@"订单2-自驾吃"] forState:UIControlStateNormal];
    }else if(chooseView && chooseView.hidden == NO){
        chooseView.hidden = YES;
        [chooseBtn setBackgroundImage:[UIImage imageNamed:@"订单1-自驾吃"] forState:UIControlStateNormal];
    }
}

-(void)Clicked:(id)sender{
    ButtonWithImage *butn = (ButtonWithImage *)sender;
   // NSLog(@"%ld",butn.tag);
    for (ButtonWithImage * btn in [chooseView1 subviews]) {
        if (btn == butn) {
            btn.imageV.hidden = NO;
        }else{
            btn.imageV.hidden = YES;
        }
    }
   
    self.navigationItem.title = butn.textLabel.text;
    chooseView.hidden = YES;
    [chooseBtn setBackgroundImage:[UIImage imageNamed:@"订单1-自驾吃"] forState:UIControlStateNormal];
    if (butn.tag == 0) {
        stasusStr = @"";
    }else if(butn.tag == 1){
        stasusStr = @"1";
    }else if(butn.tag == 2){
        stasusStr = @"0";
    }
    [self loadNewData];
}


-(void)initData{
    
    _currentPage=1;
  //_offset=0;
    stasusStr = @"";
}

#pragma mark --- 下拉刷新
-(void)loadNewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [shopArray removeAllObjects];
        shopArray = [[NSMutableArray alloc] init];
        _currentPage=1;
        NSString *md5str = [NSString stringWithFormat:@"~0;id<zOD.{ll@]JKi(:%@",[[LXUserTool alloc] getUid]];
        md5str = [WXUtil md5:md5str];
        NSDictionary *dic =@{@"assistant_id":[[LXUserTool alloc] getUid],@"wltoken":md5str,@"page":
                                 [NSString stringWithFormat:@"%d",_currentPage],@"nums":@"10",@"status":stasusStr};
        [self sendRequestWithParamers:dic];
        _currentPage++;
        // 拿到当前的下拉刷新控件，结束刷新状态
        
    });
}

#pragma mark -- 加载更多
-(void)loadLastData
{
   // _offset=_currentPage*10;
   // NSString *offset1=[NSString stringWithFormat:@"%ld",(long)_offset];
    NSString *md5str = [NSString stringWithFormat:@"~0;id<zOD.{ll@]JKi(:%@",[[LXUserTool alloc] getUid]];
     md5str = [WXUtil md5:md5str];
     NSDictionary *dic =@{@"assistant_id":[[LXUserTool alloc] getUid],@"wltoken":md5str,@"page":[NSString stringWithFormat:@"%d",_currentPage],@"nums":@"10",@"status":stasusStr};
    [self sendRequestWithParamers:dic];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [_tableView.footer endRefreshing];
        _currentPage++;
    });
}


-(void)sendRequestWithParamers:(NSDictionary *)parameters{
    //NSLog(@"%@",parameters);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:GetMyShopList parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
              if ([[dict objectForKey:@"state"] integerValue] ==1) {
                  if ([dict objectForKey:@"data"] && [[dict objectForKey:@"data"] isKindOfClass:[NSArray class]] && [[dict objectForKey:@"data"] count]>0) {
                      
                      for (int i =0 ; i < [[dict objectForKey:@"data"] count]; i++) {
                          NSDictionary *dicccc = [[dict objectForKey:@"data"] objectAtIndex:i];
                          CSHShopModel *model = [[CSHShopModel alloc] initWithDictionary:dicccc];
                          [shopArray addObject:model];
                      }
                      

                  }
              }else{
                  [[LXAlterView sharedMyTools] createTishi:[dict objectForKey:@"msg"]];
              }
              [_tableView reloadData];
              [_tableView.header endRefreshing];
            //  NSLog(@"dict = %@ " ,dict);
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              [_tableView.header endRefreshing];
              NSLog(@"Error: %@", error);
              
          }];

}

#pragma mark ---- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return shopArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIndentifier = @"lCell";
    CSHShopCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[CSHShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CSHShopModel *model = [shopArray objectAtIndex:indexPath.row];
    cell.item = model;
    
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSHAduitViewController *aduit = [[CSHAduitViewController alloc] init];
    CSHShopModel *model = [shopArray objectAtIndex:indexPath.row];
    aduit.title = model.partner_shop_name;
    aduit.model = model;
    chooseBtn.hidden =YES;
    [self.navigationController pushViewController:aduit animated:YES];
}


-(void)close{
    [self.navigationController popViewControllerAnimated:YES];
    [chooseBtn removeFromSuperview];
}

@end

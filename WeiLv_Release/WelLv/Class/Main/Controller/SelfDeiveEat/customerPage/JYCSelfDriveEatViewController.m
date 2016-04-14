//
//  JYCSelfDriveEatViewController.m
//  WelLv
//
//  Created by lyx on 15/10/28.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
#define BannerHegit 150*HeightScale
#import "JYClocationViewController.h"
#import "JYCSelfDriveEatViewController.h"
#import "YXBannerView.h"
#import "LXAdvertModel.h"
#import "YXTools.h"
#import "LXGetCityIDTool.h"
#import "JYCDriveCell.h"

#import "DriveModel.h"
#import "JYCPositionVC.h"
#import "JYCRestauantVC.h"
#import "ZFJChooseCityVC.h"
#import "YXLocationManage.h"
#import "JYCselfEatOrderVC.h"
@interface JYCSelfDriveEatViewController ()<UITableViewDelegate,UITableViewDataSource,EScrollerViewDelegate>
{
    YXBannerView *_bannerView;
    UITableView *_tableView;
    NSMutableArray *_adArray;
    UIView *chooessLine;
    UIView *_chooseView;
    UIView *hearderView;
    UIView *midelView;
    CGFloat latitude;
    CGFloat longitude;
    UILabel *cityLabel;
    AFHTTPRequestOperationManager *manager;
    BOOL isHot;
    UIView *hView;
    
}
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) UIButton * tempBut;
@property (nonatomic, assign) CGFloat chooseViewY;
@property (nonatomic, strong)UIView *chooseView;
@property (nonatomic, strong)NSMutableArray *imageArr;
@property(nonatomic,strong)NSMutableArray *baseArr;
@property(nonatomic,assign)NSInteger page;
@property (nonatomic, strong) MBProgressHUD * hud;

@end

@implementation JYCSelfDriveEatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _page=1;
    isHot=NO;
    _imageArr=[[NSMutableArray alloc]init];
    _baseArr=[[NSMutableArray alloc]init];
    //_chuArr=[[NSMutableArray alloc]init];
    self.view.backgroundColor=BgViewColor;
    self.navigationItem.title=@"微旅自驾";
    
    
    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame=CGRectMake(0, 0, 23, 23);
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
   

    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:searchBtn];
     [self initView];
    [self initLocation];
    
  
  
    
  
   
    
}



-(void)initLocation
{
//    _locService = [[BMKLocationService alloc]init];
////    
//    [_locService startUserLocationService];
    
    latitude=[YXLocationManage shareManager].coordinate.latitude;
    longitude=[YXLocationManage shareManager].coordinate.longitude;
    NSLog(@"%f-----%f",latitude,longitude);
    [self addRefreshing];
   
}

//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:YES];
//    // 此处记得不用的时候需要置nil，否则影响内存的释放
//   
//    _locService.delegate=self;
//    self.navigationController.navigationBarHidden=NO;
// }
//
//-(void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:YES];
//    
//    _locService.delegate = nil;
//    
//}
//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
//{
//    if (!userLocation.updating) {
//        [_locService stopUserLocationService];
//    }
//    latitude=userLocation.location.coordinate.latitude;
//    longitude=userLocation.location.coordinate.longitude;
//    [self addRefreshing];
//}

-(void)sendWith:(NSString *)url dict:(NSDictionary *)dict
{
     __weak typeof(self)weakSelf =self;

    [self setProgressHud];
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
       
       NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
       NSLog(@"贾玉川%@",dict);
       if ([dict[@"state"]intValue]==1) {
           [_hud hide:YES];
          
           NSMutableArray *arr=[[NSMutableArray alloc]init];
           arr=dict[@"data"];
           for (id obj in arr) {
               DriveModel *Dmodel=[[DriveModel alloc]init];
               [Dmodel setValuesForKeysWithDictionary:obj];

            [weakSelf.baseArr addObject:Dmodel];
        }
       }else {
         
          [self.tableView.header endRefreshing];
           [self.tableView.footer endRefreshing];
          [_hud hide:YES];
        
          [[LXAlterView sharedMyTools]createTishi:@"刷新失败"];
       }
    
      
       [self.tableView addLegendFooterWithRefreshingBlock:^{
           
           
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               NSLog(@"++++++");
               weakSelf.page=weakSelf.page+1;
               NSString *url=[GetHomePageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
               NSDictionary *dict=nil;
               
               dict=@{@"longitude":@(longitude),@"latitude":@(latitude),@"city":[[WLSingletonClass defaultWLSingleton]wlCityId],@"page":@(weakSelf.page)};
               [weakSelf sendWith:url dict:dict];
               NSLog(@"%@",dict);
           });
           
       }];
    
      
       [self.tableView reloadData];
       [self.tableView.header endRefreshing];
       [self.tableView.footer endRefreshing];
       
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      [self.tableView.header endRefreshing];
       [self.tableView.footer endRefreshing];
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


-(void)initView
{
    
    
//   hearderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth,245)];
//   // hearderView.backgroundColor=[UIColor redColor];
//    hearderView.backgroundColor = [UIColor colorWithRed:221 /255.0 green:230/255.0 blue:235/255.0 alpha:1.0];
//    NSArray *arr = [NSArray  array];
//    arr = [NSArray arrayWithObjects:@"banner1",@"banner2",@"banner3", nil];
//    
//    //    NSMutableArray *arr = [NSMutableArray  array];
//    //    for (int i=0; i<_adArray.count; i++){
//    //        LXAdvertModel *model=[_adArray objectAtIndex:i];
//    //        NSString *imageUrl=[NSString stringWithFormat:@"%@%@",WLHTTP,model.src];
//    //        [arr addObject:imageUrl];
//    //        if (_bannerView != nil)
//    //        {
//    //            [_bannerView removeFromSuperview];
//    //        }
//    _bannerView = [[YXBannerView alloc] initWithFrameRect:CGRectMake(0,0, windowContentWidth, 150) ImageArray:arr];
//    _bannerView.delegate = self;
//    [hearderView addSubview:_bannerView];
//    [self.view addSubview:hearderView];
    midelView=[[UIView alloc]initWithFrame:CGRectMake(0, 10, windowContentWidth, 90)];
    midelView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:midelView];
   // [hearderView addSubview:midelView];
    UIButton *cityBtn=[YXTools allocButton:nil textColor:nil nom_bg:[UIImage imageNamed:@"定位"] hei_bg:nil frame:CGRectMake(15, 12.5, 14, 18)];
    [midelView addSubview:cityBtn];
    NSString *str;
    if ([CLLocationManager authorizationStatus] !=  kCLAuthorizationStatusAuthorized && [CLLocationManager authorizationStatus] !=  kCLAuthorizationStatusAuthorizedWhenInUse) {
        str=@"郑州";
    }else {
        str=[[WLSingletonClass defaultWLSingleton]wlCityName];
        
    }
    
    
    cityLabel=[YXTools allocLabel:str font:systemFont(20) textColor:[UIColor blackColor]frame:CGRectMake(ViewRight(cityBtn)+8, 12.5, 120, 20) textAlignment:NSTextAlignmentLeft];
        [midelView addSubview:cityLabel];
    
   
    UIButton *clickBtn1=[YXTools allocButton:nil textColor:nil nom_bg:nil hei_bg:nil frame:CGRectMake(0, 0, 120, 40)];
    [clickBtn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    clickBtn1.tag=101;
    [midelView addSubview:clickBtn1];
    UIButton *arriveBtn=[YXTools allocButton:nil textColor:nil nom_bg:[UIImage imageNamed:@"tips"] hei_bg:nil frame:CGRectMake(windowContentWidth-45, 12.5, 21, 20)];
    
    [midelView addSubview:arriveBtn];
    UIButton *ClickBtn2=[YXTools allocButton:nil textColor:nil nom_bg:nil hei_bg:nil frame:CGRectMake(windowContentWidth-80, 0, windowContentWidth, 40)];
    [ClickBtn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    ClickBtn2.tag=102;
    [midelView addSubview:ClickBtn2];
    //self.chooseViewY=
    UIView *padView=[[UIView alloc]initWithFrame:CGRectMake(0, 40, windowContentWidth, 10)];
    padView.backgroundColor=BgViewColor;
    [midelView addSubview:padView];
    self.chooseView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, windowContentWidth, 40)];
    
    
    self.chooseView.backgroundColor = [UIColor whiteColor];
    
    
    NSArray * chooseTitleArr = @[@"按距离", @"按热度"];
    
    for (int i = 0; i < chooseTitleArr.count; i++) {
        UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i==0) {
            but.frame = CGRectMake(80, 0, 56, ViewHeight(self.chooseView));
            [but setTitle:[chooseTitleArr objectAtIndex:i] forState:UIControlStateNormal];
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [but addTarget:self action:@selector(chooseBut:) forControlEvents:UIControlEventTouchUpInside];
            but.backgroundColor = [UIColor whiteColor];
            [but setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            self.tempBut = but;
        }else if(i==1){
            but.frame = CGRectMake(ViewWidth(self.chooseView)-80-56, 0, 56, ViewHeight(self.chooseView));
            [but setTitle:[chooseTitleArr objectAtIndex:i] forState:UIControlStateNormal];
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [but addTarget:self action:@selector(chooseBut:) forControlEvents:UIControlEventTouchUpInside];
            but.backgroundColor = [UIColor whiteColor];
        }
        [self.chooseView addSubview:but];
      
    }
    chooessLine = [[UIView alloc] initWithFrame:CGRectMake(80, 40 - 2.5, 56, 2)];
    chooessLine.backgroundColor = [UIColor orangeColor];
    UIView *botomLine=[[UIView alloc]initWithFrame:CGRectMake(0, 40-1, windowContentWidth, 1)];
    botomLine.backgroundColor=bordColor;
    [self.chooseView addSubview:chooessLine];
    [self.chooseView addSubview:botomLine];
    
    [midelView addSubview:self.chooseView];
    hView=midelView;
  
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,ViewBelow(midelView), windowContentWidth, windowContentHeight-64-ViewBelow(midelView))style:UITableViewStylePlain];
        
        _tableView.separatorStyle =  UITableViewCellStyleDefault;
         self.tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.1)];
        if ([[[UIDevice currentDevice]systemVersion]floatValue]<8.0) {
             self.tableView.contentInset=UIEdgeInsetsMake(-23,0,0,0);
        }
        
        
        [_tableView reloadData];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=[UIColor colorWithRed:221 /255.0 green:230/255.0 blue:235/255.0 alpha:1.0];
        //_tableView.backgroundColor=[UIColor blueColor];
        [self.view addSubview:_tableView];
    }
    

}

/**
 *   加载刷新控件
 */
- (void)addRefreshing {
    NSMutableArray *imageAray=[NSMutableArray array];
    for (int i=0; i<2; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"单独-logo%d.png", i+2]];
        [imageAray addObject:image];
    }
    //-----------下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    
    __weak JYCSelfDriveEatViewController * weakSelf = self;
    [self.tableView addGifHeaderWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           // NSLog(@"**********");
            [weakSelf.baseArr removeAllObjects];
            NSString *url=[GetHomePageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dict=nil;
            
            if (isHot==NO) {
                weakSelf.page=1;
            dict=@{@"longitude":@(longitude),@"latitude":@(latitude),@"city":[[WLSingletonClass defaultWLSingleton]wlCityId],@"page":@(weakSelf.page),@"by":@"distance"};
            }else if(isHot==YES)
            {
                weakSelf.page=1;
            dict=@{@"longitude":@(longitude),@"latitude":@(latitude),@"city":[[WLSingletonClass defaultWLSingleton]wlCityId],@"page":@(weakSelf.page),@"by":@"mon_sales"};
            }
            
            [weakSelf sendWith:url dict:dict];
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



- (void)chooseBut:(UIButton *)button{
    if (self.tempBut==button) {
        return;
    }
    
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        chooessLine.frame = CGRectMake(ViewX(button), ViewHeight(self.chooseView) - 2.5, ViewWidth(button), 2);
    } completion:nil];
    if (![button isEqual:self.tempBut]){
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.tempBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    self.tempBut = button;
    if ([button.currentTitle isEqualToString:@"按距离"]) {
        isHot=NO;
       [self.tableView.gifHeader beginRefreshing];
      
      
    }else if([button.currentTitle isEqualToString:@"按热度"])
    {
        isHot=YES;
       [self.tableView.gifHeader beginRefreshing];  
 
    }
}


-(void)btnClick:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    if (btn.tag==101) {
        ZFJChooseCityVC * chooseCityVC = [[ZFJChooseCityVC alloc] init];
        chooseCityVC.dontNeedreServe = YES;
        [chooseCityVC selectCity:^(NSString *cityName, NSString *cityId) {
            NSLog(@"%@----%@", cityName, cityId);
            
            cityLabel.text=[NSString stringWithFormat:@"%@",cityName];
            NSString *url=[GetHomePageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dict=nil;
            self.page=1;
            dict=@{@"longitude":@(longitude),@"latitude":@(latitude),@"city":cityId,@"page":@(self.page)};
            [self sendWith:url dict:dict];

            
        }];
    chooseCityVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:chooseCityVC animated:YES completion:NULL];

    }else if(btn.tag==102)
    {
        
        JYCPositionVC *VC=[[JYCPositionVC alloc]init];
               
        VC.annotationArr=self.baseArr;
        VC.Popblock=^(NSString *str)
        {
            self.type=str;
            
            [self refresh];
        };
        [self.navigationController pushViewController:VC animated:YES];
        
    }
}
-(void)refresh
{
    if ([self.type isEqualToString:@"2"]) {
        UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        searchBtn.frame=CGRectMake(0, 0, 23, 23);
        [searchBtn setImage:[UIImage imageNamed:@"tips"] forState:UIControlStateNormal];
        
        
        [searchBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        searchBtn.tag=102;
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:searchBtn];
        hearderView.hidden=YES;
        self.chooseView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, windowContentWidth, 40)];
        self.chooseView.backgroundColor = [UIColor whiteColor];
        NSArray * chooseTitleArr = @[@"按距离", @"按热度"];
        
        for (int i = 0; i < chooseTitleArr.count; i++) {
            UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
            if (i==0) {
                but.frame = CGRectMake(80, 0, 56, ViewHeight(self.chooseView));
                [but setTitle:[chooseTitleArr objectAtIndex:i] forState:UIControlStateNormal];
                [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [but addTarget:self action:@selector(chooseBut:) forControlEvents:UIControlEventTouchUpInside];
                but.backgroundColor = [UIColor whiteColor];
                [but setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                self.tempBut = but;
            }else if(i==1){
                but.frame = CGRectMake(ViewWidth(self.chooseView)-80-56, 0, 56, ViewHeight(self.chooseView));
                [but setTitle:[chooseTitleArr objectAtIndex:i] forState:UIControlStateNormal];
                [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [but addTarget:self action:@selector(chooseBut:) forControlEvents:UIControlEventTouchUpInside];
                but.backgroundColor = [UIColor whiteColor];
            }
            [self.chooseView addSubview:but];
            
          
        }
        chooessLine = [[UIView alloc] initWithFrame:CGRectMake(80, 40 - 2.5, 56, 2)];
        chooessLine.backgroundColor = [UIColor orangeColor];
        UIView *botomLine=[[UIView alloc]initWithFrame:CGRectMake(0, 40-1, windowContentWidth, 1)];
        botomLine.backgroundColor=bordColor;
        [self.chooseView addSubview:chooessLine];
        [self.chooseView addSubview:botomLine];
        [self.view addSubview:self.chooseView];
        hView=self.chooseView;
        [_tableView setFrame:CGRectMake(0,40, windowContentWidth, windowContentHeight-64-40)];
    }

}
-(void)searchBtnClick
{
  //  JYCselfEatOrderVC *jyc=[[JYCselfEatOrderVC alloc]init];
   // [self.navigationController pushViewController:jyc animated:YES];
    
    //JYCRestauantVC *VC=[[JYCRestauantVC alloc]init];
//VC.title=@"123";
    //[self.navigationController pushViewController:VC animated:YES];
    
}
#pragma mark ---- TableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    
    
    return hView;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.baseArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

 
   // static NSString *cellID = @"cellID";
    NSString *cellID2= [NSString stringWithFormat:@"CellS%ldC%ld", (long)indexPath.section, (long)indexPath.row];
   
    JYCDriveCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
    if (cell == nil) {
        cell = [[JYCDriveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    DriveModel *model=[[DriveModel alloc]init];
    model=self.baseArr[indexPath.row];
    cell.model=model;
    return cell;
    
}
#pragma mark ---- TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //[tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    DriveModel *model=[[DriveModel alloc]init];
    model=self.baseArr[indexPath.row];
    
    JYCRestauantVC *VC=[[JYCRestauantVC alloc]init];
    VC.title=model.partner_shop_name;
    VC.model=model;
    VC.type=1;
    [self.navigationController pushViewController:VC animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return ViewHeight(cell);
}


#pragma mark ---- scrollViewDelegate



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

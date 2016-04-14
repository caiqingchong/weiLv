//
//  ZFJCallStewardVC.m
//  WelLv
//
//  Created by 张发杰 on 15/4/17.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJCallStewardVC.h"
#import "ZFJStewardCell.h"
#import "LXGuanJiaModel.h"
#import "XCLoadMsg.h"
#import "LXGuanJiaTableViewCell.h"
#import "YXHouseDetailViewController.h"
#import "LXGetCityIDTool.h"
@interface ZFJCallStewardVC ()<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>

{
    int _offset;//偏移量
    int _currentPage;
    int _totalPage;
    int _chooseBtn;//1案例数，2评级
    NSString *_gender;//1男，2女
    
    BOOL _isOrder_count;//按案例数筛选
    BOOL _isLevel;//按评分筛选
    
    NSString *_order_count;
    NSString *_level;
}

@property (nonatomic, strong) UITableView *stewardTabelView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, strong) UIView * chooseView;


@property (nonatomic, strong) UIView *chooesSexView;

@property (nonatomic, strong) UIButton * tempBut;


@property (nonatomic, assign) BOOL isShou;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIButton *nanBtn;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *nvBtn;
@property (nonatomic, strong) UIView *blurView;

@property (nonatomic, assign) NSInteger pageCount;//页数

@property (nonatomic, strong) NSString *chooseSex;//性别

@property (nonatomic, strong) NSString *gradeStr;//评分；

@property (nonatomic, strong) NSString *caseCount;//案例





/////
@property (nonatomic, strong) NSMutableArray *keeperAraay;

@property (nonatomic, strong) UIView *collBlurView;

@property (nonatomic, strong) UIView * collView;

@property (nonatomic, strong) NSIndexPath * selectIndexPath;


@end

@implementation ZFJCallStewardVC

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

- (NSMutableArray *)keeperAraay
{
    if (_keeperAraay == nil) {
        self.keeperAraay = [NSMutableArray array];
    }
    return _keeperAraay;
}

- (void)addChooesView
{
    self.chooseView=[[UIView alloc] init];
    self.chooseView.frame=CGRectMake(0, 0, windowContentWidth, 44);
    self.chooseView.backgroundColor=[UIColor whiteColor];
    
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, 43.5, windowContentWidth, 0.5)];
    line.backgroundColor=TableLineColor;
    [self.chooseView addSubview:line];
    
    for (int i=1; i<3; i++)
    {
        UIView *line1=[[UIView alloc] initWithFrame:CGRectMake(windowContentWidth/3*i, 7, 0.5, 30)];
        line1.backgroundColor=[UIColor orangeColor];
        [self.chooseView addSubview:line1];
    }
    
    NSArray *nameArray=[NSArray arrayWithObjects:@"案例",@"评分",@"全部", nil];
    for (int i=0; i<3; i++)
    {
        if (i==2)
        {
            UIImageView *litileImage=[[UIImageView alloc] init];
            litileImage.frame=CGRectMake(((windowContentWidth/3)-20)+windowContentWidth/3*i, 30, 5, 5);
            litileImage.image=[UIImage imageNamed:@"矩形-3.png"];
            [self.chooseView addSubview:litileImage];
        }
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake(windowContentWidth/3*i, 7, windowContentWidth/3-1, 30);
        [btn setTitle:[nameArray objectAtIndex:i] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=i+10;
        [self.chooseView addSubview:btn];
        
        
    }
    [self.view addSubview:self.chooseView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"管家列表";
     _chooseBtn=0;
    _offset=0;
    _currentPage=1;
    _isLevel=NO;
    _isOrder_count=NO;
    _order_count=@"desc";
    _level=@"desc";
    _gender=@"";
    
    [self addTableView];
    if ([self judgeString:self.admin_id]) {
        [self sendRequest:nil aUrl:[NSString stringWithFormat:@"%@/%@",M_DETAIL_VC_HOUSE_KEEPER_LIST_URL, self.admin_id] aTag:1];
//        self.stewardTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, ControllerViewHeight) ];
//        self.stewardTabelView.dataSource = self;
//        self.stewardTabelView.delegate = self;
//        self.stewardTabelView.tableFooterView = [[UIView alloc] init];
//        [self.view addSubview:_stewardTabelView];
    } else {
        //[self addRefresh];
        NSDictionary * parameterDic =@{@"offset":@"0",
                                       @"limit":@"20",
                                       @"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
        DLog("下拉刷新控件 parameter = %@",parameterDic);
        [self sendRequest:parameterDic aUrl:getHouseListUrl aTag:1];
    }
    
    //添加咨询客服的事件
    [self addRightOfItem];
    
    
}

#pragma mark **************添加右咨询客服 Item***********
-(void)addRightOfItem{
    

    //右边咨询客服 Item
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"咨询客服" style:UIBarButtonItemStylePlain target:self action:@selector(referAction:)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(240/255.) green:(145/255.) blue:(40/255.) alpha:1];
    
}

#pragma  mark **********咨询客服按钮关联事件********
- (void)referAction:(UIBarButtonItem *)item{
    //    NSLog(@"开始咨询客服");
    NSString *mobileStr = [NSString stringWithFormat:@"tel:%@",self.admin_Mobile];
    NSURL *url = [NSURL URLWithString:mobileStr];
    [[UIApplication sharedApplication] openURL:url];
    
}


#pragma mark --- 加载tabelView 
- (void)addTableView {
    self.stewardTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, ControllerViewHeight) ];
    self.stewardTabelView.dataSource = self;
    self.stewardTabelView.delegate = self;
    self.stewardTabelView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_stewardTabelView];
}

#pragma mark 下拉刷新和加载更多

- (void)addRefresh {
    NSMutableArray *imageAray=[NSMutableArray array];
    for (int i=0; i<2; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"单独-logo%d.png", i+2]];
        [imageAray addObject:image];
    }
    //-----------下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [_stewardTabelView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置普通状态的动画图片
    [_stewardTabelView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [_stewardTabelView.gifHeader setImages:imageAray forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [_stewardTabelView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateRefreshing];
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
    // 马上进入刷新状态
    [_stewardTabelView.gifHeader beginRefreshing];
    
    //----------上拉加载更多
    [_stewardTabelView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadLastData)];
    if ([_stewardTabelView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_stewardTabelView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_stewardTabelView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_stewardTabelView setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)loadNewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _currentPage=1;
        _offset=0;
        NSDictionary * parameterDic =@{@"offset":@"0",
                                       @"limit":@"20",
                                       @"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
        DLog("下拉刷新控件 parameter = %@",parameterDic);
        [self sendRequest:parameterDic aUrl:getHouseListUrl aTag:1];
//        // 拿到当前的下拉刷新控件，结束刷新状态
//        [self.stewardTabelView.header endRefreshing];
    });
}


-(void)loadLastData {
    
    _offset=_currentPage*[@"10" intValue];
    NSString *offset1=[NSString stringWithFormat:@"%ld",(long)_offset];
    NSDictionary *parameterDic = @{@"offset":offset1,
                                   @"limit":@"10",
                                   @"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
    DLog("parameter=%@",parameterDic);
    [self sendRequest:parameterDic aUrl:getHouseListUrl aTag:3];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 拿到当前的上拉刷新控件，变为没有更多数据的状态 [_tableView.footer noticeNoMoreData]
        [_stewardTabelView.footer endRefreshing];
    });
    _currentPage++;
}

#pragma mark --- 获取日期间隔（计算管家年龄）
-(NSString *)getAge:(NSString *)birth_date
{
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //创建了两个日期对象
    NSDate *date1=[dateFormatter dateFromString:birth_date];
    NSDate *date2=[NSDate date];
    //NSDate *date=[NSDate date];
    //NSString *curdate=[dateFormatter stringFromDate:date];
    
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval time=[date2 timeIntervalSinceDate:date1];
    
    int days=((int)time)/(3600*24);
    int age = days/365;
    NSString *ageStr=[NSString stringWithFormat:@"%d",age];
    return ageStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mack --- tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.keeperAraay.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_stewardTabelView)
    {
        static NSString *CellIdentifier1 = @"cellIdentifier1";
        LXGuanJiaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            cell = [[LXGuanJiaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
            //单元格的选择风格，选择时单元格不出现蓝条
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        LXGuanJiaModel *model=[_keeperAraay objectAtIndex:indexPath.row];
        //[cell setIntroductionText:model.infoStr];
        [cell returnTextCGRectText:model.infoStr textFont:13];
        cell.item=model;
        
        return cell;
    }
    return nil;
}
- (void)callSteward:(UIButton *)button
{
    LXGuanJiaModel * model = [self.keeperAraay objectAtIndex:button.tag - 100];
    DLog(@"*******管家******%@", model.phone);
    NSString * telString = [NSString stringWithFormat:@"tel:%@", model.phone];
    NSURL * telUrl = [NSURL URLWithString:telString];
    [[UIApplication sharedApplication] openURL:telUrl];
    
}
#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _stewardTabelView) {
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        return ViewHeight(cell);
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectIndexPath = indexPath;
    if (self.collBlurView == nil) {
        self.collBlurView = [[UIView alloc] initWithFrame:self.view.bounds];
        self.collBlurView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.6];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        [_collBlurView addGestureRecognizer:tap];
        //self.collView = [[UIView alloc] initWithFrame:CGRectMake(50, self.view.frame.size.height /2 - 60, windowContentWidth - 100, 120)];
        //self.collView.backgroundColor = [UIColor whiteColor];
       
        UIButton * collBut = [UIButton buttonWithType:UIButtonTypeCustom];
        collBut.frame = CGRectMake(10, self.collBlurView.frame.size.height - 160, self.collBlurView.frame.size.width - 20, 40);
        collBut.backgroundColor = [UIColor colorWithRed:63 / 255.0 green:181/ 255.0 blue:136/255.0 alpha:1.0];
        collBut.layer.cornerRadius = 5;
        collBut.layer.masksToBounds = YES;
        [collBut setTitle:@"拨打电话" forState:UIControlStateNormal];
        //[collBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

         [collBut addTarget:self action:@selector(collBut:) forControlEvents:UIControlEventTouchUpInside];
        [self.collBlurView addSubview:collBut];
        
        UIButton * addBut = [UIButton buttonWithType:UIButtonTypeCustom];
        addBut.frame = CGRectMake(10, self.collBlurView.frame.size.height - 110, self.collBlurView.frame.size.width - 20, 40);
        addBut.layer.cornerRadius = 5;
        addBut.layer.masksToBounds = YES;
        addBut.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:150 / 255.0 blue:0 alpha:1.0];
        [addBut setTitle:@"绑定管家" forState:UIControlStateNormal];
        //[addBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        [addBut addTarget:self action:@selector(addBut:) forControlEvents:UIControlEventTouchUpInside];
        [self.collBlurView addSubview:addBut];
        
        UIButton * cancelBut = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBut.frame = CGRectMake(10, self.collBlurView.frame.size.height - 60, self.collBlurView.frame.size.width - 20, 40);
        cancelBut.layer.cornerRadius = 5;
        cancelBut.layer.masksToBounds = YES;

        [cancelBut setTitle:@"取消" forState:UIControlStateNormal];
       // [cancelBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBut addTarget:self action:@selector(cancelBut:) forControlEvents:UIControlEventTouchUpInside];
        cancelBut.backgroundColor = [UIColor colorWithRed:166/255.0 green:166/ 255.0 blue:166 / 255.0 alpha:1.0];
        [self.collBlurView addSubview:cancelBut];
        
        //[self.collBlurView addSubview:self.collView];
        [self.view addSubview:_collBlurView];
    } else {
        self.collBlurView.hidden = NO;
    }
    
    
    /*
    UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拨打电话",@"绑定管家", nil];
    actionsheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionsheet showInView:self.view];
    */
    
    
    
    
    
    //if ([LXUserTool alloc].getUid == nil) {
//        LXGuanJiaModel * model = [self.keeperAraay objectAtIndex:indexPath.row];
//        DLog(@"*******管家******%@", model.phone);
//        NSString * telString = [NSString stringWithFormat:@"tel:%@", model.phone];
//        NSURL * telUrl = [NSURL URLWithString:telString];
//        [[UIApplication sharedApplication] openURL:telUrl];
   // } else {
      //  self.selectIndexPath = indexPath;
//        if (self.collBlurView == nil) {
//            self.collBlurView = [[UIView alloc] initWithFrame:self.view.bounds];
//            self.collBlurView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.6];
//            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
//            [_collBlurView addGestureRecognizer:tap];
//            self.collView = [[UIView alloc] initWithFrame:CGRectMake(50, self.view.frame.size.height /2 - 60, windowContentWidth - 100, 120)];
//            self.collView.backgroundColor = [UIColor whiteColor];
//            UIButton * addBut = [UIButton buttonWithType:UIButtonTypeCustom];
//            addBut.frame = CGRectMake(10, 15, self.collView.frame.size.width - 20, 30);
//            addBut.backgroundColor = [UIColor orangeColor];
//            [self.collView addSubview:addBut];
//            UIButton * collBut = [UIButton buttonWithType:UIButtonTypeCustom];
//            collBut.frame = CGRectMake(10, 15 + 30 + 20, self.collView.frame.size.width - 20, 30);
//            collBut.backgroundColor = [UIColor orangeColor];
//            [self.collView addSubview:collBut];
//            [self.collBlurView addSubview:self.collView];
//
//            
//            [self.view addSubview:_collBlurView];
//        } else {
//            self.blurView.hidden = NO;
//        }
//        
//        UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拨打电话",@"绑定管家", nil];
//        
//        [actionsheet showInView:self.view];
//        
   
 //   }
    
    
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    self.collBlurView.hidden = YES;
}

- (void)collBut:(UIButton *)button
{
    DLog(@"拨打电话");
    LXGuanJiaModel * model = [self.keeperAraay objectAtIndex:self.selectIndexPath.row];
    DLog(@"*******管家******%@", model.phone);
    NSString * telString = [NSString stringWithFormat:@"tel:%@", model.phone];
    NSURL * telUrl = [NSURL URLWithString:telString];
    [[UIApplication sharedApplication] openURL:telUrl];

}
- (void)addBut:(UIButton *)button
{
    DLog(@"绑定管家");
    LXGuanJiaModel *guanjiaModel=[_keeperAraay objectAtIndex:self.selectIndexPath.row];
    YXHouseDetailViewController *houseKeepervc=[[YXHouseDetailViewController alloc] init];
    houseKeepervc.houseID=guanjiaModel.assistant_id;
    houseKeepervc.houseName=guanjiaModel.nameStr;
    DLog(@"id === %@", guanjiaModel.assistant_id);
    if ([[[LXUserTool alloc] getKeeper] intValue] != 0) {
        houseKeepervc.isNeedR = NO;
    } else {
        houseKeepervc.isNeedR = YES;
    }
    
    
    [self.navigationController pushViewController:houseKeepervc animated:YES];
}
- (void)cancelBut:(UIButton *)button
{
    self.collBlurView.hidden = YES;
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    DLog(@"%ld", buttonIndex);
    if (buttonIndex == 1) {
        DLog(@"绑定管家");
        //[self bangdingGuanjia];
        LXGuanJiaModel *guanjiaModel=[_keeperAraay objectAtIndex:self.selectIndexPath.row];
        YXHouseDetailViewController *houseKeepervc=[[YXHouseDetailViewController alloc] init];
        houseKeepervc.houseID=guanjiaModel.keeperID;
        houseKeepervc.houseName=guanjiaModel.nameStr;
        [self.navigationController pushViewController:houseKeepervc animated:YES];
        
    } else if (buttonIndex == 0){
        
        DLog(@"拨打电话");
        LXGuanJiaModel * model = [self.keeperAraay objectAtIndex:self.selectIndexPath.row];
        DLog(@"*******管家******%@", model.phone);
        NSString * telString = [NSString stringWithFormat:@"tel:%@", model.phone];
        NSURL * telUrl = [NSURL URLWithString:telString];
        [[UIApplication sharedApplication] openURL:telUrl];

    }
}

-(void)bangdingGuanjia
{
    NSString *UserId = [[LXUserTool alloc] getUid];
    LXGuanJiaModel * model = [self.keeperAraay objectAtIndex:self.selectIndexPath.row];

    NSDictionary *parm =@{@"member_id":UserId,@"assistant_id":model.keeperID};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:bindHouseUrl parameters:parm success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         DLog(@"++++++++++++%@", dic);
         NSString *statu = [dic objectForKey:@"status"];
         NSString *msg = [dic objectForKey:@"msg"];
         DLog(@"----------%@",msg);
         DLog(@"----------%@",statu);
         //if ([msg isEqualToString:@"操作成功！"]) {
         
         if ([[dic objectForKey:@"status"] isEqual:@"1"])
         {
             [[LXAlterView sharedMyTools] createTishi:msg];
             [[NSUserDefaults standardUserDefaults] setObject:model.keeperID forKey:@"assistant_id"];
             [[NSUserDefaults standardUserDefaults] synchronize];

         }
         else if(msg)
         {
             [[LXAlterView sharedMyTools] createTishi:msg];
         }
         
     }failure:^(AFHTTPRequestOperation *operation,NSError *error)
     {
         [[LXAlterView sharedMyTools] createTishi:@"网洛请求失败"];
     }];
}


- (void)tapView:(UITapGestureRecognizer *)tap
{
    self.blurView.hidden = YES;
    self.collBlurView.hidden = YES;
}



-(void)topBtnClick:(UIButton *)btn
{
    [self.tempBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.tempBut = btn;
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];

    switch (btn.tag) {
        case 10:
        {
            //按案例数排序
            _chooseBtn=1;
            if (_isOrder_count==NO)
            {
                _isOrder_count=YES;
                _order_count=@"asc";
                _level=@"asc";
                NSDictionary *parameterDic=@{@"offset":@"0",@"limit":@"10",@"order_count":_order_count,@"level":_level,@"gender":_gender,@"region_id":[LXGetCityIDTool sharedMyTools].city_regionID};
                [self sendRequest:parameterDic aUrl:getHouseListUrl aTag:1];
                
            }else
            {
                _isOrder_count=NO;
                _order_count=@"desc";
                _level=@"desc";
                NSDictionary *parameterDic=@{@"offset":@"0",@"limit":@"10",@"order_count":_order_count,@"level":_level,@"gender":_gender,@"region_id":[LXGetCityIDTool sharedMyTools].city_regionID};
                [self sendRequest:parameterDic aUrl:getHouseListUrl aTag:1];
            }
            
            DLog(@"按案例数排序");
            

        }
            break;
            
        case 11:
        {
            //按评分排序
            DLog(@"按评分排序");
            _chooseBtn=2;
            if (_isLevel==NO)
            {
                _isLevel=YES;
                _order_count=@"asc";
                _level=@"asc";
                NSDictionary *parameterDic=@{@"offset":@"0",@"limit":@"10",@"order_count":_order_count,@"level":_level,@"gender":_gender,@"region_id":[LXGetCityIDTool sharedMyTools].city_regionID};
                [self sendRequest:parameterDic aUrl:getHouseListUrl aTag:1];
                
            }else
            {
                _isLevel=NO;
                _order_count=@"desc";
                _level=@"desc";
                NSDictionary *parameterDic=@{@"offset":@"0",@"limit":@"10",@"order_count":_order_count,@"level":_level,@"gender":_gender,@"region_id":[LXGetCityIDTool sharedMyTools].city_regionID};
                [self sendRequest:parameterDic aUrl:getHouseListUrl aTag:1];
            }

        }
            break;
            
        case 12:
        {
            
            if (self.chooesSexView == nil) {
                 NSArray * sexArr = @[@"全部",@"女", @"男"];
                 UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenChooesView:)];
                
                self.chooesSexView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, windowContentWidth, sexArr.count * 40)];
                self.blurView = [[UIView alloc] initWithFrame:CGRectMake(0, 44 + 90, windowContentWidth, self.view.frame.size.height - 44 - 90)];
                self.blurView.backgroundColor = [UIColor grayColor];
                self.blurView.alpha = 0.5;
                [self.blurView addGestureRecognizer:tapGesture];
                [self.view addSubview:_blurView];
                
                
                self.chooesSexView.backgroundColor = [UIColor whiteColor];
               
                for (int i = 0; i < sexArr.count; i++) {
                    UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
                    but.frame = CGRectMake(0, 40 * i, windowContentWidth, 40);
                    [but setTitle:[sexArr objectAtIndex:i] forState:UIControlStateNormal];
                    [but addTarget:self action:@selector(chooesSex:) forControlEvents:UIControlEventTouchUpInside];
                    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [self.chooesSexView addSubview:but];
                    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 40 * i + 40, windowContentWidth, 0.5)];
                    line.backgroundColor = bordColor;
                    [_chooesSexView addSubview:line];
                }
                
                [self.view addSubview:_chooesSexView];
            } else if (self.chooesSexView.hidden == NO){
                self.chooesSexView.hidden = YES;
                self.blurView.hidden = YES;
            }else {
                self.chooesSexView.hidden = NO;
                self.blurView.hidden = NO;
            }
            
        }
            break;
            
        default:
            break;
    }
    
    
}

- (void)hiddenChooesView:(UITapGestureRecognizer *)tap
{
    self.chooesSexView.hidden = YES;
    self.blurView.hidden = YES;
}

- (void)chooesSex:(UIButton *)button
{
    if ([button.titleLabel.text isEqualToString:@"男"]) {
        _gender=@"1";
        NSDictionary *parameterDic=@{@"offset":@"0",@"limit":@"50",@"gender":_gender,@"region_id":[LXGetCityIDTool sharedMyTools].city_regionID};
        [self sendRequest:parameterDic aUrl:getHouseListUrl aTag:1];
        DLog(@"选择男");
        
    }else if ([button.titleLabel.text isEqualToString:@"女"]){
        _gender=@"2";
        NSDictionary *parameterDic=@{@"offset":@"0",@"limit":@"50",@"gender":_gender,@"region_id":[LXGetCityIDTool sharedMyTools].city_regionID};
        [self sendRequest:parameterDic aUrl:getHouseListUrl aTag:1];
        DLog(@"选择女");

    }else if ([button.titleLabel.text isEqualToString:@"全部"]){
        _gender=@"";
        NSDictionary *parameterDic=@{@"offset":@"0",@"limit":@"50",@"region_id":[LXGetCityIDTool sharedMyTools].city_regionID};
        [self sendRequest:parameterDic aUrl:getHouseListUrl aTag:1];
        
    }
    self.chooesSexView.hidden = YES;
    self.blurView.hidden = YES;
    
    UIButton * but = (UIButton *)[self.chooseView viewWithTag:12];
    [but setTitle:button.titleLabel.text forState:UIControlStateNormal];
    
    
  
}

- (void)loadData
{
    [_dataArray removeAllObjects];
    NSString *str=[NSString stringWithFormat:@"%@?offset=%ld", getHouseListUrl,self.pageCount];
    DLog(@"%@", str);
    //__weak ZFJCallStewardVC * callStewardVC = self;
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        // DLog(@"获取到的数据为：%@",dict);
        
        NSArray * allArr = [dict objectForKey:@"data"];
        DLog(@"%@", allArr);
        for (NSDictionary * dic in allArr) {
            LXGuanJiaModel *orderModel=[[LXGuanJiaModel alloc] init];
            if ([[dic objectForKey:@"avatar"] isEqual:[NSNull null]]) {
                
            } else {
                orderModel.leftImageUrl = [NSString stringWithFormat:@"%@/%@",WLHTTP, [dic objectForKey:@"avatar"]];
            }
            
            if ([[dic objectForKey:@"name"] isEqual:[NSNull null]]) {
                
            } else {
                orderModel.nameStr=[dic objectForKey:@"name"];
            }
            
            if ([[dic objectForKey:@"address"] isEqual:[NSNull null]]) {
                
            } else {
                //orderModel.gjCityStr=[dic objectForKey:@"address"];
                orderModel.gjCityStr = @" ";
            }
            
            if ([[dic objectForKey:@"order_count"] isEqual:[NSNull null]]) {
                
            } else {
                orderModel.NuberStr= [[dic objectForKey:@"order_count"] intValue];
            }
            
            
            if ([[dic objectForKey:@"level"] isEqual:[NSNull null]]) {
                
            } else {
                orderModel.gradeStr= [dic objectForKey:@"level"];
            }
            
            
            
            if ([[dic objectForKey:@"birth_date"] isEqual:[NSNull null]]) {
                
            } else {
                orderModel.age = [self getAge:[dic objectForKey:@"birth_date"]];
            }
            
            if ([[dic objectForKey:@"horoscope"] isEqual:[NSNull null]]) {
                
            } else {
                orderModel.xingzuo = [dic objectForKey:@"horoscope"];
            }
            
            
            
            if ([[dic objectForKey:@"mobile"] isEqual:[NSNull null]]) {
                
            } else {
                orderModel.phone = [dic objectForKey:@"mobile"];
            }

            
            [self.dataArray addObject:orderModel];
        }
        DLog(@"数据请求 === %@", _dataArray);
        // 刷新表格
        [self.stewardTabelView reloadData];
        
        // 拿到当前的上拉刷新控件，变为没有更多数据的状态 [_tableView.footer noticeNoMoreData]
        [_stewardTabelView.footer endRefreshing];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"发生错误！%@",error);
        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
            [self loadData];
        }];
        
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];

}

- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}

//////////////////

#pragma mark 请求数据-post
-(void)sendRequest:(NSDictionary *)parameters aUrl:(NSString *)url aTag:(NSUInteger)tag
{
    DLog(@"url === %@", url);
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    if (tag==1)
    {
        [_keeperAraay removeAllObjects];
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters
     
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              DLog(@"Success: %@", dic);
              if ([dic isKindOfClass:[NSDictionary class]] && [[dic objectForKey:@"status"] integerValue]==1)
              {
                  
                  NSArray *array=[dic objectForKey:@"data"];
                  if (array.count == 0 && [self judgeString:self.admin_id]) {
                      NSDictionary * parameterDic =@{@"offset":@"0",
                                                     @"limit":@"20",
                                                     @"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
                      [self sendRequest:parameterDic aUrl:getHouseListUrl aTag:1];
                      return;
                  }
                  NSDictionary *dict1=[[NSDictionary alloc] init];
                  NSArray *sellersArray=[NSArray array];
                  for (int i=0; i<array.count; i++) {
                      dict1=[array objectAtIndex:i];
                      LXGuanJiaModel *model=[[LXGuanJiaModel alloc] init];
                      model.leftImageUrl=[NSString stringWithFormat:@"%@/%@",WLHTTP,[dict1 objectForKey:@"avatar"]];
                      model.nameStr=[dict1 objectForKey:@"name"];
                      model.xingzuo=[dict1 objectForKey:@"horoscope"];//星座
                      sellersArray=[dict1 objectForKey:@"sellers"];//管家所属旅行社
                      if (sellersArray.count==0)
                      {
                          model.gjCityStr=nil;
                      }
                      model.NuberStr=[[dict1 objectForKey:@"order_count"] intValue];//订单数，案例数
                      model.gradeStr=[dict1 objectForKey:@"level"];//评分
                      model.sex=[dict1 objectForKey:@"gender"];
                      if ([dict1 objectForKey:@"birth_date"] == nil || [[dict1 objectForKey:@"birth_date"] isEqual:[NSNull null]])
                      {
                          model.age=nil;
                      }else
                      {
                          model.age=[self getAge:[dict1 objectForKey:@"birth_date"]];
                      }
                      
                      if ([[dict1 objectForKey:@"mobile"] isEqual:[NSNull null]]) {
                          
                      } else {
                          model.phone = [dict1 objectForKey:@"mobile"];
                          DLog(@"%@", model.phone);
                      }
                      
                      if ([[dict1 objectForKey:@"advantage"] isEqual:[NSNull null]]) {
            
                      } else {
                          model.infoStr = [dict1 objectForKey:@"advantage"];
                      }

                      model.keeperID=[dict1 objectForKey:@"assistant_id"];
                      model.assistant_id = [dict1 objectForKey:@"assistant_id"];
                      [self.keeperAraay addObject:model];
                      
                  }
                  [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
                  [self.stewardTabelView.header endRefreshing];
                  [self.stewardTabelView reloadData];
                 
              } else {
                  
                  [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
                  [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
                  [self.stewardTabelView reloadData];
                  
              }
              
          
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              DLog(@"Error: %@", error);
              [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
              [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
                  
                  if ([self judgeString:self.admin_id]) {
                      [self sendRequest:nil aUrl:[NSString stringWithFormat:@"%@/%@",M_DETAIL_VC_HOUSE_KEEPER_LIST_URL, self.admin_id] aTag:1];
  
                  } else {
                      NSDictionary * parameterDic =@{@"offset":@"0",
                                                     @"limit":@"20",
                                                     @"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
                      [self sendRequest:parameterDic aUrl:getHouseListUrl aTag:1];
                  }

              }];
              
          }];
    
    
}

//////////////////



- (void)loadDataByGetWay {
    
}





@end

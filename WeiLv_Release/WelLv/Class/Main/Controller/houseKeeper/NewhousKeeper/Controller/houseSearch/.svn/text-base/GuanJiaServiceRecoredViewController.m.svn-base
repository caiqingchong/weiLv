//
//  GuanJiaServiceRecoredViewController.m
//  WelLv
//
//  Created by daihengbin on 16/1/14.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "GuanJiaServiceRecoredViewController.h"
#import "GuanJiaDetailTableViewCell.h"
#import "service_recordModel.h"

@interface GuanJiaServiceRecoredViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UIButton*topButton;
@property (nonatomic,strong)UIScrollView * chooseView1;
@property (nonatomic,strong)UIView * chooseView11;
@property(nonatomic,copy)NSString*category_id;
@property(nonatomic,strong)UIButton *lastButton;//记录上次点击的button
@end

@implementation GuanJiaServiceRecoredViewController
-(NSMutableArray*)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(UIButton*)topButton{
    if (_topButton == nil) {
        _topButton = [UIButton buttonWithType:UIButtonTypeCustom];

        [_topButton setFrame:CGRectMake(windowContentWidth/2-100, 10, 100, 40)];
    
        _topButton.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        label.text = @"服务记录";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:18.f];
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor clearColor];
        [_topButton addSubview:label];
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(90,15, 5, 5)];
        image.image = [UIImage imageNamed:@"矩形-3-副本-2"];
        image.transform = CGAffineTransformMakeRotation(M_PI_4);
        image.tag = 1000;
        [_topButton addSubview:image];
        
    }
    return _topButton;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view .backgroundColor = [UIColor clearColor];
    self.category_id = @"0";
    self.navigationItem.titleView = self.topButton;
    [_topButton addTarget:self action:@selector(downView:) forControlEvents:UIControlEventTouchUpInside];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _page = 1;
    [self createTableView];//创建tableView
    [self addRefreshing];//刷新
}
//-1 门票 －2 游学 －3 机票 －4 邮轮 2 签证 －5新邮轮 －6自驾车 －11 周边游 －12 国内游 －13 出境游 －14港澳台 －15境外参团
-(void)downView:(UIButton*)sender{
    UIImageView *imageView = (UIImageView*)[self.topButton viewWithTag:1000];
    [imageView setImage:[UIImage imageNamed:@"矩形-3"]];
    if(!_chooseView1){
        NSArray * chooseOrderTitle =@[@"\t  全部", @"\t  门票", @"\t  签证", @"\t  邮轮",@"\t  一日游",@"\t  周边游",@"\t  国内游",@"\t  出境游",@"\t  港澳台",@"\t  境外参团",@"\t  游学"];
        self.chooseView1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentHeight, ViewHeight(self.view))];
        self.chooseView11 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentHeight, ViewHeight(self.view))];
        if (ViewHeight(self.view)- 64 < 35*chooseOrderTitle.count) {
            _chooseView1.contentSize = CGSizeMake(windowContentWidth,35*chooseOrderTitle.count+44);
            
        }
        _chooseView1.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
        [_chooseView1 addSubview:_chooseView11];
        [self.view addSubview: _chooseView1];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
        tapGestureRecognizer.cancelsTouchesInView = NO;
        [_chooseView1 addGestureRecognizer:tapGestureRecognizer];
        
        
        for (int i = 0; i < chooseOrderTitle.count; i++) {
            UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
            but.frame = CGRectMake(0, 35 * i , windowContentWidth, 35);
            but.backgroundColor = [UIColor whiteColor];
            [but setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            but.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
            [but setTitle:[chooseOrderTitle objectAtIndex:i] forState:UIControlStateNormal];
            but.tag = i;
            [but addTarget:self action:@selector(chooseOrderType:) forControlEvents:UIControlEventTouchUpInside];
            [_chooseView11 addSubview:but];
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(windowContentWidth-50, 15, 18, 15)];
            image.image = [UIImage imageNamed:@"矩形-34-副本-2"];
            image.tag = 100;
            image.hidden = YES;
            [but addSubview:image];
           
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0 ,ViewHeight(but)-0.5,  windowContentWidth , 0.5)];
            lab.backgroundColor = [UIColor blackColor];//[UIColor groupTableViewBackgroundColor].CGColor;
            [but addSubview:lab];
        }
        _lastButton = (UIButton*)[_chooseView1 viewWithTag:0];
        UIImageView *selectImage = (UIImageView*)[_lastButton viewWithTag:100];
        selectImage.hidden = NO;
        //  _chooseView1.contentSize = CGSizeMake(windowContentWidth, 1000);
    }else{
        if(_chooseView1.hidden == YES){
            _chooseView1.hidden = NO;
        }else if(_chooseView1.hidden == NO){
            _chooseView1.hidden = YES;
            UIImageView *imageView = (UIImageView*)[self.topButton viewWithTag:1000];
            [imageView setImage:[UIImage imageNamed:@"矩形-3-副本-2"]];
        }
    }
}
//添加手势，隐藏下拉菜单
-(void)keyboardHide:(UITapGestureRecognizer *)tap{
    _chooseView1.hidden = YES;
    UIImageView *imageView = (UIImageView*)[self.topButton viewWithTag:1000];
    [imageView setImage:[UIImage imageNamed:@"矩形-3-副本-2"]];
}
//-1 门票 －2 游学 －3 机票 －4 邮轮 2 签证 －5新邮轮 －6自驾车 －11 周边游 －12 国内游 －13 出境游 －14港澳台 －15境外参团
// NSArray * chooseOrderTitle =@[@"\t  全部", @"\t  门票", @"\t  签证", @"\t  邮轮",@"\t  一日游",@"\t  周边游",@"\t  国内游",@"\t  出境游",@"\t  港澳台",@"\t  境外参团",@"\t  游学"];
-(void)chooseOrderType:(UIButton*)button{
    if (_lastButton != button) {
        UIImageView *image = (UIImageView*)[_lastButton viewWithTag:100];
        image.hidden = YES;
        _lastButton = button;
    }
    UIImageView *image = (UIImageView*)[button viewWithTag:100];
    image.hidden = NO;
    for(UIButton *btnn in [_chooseView11 subviews])
        {
            [btnn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.dataArray removeAllObjects];
    switch (button.tag) {
            case 0:
            _chooseView1.hidden = YES;
            self.category_id = @"0";
            [self loadDataWithUrl:GJServiceRecordUrl andPage:0];
            break;
        case 1:
            _chooseView1.hidden = YES;
            self.category_id = @"-1";
            [self loadDataWithUrl:GJServiceRecordUrl andPage:0];
            break;
        case 2:
            _chooseView1.hidden = YES;
            self.category_id = @"2";
            [self loadDataWithUrl:GJServiceRecordUrl andPage:0];
            break;
            
        case 3:
            _chooseView1.hidden = YES;
            self.category_id = @"-5";
            [self loadDataWithUrl:GJServiceRecordUrl andPage:0];
            break;
            
        case 4://一日游
            _chooseView1.hidden = YES;
            self.category_id = @"-11";
            [self loadDataWithUrl:GJServiceRecordUrl andPage:0];

            break;
        case 5://周边游
            _chooseView1.hidden = YES;
            self.category_id = @"-11";
            [self loadDataWithUrl:GJServiceRecordUrl andPage:0];
            break;
        case 6://国内游
            _chooseView1.hidden = YES;
            self.category_id = @"-12";
            [self loadDataWithUrl:GJServiceRecordUrl andPage:0];
            break;
        case 7://出境游
            _chooseView1.hidden = YES;
            self.category_id = @"-13";
            [self loadDataWithUrl:GJServiceRecordUrl andPage:0];
            break;
        case 8://港澳台
            _chooseView1.hidden = YES;
            self.category_id = @"-14";
            [self loadDataWithUrl:GJServiceRecordUrl andPage:0];
            break;
        case 9://境外参团
            _chooseView1.hidden = YES;
            self.category_id = @"-15";
            [self loadDataWithUrl:GJServiceRecordUrl andPage:0];
            break;
        case 10:
            _chooseView1.hidden = YES;
            self.category_id = @"-2";
            [self loadDataWithUrl:GJServiceRecordUrl andPage:0];
            break;
        default:
            break;

    

 }
}
//刷新
-(void)addRefreshing{

    NSMutableArray *imageAray=[NSMutableArray array];
    for (int i=0; i<2; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"单独-logo%d.png", i+2]];
        [imageAray addObject:image];
    }
    //-----------下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    
    __weak GuanJiaServiceRecoredViewController * gjsrvc = self;
    [self.tableview addGifHeaderWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [gjsrvc.dataArray removeAllObjects];
            gjsrvc.page = 0;
            [gjsrvc loadDataWithUrl:GJServiceRecordUrl andPage:1];
            
        });
    }];
    // 设置普通状态的动画图片
    [self.tableview.gifHeader setImages:imageAray forState:MJRefreshHeaderStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self.tableview.gifHeader setImages:imageAray forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self.tableview.gifHeader setImages:imageAray forState:MJRefreshHeaderStateRefreshing];
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
    // 马上进入刷新状态
    [self.tableview.gifHeader beginRefreshing];
    
    
    [self.tableview.footer setState:MJRefreshFooterStateIdle];
    
    [self.tableview addLegendFooterWithRefreshingBlock:^{
     
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            gjsrvc.page = gjsrvc.page + 1;
            DLog(@"%ld",(long)gjsrvc.page);
            
            [gjsrvc loadDataWithUrl:getHouseListUrl andPage:gjsrvc.page];
            [gjsrvc.tableview.footer endRefreshing];
        });
        
    }];
    
    if ([self.tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableview setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableview setLayoutMargins:UIEdgeInsetsZero];
    }

}
//请求数据
-(void)loadDataWithUrl:(NSString*)urlStr andPage:(NSInteger)page{
    //增加视图效果 菊花加载
    [[XCLoadMsg sharedLoadMsg:self]hideAll];
    [[XCLoadMsg sharedLoadMsg:self]showActivityLoading:self.view];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSInteger offsetNum = _page * 10;
    NSString *offsetStr = [NSString stringWithFormat:@"%ld",(long)offsetNum];
    NSDictionary  *parameters = @{@"assistant_id":self.userId,@"offset":offsetStr,@"limit":@"10",@"category_id":self.category_id};
    DLog(@"wwwweee%@",self.category_id);
    //发送请求
    __weak typeof(self)weakSelf =self;
    [manager POST:GJServiceRecordUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
      
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
       // NSLog(@"%@",dic);
        //NSString *code =[NSString stringWithFormat:@"%@",dic[@"status"]] ;
         NSArray *resultArray   = [[dic objectForKey:@"data"]objectForKey:@"orders_all_info"];
        if ([resultArray count]>0 ) {
            if (_page == 0) {
                [weakSelf.dataArray removeAllObjects];
            }
                for (NSDictionary *dic in resultArray) {
                    service_recordModel *serviceRecordModel = [[service_recordModel alloc]init];
                    [serviceRecordModel setValuesForKeysWithDictionary:dic];
                    [weakSelf.dataArray addObject:serviceRecordModel];
                    
                }
              [[XCLoadMsg sharedLoadMsg:self]hideActivityLoading];
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.header endRefreshing];
                [weakSelf.tableview.footer endRefreshing];
         //  [[LXAlterView sharedMyTools]createTishi:[dic valueForKey:@"msg"]];
        }
        else
        {
            
            [weakSelf.tableview.header endRefreshing];
            [weakSelf.tableview.footer endRefreshing];
             weakSelf.tableview.footer.hidden = YES;
            [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
            [[LXAlterView sharedMyTools]createTishi:@"暂无信息"];
            [weakSelf.tableview reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        [weakSelf.tableview.header endRefreshing];
        [weakSelf.tableview.footer endRefreshing];
        [[LXAlterView sharedMyTools]createTishi:@"请求失败,请检查网络!"];
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:self]showErrorMsgInView:self.view evn:^{
        
        [self loadDataWithUrl:GJServiceRecordUrl andPage:0];
            
        }];
      //  [weakSelf.tableview reloadData];
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)createTableView{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64) style:UITableViewStyleGrouped];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    _tableview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableview];

}

#pragma mark - UITableViewDataSource&UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 1;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *identifier = @"detailCell";
        GuanJiaDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[GuanJiaDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        service_recordModel *model = (service_recordModel*)[_dataArray objectAtIndex:indexPath.row];
        cell.serviceRecordModel = model;
        return cell;
    }else{
    static NSString *identifier = @"detailCell1";
    GuanJiaDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[GuanJiaDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    service_recordModel *model = (service_recordModel*)[_dataArray objectAtIndex:indexPath.row];
    cell.serviceRecordModel = model;
    return cell;
 }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;

}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, 15)];
    view.backgroundColor = [UIColor colorWithRed:222/240.0f green:229/240.0f blue:235/240.0f alpha:1];
    return view;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

@end

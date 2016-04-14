//
//  JYCDepositDetailVC.m
//  WelLv
//
//  Created by lyx on 16/1/20.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "JYCDepositDetailVC.h"
#import "DepositModel.h"
#import "JYCDepositDetailCell.h"
@interface JYCDepositDetailVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *rightBtn;
    AFHTTPRequestOperationManager *manager;
    UIView *backgroundView;
    BOOL isChange;
    UIButton *lastStatusBtn;
    UIButton *lastMonthBtn;
    UIButton *leftTimeBtn;
    UIButton *rightTimeBtn;
    UIDatePicker *picker;
    UIDatePicker *picker2;
    UIView *viewBtn;
    UIView *viewBtn2;
    NSString *rightStr;
    NSString *leftStr;
    UIImageView *igView;
   //判断当前是否是加载更多
    BOOL isloadMore;
    NSInteger count;
    
}
@property(nonatomic,strong)NSMutableArray *baseArr;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)NSString *endDate;
@property(nonatomic,copy)NSString *start;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,assign)NSInteger page;
@end

@implementation JYCDepositDetailVC
- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"提现明细";
    self.status=@"-1";
    self.page=1;
    //计算下载数据次数，第一次下载数据才创建createBackGroundView的UI
    count=0;
    _baseArr=[[NSMutableArray alloc]init];
    rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
   
    rightBtn.frame=CGRectMake(0, 0, 40, 40);
    
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    [self initUI];
    
    [self addGes];
    [self addRefreshing];
    }

-(void)addGes
{
    
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
    
    __weak JYCDepositDetailVC * weakSelf = self;
    [self.tableView addGifHeaderWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           
            [weakSelf.baseArr removeAllObjects];
            NSString *token = @"~0;id<zOD.{ll@]JKi(:";
            NSString *user_id = [LXUserTool sharedUserTool].getUid;
            NSString *token1 = [token stringByAppendingString:user_id];
            NSDictionary *dict=@{@"member_id":user_id,
                                 @"_token":[WXUtil md5:token1],@"group_name":[[LXUserTool alloc] getuserGroup],@"state":weakSelf.status,@"page":@"1",@"start_date":weakSelf.start,@"end_date":weakSelf.endDate};
            DLog(@"%@",dict);
            isloadMore=NO;
            [weakSelf sentUrl:get_withdrawals_list and:dict];

       
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

}
#pragma 请求
-(void)sentUrl:(NSString *)url and:(NSDictionary*)dict
{
    count++;
    WS(weakSelf);
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
   
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        DLog(@"%@",dict);
        
        if ([dict[@"flag"]intValue]==1) {
            [igView removeFromSuperview];
            weakSelf.tableView.bounces=YES;
            NSDictionary *dict1=dict[@"data"];
            NSArray *arr=dict1[@"data"];
           
                for (NSDictionary *di in arr) {
                DepositModel *model=[[DepositModel alloc]init];
                [model setValuesForKeysWithDictionary:di];
                [weakSelf.baseArr addObject:model];
            }
        }else{
            if (isloadMore) {
             [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
             [[LXAlterView sharedMyTools]createTishi:@"暂无更多数据"];
            
             [weakSelf.tableView.header endRefreshing];
             [weakSelf.tableView.footer endRefreshing];
            }else if (isloadMore==NO){
             [weakSelf.tableView addSubview:igView];
              weakSelf.tableView.bounces=NO;
             [weakSelf.tableView reloadData];
             [weakSelf.tableView.header endRefreshing];
             [weakSelf.tableView.footer endRefreshing];
        }
        }
       //加载更多放在 下载数据结束，这里 避免刚进入页面时出现下载更多按钮
        
        [weakSelf.tableView addLegendFooterWithRefreshingBlock:^{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

               weakSelf.page=weakSelf.page+1;
                
                NSString *token = @"~0;id<zOD.{ll@]JKi(:";
                NSString *user_id = [LXUserTool sharedUserTool].getUid;
                NSString *token1 = [token stringByAppendingString:user_id];
                NSDictionary *dict=@{@"member_id":user_id,
                                     @"_token":[WXUtil md5:token1],@"group_name":[[LXUserTool alloc] getuserGroup],@"state":weakSelf.status,@"page":@(weakSelf.page),@"start_date":weakSelf.start,@"end_date":weakSelf.endDate};
                DLog(@"%@",dict);
                isloadMore=YES;
                [weakSelf sentUrl:get_withdrawals_list and:dict];
            });
            
        }];
        [self.tableView reloadData];
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        [weakSelf.tableView.header endRefreshing];
        [weakSelf.tableView.footer endRefreshing];
    //当tabview的内容不够一屏幕时，不出现加载更多
        if (weakSelf.tableView.contentSize.height < ControllerViewHeight) {
            [weakSelf.tableView removeFooter];
        }
    //第一次下载网络的时候创建一下，以后每次加载网络就不用创建了
        if (count==1) {
        [self createBackGroundView];
      }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
        [weakSelf.tableView.header endRefreshing];
        [weakSelf.tableView.footer endRefreshing];
        [weakSelf.baseArr removeAllObjects];
        [weakSelf.tableView reloadData];
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
    }];
}

-(void)initUI
{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
   
    igView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"暂无相关数据-1"]];
    igView.center=self.view.center;
   
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    UIView *v=[[UIView alloc]init];
    v.backgroundColor=[UIColor clearColor];
    self.tableView.tableFooterView=v;
    
    //默认选中一个月的时间 计算，初始化一下时间 后面创建的UI要用到数据
    NSDate * date = [NSDate date];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.endDate=[dateFormatter stringFromDate:date];
    
    NSArray *arr=[self.endDate componentsSeparatedByString:@"-"];
    NSString *month=arr[1];
    NSString *year=arr[0];
    NSString *str;
    str=[NSString stringWithFormat:@"%d",([month intValue]-1)];
    if ([str intValue]<=0) {
        str=[NSString stringWithFormat:@"%d",12+[str intValue]];
        year=[NSString stringWithFormat:@"%d",[year intValue]-1];
        self.start=[NSString stringWithFormat:@"%@-%02d-%@",year,[str intValue],arr[2]];
    }else{
        self.start=[NSString stringWithFormat:@"%@-%02d-%@",arr[0],[str intValue],arr[2]];
    }

}
-(void)createBackGroundView{
    backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth,windowContentHeight-64)];
    backgroundView.backgroundColor=[UIColor colorWithWhite:0.2 alpha:0.5];
    [self.view addSubview:backgroundView];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [backgroundView addGestureRecognizer:tap];backgroundView.hidden=YES;
    UIView *whiteView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, 200+50)];
    whiteView.backgroundColor=[UIColor whiteColor];
    [backgroundView addSubview:whiteView];
    NSArray *statusArr=[NSArray arrayWithObjects:@"全部",@"进行中",@"成功",@"失败", nil];
    CGFloat with=(windowContentWidth-20-30)/4;
    for (int i=0; i<statusArr.count; i++) {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(10+10*i+i*with, 15, with, 30)];
        button.tag=101+i;
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitle:statusArr[i] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"未选中状态"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(statusBtn:) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:button];
        if (i==0) {
            [button setBackgroundImage:[UIImage imageNamed:@"选中状态"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            lastStatusBtn=button;
        }
    }
    UILabel *line1=[[UILabel alloc]initWithFrame:CGRectMake(0, 60, windowContentWidth, 0.5)];
    line1.backgroundColor=bordColor;
    [whiteView addSubview:line1];
    NSArray *monthArr=[NSArray arrayWithObjects:@"一个月",@"三个月",@"一年",nil];
    CGFloat with2=(windowContentWidth-20-30)/3;
    for (int i=0; i<monthArr.count; i++) {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(10+15*i+i*with2, 75, with2, 30)];
        button.tag=1001+i;
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitle:monthArr[i] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"未选中月份"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(monthBtn:) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:button];
        if (i==0) {
            [button setBackgroundImage:[UIImage imageNamed:@"选中月份"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            lastMonthBtn=button;
        }
        
    }
    
    
    UILabel *line2=[[UILabel alloc]initWithFrame:CGRectMake(0, 120, windowContentWidth, 0.5)];
    line2.backgroundColor=bordColor;
    [whiteView addSubview:line2];
    
    UILabel *optionalLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, ViewBelow(line2)+10, 100, 20)];
    optionalLabel.textColor=[UIColor blackColor];
    optionalLabel.text=@"自选时间:";
    optionalLabel.font=[UIFont systemFontOfSize:18];
    [whiteView addSubview:optionalLabel];
    CGFloat w=(windowContentWidth-10*2-30)/2;
    
    leftTimeBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, ViewBelow(optionalLabel)+10, w, 30)];
    [leftTimeBtn setTitle:self.start forState:UIControlStateNormal];
    [leftTimeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [leftTimeBtn addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:leftTimeBtn];
    UILabel *orangeLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(leftTimeBtn), ViewBelow(optionalLabel)+15+10, 32, 2)];
    orangeLabel.backgroundColor=[UIColor colorWithRed:254/225.0 green:153/255.0 blue:101/255.0 alpha:1];
    [whiteView addSubview:orangeLabel];
    
    rightTimeBtn=[[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth-10-w, ViewY(leftTimeBtn), w, 30)];
    [rightTimeBtn setTitle:self.endDate forState:UIControlStateNormal];
    [rightTimeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [rightTimeBtn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:rightTimeBtn];
    CGFloat w2=(windowContentWidth-20-50)/2;
    UILabel *line3=[[UILabel alloc]initWithFrame:CGRectMake(10, ViewBelow(leftTimeBtn), w2, 0.5)];
    line3.backgroundColor=bordColor;
    [whiteView addSubview:line3];
    UILabel *line4=[[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth-10-w2, ViewY(line3), w2, 0.5)];
    line4.backgroundColor=bordColor;
    [whiteView addSubview:line4];
    UIButton *buton=[[UIButton alloc]initWithFrame:CGRectMake(10, ViewHeight(whiteView)-50, windowContentWidth-20,40)];
    
    [buton setTitle:@"确定" forState:UIControlStateNormal];
    [buton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buton setBackgroundImage:[UIImage imageNamed:@"确定按钮"] forState:UIControlStateNormal];
    //[buton setBackgroundColor:[UIColor colorWithRed:254/255.0 green:153/255.0 blue:102/255.0 alpha:1]];
    [buton addTarget:self action:@selector(accomplishBtn) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:buton];
    picker=[[UIDatePicker alloc]init];
    picker.frame=CGRectMake(0, ViewHeight(backgroundView)-150, windowContentWidth, 150);
    
    picker.backgroundColor=[UIColor whiteColor];
    picker.datePickerMode=UIDatePickerModeDate;
    
    picker.maximumDate=[NSDate date];
    [picker addTarget:self action:@selector(change1) forControlEvents:UIControlEventValueChanged];
    [backgroundView addSubview:picker];
    viewBtn=[[UIView alloc]initWithFrame:CGRectMake(0, ViewY(picker)-40, windowContentWidth, 40)];
    viewBtn.backgroundColor=[UIColor whiteColor];
    UILabel *leftBtnline=[[UILabel alloc]initWithFrame:CGRectMake(0, 39.5, windowContentWidth, 0.5)];
    leftBtnline.backgroundColor=bordColor;
    [viewBtn addSubview:leftBtnline];
    [backgroundView addSubview:viewBtn];
    UIButton *completeBtn=[[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth-40-5, 0, 40, 40)];
    [completeBtn addTarget:self action:@selector(completeLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [completeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [viewBtn addSubview:completeBtn];
    viewBtn.hidden=YES;
    picker.hidden=YES;
    picker2=[[UIDatePicker alloc]init];
    picker2.frame=CGRectMake(0, ViewHeight(backgroundView)-150, windowContentWidth, 150);
    
    picker2.backgroundColor=[UIColor whiteColor];
    picker2.datePickerMode=UIDatePickerModeDate;
    
    picker2.maximumDate=[NSDate date];
    [picker2 addTarget:self action:@selector(change2) forControlEvents:UIControlEventValueChanged];
    [backgroundView addSubview:picker2];
    viewBtn2=[[UIView alloc]initWithFrame:CGRectMake(0, ViewY(picker2)-40, windowContentWidth, 40)];
    viewBtn2.backgroundColor=[UIColor whiteColor];
    [backgroundView addSubview:viewBtn2];
    UILabel *rightBtnline=[[UILabel alloc]initWithFrame:CGRectMake(0, 39.5, windowContentWidth, 0.5)];
    rightBtnline.backgroundColor=bordColor;
    [viewBtn2 addSubview:rightBtnline];
    
    UIButton *completeBtn2=[[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth-40-5, 0, 40, 40)];
    [completeBtn2 addTarget:self action:@selector(completeLeftBtn2) forControlEvents:UIControlEventTouchUpInside];
    [completeBtn2 setTitle:@"完成" forState:UIControlStateNormal];
    [completeBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [viewBtn2 addSubview:completeBtn2];
    picker2.hidden=YES;
    viewBtn2.hidden=YES;
  
}
-(void)accomplishBtn
{
    if ([self.start compare:self.endDate]==NSOrderedDescending) {
        [[LXAlterView sharedMyTools]createTishi:@"起始时间不能大于截止时间"];
        return;
    }
    [self.baseArr removeAllObjects];
    backgroundView.hidden=YES;
    [rightBtn setTitle:@"筛选" forState:UIControlStateNormal];
    isChange=NO;
    self.page=1;
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString *user_id = [LXUserTool sharedUserTool].getUid;
    NSString *token1 = [token stringByAppendingString:user_id];
    NSDictionary *dict=@{@"member_id":user_id,
                         @"_token":[WXUtil md5:token1],@"group_name":[[LXUserTool alloc] getuserGroup],@"state":self.status,@"page":@"1",@"start_date":self.start,@"end_date":self.endDate};
    isloadMore=NO;
    DLog(@"%@",dict);
    [self sentUrl:get_withdrawals_list and:dict];
}
-(void)close
{
    if (!backgroundView.hidden) {
        backgroundView.hidden=YES;
        [rightBtn setTitle:@"筛选" forState:UIControlStateNormal];
        isChange=NO;
    }else if (backgroundView.hidden)
    {
        self.navigationController.navigationBarHidden=YES;
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)leftClick:(UIButton *)button
{
    picker2.hidden=YES;
    viewBtn2.hidden=YES;
    viewBtn.hidden=NO;
    picker.hidden=NO;
    
}
-(void)completeLeftBtn
{
    DLog(@"%@",leftStr);
    if (![self judgeString:leftStr]) {
        NSDate *selected = [NSDate date];
        NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
        [dateFormatter2 setDateFormat:@"yyyy-MM-dd"];
        leftStr = [dateFormatter2 stringFromDate:selected];
    }
    viewBtn.hidden=YES;
    picker.hidden=YES;
    self.start=leftStr;
    [leftTimeBtn setTitle:leftStr forState:UIControlStateNormal];
    [lastMonthBtn setBackgroundImage:[UIImage imageNamed:@"未选中月份"] forState:UIControlStateNormal];
    [lastMonthBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

-(void)rightClick:(UIButton *)button
{
    viewBtn.hidden=YES;
    picker.hidden=YES;
    picker2.hidden=NO;
    viewBtn2.hidden=NO;
}
-(void)completeLeftBtn2
{
    if (![self judgeString:rightStr]) {
        NSDate *selected = [NSDate date];
        NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
        [dateFormatter2 setDateFormat:@"yyyy-MM-dd"];
        rightStr = [dateFormatter2 stringFromDate:selected];
    }

    viewBtn2.hidden=YES;
    picker2.hidden=YES;
    
    self.endDate=rightStr;
    [rightTimeBtn setTitle:rightStr forState:UIControlStateNormal];
    [lastMonthBtn setBackgroundImage:[UIImage imageNamed:@"未选中月份"] forState:UIControlStateNormal];
    [lastMonthBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

-(void)change1
{
    NSDate *selected = [picker date];
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd"];
    leftStr = [dateFormatter2 stringFromDate:selected];
    DLog(@"%@",leftStr);
}

-(void)change2
{
    NSDate *selected = [picker2 date];
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd"];
    rightStr = [dateFormatter2 stringFromDate:selected];
    
    
}

-(void)monthBtn:(UIButton *)button
{
    [lastMonthBtn setBackgroundImage:[UIImage imageNamed:@"未选中月份"] forState:UIControlStateNormal];
    [lastMonthBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [button setBackgroundImage:[UIImage imageNamed:@"选中月份"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    lastMonthBtn=button;
    NSDate * date = [NSDate date];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
     self.endDate=[dateFormatter stringFromDate:date];
    //设置时间间隔（秒）（这个我是计算出来的，不知道有没有简便的方法 )
   // NSTimeInterval time;
    NSArray *arr=[self.endDate componentsSeparatedByString:@"-"];
    NSString *month=arr[1];
    NSString *year=arr[0];
    NSString *str;
       if (button.tag==1001) {
        //time=30*24*60*60;
           str=[NSString stringWithFormat:@"%d",([month intValue]-1)];
           if ([str intValue]<=0) {
               str=[NSString stringWithFormat:@"%d",12+[str intValue]];
               year=[NSString stringWithFormat:@"%d",[year intValue]-1];
               self.start=[NSString stringWithFormat:@"%@-%02d-%@",year,[str intValue],arr[2]];
           }else{
           self.start=[NSString stringWithFormat:@"%@-%02d-%@",arr[0],[str intValue],arr[2]];
           }
    }else if (button.tag==1002){
        //time=3*30*24*60*60;
        str=[NSString stringWithFormat:@"%d",[month intValue]-3];
        if ([str intValue]<=0) {
            str=[NSString stringWithFormat:@"%d",12+[str intValue]];
            year=[NSString stringWithFormat:@"%d",[year intValue]-1];
            self.start=[NSString stringWithFormat:@"%@-%02d-%@",year,[str intValue],arr[2]];
        }else{
          self.start=[NSString stringWithFormat:@"%@-%02d-%@",arr[0],[str intValue],arr[2]];
        }

        
    }else if (button.tag==1003)
    {
       // time=365*24*60*60;
        str=[NSString stringWithFormat:@"%d",[year intValue]-1];
        self.start=[NSString stringWithFormat:@"%@-%@-%@",str,arr[1],arr[2]];
    }
    //NSDate * lastYear = [date dateByAddingTimeInterval:-time];
    //self.start=[NSString stringWithFormat:@"%@-%@-%@",];
    //转化为字符串
    //self.start = [dateFormatter stringFromDate:lastYear];
    
    [rightTimeBtn setTitle:self.endDate forState:UIControlStateNormal];
    [leftTimeBtn setTitle:self.start forState:UIControlStateNormal];
}
-(void)statusBtn:(UIButton *)button
{
    
    [lastStatusBtn setBackgroundImage:[UIImage imageNamed:@"未选中状态"] forState:UIControlStateNormal];
    [lastStatusBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

    [button setBackgroundImage:[UIImage imageNamed:@"选中状态"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    lastStatusBtn=button;
    if (button.tag==101) {
        self.status=@"-1";
        
    }else if (button.tag==102)
    {
        self.status=@"1";
    }else if(button.tag==103)
    {
        self.status=@"2";
    }else if (button.tag==104)
    {
        self.status=@"3";
    }
}
-(void)tap
{
    
}
-(void)rightBtnClick
{
    [rightBtn setTitle:isChange?@"筛选":@"收起" forState:UIControlStateNormal];
    backgroundView.hidden=isChange?YES:NO;
    
    isChange=!isChange;
}
#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return self.baseArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString * cellIndetifier = @"cellIndetifier";
    JYCDepositDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
    if (cell == nil) {
        cell = [[JYCDepositDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifier];
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    DepositModel *model=[[DepositModel alloc]init];
    model=self.baseArr[indexPath.row];
    
    cell.model=model;
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
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

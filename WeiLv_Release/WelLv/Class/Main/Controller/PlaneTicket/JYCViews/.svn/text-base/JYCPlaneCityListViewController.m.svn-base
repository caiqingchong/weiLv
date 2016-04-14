//
//  JYCPlaneCityListViewController.m
//  WelLv
//
//  Created by lyx on 15/9/6.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
//http://202.104.102.2/api/flightApi/getAirportList


#define HistoryPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"City.data"]
#define LeftBeginX 10
#import "JYCPlaneCityListViewController.h"
#import "PlaneCityModel.h"
#import "YXLocationManage.h"
#import "JYCPlaneTicketViewController.h"
@interface JYCPlaneCityListViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate>
{
    UISegmentedControl *segmentControl;
    UITableView *_tableView;
    AFHTTPRequestOperationManager *_manager;
    NSMutableArray *_dataArr;
    NSMutableArray *_dataArr2;
    NSMutableArray *_hotArr;
    NSMutableArray *_titleArr;
    //NSMutableArray *_historyArr;
    NSArray *filterData;
    UISearchDisplayController * searchdispalyCtrl;
    NSMutableArray *_tempArr;
    BOOL search;
    
    //NSUInteger _index;
}
@property (nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong)NSArray *hotArr;
@property(nonatomic,strong)NSMutableArray *titleArr;
@property(nonatomic,strong)NSMutableArray *historyArr;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *dataArr2;
@property (nonatomic, strong) NSMutableDictionary *planeCityDic;
@property (nonatomic, copy) ChooseCityBlock chooseCityBlock;
@property(nonatomic,strong)NSMutableArray *tempArr;
@property(nonatomic,strong)NSMutableArray *filterArr;//过滤后的数组
//@property (nonatomic, copy) NSString *historyPath;
@end

@implementation JYCPlaneCityListViewController

- (id)initWithAddress:(ChooseCityBlock)cityAddress{
    if (self =[super init]) {
        self.chooseCityBlock = cityAddress;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // self.title=@"出发城市";
    self.view.backgroundColor=[UIColor whiteColor];
    _dataArr=[[NSMutableArray alloc]init];
    _dataArr2=[[NSMutableArray alloc]init];
    //self.historyArr=[NSMutableArray array];
    _hotArr=[[NSMutableArray alloc]init];
    _titleArr=[[NSMutableArray alloc]init];
    _planeCityDic=[[NSMutableDictionary alloc]init];
    _filterArr=[[NSMutableArray alloc]init];
    _tempArr=[[NSMutableArray alloc]init];
   
    self.historyArr=[NSMutableArray arrayWithContentsOfFile:HistoryPath];
     if(self.historyArr==nil)
    {
        self.historyArr=[NSMutableArray arrayWithCapacity:0];
    }
    [self createView];
    [self initData];
    
}


-(void)createView
{
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth,86)];
//    UIView * aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 44)];
//    [headerView addSubview:aView];
//
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 40)];
    //设置代理
    searchBar.delegate = self;
    searchBar.placeholder = @"搜索/如:北京";
    [headerView addSubview:searchBar];
    
    NSArray *items = @[@"城市列表",@"历史记录"];
    segmentControl = [[UISegmentedControl alloc] initWithItems:items];
    
    segmentControl.tintColor = [UIColor orangeColor];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:16.0],NSFontAttributeName,nil];
    [segmentControl setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    segmentControl.frame = CGRectMake(LeftBeginX, ViewY(searchBar)+ViewHeight(searchBar)+3,windowContentWidth-LeftBeginX*2, 40);
    
    segmentControl.selectedSegmentIndex = 0;
    [segmentControl addTarget:self action:@selector(segmentControlAction) forControlEvents:UIControlEventValueChanged];
    [headerView addSubview:segmentControl];
    
    [self.view addSubview:headerView];
    //创建 tableView
    if (!self.tableView) {
        //如果没有再创建  懒加载
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, windowContentWidth,windowContentHeight-64) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView reloadData];
        [self.view addSubview:self.tableView];
    }
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }

    
    self.tableView.tableHeaderView=headerView;
    self.tableView.sectionIndexColor = [UIColor colorWithRed:112 /255.0 green:168 /255.0 blue:254 /255.0 alpha:1.0];;
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
     //创建footVew
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth,50)];
        footView.backgroundColor = [UIColor clearColor];
        UIView *topLine=[[UIView alloc]initWithFrame:CGRectMake(0, 1, windowContentWidth, 0.5)];
        [footView addSubview:topLine];
        topLine.backgroundColor=bordColor;
        UIView *botomLine=[[UIView alloc]initWithFrame:CGRectMake(0, 49-1, windowContentWidth, 0.5)];
        [footView addSubview:botomLine];
        botomLine.backgroundColor=bordColor;
        UIButton *sureButton  = [[UIButton alloc]initWithFrame:CGRectMake((windowContentWidth-100)/2, 0, 100, 50)];
        //sureButton.backgroundColor = [UIColor whiteColor];
        sureButton.layer.cornerRadius = 2.0f;
        sureButton.layer.masksToBounds = YES;
        [sureButton setTitle:@"清除记录" forState:UIControlStateNormal];
        [sureButton addTarget:self action:@selector(sureButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        sureButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [footView addSubview:sureButton];
        self.tableView.tableFooterView=footView;
        self.tableView.tableFooterView.hidden=YES;

}
#pragma mark - UISearcharBarDelegate
//是否可以进入编辑模式
//将要进入编辑模式调用
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    //显示 cancel 按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    for(id cc in [searchBar.subviews[0] subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"forState:UIControlStateNormal];
        }
    }
    return YES;
}

//将要结束编辑模式调用
//是否可以结束编辑模式
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    //隐藏cancel 按钮
    [searchBar setShowsCancelButton:NO animated:YES];
    NSLog(@"****%g****\n%g\n****", ViewHeight(searchBar.superview), ViewY(searchBar.superview));
    return YES;//可以结束编辑模式
}
//点击cancel 的时候调用
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";//清空内容
    //收键盘
    [searchBar resignFirstResponder];
    //[headerView bringSubviewToFront:segmentControl];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if ([self.dataArr containsObject:searchBar.text]) {
        [self.dataArr removeAllObjects];
        [self.dataArr addObject:searchBar.text];
        [self.tableView reloadData];
    }
}

//点击search 按钮 调用
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    search=YES;
    [self.tempArr removeAllObjects];
           for(NSString *str in self.dataArr) {
                NSRange range = [str rangeOfString:searchBar.text options:NSCaseInsensitiveSearch];
                if (range.location != NSNotFound) {
                    [self.tempArr addObject:str];
                }

        }
    [self.titleArr removeAllObjects];
    [self.titleArr addObject:@""];
    [self.tableView reloadData];
}
-(void)initData
{
    //初始化 AF
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    __weak typeof(self)weakSelf =self;
    [_manager GET:PlaneTicketCityUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        if (responseObject) {
          NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            NSDictionary *dictData=dict[@"data"];
            NSDictionary *hot_city=dictData[@"hot_city"];
            NSArray *hot_arr=[hot_city allKeys];
            for (NSString *str in hot_arr) {
                NSString *city=[hot_city objectForKey:str];
                [_hotArr addObject:city];
            }
            
            NSMutableArray *arr=dictData[@"list"];
            NSMutableDictionary * tempDic = [NSMutableDictionary dictionary];
            for (NSDictionary * dic in arr) {
                [tempDic setValue:dic forKey:[dic objectForKey:@"city_name"]];
            }
            for (NSDictionary *appDict in [tempDic allValues]) {
                //放入数据模型对象
                PlaneCityModel *model = [[PlaneCityModel alloc] init];
                
                [model setValuesForKeysWithDictionary:appDict];
                //[weakSelf.dataArr2 addObject:model.city_py];
                [weakSelf.dataArr addObject:model.city_name];
                
                NSString *key=[model.city_prefix uppercaseString];
                
                //[weakSelf.planeCityDic setValue:model forKey:key];
                if ([weakSelf.planeCityDic objectForKey:key]) {
                    NSMutableArray * arr = [weakSelf.planeCityDic objectForKey:key];
                    [arr addObject:model];
                } else {
                    NSMutableArray * arr = [NSMutableArray array];
                    [arr addObject:model];
                    [weakSelf.planeCityDic setValue:arr forKey:key];
                };
                
            }
           
            //NSLog(@"%@",weakSelf.planeCityDic);
        [weakSelf.titleArr addObjectsFromArray:[[weakSelf.planeCityDic allKeys] sortedArrayUsingSelector:@selector(compare:)]];
        }
        [weakSelf.titleArr insertObject:@"热门" atIndex:0];
        [weakSelf.titleArr insertObject:@"定位" atIndex:0];
        [self.tableView reloadData];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[LXAlterView sharedMyTools]createTishi:@"网络请求失败，请稍后再试"];
        NSLog(@"下载失败");
    }];
   
}
-(void)segmentControlAction
{
    switch ([segmentControl selectedSegmentIndex]) {
        case 0:
        {
            
            self.tableView.tableFooterView.hidden=YES;
            [self.tableView reloadData];
        }
            break;
        case 1:
        {
            self.tableView.tableFooterView.hidden=NO;
            [self.tableView reloadData];
        }
            break;
        default:
            break;
    }
}


#pragma mark --tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([segmentControl selectedSegmentIndex]==0) {
        return self.titleArr.count;
        
    }else {
        return 1;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([segmentControl selectedSegmentIndex]==0) {
        if (search==NO) {
            if (section==0) {
            return 1;
        }else if(section==1)
            return _hotArr.count;
        else{
         self.tempArr = [self.planeCityDic objectForKey:[self.titleArr objectAtIndex:section]];
         return self.tempArr.count;

        }
    }else if(search==YES)
    {
        return self.tempArr.count;
    }
  }else
     self.historyArr=[NSMutableArray arrayWithContentsOfFile:HistoryPath];
    return self.historyArr.count;
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 20)];
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, windowContentWidth, 20)];
    titleLabel.textColor = [UIColor whiteColor];
    if ([segmentControl selectedSegmentIndex]==0){
        if (search==NO) {
            
        
    if (section==0) {
        titleLabel.text=@"定位";
    }else if(section==1)
    {
        titleLabel.text=@"热门城市";
    }else{
    
        titleLabel.text = [self.titleArr objectAtIndex:section];
        }
    }else if(search==YES)
    {
        titleLabel.text=@"搜索";
    }
  }else{
     titleLabel.text=@"历史";
    }
    headerView.backgroundColor =  [UIColor colorWithRed:131 /255.0 green:146/255.0 blue:156/255.0 alpha:1.0];
    [headerView addSubview:titleLabel];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
        return 20;
}
//设置区头
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *str=nil;
    if ([segmentControl selectedSegmentIndex]==0){
        if (search ==NO) {
        if (section==0) {
         str=@"定位";
    }else if(section==1)
    {
         str=@"热门城市";
    }else
    {
         str=[self.titleArr objectAtIndex:section];
    }
            
    } else if(search==YES)
    {
         str=@"搜索";
    }
        
    }else if([segmentControl selectedSegmentIndex]==1){
     
     str=@"历史";
    }
    return str;
}
//索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if ([segmentControl selectedSegmentIndex]==0){
         return self.titleArr;
    }else
    return nil;
 
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"listCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsZero;
    }
   
    NSString *str=[YXLocationManage shareManager].city;
   
    if ([segmentControl selectedSegmentIndex]==0){
      if (search==NO) {
    if (indexPath.section==0) {
        if ([CLLocationManager authorizationStatus] !=  kCLAuthorizationStatusAuthorized && [CLLocationManager authorizationStatus] !=  kCLAuthorizationStatusAuthorizedWhenInUse) {
            cell.textLabel.text = @"无法获取您的位置";
        }else{
            cell.textLabel.text=str;
        }
        
    }else if(indexPath.section==1)
    {
        cell.textLabel.text=[_hotArr objectAtIndex:indexPath.row];
    } else {
        PlaneCityModel * model = [[self.planeCityDic  objectForKey:[_titleArr objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
        
        cell.textLabel.text =model.city_name;
    }
    
    }else if(search==YES)
    {
        cell.textLabel.text=self.tempArr[indexPath.row];
    }
     
    }else if([segmentControl selectedSegmentIndex]==1){
       
        NSLog(@"111");
        self.historyArr=[NSMutableArray arrayWithContentsOfFile:HistoryPath];
        for (id obj in _historyArr) {
            NSLog(@"%@",obj);
        }

        cell.textLabel.text=self.historyArr[indexPath.row];
    }
    return cell;

        
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (search==NO) {
       if ([segmentControl selectedSegmentIndex]==0){
        if (indexPath.section==0) {
             if ([CLLocationManager authorizationStatus] !=  kCLAuthorizationStatusAuthorized && [CLLocationManager authorizationStatus] !=  kCLAuthorizationStatusAuthorizedWhenInUse) {
                 [[LXAlterView sharedMyTools]createTishi:@"请在设置里面打开定位信息"];
             }else{
            self.chooseCityBlock([YXLocationManage shareManager].city);
                 
            if (![self.historyArr containsObject:[YXLocationManage shareManager].city]) {
                
                [self.historyArr insertObject:[YXLocationManage shareManager].city atIndex:0];
                [self.historyArr writeToFile:HistoryPath atomically:YES];
                [self.tableView reloadData];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        }else if(indexPath.section==1)
        {
           
            self.chooseCityBlock(_hotArr[indexPath.row]);
            if (![self.historyArr containsObject:_hotArr[indexPath.row]]) {
                NSLog(@"%@",_hotArr[indexPath.row]);
                //[self.historyArr addObject:_hotArr[indexPath.row]];
                [self.historyArr insertObject:_hotArr[indexPath.row] atIndex:0];
                NSLog(@"%@",self.historyArr);
                [self.historyArr writeToFile:HistoryPath atomically:YES];
                
                [self.tableView reloadData];
            }
            [self.navigationController popViewControllerAnimated:YES];

            
        }else{
        
        //NSMutableArray *arr=[NSMutableArray arrayWithContentsOfFile:HistoryPath];
            
        PlaneCityModel * model = [[self.planeCityDic  objectForKey:[_titleArr objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
         self.chooseCityBlock(model.city_name);
            if (![self.historyArr containsObject:model.city_name]) {
                [self.historyArr insertObject:model.city_name atIndex:0];
                
                [self.historyArr writeToFile:HistoryPath atomically:YES];
                [self.tableView reloadData];
                
        }
            [self.navigationController popViewControllerAnimated:YES];

        }
          }else if([segmentControl selectedSegmentIndex]==1)
    {
        self.historyArr=[NSMutableArray arrayWithContentsOfFile:HistoryPath];
        self.chooseCityBlock(_historyArr[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }

    }else if(search==YES)
    {
        self.chooseCityBlock(self.tempArr[indexPath.row]);
        
        if (![self.historyArr containsObject:self.tempArr[indexPath.row]]) {
            [self.historyArr insertObject:self.tempArr[indexPath.row] atIndex:0];
            [self.historyArr writeToFile:HistoryPath atomically:YES];
            [self.tableView reloadData];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)sureButtonPressed
{
    [self.historyArr removeAllObjects];
    [self.historyArr writeToFile:HistoryPath atomically:YES];
    //NSLog(@"---%@---",self.historyArr);
    [self.tableView reloadData];
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

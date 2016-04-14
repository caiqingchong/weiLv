//
//  HouseListViewController.m
//  WelLv
//
//  Created by lx on 15/8/4.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "HouseListViewController.h"
#import "LXGuanJiaTableViewCell.h"
#import "YXHouseDetailViewController.h"
#import "LXGuanJiaModel.h"
#import "LXGetCityIDTool.h"

@interface HouseListViewController ()
<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_keeperTab;
     NSMutableArray *_keeperAraay;
}
@end

@implementation HouseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"管家列表";
    _keeperTab=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight) style:UITableViewStylePlain];
    _keeperTab.tableFooterView=[[UIView alloc] init];
    _keeperTab.delegate=self;
    _keeperTab.dataSource=self;
    //_keeperTab.backgroundColor=[UIColor redColor];
    [self.view addSubview:_keeperTab];
    
    _keeperAraay=[[NSMutableArray alloc] initWithCapacity:0];
    
    NSDictionary *parameterDic=@{@"offset":@"0",@"limit":@"10",@"keywords":self.keywords,@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]};
    [self sendRequest:parameterDic aUrl:getHouseListUrl aTag:1];
}

#pragma mark 请求数据-post
-(void)sendRequest:(NSDictionary *)parameters aUrl:(NSString *)url aTag:(NSUInteger)tag
{
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    if (tag==1)
    {
        DLog(@"删除管家数据");
        [_keeperAraay removeAllObjects];
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters
     
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             // DLog(@"Success: %@", dic);
              if ([[dic objectForKey:@"status"] integerValue]==1)
              {
                  
                  NSArray *array=[dic objectForKey:@"data"];
                  NSDictionary *dict1=[[NSDictionary alloc] init];
                  //DLog(@"data=%@",array);
                  NSArray *sellersArray=[NSArray array];
                  for (int i=0; i<array.count; i++)
                  {
                      
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
                      
                      model.infoStr=[dict1 objectForKey:@"advantage"];
                      model.keeperID=[dict1 objectForKey:@"id"];
                      model.phone=[dict1 objectForKey:@"mobile"];
                      DLog(@"管家姓名：%@",model.nameStr);
                      [_keeperAraay addObject:model];
                      
                  }
                  
                  [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
                  [_keeperTab reloadData];
              }
              else
              {
                  [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
                  [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
                  [_keeperTab reloadData];
              }
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
              [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
                  NSDictionary *parameterDic=@{@"offset":@"0",@"limit":@"10"};
                  [self sendRequest:parameterDic aUrl:getHouseListUrl aTag:1];
              }];
              
        }];
    
}
#pragma mark --- 获取日期间隔（计算管家年龄）
-(NSString *)getAge:(NSString *)birth_date
{
    if ([birth_date isEqualToString:@"0000-00-00"])
    {
        return @"0";
    }else
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
    
}


#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

        return _keeperAraay.count;
 
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    if (tableView==_keeperTab)
//    {
//        return 1;
//    }
//    return 0;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (tableView==_keeperTab)
//    {
//        return 44;
//    
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //NSLog(@"labelSize.width==%f",cell.frame.size.height);
  
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        return ViewHeight(cell);
   
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

        static NSString *CellIdentifier1 = @"cellIdentifier1";
        LXGuanJiaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            cell = [[LXGuanJiaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
            //单元格的选择风格，选择时单元格不出现蓝条
            // cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if (_keeperAraay.count>0) {
            LXGuanJiaModel *model=[_keeperAraay objectAtIndex:indexPath.row];
            //[cell setIntroductionText:model.infoStr];
            [cell returnTextCGRectText:model.infoStr textFont:13];
            cell.item=model;
        }
        
        
        return cell;
  
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"_________%lu",indexPath.row);
    if (tableView==_keeperTab)
    {
        LXGuanJiaModel *guanjiaModel=[_keeperAraay objectAtIndex:indexPath.row];
        YXHouseDetailViewController *houseKeepervc=[[YXHouseDetailViewController alloc] init];
        houseKeepervc.houseID=guanjiaModel.keeperID;
        houseKeepervc.houseName=guanjiaModel.nameStr;
        [self.navigationController pushViewController:houseKeepervc animated:YES];
        
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

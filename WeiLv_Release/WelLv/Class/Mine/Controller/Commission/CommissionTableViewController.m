//
//  CommissionTableViewController.m
//  WelLv
//
//  Created by mac for csh on 15/9/1.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "CommissionTableViewController.h"
#import "MyOrderModel.h"
#import "CommissionTableViewCell.h"

//#define NavHeight 64
#define IS_IPHONE4OR5 (([[UIScreen mainScreen] bounds].size.width-320)?NO:YES)

#import "MyOrderModel.h"
#import "MyOrderTableViewCell.h"
#import "LXUserDefault.h"
#import "AFNetworking.h"
#import "MyOrderDetailViewController.h"
#import "WXApi.h"
#import "NTViewController.h"
#import "MineViewController.h"
#import "LoginAndRegisterViewController.h"

@interface CommissionTableViewController ()
{
    int _currentPage;
    int _offset;
    
    NSMutableArray *_orderArray;
    UITableView *_orderTab;
    
}
@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation CommissionTableViewController
//@synthesize order_id,cat_id,member_id;

-(void)viewWillAppear:(BOOL)animated{
    //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi) name:@"Tongzhi" object:nil];
    
    //    [self initData];
    //    [self initTable];
    
}
//-(void)tongzhi{
//    for(UIView *view in [self.view subviews])
//    {
//        [view removeFromSuperview];
//    }
//    [self viewDidLoad];
//}
//
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"返佣明细";
    self.view.backgroundColor=BgViewColor;
    
    _orderTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ViewHeight(self.view)-64)];
    _orderTab.tableFooterView=[[UIView alloc] init];//去掉多余的cell
    _orderTab.backgroundColor = BgViewColor;
    _orderTab.dataSource =self;_orderTab.delegate = self;
    [self.view addSubview:_orderTab];
    
    [self initData];
}

-(void)initData{
    _currentPage=2;
    _offset=1;
    if (_orderArray) {
        [_orderArray removeAllObjects];
    }
    _orderArray = [[NSMutableArray alloc] init];
    NSString *offset1=[NSString stringWithFormat:@"%d",1];
    NSDictionary *dic=@{@"assistant_id":[[LXUserTool alloc] getUid],@"offset":offset1,@"limit":@"10"};
    [self sendRequest:dic];
    
    //----------上拉加载更多
    [_orderTab addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadLastData)];
    if ([_orderTab respondsToSelector:@selector(setSeparatorInset:)]) {
        [_orderTab setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_orderTab respondsToSelector:@selector(setLayoutMargins:)]) {
        [_orderTab setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)loadLastData
{
    _offset=_currentPage;
    NSString *offset1=[NSString stringWithFormat:@"%ld",(long)_offset];
    NSDictionary *dic=@{@"assistant_id":[[LXUserTool alloc] getUid],@"offset":offset1,@"limit":@"10"};
    [self sendRequest:dic];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_orderTab.footer endRefreshing];
        _currentPage++;
    });
}
-(void)sendRequest:(NSDictionary *)parameters
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //  NSDictionary *parameters =  @{@"assistant_id":[[LXUserTool alloc] getUid]};
    [self setProgressHud];
    [manager POST:commissionOrderList parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
             
             
              id list = [dict valueForKey:@"cash_journal_lists"];
              [_hud hide:YES];
              if ([list isKindOfClass:[NSArray class]]) {
                  
                  for (int a = 0; a < [list count]; a ++){
                      MyOrderModel *model = [[MyOrderModel alloc] init];
                      model.titleStr = [[[list objectAtIndex:a] objectForKey:@"orders"] objectForKey:@"product_name"];             //----产品名字
                      NSMutableString * String1= [NSMutableString stringWithFormat:@"订单编号:%@",[[[list objectAtIndex:a] objectForKey:@"orders"] objectForKey:@"order_sn"]];
                      model.orderSN = String1;                                                                                     //订单号
                      
                      model.commissionStr = [NSString stringWithFormat:@"返佣:%@",[[list objectAtIndex:a] objectForKey:@"inactive"]];//返佣
                      NSString *String2 = [[list objectAtIndex:a] objectForKey:@"thumb"];                                            //左侧图片url
                      NSString *cat_id = [[[list objectAtIndex:a] objectForKey:@"orders"] objectForKey:@"product_category"];
                      NSString *imgeURLString =WLHTTP;
                      //@"https://www.weilv100.com/";
                      if([cat_id integerValue] == 2){
                          //签证
                          imgeURLString =[NSString stringWithFormat:@"%@/",WLHTTP];
                          //@"https://www.weilv100.com/";
                      }else if([cat_id integerValue] == 3){
                          //游轮
                          imgeURLString =WLHTTP;
                         // @"https://www.weilv100.com/";
                      }else{
                          //旅游
                          imgeURLString =[NSString stringWithFormat:@"%@upload/thumb/",WLHTTP];
                         // @"https://www.weilv100.com/upload/thumb/";
                      }
                      if (!(String2==nil || [String2 isEqual:[NSNull null]])) {
                          
                          if ([String2 hasPrefix:@"https://"]||[String2 hasPrefix:@"http://"]) {
                              model.leftImageUrl = String2;
                          }else{
                              model.leftImageUrl = [imgeURLString stringByAppendingString: String2];
                          }
                      }else {
                          model.leftImageUrl = @"";
                      }
                      
                      NSString *String3 = [[list objectAtIndex:a] objectForKey:@"category"];
                      if ([String3 isEqualToString:@"travel"]) {
                          model.catName = @"旅游度假";
                      }else if ([String3 isEqualToString:@"cruise"]) {
                          model.catName = @"邮轮";
                      }else if ([String3 isEqualToString:@"ticket"]) {
                          model.catName = @"门票";
                      }else if ([String3 isEqualToString:@"yoosure"]) {
                          model.catName = @"游学";
                      }else if ([String3 isEqualToString:@"visa"]) {
                          model.catName = @"签证";
                      }else if ([String3 isEqualToString:@"driving_eat"]) {
                          model.catName = @"自驾吃";
                      }
                      
                      NSString*times = [[list objectAtIndex:a] objectForKey:@"create_time"];                                       //出发时间
                      NSTimeInterval time=[times doubleValue];
                      NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
                      //实例化一个NSDateFormatter对象
                      NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                      //设定时间格式,这里可以设置成自己需要的格式
                      [dateFormatter setDateFormat:@"MM月dd日"];
                      model.timeStr = [NSString stringWithFormat:@"到账时间：%@",[dateFormatter stringFromDate: detaildate]];
                      
                      [_orderArray addObject:model];
                  }
                  [_orderTab reloadData];
                  [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              }
              
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              [_hud hide:YES];
              NSLog(@"Error: %@", error);
              
          }];
    
}


- (void)setProgressHud
{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"加载中";
    
    [self.view addSubview:_hud];
    [_hud show:YES];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _orderArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier10001 = @"cellIdentifier10001";
    CommissionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier10001];
    
    if (cell == nil)
    {
        cell = [[CommissionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier10001];
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    MyOrderModel *model = [_orderArray objectAtIndex:indexPath.row];
    cell.item = model;
    
    
    return cell;
}



@end

//
//  MyMemberOrderTableViewController.m
//  WelLv
//
//  Created by mac for csh on 15/8/25.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
#define NavHeight 64

#import "MyMemberOrderTableViewController.h"
#import "MyOrderModel.h"
#import "MyOrderTableViewCell.h"
#import "LXUserDefault.h"
#import "AFNetworking.h"
#import "MyOrderDetailViewController.h"
#import "WXApi.h"
#import "NTViewController.h"
#import "MineViewController.h"
#import "LoginAndRegisterViewController.h"
#import "PlaneTicketViewController.h"
#import "ShipCSHViewController.h"
#import "DetailOrideViewController.h"
@interface MyMemberOrderTableViewController ()
{
    NSMutableArray *_orderArray;
    UITableView *_orderTab;
}
@property (nonatomic, strong) UIScrollView * chooseView1;
@property (nonatomic, strong) UIView * chooseView11;
@property (nonatomic, strong) UIView * chooseView2;


@property (nonatomic, copy) NSString * order_status;
@property (nonatomic, copy) NSString * pay_status;
@property (nonatomic, copy) NSDictionary * sortDictionary;
@property (nonatomic, copy) NSString * product_category;

@property (nonatomic, strong) UIButton * chooseBut1;
@property (nonatomic, strong) UIButton * chooseBut2;

@property (nonatomic,assign) NSInteger flag;

@end
@implementation MyMemberOrderTableViewController
@synthesize order_id,cat_id,member_id;

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi) name:@"Tongzhi" object:nil];
    
    if(self.navigationController.viewControllers && self.navigationController.viewControllers.count >1){
        
    }else{
        self.backBtn.hidden =YES;
    }
    
    for(UIView *view in [self.view subviews])
    {
        [view removeFromSuperview];
    }
    _chooseView1 = nil;
    _chooseView2 = nil;
    self.order_status = @"";
    self.pay_status = @"";
    self.product_category = @"";
    [self initData];
    [self initTable];
    
}
-(void)tongzhi{
    for(UIView *view in [self.view subviews])
    {
        [view removeFromSuperview];
    }
    [self viewDidLoad];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"会员订单";
    self.view.backgroundColor=BgViewColor;
    
    
    
}

-(void)goToLogin{
    LoginAndRegisterViewController *loginV = [[LoginAndRegisterViewController alloc] init];
    [self.navigationController pushViewController:loginV animated:YES];
    
}

-(void)initData
{
    /*
     product_category ：
     -1     ----- 门票
     2      ----- 签证
     3      ----- 邮轮
     -5     ----- 新邮轮
     5      ----- 一日游
     6      ----- 周边游
     7      ----- 国内游
     8      ----- 出境游
     9      ----- 港澳台
     10     ----- 境外参团
     */
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *md5str = [NSString stringWithFormat:@"~0;id<zOD.{ll@]JKi(:%@",[[LXUserTool alloc] getUid]];
    md5str = [WXUtil md5:md5str];
    self.sortDictionary = @{@"product_category":self.product_category};
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:[[LXUserTool alloc] getUid] forKey:@"member_id"];
    [parameters setValue:@"1" forKey:@"is_assistant_member"];
    [parameters setValue:[self dictionaryToJson:_sortDictionary] forKey:@"where"];
    [parameters setValue:md5str forKey:@"wltoken"];
    [parameters setValue:@"create_time" forKey:@"by"];
    
//    if (![self.order_status isEqualToString:@""]) {
        [parameters setValue:self.order_status forKey:@"order_status"];
//    }
//    if (![self.pay_status isEqualToString:@""]) {
        [parameters setValue:self.pay_status forKey:@"pay_status"];
//    }
//    NSMutableDictionary *parameters = @{@"member_id":[[LXUserTool alloc] getUid], @"pay_status":self.pay_status, @"order_status":self.order_status,@"is_assistant_member":@"1",@"where":[self dictionaryToJson:_sortDictionary],@"wltoken":md5str,@"by":@"create_time"};
    
    NSLog(@"parameters is %@",parameters);
    [manager POST:GetOrderListUrl parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:responseObject options:0 error:nil];
        
        id data = [dict valueForKey:@"data"];
        
        if (_orderArray && _orderArray.count>0) {
            [_orderArray removeAllObjects];
        }
        _orderArray = [[NSMutableArray alloc] initWithCapacity:0];
        
        if ([data isKindOfClass:[NSArray class]]) {
            NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
            arr = [dict valueForKey:@"data"];
            
            NSString *imageNewUrl = nil;
            
//#pragma mark ---- 修改左边图片展示判断 ----
//            for (NSDictionary *dataDic in arr) {
//                NSString *imageUrlStr = dataDic[@"img"];
//                if ([imageUrlStr hasPrefix:@"http"]) {
//                    imageNewUrl = imageUrlStr;
//                } else if ([imageUrlStr hasPrefix:@"/upload"]) {
//                    imageUrlStr = [NSString stringWithFormat:@"%@%@",WLHTTP,imageUrlStr];
//                } else if ([imageUrlStr hasPrefix:@"20"]) {
//                    NSString *urlStr1 = [NSString stringWithFormat:@"%@/upload/thumb/",WLHTTP];
//                    NSString *urlStr2 = [NSString stringWithFormat:@"%@%@",urlStr1,imageUrlStr];
//                    imageUrlStr = urlStr2;
//                }
//            }
            
            for (int a = 0; a < arr.count; a ++)
            {
                cat_id = [[arr objectAtIndex:a ] valueForKey:@"product_category"];
                NSString *imgeURLString =WLHTTP;
                
                // @"https://www.weilv100.com/";
                if([cat_id integerValue] == 2){
                    //签证
                    imgeURLString =[NSString stringWithFormat:@"%@/",WLHTTP];
                    //@"https://www.weilv100.com/";
                }else if([cat_id integerValue] == 3){
                    //老游轮
                    imgeURLString =WLHTTP;
                    //@"https://www.weilv100.com/";
                }else{
                    //旅游
                    imgeURLString =[NSString stringWithFormat:@"%@/upload/thumb/",WLHTTP];
                    //@"https://www.weilv100.com/upload/thumb/";
                }
//                if (!([[arr objectAtIndex:a] valueForKey:@"img"]==nil || [[[arr objectAtIndex:a] valueForKey:@"img"]isEqual:[NSNull null]])) {
//                    
//                    if ([[[arr objectAtIndex:a] valueForKey:@"img"] hasPrefix:@"https://"]||[[[arr objectAtIndex:a] valueForKey:@"img"] hasPrefix:@"http://"]) {
//                        imgeURLString = [[arr objectAtIndex:a] valueForKey:@"img"];
//                    }else{
//                        imgeURLString = [imgeURLString stringByAppendingString: [[arr objectAtIndex:a] valueForKey:@"img"]];
//                    }
//                }else {
//                    imgeURLString = @"";
//                }

#pragma mark ---- 修改左边图片展示判断 ----
                NSDictionary *imgDataDic = arr[a];
                NSString *imageUrlStr = imgDataDic[@"img"];
                
                if ([imageUrlStr isEqual:[NSNull null]]) {
                    NSLog(@"%@",imgDataDic[@"product_name"]);
                    imageUrlStr = @"";
                } else {
                if ([imageUrlStr hasPrefix:@"http"]) {
                    imageNewUrl = imageUrlStr;
                    
                } else if ([imageUrlStr hasPrefix:@"/upload"]) {
                    imageUrlStr = [NSString stringWithFormat:@"%@%@",WLHTTP,imageUrlStr];
                    
                } else if ([imageUrlStr hasPrefix:@"20"]) {
                    
                    NSString *urlStr1 = [NSString stringWithFormat:@"%@/upload/thumb/",WLHTTP];
                    NSString *urlStr2 = [NSString stringWithFormat:@"%@%@",urlStr1,imageUrlStr];
                    imageUrlStr = urlStr2;
                }
                }
                
                NSString *payStateString = @"";
                if ([[[arr objectAtIndex:a] valueForKey:@"pay_status"] isEqualToString:@"0"]&& ([[[arr objectAtIndex:a] valueForKey:@"order_status"] isEqualToString:@"0"] || [[[arr objectAtIndex:a] valueForKey:@"order_status"] isEqualToString:@"1"])) {
                    payStateString =@"[待付款]";
                }else if ([[[arr objectAtIndex:a] valueForKey:@"pay_status"] integerValue] == 1){
                    payStateString =@"[已付款]";
                }

                
                
//                NSString *OrderStateString = @"";
//                if ([[[arr objectAtIndex:a] valueForKey:@"order_status"] isEqualToString:@"0"]) {
//                    OrderStateString = @"[新订单]";
//                }else if([[[arr objectAtIndex:a] valueForKey:@"order_status"] isEqualToString:@"2"]){
//                    OrderStateString = @"[订单已完成]";
//                }else if([[[arr objectAtIndex:a] valueForKey:@"order_status"] isEqualToString:@"5"]){
//                    OrderStateString = @"［处理完成］";
//                }else if([[[arr objectAtIndex:a] valueForKey:@"order_status"] isEqualToString:@"6"]){
//                    OrderStateString = @"[退款中]";
//                }else if([[[arr objectAtIndex:a] valueForKey:@"order_status"] isEqualToString:@"7"]){
//                    OrderStateString = @"[退款成功]";
//                }else if([[[arr objectAtIndex:a] valueForKey:@"order_status"] isEqualToString:@"8"]){
//                    OrderStateString = @"[退款失败]";
//                }else if([[[arr objectAtIndex:a] valueForKey:@"order_status"] isEqualToString:@"9"]){
//                    OrderStateString = @"[订单已取消]";
//                }else if([[[arr objectAtIndex:a] valueForKey:@"order_status"] isEqualToString:@"10"]){
//                    OrderStateString = @"[已清分]";
//                }else if([[[arr objectAtIndex:a] valueForKey:@"order_status"] isEqualToString:@"11"]){
//                    OrderStateString = @"[已取消]";
//                }else if ([[[arr objectAtIndex:a] valueForKey:@"pay_status"] integerValue] == 0 &&([[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 90 || [[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 91 || [[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 92)) {
//                    OrderStateString = @"[待确认]";
//                }
                
                
                MyOrderModel *orderModel=[[MyOrderModel alloc] init];
                orderModel.leftImageUrl= imageUrlStr;
                orderModel.titleStr=[NSString stringWithFormat:@"%@",[[arr objectAtIndex:a] valueForKey:@"product_name"]];
                orderModel.priceStr=[NSString stringWithFormat:@"￥%@",[[arr objectAtIndex:a] valueForKey:@"order_price"]];
                //                      orderModel.orderState=payStateString;
//                if ([[[arr objectAtIndex:a] valueForKey:@"pay_status"] integerValue] == 0 && ([[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 90 || [[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 91 || [[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 92 || [[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 12)) {
//                    //                          OrderStateString = @"[待确认]";
//                    orderModel.orderState=@"[待确认]";
//                } else if([[[arr objectAtIndex:a] valueForKey:@"pay_status"] integerValue] == 1 && [[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 2){
//                    orderModel.orderState=@"[已完成]";
//                    
//                }else{
//                    orderModel.orderState=payStateString;
//                }
//                if([[[arr objectAtIndex:a] valueForKey:@"pay_status"] integerValue] == 0 && [[[arr objectAtIndex:a] valueForKey:@"order_status"] isEqualToString:@"11"]){
//                    orderModel.orderState = @"[已取消]";
//                }
                
//                switch ([[[arr objectAtIndex:a] valueForKey:@"pay_status"] integerValue]) {
//                        
//                    case 0:
//                        
//                        if (([[[arr objectAtIndex:a] valueForKey:@"order_status"] isEqualToString:@"0"] || [[[arr objectAtIndex:a] valueForKey:@"order_status"] isEqualToString:@"1"]) && [[[arr objectAtIndex:a] valueForKey:@"pay_status"] isEqualToString:@"0"]) {
//                            orderModel.orderState=@"[待付款]";
//                            
//                        } else if ([[[arr objectAtIndex:a] valueForKey:@"pay_status"] integerValue] == 0 && ([[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 90 || [[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 91 || [[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 92 || [[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 12)) {
//                            orderModel.orderState=@"[待确认]";
//                            
//                        } else if ([[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 11) {
//                            orderModel.orderState=@"[已取消]";
//                        }
//                        
//                        break;
//                    
//                    case 1:
//                        
//                        if ([[[arr objectAtIndex:a] valueForKey:@"pay_status"] integerValue] == 1 && [[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 2) {
//                            orderModel.orderState=@"[已完成]";
//                            
//                        } else {
//                            
//                            orderModel.orderState=@"[已付款]";
//                            
//                        }
//                        
//                        break;
//                        
//                    default:
//                        break;
//                }
                
                if ([[[arr objectAtIndex:a] valueForKey:@"pay_status"] integerValue] == 0) {
                    
                    if (([[[arr objectAtIndex:a] valueForKey:@"order_status"] isEqualToString:@"0"] || [[[arr objectAtIndex:a] valueForKey:@"order_status"] isEqualToString:@"1"]) && [[[arr objectAtIndex:a] valueForKey:@"pay_status"] isEqualToString:@"0"]) {
                            orderModel.orderState=@"[待付款]";
                        
                    } else if ([[[arr objectAtIndex:a] valueForKey:@"pay_status"] integerValue] == 0 && ([[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 90 || [[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 91 || [[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 92 || [[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 12)) {
                        orderModel.orderState=@"[待确认]";
                        
                    } else if ([[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 11) {
                        orderModel.orderState=@"[已取消]";
                    }
                    
                } else {
                    
                    if ([[[arr objectAtIndex:a] valueForKey:@"pay_status"] integerValue] == 1 && [[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 2) {
                        
                        orderModel.orderState=@"[已完成]";
                    }
                    else if ([[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 11) {
                        
                        orderModel.orderState=@"[已取消]";

                    }
                    else {

                        orderModel.orderState=@"[已付款]";
                        
                    }
                }
                
                
//                if ([[[arr objectAtIndex:a] valueForKey:@"pay_status"] integerValue] == 0 && ([[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 90 || [[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 91 || [[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 92 || [[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 12)) {
//                    orderModel.orderState=@"[待确认]";
//                } else if ([[[arr objectAtIndex:a] valueForKey:@"pay_status"] integerValue] == 1 && [[[arr objectAtIndex:a] valueForKey:@"order_status"] integerValue] == 2) {
//                    orderModel.orderState=@"[已完成]";
//                    
//                } else if ([[[arr objectAtIndex:a] valueForKey:@"pay_status"] integerValue] == 1 ) {
//                    orderModel.orderState=@"[已付款]";
//                    
//                } else if ([[[arr objectAtIndex:a] valueForKey:@"order_status"] isEqualToString:@"11"]) {
//                    orderModel.orderState=@"[已取消]";
//                    
//                } else if (([[[arr objectAtIndex:a] valueForKey:@"order_status"] isEqualToString:@"0"] || [[[arr objectAtIndex:a] valueForKey:@"order_status"] isEqualToString:@"1"]) && [[[arr objectAtIndex:a] valueForKey:@"pay_status"] isEqualToString:@"0"]) {
//                    orderModel.orderState=@"[待付款]";
//                }
                
                
                
                
                
                orderModel.order_id = [NSString stringWithFormat:@"%@",[[arr objectAtIndex:a] valueForKey:@"order_id"]];
                NSString *catId =[NSString stringWithFormat:@"%@",[[arr objectAtIndex:a] valueForKey:@"product_category"]];
                if ([catId intValue] >3 ||[catId intValue]==1 || [catId intValue]==-11 || [catId intValue]==-12 || [catId intValue]==-13 || [catId intValue]==-14 || [catId intValue]==-15)
                {
//                    orderModel.cat_id =catId;      //旅游
//                    orderModel.catName = @"旅游度假";
                    if ([catId intValue]==-11 || [catId intValue] == 6) {
                        orderModel.catName = @"周边游";
                    } else if ([catId intValue]==-12 || [catId intValue]==7) {
                        orderModel.catName = @"国内游";
                    } else if ([catId intValue]==-13 || [catId intValue]==8) {
                        orderModel.catName = @"出境游";
                    } else if ([catId intValue]==-14 || [catId intValue]== 9) {
                        orderModel.catName = @"港澳台";
                    } else if ([catId intValue]==-15 || [catId intValue]==10) {
                        orderModel.catName = @"境外参团";
                    }else if([catId intValue]==5){
                        orderModel.catName = @"一日游";

                    }else {
                        orderModel.catName = @"旅游度假";
                    }
                    orderModel.cat_id =catId;      //旅游
                    
                }
                else if ([catId intValue]==2)
                {
                    orderModel.cat_id = @"2";      //签证
                    orderModel.catName = @"签证";
                }
                else if([catId intValue]==3 || [catId intValue]==-5)
                {
                    orderModel.cat_id = catId;      //邮轮
                    orderModel.catName = @"邮轮";
                }
                else if([catId intValue]== -1)
                {
                    orderModel.cat_id =catId;     //门票
                    orderModel.catName = @"门票";
                }
                else if([catId intValue]== -2)
                {
                    orderModel.cat_id = catId;      //游学
                    orderModel.catName = @"游学";
                }
                else if([cat_id integerValue] == -3)
                {
                    orderModel.cat_id =catId;      //机票
                    orderModel.catName = @"机票";
                }else
                {
                    orderModel.cat_id =@"0";      //游学
                    orderModel.catName = @"全部";
                }
                
                orderModel.contactsStr = [NSString stringWithFormat:@"联系人：%@",[[arr objectAtIndex:a] valueForKey:@"contacts"]];
                orderModel.phoneStr = [NSString stringWithFormat:@"电话：%@",[[arr objectAtIndex:a] valueForKey:@"cphone"]];
                orderModel.member_id = [NSString stringWithFormat:@"%@",[[arr objectAtIndex:a] valueForKey:@"member_id"]];
                
                [_orderArray addObject:orderModel];
                
            }
            
        }
        NSLog(@"orderArray:%@+++++++++",_orderArray);
        
        [_orderTab reloadData];
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}
-(void)initTable
{
    [self.view addSubview:[self headerChooseView]];
    _orderTab=[[UITableView alloc] initWithFrame:CGRectMake(0, 40, windowContentWidth, windowContentHeight-NavHeight-40) style:UITableViewStylePlain];
    _orderTab.delegate=self;
    _orderTab.dataSource=self;
    _orderTab.backgroundColor = BgViewColor;
    _orderTab.separatorStyle = UITableViewCellSeparatorStyleNone;//去除分割线
    _orderTab.tableFooterView=[[UIView alloc] init];//去掉多余的cell
    if(self.navigationController.viewControllers && self.navigationController.viewControllers.count >1){
        
    }else{
        [_orderTab setFrame:CGRectMake(0, 40, windowContentWidth, windowContentHeight-NavHeight-40- 50)];
    }
    [self.view addSubview:_orderTab];
    
    NSMutableArray *imageAray=[NSMutableArray array];
    for (int a=0; a<2; a++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"单独-logo%d.png", a+2]];
        [imageAray addObject:image];
    }
    
    //-----------下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [_orderTab addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置普通状态的动画图片
    [_orderTab.gifHeader setImages:imageAray forState:MJRefreshHeaderStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [_orderTab.gifHeader setImages:imageAray forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [_orderTab.gifHeader setImages:imageAray forState:MJRefreshHeaderStateRefreshing];
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
    // 马上进入刷新状态
    [_orderTab.gifHeader beginRefreshing];
    
    //----------上拉加载更多
    // [_orderTab addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadLastData)];
}

- (UIView *)headerChooseView
{
    UIView * headerChooseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 40)];
    headerChooseView.backgroundColor = [UIColor whiteColor];
    
    self.chooseBut1 =[UIButton buttonWithType:UIButtonTypeCustom];
    _chooseBut1.frame = CGRectMake(windowContentWidth/4 - 40, 0,100, 40);
    _chooseBut1.titleLabel.font = [UIFont systemFontOfSize:15];
    [_chooseBut1 setTitle:@"类目" forState:UIControlStateNormal];
    [_chooseBut1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_chooseBut1 addTarget:self action:@selector(addChooseView:) forControlEvents:UIControlEventTouchUpInside];
    _chooseBut1.tag = 1;
    [headerChooseView addSubview:_chooseBut1];
    UIImageView *litileImage1=[[UIImageView alloc] init];
    litileImage1.frame=CGRectMake(100, 30, 5, 5);
    litileImage1.image=[UIImage imageNamed:@"矩形-3.png"];
    [_chooseBut1 addSubview:litileImage1];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(windowContentWidth/2- 0.25, 8 , 0.5, ViewHeight(headerChooseView) -16)];
    line.backgroundColor = [UIColor orangeColor];
    line.alpha = 0.8;
    [headerChooseView addSubview:line];
    
    
    self.chooseBut2 =[UIButton buttonWithType:UIButtonTypeCustom];
    _chooseBut2.frame = CGRectMake(windowContentWidth/4*3+0.25 - 40, 0, 100, 40);
    _chooseBut2.titleLabel.font = [UIFont systemFontOfSize:15];
    [_chooseBut2 setTitle:@"状态" forState:UIControlStateNormal];
    [_chooseBut2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_chooseBut2 addTarget:self action:@selector(addChooseView:) forControlEvents:UIControlEventTouchUpInside];
    _chooseBut2.tag = 2;
    [headerChooseView addSubview:_chooseBut2];
    UIImageView *litileImage2=[[UIImageView alloc] init];
    litileImage2.frame=CGRectMake(100, 30, 5, 5);
    litileImage2.image=[UIImage imageNamed:@"矩形-3.png"];
    [_chooseBut2 addSubview:litileImage2];
    
    
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0 ,ViewHeight(headerChooseView)-0.5,  windowContentWidth , 0.5)];
    lab.layer.borderWidth = 0.25;
    lab.layer.borderColor = [UIColor lightGrayColor].CGColor;//[UIColor groupTableViewBackgroundColor].CGColor;
    [headerChooseView addSubview:lab];
    
    return headerChooseView;
}

#pragma mark - 添加类目，状态
- (void)addChooseView:(UIButton *)button
{
    //类目
    if (button.tag == 1)
    {
        _chooseView2.hidden = YES;
        
        if (![_chooseBut1.titleLabel.text isEqual:@"类目"])
        {
            [_chooseBut1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }
        else
        {
            [_chooseBut1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        if(!_chooseView1)
        {
            NSArray * chooseOrderTitle =@[@"\t  全部", @"\t  门票", @"\t  签证", @"\t  邮轮",@"\t  一日游",@"\t  周边游",@"\t  国内游",@"\t  出境游",@"\t  港澳台",@"\t  境外参团",@"\t  游学"];
            self.chooseView1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, windowContentHeight, ViewHeight(self.view)-40)];
            self.chooseView11 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentHeight, ViewHeight(self.view))];
            if (ViewHeight(self.view)- 44 -40 < 35*chooseOrderTitle.count)
            {
                _chooseView1.contentSize = CGSizeMake(windowContentWidth,35*chooseOrderTitle.count+44);
                
            }
            _chooseView1.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
            [_chooseView1 addSubview:_chooseView11];
            [self.view addSubview: _chooseView1];
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
            tapGestureRecognizer.cancelsTouchesInView = NO;
            [_chooseView1 addGestureRecognizer:tapGestureRecognizer];
            
            
            for (int i = 0; i < chooseOrderTitle.count; i++)
            {
                UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
                but.frame = CGRectMake(0, 35 * i , windowContentWidth, 35);
                but.backgroundColor = [UIColor whiteColor];
                [but setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                but.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
                [but setTitle:[chooseOrderTitle objectAtIndex:i] forState:UIControlStateNormal];
                but.tag = 1 + i;
                [but addTarget:self action:@selector(chooseOrderType:) forControlEvents:UIControlEventTouchUpInside];
                [_chooseView11 addSubview:but];
                
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0 ,ViewHeight(but)-0.5,  windowContentWidth , 0.5)];
                lab.layer.borderWidth = 0.25;
                lab.layer.borderColor = [UIColor lightGrayColor].CGColor;
                [but addSubview:lab];
                if (i == 0)
                {
                    [self chooseOrderType:but];
                    _chooseView1.hidden =NO;
                }
            }
        }
        else
        {
            if(_chooseView1.hidden == YES)
            {
                _chooseView1.hidden = NO;
            }
            else if(_chooseView1.hidden == NO)
            {
                _chooseView1.hidden = YES;
            }
        }
    }
    else if (button.tag == 2)  //状态
    {
        _chooseView1.hidden = YES;
        
        if (![_chooseBut2.titleLabel.text isEqual:@"状态"])
        {
            [_chooseBut2 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }
        else
        {
            [_chooseBut2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        
        if(!_chooseView2)
        {
            NSArray * chooseOrderTitle = @[@"\t  全部",@"\t  待确认", @"\t  待付款", @"\t  已付款",@"\t  已完成", @"\t  已取消"];
            self.chooseView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 40, windowContentHeight, ViewHeight(self.view))];
            _chooseView2.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
            [self.view addSubview: _chooseView2];
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
            tapGestureRecognizer.cancelsTouchesInView = NO;
            [_chooseView2 addGestureRecognizer:tapGestureRecognizer];
            
            for (int i = 0; i < chooseOrderTitle.count; i++)
            {
                UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
                but.frame = CGRectMake(0, 35 * i , windowContentWidth, 35);
                but.backgroundColor = [UIColor whiteColor];
                
                [but setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                but.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
                [but setTitle:[chooseOrderTitle objectAtIndex:i] forState:UIControlStateNormal];
                but.tag = 12 + i;
                [but addTarget:self action:@selector(chooseOrderType:) forControlEvents:UIControlEventTouchUpInside];
                [_chooseView2 addSubview:but];
                
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0 ,ViewHeight(but)-0.5,  windowContentWidth , 0.5)];
                lab.layer.borderWidth = 0.25;
                lab.layer.borderColor = [UIColor lightGrayColor].CGColor;//[UIColor groupTableViewBackgroundColor].CGColor;
                [but addSubview:lab];
                if (i == 0)
                {
                    [self chooseOrderType:but];
                    _chooseView2.hidden =NO;
                }
            }
        }
        else
        {
            if(_chooseView2.hidden == YES)
            {
                _chooseView2.hidden = NO;
            }
            else if(_chooseView2.hidden == NO)
            {
                _chooseView2.hidden = YES;
            }
        }
    }
    
    
    
}
#pragma mark - 点击 栏目，状态二级页面的按钮 触发事件
- (void)chooseOrderType:(UIButton *)button{
    
    if (button.tag <12)
    {
        //类目二级按钮触发事件
        for(UIButton *btnn in [_chooseView11 subviews])
        {
            [btnn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        if (button.tag!=1)
        {
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [_chooseBut1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [_chooseBut1 setTitle:button.titleLabel.text forState:UIControlStateNormal];
        }
        else
        {
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [_chooseBut1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_chooseBut1 setTitle:@"类目" forState:UIControlStateNormal];
        }
    }
    else
    {
        //状态二级按钮触发事件
        for(UIButton *btnn in [_chooseView2 subviews])
        {
            [btnn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        if (button.tag!=12)
        {
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [_chooseBut2 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [_chooseBut2 setTitle:button.titleLabel.text forState:UIControlStateNormal];
        }
        else
        {
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [_chooseBut2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_chooseBut2 setTitle:@"状态" forState:UIControlStateNormal];
        }
    }
    
    switch (button.tag)
    {
            //全部
        case 1:
            _chooseView1.hidden = YES;
            //self.pay_status = @""; self.order_status = @"";
            self.product_category = @"";
            [self initData];
            break;
            //门票
        case 2:
            _chooseView1.hidden = YES;
            //self.pay_status = @""; self.order_status = @"";
            self.product_category = @"-1";
            [self initData];
            break;
            //签证
        case 3:
            _chooseView1.hidden = YES;
            //self.pay_status = @""; self.order_status = @"";
            self.product_category = @"2";
            [self initData];
            break;
            //邮轮
        case 4:
            _chooseView1.hidden = YES;
            //self.pay_status = @""; self.order_status = @"";
            self.product_category = @"3,-5";
            [self initData];
            break;
            //一日游
        case 5:
            _chooseView1.hidden = YES;
            //self.pay_status = @""; self.order_status = @"";
            self.product_category = @"5";
            [self initData];
            break;
            //周边游
        case 6:
            _chooseView1.hidden = YES;
            //self.pay_status = @""; self.order_status = @"";
            self.product_category = @"6,-11";
            [self initData];
            break;
            //国内游
        case 7:
            _chooseView1.hidden = YES;
            //self.pay_status = @""; self.order_status = @"";
            self.product_category = @"7,-12";
            [self initData];
            break;
            //出境游
        case 8:
            _chooseView1.hidden = YES;
            //self.pay_status = @""; self.order_status = @"";
            self.product_category = @"8,-13";
            [self initData];
            break;
            //港澳台
        case 9:
            _chooseView1.hidden = YES;
            //self.pay_status = @""; self.order_status = @"";
            self.product_category = @"9,-14";
            [self initData];
            break;
            //境外参团
        case 10:
            _chooseView1.hidden = YES;
            //self.pay_status = @""; self.order_status = @"";
            self.product_category = @"10,-15";
            [self initData];
            break;
            //游学
        case 11:
            _chooseView1.hidden = YES;
            // self.pay_status = @""; self.order_status = @"";
            self.product_category = @"-2";
            [self initData];
            break;
            //状态-全部
        case 12:
            _chooseView2.hidden = YES;
            self.pay_status = @""; self.order_status = @"all";
            //self.product_category = @"";
            [self initData];
            break;
            //待确认
        case 13:
            _chooseView2.hidden = YES;
            self.pay_status = @"0"; self.order_status = @"90,91,92";
            //self.product_category = @"";
            [self initData];
            break;
            //待付款
        case 14:
            _chooseView2.hidden = YES;
            self.pay_status = @"0"; self.order_status = @"0";
            //self.product_category = @"";
            [self initData];
            break;
            //已付款
        case 15:
            _chooseView2.hidden = YES;
            self.pay_status = @"1"; self.order_status = @"0,1";
            //self.product_category = @"";
            [self initData];
            break;
            //已完成
        case 16:
            _chooseView2.hidden = YES;
            self.pay_status = @"1"; self.order_status = @"2";
            //self.product_category = @"";
            [self initData];
            break;
            //已取消
        case 17:
            _chooseView2.hidden = YES;
            self.pay_status = @"";
            self.order_status = @"11";
            //self.product_category = @"";
            [self initData];
            break;
        default:
            break;
    }
    
}

-(void)loadNewData{
    
    DLog(@"下拉刷新");
    sleep(1);
    // 刷新表格
    [_orderTab reloadData];
    
    // 拿到当前的下拉刷新控件，结束刷新状态
    [_orderTab.header endRefreshing];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _chooseView1.hidden = YES;
    _chooseView2.hidden = YES;
    
}

/*
 -(void)loadLastData{
 
 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
 // 刷新表格
 [_orderTab reloadData];
 
 // 拿到当前的上拉刷新控件，变为没有更多数据的状态 [_tableView.footer noticeNoMoreData]
 [_orderTab.footer endRefreshing];
 });
 
 }*/

#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _orderArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier0 = @"cellIdentifier0";
    MyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier0];
    if (cell == nil) {
        cell = [[MyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier0];
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    //    if (indexPath.row == 0){
    //        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0 , windowContentWidth - 10, 0.5)];
    //        lab.layer.borderWidth = 0.25;
    //        lab.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //        [cell addSubview:lab];
    //    }
    MyOrderModel *model=[_orderArray objectAtIndex:indexPath.row];
    cell.item=model;
    //NSLog(@"%@",model.cat_id);
    
    return cell;
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 40;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyOrderModel *orderModel1=[[MyOrderModel alloc] init];
    orderModel1 =[_orderArray objectAtIndex:indexPath.row];
    self.order_id = orderModel1.order_id;
    self.cat_id = orderModel1.cat_id;
    self.member_id = orderModel1.member_id;
    
    if ([self.cat_id integerValue] == -3) {
        PlaneTicketViewController *mydetail = [[PlaneTicketViewController alloc] init];
        mydetail.order_id = self.order_id;
        mydetail.cat_id = self.cat_id;
        mydetail.member_id = self.member_id;
        [self.navigationController pushViewController:mydetail animated:YES];
    }else if([self.cat_id integerValue] == -5 || [self.cat_id integerValue] == 3){
        ShipCSHViewController *mydetail = [[ShipCSHViewController alloc] init];
        mydetail.order_id = self.order_id;
        mydetail.cat_id = self.cat_id;
        mydetail.member_id = self.member_id;
        [self.navigationController pushViewController:mydetail animated:YES];
    }else if([self.cat_id integerValue] == -11 || [self.cat_id integerValue] == -12 || [self.cat_id integerValue] == -13 || [self.cat_id integerValue] == -14 || [self.cat_id integerValue] == -15 || [self.cat_id integerValue] == 5 || [self.cat_id integerValue] == 6 || [self.cat_id integerValue] == 7 || [self.cat_id integerValue] == 8 || [self.cat_id integerValue] == 9 || [self.cat_id integerValue] == 10){
        DetailOrideViewController *mydetail = [[DetailOrideViewController alloc] init];
        
        mydetail.order_id = self.order_id;
        mydetail.cat_id = self.cat_id;
        mydetail.member_id = self.member_id;
        mydetail.frontPageFlag = @"100";
        
        if ([[WLSingletonClass defaultWLSingleton] wlUserType]==WLMemberTypeSteward) {
            mydetail.hideArrowFlag = @"300";
        }
       
        
        [self.navigationController pushViewController:mydetail animated:YES];
    }else{
        MyOrderDetailViewController *mydetail = [[MyOrderDetailViewController alloc] init];
        mydetail.order_id = self.order_id;
        mydetail.cat_id = self.cat_id;
        mydetail.member_id = self.member_id;
        [self.navigationController pushViewController:mydetail animated:YES];
        
    }
    
}


- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

-(void)keyboardHide:(UITapGestureRecognizer *)tap{
    _chooseView2.hidden = YES;
    _chooseView1.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

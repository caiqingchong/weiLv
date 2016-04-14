//
//  ShaixuanVc.m
//  Lvyou
//
//  Created by 赵冉 on 16/1/12.
//  Copyright © 2016年 赵冉. All rights reserved.
//

#import "ShaixuanVc.h"
#import "AFHTTPRequestOperationManager.h"
#import "GuoneiyouModel.h"
#import "ShaixuanTableViewCell.h"
#import "Desmodel.h"
#import "DayTableViewCell.h"
#import "PriceTableViewCell.h"
#import "TravelAllHeader.h"

#define BgViewColor [UIColor colorWithRed:222/255.0 green:229/255.0 blue:235/255.0 alpha:1]
// 目的地接口


@interface ShaixuanVc ()

@property(nonatomic,assign)BOOL isFirstLoadData;

@end

static int A = 1;//判断天转页面的标识符
@implementation ShaixuanVc
#pragma mark-- 初始化
-(instancetype)initWithCityID:(NSString *)cityID andRouteType:(NSString *)routeType andDestination:(NSArray *)datasource
{
    if (self = [super init]) {
        _datasource = [NSMutableArray array];
        _Pricedata = [NSMutableArray array];
        _Daydata =  [NSMutableArray array];
        _Dayarray = [NSMutableArray array];
        _Pricearray = [NSMutableArray array];
        _datasource = (NSMutableArray *)datasource;
        self.frame = CGRectMake(0, 0,windowContentWidth, windowContentHeight);
        
        self.backgroundColor=[UIColor colorWithWhite:0.5 alpha:0.5];
    }

    _city_id=[[WLSingletonClass defaultWLSingleton] wlCityId];
    _rote_ID = routeType;
    _Mdit = [NSMutableDictionary dictionary];
    
    self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, windowContentHeight - windowContentHeight /3.1 - 64, windowContentWidth, windowContentHeight / 3.1)];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backgroundView];
    
    _cellheight = 40;
    // 用来隐藏父视图按钮
    UIButton * butt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth,windowContentHeight - windowContentHeight / 3.1 - 100)];
    [butt addTarget:self action:@selector(ONbuttclick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:butt];
    
    //创建试图内容
    [self createVc];
    
    return self;


}
//- (instancetype)init{
//    if (self = [super init]) {
//          _datasource = [NSMutableArray array];
//        _Pricedata = [NSMutableArray array];
//        _Daydata =  [NSMutableArray array];
//               _Dayarray = [NSMutableArray array];
//        _Pricearray = [NSMutableArray array];
//        self.frame = CGRectMake(0, 0,windowContentWidth, windowContentHeight);
//        
//        self.backgroundColor=[UIColor colorWithWhite:0.5 alpha:0.5];
//    }
//    //static int Height = 367/2;
//    _city_id=[[WLSingletonClass defaultWLSingleton] wlCityId];
//
//    _Mdit = [NSMutableDictionary dictionary];
//
//    self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, windowContentHeight - windowContentHeight /3.1 - 64, windowContentWidth, windowContentHeight / 3.1)];
//    self.backgroundView.backgroundColor = [UIColor whiteColor];
//    [self addSubview:self.backgroundView];
//    
//    _cellheight = windowContentHeight / 16.67;
//    // 用来隐藏父视图按钮
//    UIButton * butt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth,windowContentHeight - windowContentHeight / 3.1 - 100)];
//    [butt addTarget:self action:@selector(ONbuttclick) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:butt];
//    
//    //创建试图内容
//    [self createVc];
//    
//    return self;
//}
 // 用来隐藏父视图按钮点击事件
- (void)ONbuttclick{
    self.hidden = YES;
}
- (void)createVc{
    
     UIButton * leftbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0 , windowContentWidth / 2.5, windowContentHeight / 3.1 / 5.3)];
    [leftbutton setTitle:@"取消" forState:UIControlStateNormal];
    leftbutton.titleLabel.font = [UIFont systemFontOfSize:windowContentWidth / 22];
    [leftbutton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(onLeftbuttonclick) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:leftbutton];
    //黑线
  
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, windowContentHeight / 3.1 / 5.3 , windowContentWidth,0.1)];
    line.backgroundColor = [UIColor blackColor];
    
    [_backgroundView addSubview:line];
    
    
    UIButton * rightbutton = [[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth / 2.5, 0 ,windowContentWidth - windowContentWidth / 2.5, windowContentHeight / 3.1 / 5.3)];

    [rightbutton setTitle:@"确定" forState:UIControlStateNormal];
    rightbutton.titleLabel.font = [UIFont systemFontOfSize:windowContentWidth / 22];
    [rightbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightbutton addTarget:self action:@selector(onRightbuttonclick) forControlEvents:UIControlEventTouchUpInside];
    rightbutton.backgroundColor = [UIColor orangeColor];
    [_backgroundView addSubview:rightbutton];
    
    
    //创建tablevc
    _tablevc=[[UITableView alloc] initWithFrame:CGRectMake(windowContentWidth / 2.6,windowContentHeight / 3.1 / 5.3,windowContentWidth - windowContentWidth / 2.6 ,windowContentHeight / 3.1 - windowContentHeight / 3.1 / 5.3) style:UITableViewStylePlain];
   
    _tablevc.delegate=self;
    _tablevc.dataSource=self;
    [_backgroundView addSubview:_tablevc];
    
    
    if ([_tablevc respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [_tablevc setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([_tablevc respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [_tablevc setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    
    //创建数组

//     NSArray * arr = @[@"目的地",@"行程天数",@"价格区间"];


    _topbutton = [[UIButton alloc]initWithFrame:CGRectMake(0,  windowContentHeight / 3.1 / 5.3 , windowContentWidth / 2.88, _cellheight)];
    _toplable = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 24.6,  0 , windowContentWidth / 2.88 - windowContentWidth / 24.6, _cellheight)];
    _toplable.text = @"目的地";
    _toplable.textColor = [UIColor orangeColor];
    _toplable.font = [UIFont systemFontOfSize:windowContentWidth / 23.4];
    [_topbutton addSubview:_toplable];
    [_topbutton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_topbutton addTarget:self action:@selector(ontopbutton) forControlEvents:UIControlEventTouchUpInside];
    _topbutton.backgroundColor = [UIColor whiteColor];
    [_backgroundView addSubview:_topbutton];
    
    
    
   _button = [[UIButton alloc]initWithFrame:CGRectMake(0, windowContentHeight / 3.1 / 5.3 +_cellheight, windowContentWidth / 2.88, _cellheight )];
    _lable = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 24.6, 0, windowContentWidth / 2.88 - windowContentWidth / 24.6, _cellheight)];
    _lable.text = @"行程天数";
    [_button addSubview:_lable];
    _lable.font = [UIFont systemFontOfSize:windowContentWidth /23.4];
 
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     _button.backgroundColor = BgViewColor;
     [_button addTarget:self action:@selector(buttonClik) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:_button];
    
    _lowbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, windowContentHeight / 3.1 / 5.3 + 2 * _cellheight , windowContentWidth / 2.88,windowContentHeight / 3.1 - 3 * _cellheight  )];
    _lowlable = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 24.6, 0 , windowContentWidth / 2.88 - windowContentWidth / 24.6,_cellheight)];
    _lowlable.text = @"价格区间";
    _lowlable.font = [UIFont systemFontOfSize:windowContentWidth /23.4];
    _lowlable.textColor = [UIColor blackColor];
    [_lowbutton addSubview:_lowlable];
    //[_lowbutton setTitle:@"价格区间" forState:UIControlStateNormal];
    [_lowbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _lowbutton.backgroundColor = BgViewColor;
    
    [_lowbutton addTarget:self action:@selector(onlowbutton) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:_lowbutton];
//获取数据
    [self ontopbutton];
   }

//  确定  按钮  点击事件
- (void)onRightbuttonclick{
    [self.delegate ReturnShaixuanstr:_Mdit];
    self.hidden = true;

}
//  取消  按钮  点击事件
- (void)onLeftbuttonclick{
   
    self.hidden = true;

}

//目的地，行程天数，价格区间  按钮 点击事件
- (void)ontopbutton
{
    _toplable.backgroundColor = [UIColor whiteColor];
    _topbutton.backgroundColor = [UIColor whiteColor];
     _lable.backgroundColor = BgViewColor;
    _button.backgroundColor = BgViewColor;
     _lowbutton.backgroundColor = BgViewColor;
    _lowlable.backgroundColor = BgViewColor;
    
    _toplable.textColor = [UIColor orangeColor];
    _lable.textColor = [UIColor blackColor];
    _lowlable.textColor = [UIColor blackColor];
    A = 1;
    if (_datasource.count == 0) {
        [self getdata];
    }
    else
    {
    [self.tablevc reloadData];
    }
}




-(void)buttonClik
{

    _topbutton.backgroundColor = BgViewColor;
    _toplable.backgroundColor = BgViewColor;

    _button.backgroundColor = [UIColor whiteColor];
    _lable.backgroundColor = [UIColor whiteColor];
    _lowbutton.backgroundColor = BgViewColor;
    _lowlable.backgroundColor = BgViewColor;
    
    _toplable.textColor = [UIColor blackColor];
     _lable.textColor = [UIColor orangeColor];
     _lowlable.textColor = [UIColor blackColor];
    
    A = 2;
    [self getDaydata];
}

- (void)onlowbutton
{
    _topbutton.backgroundColor = BgViewColor;
    _toplable.backgroundColor = BgViewColor;
    _button.backgroundColor = BgViewColor;
    _lable.backgroundColor = BgViewColor;
    _lowbutton.backgroundColor = [UIColor whiteColor];
    _lowlable.backgroundColor = [UIColor whiteColor];
    
    _toplable.textColor = [UIColor blackColor];
    _lable.textColor = [UIColor blackColor];
    _lowlable.textColor = [UIColor orangeColor];
    A = 3;
    [self getPricedata];
}

#pragma mark --  获取目的地数据
- (void)getdata{
    
    [_datasource removeAllObjects];
    AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary * parameters = @{@"route_type":_rote_ID,@"city_id":_city_id};
    [manger POST:DESTIONATUION parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dictroot = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        DLog(@"%@",dictroot);
        if ([dictroot[@"status"] intValue] == 1) {
            NSArray * array = dictroot[@"data"];
            for (NSDictionary * dict in array) {
                Desmodel * desmodel =[[Desmodel alloc]init];
                desmodel.region_name = dict[@"region_name"];
                desmodel.region_id = dict[@"region_id"];
                [_datasource addObject:desmodel];
            }
            _isFirstLoadData = NO;
            [self.tablevc reloadData];
        } else {
            [[LXAlterView sharedMyTools]createTishi:@"暂无相关数据!"];
            self.hidden = true;
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[LXAlterView sharedMyTools]createTishi:@"请求失败,请检查网络!"];
        self.hidden = true;
        
    }];
    
 }

#pragma mark --  获取行程天数数据
- (void)getDaydata{
    [_Daydata removeAllObjects];
    NSArray * arr = @[@"1-2天",@"3-5天",@"6-8天",@"8-15天",@"15天以上"];
    [_Daydata addObjectsFromArray:arr];
    
    [self.tablevc reloadData];
}

#pragma mark --  获取价格 数据
- (void)getPricedata{
    [_Pricedata removeAllObjects];
    NSArray * arr = @[@"0-500元",@"501-2000元",@"2001-5000元",@"5000-10000元",@"10000-20000元",@"20000元以上 "];
    [_Pricedata addObjectsFromArray:arr];
    
    [self.tablevc reloadData];
    
}
#pragma mark -- 实现tableview的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (A == 1) {
        return _datasource.count;
    }else if (A == 2){
     return _Daydata.count;
    }
    return _Pricedata.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _cellheight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (A == 1) {
        ShaixuanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
        if (cell == nil) {
            cell = [[ShaixuanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        }
        Desmodel * model = _datasource[indexPath.row];
        [cell config:model];
        return cell;
 
    }
   else if (A==2) {
        DayTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DayTableViewID"];
        if (cell == nil) {
            cell = [[DayTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DayTableViewID"];
        }
       cell.titlelable.text = [_Daydata objectAtIndex:indexPath.row];
       
       
          return cell;
     }else{
       PriceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PriceTableViewID"];
       if (cell == nil) {
           cell = [[PriceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PriceTableViewID"];
       }
       cell.titlelable.text = [_Pricedata objectAtIndex:indexPath.row];
       
       return cell;
   

     }


    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (A == 1) {
        _DFarray = [NSMutableArray array];

        Desmodel * model = _datasource[indexPath.row];
        _Destionstr = model.region_id;

        ShaixuanTableViewCell * cell = [self.tablevc cellForRowAtIndexPath:indexPath];
        NSString * DEstionstr = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        
        
        [_DFarray addObject:DEstionstr];
       
        [cell.Vc setImage:[UIImage imageNamed:@"矩形-34-副本-3"]];
        [_Mdit setObject:_Destionstr forKey:@"t_city"];

    }
    if (A == 2 ) {
        _Daystr = _Daydata[indexPath.row];
        DayTableViewCell * cell = [self.tablevc cellForRowAtIndexPath:indexPath];
        [cell.Vc setImage:[UIImage imageNamed:@"矩形-34-副本-3"]];
        
        if (indexPath.row == 4) {
            
            _Daystr = @"15-3650天";
        }

        [_Mdit setObject:[_Daystr substringToIndex:[_Daystr length]-1] forKey:@"day_area"];

    }
    if (A == 3) {
        _Pricestr = _Pricedata[indexPath.row];
        PriceTableViewCell * cell = [self.tablevc cellForRowAtIndexPath:indexPath];
        [cell.Vc setImage:[UIImage imageNamed:@"矩形-34-副本-3"]];
        DLog(@"%ld",indexPath.row);
        if (indexPath.row == 5) {
            
            _Pricestr = @"20000-500000元";
        }

        
       [_Mdit setObject:[_Pricestr substringToIndex:[_Pricestr length]-1] forKey:@"price_area"];
    }
    
}

#pragma mark 分割线左边对齐
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}




@end

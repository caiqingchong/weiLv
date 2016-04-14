//
//  CYYkViewController.m
//  WelLv
//
//  Created by 赵冉 on 16/1/19.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "CYYkViewController.h"
#import "CyYLTableViewCell.h"
#import "FillOrderViewController.h"
#import "CYYLModel.h"
#import "LoginAndRegisterViewController.h"
#import "TravelManagCusInfoViewController.h"
#import "ChangeTravellerInfoViewController.h"
#import "ChangeCYTravellerInfoViewController.h"
#import "MJRefresh.h"
#import "TravelOrderDetailModel.h"



@interface CYYkViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,Godelegate>{
    UITableView *_tableView;
    NSMutableArray *_datasource;
    UIScrollView *_scrollvc;
    NSMutableArray *cusInfoArray;
    NSDictionary *_parameters;
    NSMutableArray * _addarry;
    NSIndexPath *_lastpath;
    BOOL _editing;
}

@end



@implementation CYYkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _addarry = [NSMutableArray array];
    _datasource = [NSMutableArray array];
    self.view.backgroundColor = BgViewColor;
    
    
    _editing = NO;
    
    //    if ([[WLSingletonClass defaultWLSingleton] wlUserType]==WLMemberTypeNone) {
    //        [[LXAlterView sharedMyTools] createTishi:@"请先登录"];
    //        LoginViewController *loginVC = [[LoginViewController alloc]init];
    //        [self.navigationController pushViewController:loginVC animated:YES];
    //    } else {
    //        _parameters = @{@"member_id":[[LXUserTool alloc] getUid]};
    //       // [self GetData];
    //
    //    }
    
    //    [self.navigationItem.leftBarButtonItem ];
    
}

- (void)viewWillAppear:(BOOL)animated{
    for(UIView *view in [self.view subviews])
    {
        [view removeFromSuperview];
    }
    [self createScroll];
    [self createtop];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, windowContentHeight / 11.1 + windowContentHeight / 44.4, windowContentWidth, windowContentHeight-64)];
    _tableView.backgroundColor = [UIColor clearColor];
    [_scrollvc addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //[_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];//设置不显示cell间隔线
    
    
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];//设置不显示多余的cell
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
    UILabel *tsLabel = [[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth / 37.5, 65*cusInfoArray.count+5,windowContentWidth-windowContentWidth/21.7, windowContentHeight/29.44)];
    
    tsLabel.text = @"向左侧滑动删除联系人";
    tsLabel.textColor = [UIColor lightGrayColor];
    tsLabel.font = [UIFont systemFontOfSize:13];
    tsLabel.textAlignment = NSTextAlignmentLeft;
    _tableView.tableFooterView = tsLabel;
    
    [self GetData];
    
}


- (void)createtop{
    
    //self.view.backgroundColor = BgViewColor;
    self.navigationItem.title = @"常用游客资料";
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:windowContentWidth / 18.75]};
    //确定按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(ONright) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.navigationItem.rightBarButtonItem = item;
    
    
    //返回按钮
    UIButton * leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbutton.frame = CGRectMake(0, 0, 40, 40);
    [leftbutton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(onleftight) forControlEvents:UIControlEventTouchUpInside];
    [leftbutton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    UIBarButtonItem *leftitem = [[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.navigationItem.leftBarButtonItem = leftitem;
    
    
}
- (void)onleftight{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ---------------------确定按钮-------------------
- (void)ONright{
    
    
    if (_addarry.count <= _travelerCount && _travelerCount >= 2) {
        
        if (_addarry.count < 2 && _addarry.count != 0) {
            [[LXAlterView sharedMyTools] createTishi:@"您至少选择两位出游人"];
            
            
        }else{
            
            
            self.sendBlock(_addarry);
            [self dismissViewControllerAnimated:YES completion:nil];
            
            
        }
        
    }else if(_addarry.count <= _travelerCount && _travelerCount <= 1){
        
        
        self.sendBlock(_addarry);
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
    }else{
        
        [[LXAlterView sharedMyTools] createTishi:@"您选择的出游人过多"];
    }
    
    
}

- (void)createScroll{
    _scrollvc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight  )];
    _scrollvc.backgroundColor = [UIColor clearColor];
    _scrollvc.showsHorizontalScrollIndicator = NO;
    _scrollvc.showsVerticalScrollIndicator = NO;
    _scrollvc.contentSize = CGSizeMake(windowContentWidth, windowContentHeight );
    _scrollvc.delegate = self;
    [self.view addSubview:_scrollvc];
    
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight / 44.4)];
    line.backgroundColor = BgViewColor;
    [_scrollvc addSubview:line];
    
    UIButton * butt = [[UIButton alloc]initWithFrame:CGRectMake(0, windowContentHeight / 44.4, windowContentWidth, windowContentHeight / 14.8)];
    butt.backgroundColor = [UIColor whiteColor];
    [butt addTarget:self action:@selector(ONadd) forControlEvents:UIControlEventTouchUpInside];
    [_scrollvc addSubview:butt];
    
    
    //加号
    UIImageView * jH = [[UIImageView alloc]initWithFrame:CGRectMake(windowContentWidth / 37.5, windowContentHeight / 46, windowContentWidth / 25, windowContentWidth / 25)];
    [jH setImage:[UIImage imageNamed:@"+"]];
    [butt addSubview:jH];
    
    //添加新游客
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 11, windowContentHeight / 46, 200, windowContentWidth / 25)];
    
    lab.text = @"添加新游客";
    lab.backgroundColor = [UIColor whiteColor];
    lab.font = [UIFont systemFontOfSize:windowContentWidth / 23.4];
    lab.textColor = [UIColor orangeColor];
    [butt addSubview:lab];
    
    UILabel * lineS = [[UILabel alloc]initWithFrame:CGRectMake(0, windowContentHeight / 11.1, windowContentWidth, windowContentHeight / 44.4)];
    lineS.backgroundColor = BgViewColor;
    [  _scrollvc addSubview:lineS];
    
    //尖头
    UIButton * butts =  [[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth - windowContentWidth / 25 - windowContentWidth / 21.4 - 10, -5, windowContentWidth / 25 + 20, windowContentWidth / 25 * 4)];
    [butts  setImage:[UIImage imageNamed:@"矩形-32"] forState:UIControlStateNormal];
    [butt addSubview:butts];
    
    
}
- (void)createLOw{
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, windowContentHeight / 11.1 + windowContentHeight / 44.4 + _datasource.count * windowContentHeight / 9.5, windowContentWidth, 1000 )];
    lab.backgroundColor = BgViewColor;
    [_scrollvc addSubview:lab];
}
#pragma mark ====================== 添加联系人 ===================
- (void)ONadd{
    TravelManagCusInfoViewController * manger = [[TravelManagCusInfoViewController alloc]init];
    [self.navigationController pushViewController:manger animated:YES];
}

////创建联系人
- (void)CreateVC{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,windowContentHeight / 11.1 + windowContentHeight / 44.4, windowContentWidth, _datasource.count * windowContentHeight / 9.5 ) style:UITableViewStylePlain];
    
    
    //    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];//设置不显示多余的cell
    //    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
    //
    //        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    //
    //    }
    //
    //    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
    //        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    //    }
    
    
    // 设置代理和数据源
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_scrollvc addSubview:_tableView];
    
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, 30+windowContentHeight / 11.1 + windowContentHeight / 44.4+ _datasource.count * windowContentHeight / 9.5, windowContentWidth, 1000)];
    line.backgroundColor = BgViewColor;
    
    
    [_scrollvc addSubview:line];
    
    
    
    
    
    
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datasource.count ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return windowContentHeight / 9.5;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CyYLTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[CyYLTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.delegate = self;
    CYYLModel * model = _datasource[indexPath.row];
    [cell config:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_addarry removeAllObjects];
    
    CYYLModel *model = _datasource[indexPath.row];
    
    if (model.selectState)
    {
        model.selectState = NO;
    }
    else
    {
        model.selectState = YES;
    }
    
    //刷新当前行
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    //记录选中的行
    [self createline];
    
}

- (void)createline{
    for (int i =0; i<_datasource.count; i ++) {
        CYYLModel * model = _datasource[i];
        if (model.selectState) {
            
            [_addarry addObject:model];
        }
    }
    
}

//实现滑动删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    CYYLModel * model = _datasource[indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_datasource removeObjectAtIndex:indexPath.row];
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self deletePeople:(CYYLModel *)model];
        
        
        
    }
    
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSString *str = _datasource[sourceIndexPath.row];
    [_datasource removeObjectAtIndex:sourceIndexPath.row];
    [_datasource insertObject:str atIndex:destinationIndexPath.row];
    
    [_tableView reloadData];
}
//删除数据
- (void)deletePeople:(CYYLModel *)model{
    AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary * parameters = @{@"to_id":model.to_id};
    [manger POST:DELEPEOPLE parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

//获取数据
- (void)GetData{
    _parameters = @{@"member_id":[[LXUserTool alloc] getUid]};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:GetCommonList parameters:_parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
              NSArray * arrRoot = [dict objectForKey:@"data"];
              [_datasource removeAllObjects];
              for (NSDictionary * dic in arrRoot) {
                  CYYLModel * model = [[CYYLModel alloc]init];
                  model.to_username = dic[@"to_username"];
                  model.id_number = dic[@"id_number"];
                  model.phone = dic[@"phone"];
                  model.to_id = dic[@"to_id"];
                  model.id_type = dic[@"id_type"];
                  model.sex = dic[@"sex"];
                  
                  [_datasource addObject:model];
              }
              //              NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
              //              [defaults setObject:_datasource forKey:@"people"];
              
              //[self CreateVC];
              // [self createpeople];
              [_tableView reloadData];
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              NSLog(@"Error: %@", error);
          }];
    
}

#pragma mark -- 点击按钮 代理实现
- (void)Goto:(CYYLModel *)model{
    ChangeCYTravellerInfoViewController *changeCYVC = [[ChangeCYTravellerInfoViewController alloc]init];
    changeCYVC.travelerInfoModel = model;
    [self.navigationController pushViewController:changeCYVC animated:YES];
    
}

@end

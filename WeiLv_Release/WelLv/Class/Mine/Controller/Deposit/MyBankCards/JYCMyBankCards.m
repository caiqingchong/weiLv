//
//  JYCMyBankCards.m
//  WelLv
//
//  Created by lyx on 16/1/15.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "JYCMyBankCards.h"
#import "AddBankCardsViewController.h"
#import "bank_model.h"
#import "JYCMyBankCardsCell.h"
#import "JYCBankCardsDetail.h"
@interface JYCMyBankCards ()<UITableViewDataSource,UITableViewDelegate>
{
    AFHTTPRequestOperationManager *manager;
}
@property(nonatomic,strong)NSMutableArray *baseArr;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation JYCMyBankCards

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=BgViewColor;
    self.title=@"我的银行卡";
    _baseArr=[[NSMutableArray alloc]init];
    
    
}
-(void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:animated];
    for (UIView *view in [self.view subviews]) {
        [view removeFromSuperview];
    }
    [self createTableview];
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString *user_id = [LXUserTool sharedUserTool].getUid;
    NSString *token1 = [token stringByAppendingString:user_id];
    NSDictionary *dict=@{@"member_id":user_id,
                         @"_token":[WXUtil md5:token1],@"group_name":[[LXUserTool alloc] getuserGroup]};
    DLog(@"%@",dict);
   [self.baseArr removeAllObjects];
   [self sentUrl:get_card_list and:dict];
    
    
 
}
-(void)createTableview
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64)];
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UIView *v=[[UIView alloc]init];
    v.backgroundColor=[UIColor clearColor];
    self.tableView.tableFooterView=v;
    //self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    //[_tableView reloadData];
}


#pragma 请求
-(void)sentUrl:(NSString *)url and:(NSDictionary*)dict
{
   
    WS(weakSelf);
    [self setProgressHud];
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        DLog(@"%@",dict);
       
    if ([dict[@"flag"]intValue]==1) {
        [_hud hide:YES];
        NSArray *arr=dict[@"data"];
        for (NSDictionary *di in arr) {
            bank_model *model=[[bank_model alloc]init];
            [model setValuesForKeysWithDictionary:di];
            [weakSelf.baseArr addObject:model];
         }
        }else{
            [[LXAlterView sharedMyTools]createTishi:dict[@"msg"]];
            [_hud hide:YES];
        }
        [weakSelf.tableView reloadData];
        DLog(@"%@",dict);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
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

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    }else{
        return self.baseArr.count ;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50;
    }else{
        return 80;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 15)];
    vv.backgroundColor = [UIColor clearColor];
    return vv;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        static NSString * cellIndetifier100 = @"cellIndetifier100";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier100];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifier100];
            //单元格的选择风格，选择时单元格不出现蓝条
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.separatorInset = UIEdgeInsetsZero;
            
            UIImageView  *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50/2-20/2, 20, 20)];
            [imageV setImage:[UIImage imageNamed:@"常用游客资料-添加"]];//这个图片根银行卡用的加号图片一样
            [cell addSubview:imageV];
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(imageV) +15, 0, windowContentWidth - ViewRight(imageV) - 15 - 40, 50)];
            lab.backgroundColor = [UIColor clearColor];
            lab.text = @"添加银行卡";
            lab.textAlignment = NSTextAlignmentLeft;
            lab.textColor = kColor(250, 150, 19);
            lab.font = [UIFont systemFontOfSize:18];
            [cell addSubview:lab];
            
            UIImageView *IGV = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth -40, 50/2- 26.7/2, 40, 26.7)];
            [IGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
            [cell addSubview:IGV];
            
        }
        return cell;
        
    }else{
        static NSString * cellIndetifier1000 = @"cellIndetifier1000";
        JYCMyBankCardsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier1000];
        if (cell == nil) {
            cell = [[JYCMyBankCardsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifier1000];
            //单元格的选择风格，选择时单元格不出现蓝条
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.separatorInset = UIEdgeInsetsZero;
            
        }
        
        
        bank_model *model=[[bank_model alloc]init];
        model=self.baseArr[indexPath.row];
       
        cell.model=model;
        
        return cell;
        
    }
    return nil;
}

//点击某一行时候触发的事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.section == 0)
        {
            AddBankCardsViewController *vc=[[AddBankCardsViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            JYCBankCardsDetail *vc=[[JYCBankCardsDetail alloc]init];
            bank_model *model=[[bank_model alloc]init];
            model=self.baseArr[indexPath.row];
            vc.model=model;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
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

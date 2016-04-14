//
//  LXCusInfoViewController.m
//  WelLv
//
//  Created by liuxin on 15/9/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "LXCusInfoViewController.h"
#import "LXPlaneTicketOrderViewController.h"

@interface LXCusInfoViewController ()

@end

@implementation LXCusInfoViewController
@synthesize buttonTag,cusInfoArray;
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"常用游客资料"];
    igview.hidden = YES;
    cusInfoArray=[[NSMutableArray alloc] init];
}

-(void)viewWillAppear:(BOOL)animated{
    for(UIView *view in [self.view subviews])
    {
        [view removeFromSuperview];
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64-40)];
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;_tableView.dataSource = self;
    //[_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];//设置不显示cell间隔线
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];//设置不显示多余的cell
    
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    cusInfoArray = [NSMutableArray arrayWithArray:[settings objectForKey:@"custom"]];
    NSLog(@"11cusinfoarr  = %@",cusInfoArray);
    if ([cusInfoArray count] == 0 || cusInfoArray == nil)
    {
        [self getCusList];
    }
    buttonTag = 0;
    UIButton *addPersonBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, windowContentHeight-40-64,windowContentWidth, 40)];
    addPersonBtn.backgroundColor = kColor(57, 246, 177);
    [addPersonBtn setTitle:@"添加常用联系人" forState:UIControlStateNormal];
    addPersonBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    addPersonBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    addPersonBtn.titleLabel.textColor = [UIColor whiteColor];
    [addPersonBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];//加粗
    [addPersonBtn addTarget:self action:@selector(addCusInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addPersonBtn];
    UIImageView * Imgview = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(addPersonBtn)/2-105, 8, 24, 24)];
    [Imgview setImage:[UIImage imageNamed:@"添加常用联系人"]];
    [addPersonBtn addSubview:Imgview];
    
    
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 65*cusInfoArray.count,windowContentWidth, 0.35)];
    vv.backgroundColor = [UIColor lightGrayColor];
    [_tableView addSubview:vv];
    
    UILabel *tsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 65*cusInfoArray.count+5,windowContentWidth-20, 25)];
    tsLabel.text = @"向左侧滑动删除联系人";
    tsLabel.textColor = [UIColor lightGrayColor];
    tsLabel.font = [UIFont systemFontOfSize:13];
    tsLabel.textAlignment = NSTextAlignmentLeft;
    _tableView.tableFooterView = tsLabel;     //把备注设为tableFooterView
    
    if ([cusInfoArray count] == 0) {
        //添加无信息bgimage
        igview =[ [UIImageView alloc]initWithFrame:CGRectMake((windowContentWidth-200)/2,(windowContentHeight -200 - 140)/2,200,200)];
        igview.backgroundColor = [UIColor whiteColor];
        igview.image = [UIImage imageNamed:@"没找到相关内容.png" ];
        [self.view addSubview:igview];
        igview.hidden = NO;_tableView.hidden =YES;
        
    }else{
        //xianshi常用联系人tableview
        igview.hidden =YES;_tableView.hidden = NO;
        [_tableView reloadData];
    }
}

//网络请求获取联系人列表
-(void)getCusList{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"member_id":[[LXUserTool alloc] getUid]};
    [manager POST:GetCommonList parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
              cusInfoArray = [dict objectForKey:@"data"];
              NSLog(@"22cusinfoarr  = %@",cusInfoArray);
              //   NSLog(@"%ld",cusInfoArray.count);
              //村本地
              NSUserDefaults *settings=[NSUserDefaults  standardUserDefaults];
              [settings setObject:cusInfoArray forKey:@"custom"];
              if (cusInfoArray.count != 0) {
                  [self viewWillAppear:YES];
              }
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              
          }];
    
}

//选中某一个游客
- (void)selectedCusInfo:(NSInteger)index
{
    NSDictionary *dic = [cusInfoArray objectAtIndex:index];
    if ([self.delegate respondsToSelector:@selector(getContact:)]) {
        [self.delegate getContact:dic];
    }
    [self close];
}
//添加
-(void)addCusInfo{
    ManagCusInfoViewController *addViewC = [[ManagCusInfoViewController alloc] init];
    [self.navigationController pushViewController:addViewC animated:YES];
}

//删除
-(void) deteleCusInfo:(NSInteger)index{
    // UIButton *btn=(UIButton *)sender;
    //把btn.tag转化成整型
    buttonTag = index;
    UIAlertView *vv = [[UIAlertView alloc] initWithTitle:nil message:@"确定要删除联系人？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    vv.delegate = self;
    [vv show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        
        //上传服务器
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSDictionary *parameters = @{@"to_id":[[cusInfoArray objectAtIndex:buttonTag] objectForKey:@"to_id"]};
        [manager POST:DelCommon parameters:parameters
              success:^(AFHTTPRequestOperation *operation,id responseObject) {
                  NSString *html = operation.responseString;
                  NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
                  NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
                  cusInfoArray = [dict objectForKey:@"data"];
                  NSLog(@"ssss  = %@",dict);
                  
                  //shua刷新列表
                  [cusInfoArray removeObjectAtIndex:buttonTag];
                  NSUserDefaults *set=[NSUserDefaults  standardUserDefaults];
                  [set setObject:cusInfoArray forKey:@"custom"];
                  
                  [self viewWillAppear:YES];
              }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                  
                  NSLog(@"Error: %@", error);
                  
              }];
    }
}

//修改
-(void)changeInfo:(id)sender{
    UIButton *btn=(UIButton *)sender;
    //把btn.tag转化成整型
    NSInteger xx = (int)btn.tag;
    ChangeCusInfoViewController *chaVi = [[ChangeCusInfoViewController alloc] init];
    chaVi.btnIndex = xx;
    [self.navigationController pushViewController:chaVi animated:YES];
}

-(void)getBack{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [cusInfoArray count] ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

/*- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
 {
 UILabel *tsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0,windowContentWidth-20, 25)];
 tsLabel.text = @"向左侧滑动删除联系人";
 tsLabel.textColor = [UIColor lightGrayColor];
 tsLabel.font = [UIFont systemFontOfSize:13];
 tsLabel.textAlignment = NSTextAlignmentLeft;
 
 return tsLabel.text;
 }*/

/*-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
 
 UIView *viewww = [[UIView alloc] initWithFrame:CGRectMake(20, 0,windowContentWidth-20, 25)];
 UILabel *tsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0,windowContentWidth-20, 25)];
 tsLabel.text = @"向左侧滑动删除联系人";
 tsLabel.textColor = [UIColor lightGrayColor];
 tsLabel.font = [UIFont systemFontOfSize:13];
 tsLabel.textAlignment = NSTextAlignmentLeft;
 [viewww addSubview:tsLabel];
 return viewww;
 }*/


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIndetifier1000 = @"cellIndetifier1000";
    CustomInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier1000];
    if (cell == nil) {
        cell = [[CustomInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifier1000];
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    //    if (indexPath.row <cusInfoArray.count) {
    //本地存的是字典 并不是联系人的model对象：customInfo
    //NSDictionary *dic = [[NSDictionary alloc] init];
    CustomInfo *cusModel = [[CustomInfo alloc] init];
    cusModel = [cusInfoArray objectAtIndex:indexPath.row];
    
//    cusModel.realname = [dic objectForKey:@"to_username"];
//    cusModel.Idtype = [dic objectForKey:@"id_type"];
//    cusModel.Idnumbr = [dic objectForKey:@"id_number"];
//    cusModel.phoneNumber = [dic objectForKey:@"phone"];
    
    cell.custom = cusModel;
    
    [cell.button addTarget:self action:@selector(changeInfo:) forControlEvents:UIControlEventTouchUpInside];
    cell.button.tag = indexPath.row;
    //   }else{
    
    // }
    return cell;
}

//点击某一行时候触发的事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //   NSLog(@"%ld",self.navigationController.viewControllers.count);
    /*  if(self.navigationController.viewControllers && self.navigationController.viewControllers.count >2){
     [self selectedCusInfo:indexPath.row];
     }*/
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[LXPlaneTicketOrderViewController class]] ) {
            [self selectedCusInfo:indexPath.row];
        }
    }
    
}



#pragma mark -长按左滑删除

//设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
//要求委托方的编辑风格在表视图的一个特定的位置。
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}
//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //  NSLog(@"touchIIddddd");
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deteleCusInfo:indexPath.row];
    }
    
    
    
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

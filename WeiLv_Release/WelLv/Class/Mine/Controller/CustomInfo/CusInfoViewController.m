//
//  CusInfoViewController.m
//  WelLv
//
//  Created by mac for csh on 15/4/13.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "CusInfoViewController.h"
#import "YXOrderViewController.h"
//#import "CYYLModel.h"
#import "CustomInfo.h"
@interface CusInfoViewController ()
{
    UIImageView *imageVB;
}
@end

@implementation CusInfoViewController
@synthesize buttonTag,cusInfoArray;
@synthesize delegate;
@synthesize isFromeOrder;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BgViewColor;
    [self.navigationItem setTitle:@"常用游客资料"];
    igview.hidden = YES;
   
    
}
-(void)viewWillAppear:(BOOL)animated

{
    for(UIView *view in [self.view subviews])
    {
        [view removeFromSuperview];
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64)];
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
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

    //NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    //cusInfoArray = [NSMutableArray arrayWithArray:[settings objectForKey:@"custom"]];
   // NSLog(@"11cusinfoarr  = %@",cusInfoArray);
    
    [self getCusList];
    
    buttonTag = 0;
    //    UIButton *addPersonBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, windowContentHeight-40-64,windowContentWidth, 40)];
    //    addPersonBtn.backgroundColor = kColor(57, 246, 177);
    //    [addPersonBtn setTitle:@"添加常用联系人" forState:UIControlStateNormal];
    //    addPersonBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    //    addPersonBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    //    addPersonBtn.titleLabel.textColor = [UIColor whiteColor];
    //    [addPersonBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];//加粗
    //    [addPersonBtn addTarget:self action:@selector(addCusInfo) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:addPersonBtn];
    //    UIImageView * Imgview = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(addPersonBtn)/2-105, 8, 24, 24)];
    //    [Imgview setImage:[UIImage imageNamed:@"添加常用联系人"]];
    //    [addPersonBtn addSubview:Imgview];
    
   
    
    
    UILabel *tsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 65*cusInfoArray.count+5,windowContentWidth-20, 25)];
    tsLabel.text = @"向左侧滑动删除联系人";
    tsLabel.textColor = [UIColor lightGrayColor];
    tsLabel.font = [UIFont systemFontOfSize:13];
    tsLabel.textAlignment = NSTextAlignmentLeft;
    _tableView.tableFooterView = tsLabel;     //把备注设为tableFooterView
    
//    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0 ,windowContentWidth, 0.35)];
//    vv.backgroundColor = [UIColor lightGrayColor];
//    [tsLabel addSubview:vv];
//   
    
    
       // [_tableView reloadData];
    
}

//网络请求获取联系人列表
-(void)getCusList{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"member_id":[[LXUserTool alloc] getUid]};
    [manager POST:GetCommonList parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
             // [cusInfoArray removeAllObjects];
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];

              NSArray *arr=[dict objectForKey:@"data"];
               cusInfoArray=[NSMutableArray arrayWithArray:arr];
              
//              for (NSDictionary * dic in arr) {
//                  CustomInfo *model=[[CustomInfo alloc]init];
//                  model.phone = dic[@"phone"];
//                  [model setValuesForKeysWithDictionary:dic];
//
//                  //[model setValuesForKeysWithDictionary:dic];
//                  DLog(@"%@",model);
//                  [cusInfoArray addObject:model];
//              }
//
//             
//              NSLog(@"22cusinfoarr  = %@",cusInfoArray);
              //   NSLog(@"%ld",cusInfoArray.count);
              //村本地
             // NSUserDefaults *settings=[NSUserDefaults  standardUserDefaults];
              //[settings setObject:cusInfoArray forKey:@"custom"];
              if (cusInfoArray.count==0) {
                  imageVB=[[UIImageView alloc]initWithFrame:CGRectMake(0, 65+15, windowContentWidth, windowContentHeight-64-80)];
                  DLog(@"%f--%f",imageVB.frame.size.height,imageVB.frame.size.width);
                  imageVB.image=[UIImage imageNamed:@"无常用游客"];
                  [_tableView addSubview:imageVB];
              }else if (cusInfoArray.count>0)
              {
                  imageVB.hidden=YES;
              }

              
              [_tableView reloadData];
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
    
//    ManagCusInfoViewController *addViewC = [[ManagCusInfoViewController alloc] init];
//    [self.navigationController pushViewController:addViewC animated:YES];
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
        NSLog(@"%@",[cusInfoArray objectAtIndex:buttonTag]);
        NSDictionary *parameters = @{@"to_id":[[cusInfoArray objectAtIndex:buttonTag] objectForKey:@"to_id"]};
        [manager POST:DelCommon parameters:parameters
              success:^(AFHTTPRequestOperation *operation,id responseObject) {
                  NSString *html = operation.responseString;
                  NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
                  NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
                 
                  if ([dict[@"status"]integerValue]==1) {
                    
                      [cusInfoArray removeObjectAtIndex:buttonTag];
                      
                  }else{
                      [[LXAlterView sharedMyTools]createTishi:@"删除失败"];
                  }
                 
                  if (cusInfoArray.count==0) {
                      imageVB=[[UIImageView alloc]initWithFrame:CGRectMake(0, 65+15, windowContentWidth, windowContentHeight-64-80)];
                      imageVB.image=[UIImage imageNamed:@"无常用游客"];
                      [_tableView addSubview:imageVB];

                  }else if (cusInfoArray.count>0)
                  {
                      imageVB.hidden=YES;
                  }
                  

                  
                  [_tableView reloadData];

              }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                  
                  NSLog(@"Error: %@", error);
                  
              }];
    }
}
/*
 //修改
 -(void)changeInfo:(id)sender{
 UIButton *btn=(UIButton *)sender;
 //把btn.tag转化成整型
 NSInteger xx = (int)btn.tag;
 ChangeCusInfoViewController *chaVi = [[ChangeCusInfoViewController alloc] init];
 chaVi.btnIndex = xx;
 [self.navigationController pushViewController:chaVi animated:YES];
 }*/

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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    }else{
        return [cusInfoArray count] ;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50;
    }else{
        return 60;
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
            [imageV setImage:[UIImage imageNamed:@"常用游客资料-添加"]];
            [cell addSubview:imageV];
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(imageV) +15, 0, windowContentWidth - ViewRight(imageV) - 15 - 40, 50)];
            lab.backgroundColor = [UIColor clearColor];
            lab.text = @"添加新游客";
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
        
        if (cusInfoArray.count==0) {
            imageVB.hidden=NO;
        }else if (cusInfoArray.count>0){
        imageVB.hidden=YES;
        }
        static NSString * cellIndetifier1000 = @"cellIndetifier1000";
        CustomInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier1000];
        if (cell == nil) {
            cell = [[CustomInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifier1000];
            //单元格的选择风格，选择时单元格不出现蓝条
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.separatorInset = UIEdgeInsetsZero;
        }
        
        //本地存的是字典 并不是联系人的model对象：customInfo
        CustomInfo *cusModel = [[CustomInfo alloc] init];
         NSDictionary *dic = [cusInfoArray objectAtIndex:indexPath.row];
        
        cusModel.to_username = [dic objectForKey:@"to_username"];
        cusModel.id_type = [dic objectForKey:@"id_type"];
        cusModel.id_number = [dic objectForKey:@"id_number"];
        cusModel.phone = [dic objectForKey:@"phone"];
        
         cell.custom = cusModel;
        
        //        [cell.button addTarget:self action:@selector(changeInfo:) forControlEvents:UIControlEventTouchUpInside];
        //        cell.button.tag = indexPath.row;
        
        return cell;
        
    }
   
    return nil;
}

//点击某一行时候触发的事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isFromeOrder == YES)
    {
        if (indexPath.section==0)
        {
            [self addCusInfo];
        }
        else
        {
            for (UIViewController *controller in self.navigationController.viewControllers)
            {
                if ([controller isKindOfClass:[YXOrderViewController class]])
                {
                    [self selectedCusInfo:indexPath.row];
                }
            }
        }
    }
    else
    {
        if (indexPath.section == 0)
        {
            [self addCusInfo];
        }
        else
        {
            ChangeCusInfoViewController *chaVi = [[ChangeCusInfoViewController alloc] init];
            chaVi.chuDict=[cusInfoArray objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:chaVi animated:YES];
        }
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

#pragma mark -长按左滑删除

//设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        return NO;
    }
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



@end

//
//  LXCContactViewController.m
//  WelLv
//
//  Created by liuxin on 15/9/10.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "LXCContactViewController.h"

#import "ManagCusInfoViewController.h"
//#import "CustomInfo.h"
//#import "CustomInfoCell.h"
#import "ChangeCusInfoViewController.h"
#import "LXPlanePersonModel.h"
#import "LXPlanePersonCell.h"

#import "LXAddOrUpdatePerViewController.h"
#import "WXUtil.h"

@interface LXCContactViewController ()
{
    NSMutableArray *_selectCommonContactArray;
}
@end

@implementation LXCContactViewController
@synthesize buttonTag,cusInfoArray;

- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"常用游客资料"];
    
    UIButton *ensureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    ensureBtn.frame=CGRectMake(0, 0, 60, 30);
    [ensureBtn setTitle:@"添加" forState:UIControlStateNormal];
    [ensureBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    //[searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [ensureBtn addTarget:self action:@selector(addCusInfo) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:ensureBtn];
    
    
    [self initData];
    
//    [self initView];
    
}

-(void)ensureBtnBtnClick
{
    if (self.blockArray) {
        self.blockArray(_selectCommonContactArray);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initData
{
    _selectCommonContactArray=[[NSMutableArray alloc] initWithCapacity:0];
    igview.hidden = YES;
    cusInfoArray=[[NSMutableArray alloc] init];
    [self getCusList];
}

-(void)initView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64-40)];
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;_tableView.dataSource = self;
    //[_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];//设置不显示cell间隔线
    //_tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];//设置不显示多余的cell
    

    buttonTag = 0;
    UIButton *addPersonBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, windowContentHeight-40-64,windowContentWidth, 40)];
    addPersonBtn.backgroundColor = kColor(57, 246, 177);
    [addPersonBtn setTitle:@"确定" forState:UIControlStateNormal];
    addPersonBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    addPersonBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    addPersonBtn.titleLabel.textColor = [UIColor whiteColor];
    [addPersonBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];//加粗
    [addPersonBtn addTarget:self action:@selector(ensureBtnBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addPersonBtn];
//    UIImageView * Imgview = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(addPersonBtn)/2-105, 8, 24, 24)];
//    [Imgview setImage:[UIImage imageNamed:@"添加常用联系人"]];
//    [addPersonBtn addSubview:Imgview];
    
    
//    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 65*cusInfoArray.count,windowContentWidth, 0.35)];
//    vv.backgroundColor = [UIColor lightGrayColor];
//    [_tableView addSubview:vv];
    
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
    LXUserTool *user=[[LXUserTool alloc] init];
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString *token1 = [token stringByAppendingString:[user getUid]];
    NSString  *userGroup=[user getuserGroup];
    
    [cusInfoArray removeAllObjects];
    
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"uid":[[LXUserTool alloc] getUid],@"wltoken":[WXUtil md5:token1],@"group":userGroup};
    DLog(@"uid=%@",[[LXUserTool alloc] getUid]);
    [manager POST:ContactPersonList parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary *dic=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
              //cusInfoArray = [dict objectForKey:@"data"];
                if ([[dic objectForKey:@"error"] integerValue]==0) {
                  NSArray *arr=[dic objectForKey:@"msg"];
                  for (int i=0; i<arr.count; i++) {
                      NSDictionary *dic=[arr objectAtIndex:i];
                      LXPlanePersonModel *model=[[LXPlanePersonModel alloc] initWithDictionary:dic];
                      model.plane_id=[dic objectForKey:@"id"];
                      [cusInfoArray addObject:model];
                  }
              }else{
                  [[LXAlterView sharedMyTools] createTishi:@"您还没有联系人，请添加"];
              }
              
//              if (arr.count>0) {
//                  for (int i=0; i<arr.count; i++) {
//                      NSDictionary *dic=[arr objectAtIndex:i];
//                      LXPlanePersonModel *model=[[LXPlanePersonModel alloc] initWithDictionary:dic];
//                      model.plane_id=[dic objectForKey:@"id"];
//                      [cusInfoArray addObject:model];
//                  }
//                  //cusInfoArray=[NSMutableArray arrayWithArray:arr];
//              }else{
//                  [[LXAlterView sharedMyTools] createTishi:@"您还没有联系人，请添加"];
//              }
              DLog(@"-----%@",cusInfoArray);
              [self initView];
              
              [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              DLog(@"error=%@",error);
              [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
                  [self getCusList];
              }];
          }];
    
}

////选中某一个游客
//- (void)selectedCusInfo:(NSInteger)index
//{
//    NSDictionary *dic = [cusInfoArray objectAtIndex:index];
//    if ([self.delegate respondsToSelector:@selector(getContact:)]) {
//        [self.delegate getContact:dic];
//    }
//    [self close];
//}
//添加
-(void)addCusInfo{
//    ManagCusInfoViewController *addViewC = [[ManagCusInfoViewController alloc] init];
//    [self.navigationController pushViewController:addViewC animated:YES];
    LXAddOrUpdatePerViewController *lxaddVc=[[LXAddOrUpdatePerViewController alloc] init];
    lxaddVc.addOrUpdata=add;
    lxaddVc.addOrUpdatablock = ^(NSString *str){
        [self getCusList];
    };
    [self.navigationController pushViewController:lxaddVc animated:YES];
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
        LXUserTool *user=[[LXUserTool alloc] init];
        NSString *token = @"~0;id<zOD.{ll@]JKi(:";
        NSString *token1 = [token stringByAppendingString:[user getUid]];
        NSString  *userGroup=[user getuserGroup];
        
        LXPlanePersonModel *model=[cusInfoArray objectAtIndex:buttonTag];
        //上传服务器
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSDictionary *parameters = @{@"id":model.plane_id,
                                     @"member_id":[[LXUserTool alloc] getUid],
                                     @"wltoken":[WXUtil md5:token1],
                                     @"group":userGroup};
        [manager POST:delContactPerson parameters:parameters
              success:^(AFHTTPRequestOperation *operation,id responseObject) {
                  NSString *html = operation.responseString;
                  NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
                  NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
                  
                  NSLog(@"ssss  = %@",dict);
                  if ([[dict objectForKey:@"msg"] isEqualToString:@"成功"]) {
                      //shua刷新列表
                      [cusInfoArray removeObjectAtIndex:buttonTag];
                      [_tableView reloadData];
                  }else{
                      [[LXAlterView sharedMyTools] createTishi:@"删除失败"];
                  }
                  
                  
              }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                  
                  NSLog(@"Error: %@", error);
                  
              }];
    }
}

//修改
-(void)changeInfo:(id)sender{
    UIButton *btn=(UIButton *)sender;
//    //把btn.tag转化成整型
    NSInteger xx = (int)btn.tag;
//    ChangeCusInfoViewController *chaVi = [[ChangeCusInfoViewController alloc] init];
//    chaVi.btnIndex = xx;
//    [self.navigationController pushViewController:chaVi animated:YES];
    //LXPlanePersonModel *model=[[LXPlanePersonModel alloc] init];
    //model=[cusInfoArray objectAtIndex:buttonTag];
    
    LXAddOrUpdatePerViewController *lxaddVc=[[LXAddOrUpdatePerViewController alloc] init];
    lxaddVc.addOrUpdata=updata;
    lxaddVc.personModel=[cusInfoArray objectAtIndex:xx];
    lxaddVc.addOrUpdatablock= ^(NSString *str){
        [self getCusList];
    };
    [self.navigationController pushViewController:lxaddVc animated:YES];
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
    LXPlanePersonCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier1000];
    if (cell == nil) {
        cell = [[LXPlanePersonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifier1000];
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       // cell.separatorInset = UIEdgeInsetsZero;
        
        UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 64,windowContentWidth, .5)];
        vv.backgroundColor = [UIColor lightGrayColor];
        [cell addSubview:vv];
    }
    

    LXPlanePersonModel *cusModel = [cusInfoArray objectAtIndex:indexPath.row];

    
    cell.custom = cusModel;
    
    [cell.button addTarget:self action:@selector(changeInfo:) forControlEvents:UIControlEventTouchUpInside];
    cell.button.tag = indexPath.row;
    
   // if (cell.selected==NO) {
        cell.imageView.image=[UIImage imageNamed:@"未选中圆圈"];
//    }else{
//        cell.imageView.image=[UIImage imageNamed:@"选中圆圈"];
//    }
    
  
    return cell;
}

//点击某一行时候触发的事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //   NSLog(@"%ld",self.navigationController.viewControllers.count);
    /*  if(self.navigationController.viewControllers && self.navigationController.viewControllers.count >2){
     [self selectedCusInfo:indexPath.row];
     }*/
//    for (UIViewController *controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[YXOrderViewController class]]) {
//            [self selectedCusInfo:indexPath.row];
//        }
//    }
    LXPlanePersonCell *cell=(LXPlanePersonCell *)[tableView cellForRowAtIndexPath:indexPath];
    DLog(@"cell.select==%d,cell=%@",cell.selected,cell);
    //NSMutableArray *arr=[NSMutableArray arrayWithArray:cusInfoArray];
    if (cell.isSelect==NO) {
        cell.isSelect=YES;
        LXPlanePersonModel *model=[cusInfoArray objectAtIndex:indexPath.row];
        [_selectCommonContactArray addObject:model];
        cell.imageView.image=[UIImage imageNamed:@"选中圆圈"];
        DLog(@"1cell.select==%d",cell.isSelected);
    }
    else if (cell.isSelect==YES){
        cell.isSelect=NO;
        LXPlanePersonModel *model=[cusInfoArray objectAtIndex:indexPath.row];
        [_selectCommonContactArray removeObject:model];
        cell.imageView.image=[UIImage imageNamed:@"未选中圆圈"];
    }
    
    //cell.selected=!cell.selected;
    //[_tableView reloadData];
    DLog(@"2cell.select==%d",cell.selected);
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

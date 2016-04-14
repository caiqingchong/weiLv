//
//  MemberInformationViewController.m
//  WelLv
//
//  Created by liuxin on 16/1/18.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "MemberInformationViewController.h"
#import "WritreMessageViewController.h"
#import "zxdTouristViewController.h"
#import "MBProgressHUD.h"
#import "MyMembersModel.h"
#import "zxdChangYongViewController.h"
#import "zxdDateModel.h"

@interface MemberInformationViewController ()<UITableViewDelegate,UITableViewDataSource,WritreMessageViewControllerDeledate,zxdChangYongViewControllerDelegate>
@property(nonatomic,strong)NSMutableArray *zxdArr;
@property(strong,nonatomic)NSDictionary *zxdDateDict;
@property(nonatomic,strong)UITableView *zxdTableView;
@property(nonatomic,strong)NSArray *arr1;
@property(nonatomic,strong)NSArray *arr2;
@property(nonatomic,strong)NSMutableArray *arr3;
@property(nonatomic,strong) MBProgressHUD *zxdHud;
@property(nonatomic,strong)zxdDateModel *zxdModel;
@property(nonatomic,strong)NSString *zxdName;
@property(nonatomic,strong)NSString *zxdPhone;
@property(nonatomic,strong)NSString *province;//省份
@property(nonatomic,strong)NSString *city;//城市
@property(nonatomic,strong)NSString *country;//县区
@property(nonatomic,strong)NSString *address;//详细地址
@property(nonatomic,assign)BOOL isSued;
@end

@implementation MemberInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTitle];
    [self creatArr];
    
    [self creatTableView];
     [self downDate];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
   
}
#pragma mark----下载数据
-(void)downLoad
{
    
}
-(void)creatArr
{
    self.arr1 =@[@"会员姓名",@"性别",@"出生日期",@"身份证号码",@"邮箱"];
    self.arr2 =@[@"常用游客资料",@"紧急联系人资料",@"常用地址"];
    self.arr3 = [[NSMutableArray alloc] initWithArray:@[@"",@"",@"",@"",@"",@"",@""]];
    
    self.zxdArr = [[NSMutableArray alloc] initWithObjects:self.arr1,self.arr2, nil];
}
-(void)creatTitle
{
   self.navigationItem.title = @"完善资料";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[YXTools stringToColor:@"#3c4042"]}];
    self.view.backgroundColor = BgViewColor;
}
-(void)creatTableView
{
    [self.zxdTableView removeFromSuperview];
    self.zxdTableView = [[UITableView alloc] init];
    self.zxdTableView.frame = CGRectMake(0, 0, windowContentWidth, windowContentHeight-15-64);
    self.zxdTableView.dataSource= self;
    self.zxdTableView.delegate = self;
    
    self.zxdTableView.tableFooterView =[[UIView alloc] init];
    self.zxdTableView.backgroundColor = BgViewColor;
    [self.zxdTableView setShowsVerticalScrollIndicator:NO];
    if ([self.zxdTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.zxdTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.zxdTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.zxdTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.view addSubview:self.zxdTableView];
    
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
#pragma mark----tableView dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.zxdArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.zxdArr objectAtIndex:section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:_zxdTableView.tableHeaderView.frame];
    header.backgroundColor = BgViewColor;
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1&&indexPath.section == 1) {
        return 60;
    }
    return 45;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"cellIdentifier";
        //UITableViewCell *cell = [[UITableViewCell alloc] init];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            UIImageView *zxdView = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-23, ViewHeight(cell)/2-9, 10, 17)];
            /*UIImageView *zxdView2 = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-25, 15+i*45, 10, 18)];
             //[zxdView2 setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
             [zxdView2 setImage:[UIImage imageNamed:@"zxdf"]];*/
            [zxdView setImage:[UIImage imageNamed:@"zxdf"]];
            [cell addSubview:zxdView];
            UILabel *zxdDetial = [[UILabel alloc] init];
            zxdDetial.frame = CGRectMake(15, 7, windowContentWidth/2, 30);
            zxdDetial.textAlignment = NSTextAlignmentLeft;
            zxdDetial.tag = 605;
            zxdDetial.font = [UIFont systemFontOfSize:15];
            zxdDetial.textColor = [YXTools stringToColor:@"#6f7378"];
            [cell addSubview:zxdDetial];
            //cell.textLabel.text = [[self.zxdArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(150, 10, windowContentWidth-150-30, 25);
            // label.backgroundColor = [UIColor redColor];
            label.font = [UIFont systemFontOfSize:15];
            label.tag = 100;
            label.textAlignment = NSTextAlignmentRight;
            [cell addSubview:label];
        }
        UILabel *zxdLabel = (UILabel *)[cell viewWithTag:605];
        
        zxdLabel.text =[[self.zxdArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        UILabel *label = [cell viewWithTag:100];
        label.text =[self.arr3 objectAtIndex:indexPath.row];
        label.textColor = [YXTools stringToColor:@"#2f2f2f"];
    return cell;
  
    }
    else
    {
        if (indexPath.row == 1) {
            static NSString *CellIdtifier2 = @"CellIdtifier2";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdtifier2];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdtifier2];
                cell.selectionStyle = UITableViewCellSeparatorStyleNone;
                UIImageView *zxdView = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-23, ViewHeight(cell)/2, 10, 18)];
                //zxdView.image = [UIImage imageNamed:@"zxdAddRight"];
                [zxdView setImage:[UIImage imageNamed:@"zxdf"]];
                //cell.textLabel.text = [[self.zxdArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                [cell addSubview:zxdView];
                UILabel *zxdDetial = [[UILabel alloc] init];
                zxdDetial.frame = CGRectMake(15, 15, windowContentWidth/2, 30);
                zxdDetial.textAlignment = NSTextAlignmentLeft;
                zxdDetial.tag = 605;
                zxdDetial.textColor = [YXTools stringToColor:@"#6f7378"];
                zxdDetial.font = [UIFont systemFontOfSize:15];
                [cell addSubview:zxdDetial];

                //联系人姓名
                UILabel *label1 = [[UILabel alloc] init];
                label1.frame = CGRectMake(150, 5, windowContentWidth-150-30, 25);
                label1.tag = 601;
                label1.font = [UIFont systemFontOfSize:15];
                label1.textAlignment = NSTextAlignmentRight;
                [cell addSubview:label1];
                //联系人电话
                UILabel *label2 =[[UILabel alloc] init];
                label2.frame = CGRectMake(150, 30, windowContentWidth-150-30, 25);
                label2.tag = 602;
                label2.font = [UIFont systemFontOfSize:15];
                label2.textAlignment = NSTextAlignmentRight;
                [cell addSubview:label2];
            }
            UILabel *zxdlabel1 = [cell viewWithTag:601];
            zxdlabel1.text = self.zxdName;
            zxdlabel1.textColor = [YXTools stringToColor:@"#2f2f2f"];
            UILabel *zxdlabel2 = [cell viewWithTag:602];
            zxdlabel2.text = self.zxdPhone;
            zxdlabel2.textColor = [YXTools stringToColor:@"#2f2f2f"];
            UILabel *zxdLabel = (UILabel *)[cell viewWithTag:605];
            zxdLabel.text =[[self.zxdArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

            return cell;
        }
        else
        {
            static NSString *CellIdtifier3 = @"CellIdtifier3";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdtifier3];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdtifier3];
                cell.selectionStyle = UITableViewCellSeparatorStyleNone;
                UIImageView *zxdView = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-23, ViewHeight(cell)/2-9, 10, 17)];
                [zxdView setImage:[UIImage imageNamed:@"zxdf"]];
               // cell.textLabel.text = [[self.zxdArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                [cell addSubview:zxdView];
                UILabel *zxdDetial = [[UILabel alloc] init];
                zxdDetial.frame = CGRectMake(15, 7, windowContentWidth/2, 30);
                zxdDetial.textAlignment = NSTextAlignmentLeft;
                zxdDetial.tag = 605;
                zxdDetial.textColor = [YXTools stringToColor:@"#6f7378"];
                zxdDetial.font = [UIFont systemFontOfSize:15];
                [cell addSubview:zxdDetial];

                //常用地址
                UILabel *label1 = [[UILabel alloc] init];
                label1.frame = CGRectMake(120, 10, windowContentWidth-120-30, 25);
                label1.tag = 701;
                label1.textColor = [YXTools stringToColor:@"#2f2f2f"];
                label1.font = [UIFont systemFontOfSize:15];
                label1.textAlignment = NSTextAlignmentRight;
                [cell addSubview:label1];
            }
            UILabel *zxdLabel = (UILabel *)[cell viewWithTag:605];
            zxdLabel.text =[[self.zxdArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

            UILabel *zxdlabel3 = [cell viewWithTag:701];
            switch (indexPath.row) {
                case 0:
                    
                    break;
                case 2:
                    zxdlabel3.text = [NSString stringWithFormat:@"%@%@%@%@",[self judgeString:self.province]?self.province:@"",[self judgeString:self.city]?self.city:@"",[self judgeString:self.country]?self.country:@"",[self judgeString:self.address]?self.address:@""];
                    break;
                default:
                    break;
            }
           
            return cell;
  
        }
    }
    return nil;
  
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.isSued) {
        //[[LXAlterView sharedMyTools] createTishi:@"下载失败,暂无数据"];
        //return;
    }
    if (0 ==indexPath.section ) {
        WritreMessageViewController *zxdVc = [[WritreMessageViewController alloc] init];
        zxdVc.navigationItem.title = [[self.zxdArr objectAtIndex:0] objectAtIndex:indexPath.row];
        zxdVc.type = indexPath.row;
        zxdVc.uid = self.memberModel.uid;
        zxdVc.delegate = self;
        zxdVc.strtext =[self.arr3 objectAtIndex:indexPath.row];

        [self.navigationController pushViewController:zxdVc animated:YES];
    }
    else if (1== indexPath.section && indexPath.row == 0)
    {
        zxdTouristViewController *zxdTourVc = [[zxdTouristViewController alloc] init];
        zxdTourVc.uid = self.memberModel.uid;
        [self.navigationController pushViewController:zxdTourVc animated:YES];
    }
    else
    {
        zxdChangYongViewController *zxdVc3 = [[zxdChangYongViewController alloc] init];
        zxdVc3.type = indexPath.row;
        zxdVc3.delegate = self;
        if (indexPath.row == 1) {
            zxdVc3.frist = [self judgeString:self.zxdName]?self.zxdName:@"";
            zxdVc3.second = [self judgeString:self.zxdPhone]?self.zxdPhone:@"";
        }
        else
        {
        zxdVc3.zxdcity1 = [self judgeString:self.province]?self.province:@"河南";
        zxdVc3.zxdcity2 = [self judgeString:self.city]?self.city:@"郑州";
        zxdVc3.zxdcity3 = [self judgeString:self.country]?self.country:@"金水区";
        zxdVc3.zxdStr1 = zxdVc3.zxdcity1;
        zxdVc3.zxdStr2 = zxdVc3.zxdcity2;
        zxdVc3.zxdStr3 = zxdVc3.zxdcity3;
            zxdVc3.second = [self judgeString:self.address]?self.address:@"";
        zxdVc3.frist = [NSString stringWithFormat:@"%@-%@-%@",zxdVc3.zxdcity1,zxdVc3.zxdcity2,zxdVc3.zxdcity3];

        }
        zxdVc3.uid = self.memberModel.uid;
        zxdVc3.navigationItem.title = [self.arr2 objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:zxdVc3 animated:YES];
    }
}
-(void)downDate
{
    NSString *url = [NSString stringWithFormat:@"%@/%@",WLHTTP,@"api/assistant/edit_member_info"];
    
    NSDictionary *dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                          @"select":@"*"};
    // NSArray *arr = [[NSArray alloc] initWithObjects:dic, nil];
    NSDictionary *parameters = @{@"member_id":self.memberModel.uid,
                                 @"data":[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:dic]};
    //data={"token":"7a6bd7af36e5db226281a037909fbdfd","select":"*"}&member_id=31040
    [self setHud:@"正在下载"];
    __weak typeof (self)weakSelf = self;
    AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
    zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [zxdManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        weakSelf.zxdHud.hidden = YES;
        
        if ([dict count]==0) {
            [[LXAlterView sharedMyTools] createTishi:@"下载失败"];
            self.isSued = NO;
        }
        else if ([[dict objectForKey:@"status"] integerValue]!=1)
        {
            [[LXAlterView sharedMyTools] createTishi:@"下载失败"];
            self.isSued = NO;
        }
        else
        {
           // NSDictionary *zxdDict = dict[@"msg"];
            if ([dict[@"data"] count]==0) {
               [[LXAlterView sharedMyTools] createTishi:@"下载失败"];
                self.isSued = NO;
            }
            else
            {
                self.isSued = YES;
             self.zxdDateDict = dict[@"data"];
                self.zxdModel = [[zxdDateModel alloc] init];
                [self.zxdModel setValuesForKeysWithDictionary:self.zxdDateDict];
            //会员姓名
            [self.arr3 replaceObjectAtIndex:0 withObject:[self judgeString:self.zxdDateDict[@"remark_name"]]?self.zxdDateDict[@"remark_name"]:@""];
            //性别
            if (![self judgeString:self.zxdDateDict[@"gender"]]) {
                [self.arr3 replaceObjectAtIndex:1 withObject:@"男"];
            }
            else if([self.zxdDateDict[@"gender"] integerValue]==1)
            {
                [self.arr3 replaceObjectAtIndex:1 withObject:@"男"];

            }
            else
            {
                [self.arr3 replaceObjectAtIndex:1 withObject:@"女"];

            }
           // [self.arr3 replaceObjectAtIndex:1 withObject:[self judgeString:self.zxdDateDict[@"gender"]]?self.zxdDateDict[@"gender"]:@""];
            //出生日期
            [self.arr3 replaceObjectAtIndex:2 withObject:[self judgeString:self.zxdDateDict[@"birth_date"]]?self.zxdDateDict[@"birth_date"]:@""];
            //证件号码
            [self.arr3 replaceObjectAtIndex:3 withObject:[self judgeString:self.zxdDateDict[@"id_number"]]?self.zxdDateDict[@"id_number"]:@""];
            //邮箱
            [self.arr3 replaceObjectAtIndex:4 withObject:[self judgeString:self.zxdDateDict[@"info_email"]]?self.zxdDateDict[@"info_email"]:@""];
            self.zxdName = [self judgeString:self.zxdDateDict[@"contact"]]?self.zxdDateDict[@"contact"]:@"";
            self.zxdPhone = [self judgeString:self.zxdDateDict[@"contact_phone"]]?self.zxdDateDict[@"contact_phone"]:@"";
                //详细地址
              self.address = [self judgeString:self.zxdDateDict[@"info_address"]]?self.zxdDateDict[@"info_address"]:@"";
              self.province = [self judgeString:self.zxdDateDict[@"info_province"]]?self.zxdDateDict[@"info_province"]:@"";
             self.city = [self judgeString:self.zxdDateDict[@"info_city"]]?self.zxdDateDict[@"info_city"]:@"149";
             self.country = [self judgeString:self.zxdDateDict[@"info_country"]]?self.zxdDateDict[@"info_country"]:@"";
                [weakSelf exxhangeIdToCity];
              // [self.zxdTableView reloadData];
            }
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        weakSelf.zxdHud.hidden = YES;
        [[LXAlterView sharedMyTools] createTishi:@"网络出现故障"];
        self.isSued = NO;
        
    }];
}
-(void)setHud:(NSString *)str
{
    
    self.zxdHud = [[MBProgressHUD alloc] initWithView:self.view];
    self.zxdHud.frame = self.view.bounds;
    self.zxdHud.minSize = CGSizeMake(100, 100);
    self.zxdHud.mode = MBProgressHUDModeIndeterminate;
    self.zxdHud.labelText = str;
    [self.view addSubview:self.zxdHud];
    // [_zxdTableView bringSubviewToFront:self.zxdHud];
    [self.zxdHud show:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark----WritreMessageViewControllerDeledate
//反向传值
-(void)zxdViewController:(WritreMessageViewController *)vc text:(NSString *)string number:(NSInteger)num
{
    //UILabel *label = (UILabel *)[self.view viewWithTag:num+100];
    //label.text = string;
   // [self.arr3 exchangeObjectAtIndex:num-100 withObjectAtIndex:[NSString stringWithString:string]];
    [self.arr3 replaceObjectAtIndex:num withObject:string];
    //刷新某一部分
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
    [self.zxdTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];

}
-(void)zxdVcBack:(zxdChangYongViewController *)zxdVC text1:(NSString *)str1 text2:(NSString *)str2 text3:(NSString *)str3 text4:(NSString *)str4 text5:(NSString *)str5 zxdBool:(NSInteger)type
{
    if (type == 1) {
        self.zxdName = str4;
        self.zxdPhone = str5;
        [self.zxdTableView reloadData];
    }
    else
    {
        self.province = str1;
        self.city = str2;
        self.country = str3;
        self.address = str5;
        [self.zxdTableView reloadData];
    }
}
-(void)exxhangeIdToCity
{
    NSDictionary *parameters = @{@"province":self.province,
                                 @"city":self.city,
                                 @"country":self.country,
                                 @"sign":@"name",
                                 @"token":@"7a6bd7af36e5db226281a037909fbdfd",
                                 };
    [self setHud:@"正在下载"];
    __weak typeof (self)weakSelf = self;
    AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
    zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [zxdManager POST:zxdIdtoCityUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        weakSelf.zxdHud.hidden = YES;
         NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dict[@"status"] integerValue]==1) {
            NSString *strpro = nil;
            NSString  *strCity = nil;
            NSString *strCountry = nil;
            strpro = dict[@"province"];
            strCity = dict[@"city"];
            strCountry = dict[@"country"];
            weakSelf.province = [weakSelf judgeString:strpro]?strpro:@"河南";
            weakSelf.city = [weakSelf judgeString:strCity]?strCity:@"郑州";
            weakSelf.country = [weakSelf judgeString:strCountry]?strCountry:@"金水区";
            [weakSelf.zxdTableView reloadData];
        }
        else
        {
            [[LXAlterView sharedMyTools] createTishi:@"下载失败"];
        }
      //  NSDictionary *zxddict = dict;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        weakSelf.zxdHud.hidden = YES;
         [[LXAlterView sharedMyTools] createTishi:@"网络出现故障"];
    }];

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

//
//  CSHAduitViewController.m
//  WelLv
//
//  Created by mac for csh on 15/11/24.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "CSHAduitViewController.h"
#import "openShopCell.h"
#import "WXUtil.h"
#import "CSHRefuseViewController.h"

@interface CSHAduitViewController ()
{
      UITableView *_tableView;
    NSMutableArray *titleArray;
}

@end

@implementation CSHAduitViewController
@synthesize model;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BgViewColor;
     NSArray *array0 = [NSArray arrayWithObjects:@"店铺状态", nil];
    NSArray *array1 = [NSArray arrayWithObjects:@"商铺名称",@"商铺logo", nil];
    NSArray *array2 = [NSArray arrayWithObjects:@"营业执照",@"卫生许可证",@"地图定位",@"详细地址", nil];
    NSArray *array3 = [NSArray arrayWithObjects:@"店主姓名",@"登录名(店主手机号)",@"商铺微信号",@"联系电话(选填)", nil];
    NSArray *array4 = [NSArray arrayWithObjects:@"店主银行卡", nil];
    NSArray *array5 = [NSArray arrayWithObjects:@"开通商户", nil];
    titleArray = [NSMutableArray arrayWithObjects:array0,array1,array2,array3,array4,array5, nil];

    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight - NavHeight)];
    _tableView.tableFooterView=[[UIView alloc] init];//去掉多余的cell
    _tableView.delegate = self; _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor ];
    [self.view addSubview:_tableView];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:_tableView.tableHeaderView.frame];
    header.backgroundColor = [UIColor clearColor];
    
    return header;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return footerheighter;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[titleArray objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 5) {
        return 80;
    }else{
        return 45;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 5)
    {
        static NSString *CellIdentifier3 = @"cellIdentifier3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier3];
            //单元格的选择风格，选择时单元格不出现蓝条
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell.separatorInset = UIEdgeInsetsMake(0, windowContentWidth, 0,0);
            
            if (model.status && [model.status integerValue] == 0) {
                
                UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                exitBtn.frame=CGRectMake(20, 10, (windowContentWidth - 20*3)/2, 40);
                exitBtn.layer.cornerRadius=5;
                exitBtn.backgroundColor = kColor(66,250,162);
                [exitBtn setTitle:@"开通商户" forState:UIControlStateNormal];
                [exitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [exitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
                exitBtn.tag = 1; [cell addSubview:exitBtn];
                
                UIButton *refBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                refBtn.frame=CGRectMake(windowContentWidth/2 +10, 10, (windowContentWidth - 20*3)/2, 40);
                refBtn.layer.cornerRadius=5;
                refBtn.backgroundColor = kColor(250,96,101);
                [refBtn setTitle:@"拒绝" forState:UIControlStateNormal];
                [refBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [refBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
                refBtn.tag = 2; [cell addSubview:refBtn];

            }
        }
        return cell;
    }else{
        static NSString *CellIdentifier100 = @"cellIdentifier100";
        openShopCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier100];
        
        if (cell == nil)
        {
            cell = [[openShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier100];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.titleLabel.text = [[titleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        if(indexPath.section == 0 && indexPath.row == 0){
            if ([model.status integerValue] == 0) {
                cell.detailtitleLabel.text = @"待审核";
            }else if ([model.status integerValue] == 1) {
                cell.detailtitleLabel.text = @"已通过";
            }else if ([model.status integerValue] == 3) {
                cell.detailtitleLabel.text = @"已拒绝";
            }
            
        }else if(indexPath.section == 1 && indexPath.row == 0){
            cell.detailtitleLabel.text = model.partner_shop_name;
            
        }else if(indexPath.section == 1 && indexPath.row == 1){
            cell.detailtitleLabel.hidden = YES;
           UIImageView *logoIGV = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth -45 -40,cell.frame.size.height/2-40/2, 40, 40)];
            logoIGV.backgroundColor = [UIColor clearColor];
            NSString *urlstr = [[NSString stringWithFormat:@"%@/",WLHTTP] stringByAppendingString:[self judgeReturnString:model.logo withReplaceString:@""]];
            [logoIGV sd_setImageWithURL:[NSURL URLWithString:urlstr] placeholderImage:[UIImage imageNamed:@"默认图1"]];
            [cell addSubview:logoIGV];
            
        }else if(indexPath.section == 2 && indexPath.row == 0){
            cell.detailtitleLabel.hidden = YES;
            UIImageView *logoIGV = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth -45 -40,cell.frame.size.height/2-40/2, 40, 40)];
            logoIGV.backgroundColor = [UIColor clearColor];
            NSString *urlstr = [[NSString stringWithFormat:@"%@/",WLHTTP] stringByAppendingString:[self judgeReturnString:model.business_licenses withReplaceString:@""]];
            [logoIGV sd_setImageWithURL:[NSURL URLWithString:urlstr] placeholderImage:[UIImage imageNamed:@"默认图1"]];
            [cell addSubview:logoIGV];
            
        }else if(indexPath.section == 2 && indexPath.row == 1){
            cell.detailtitleLabel.hidden = YES;
            UIImageView *logoIGV = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth -45 -40,cell.frame.size.height/2-40/2, 40, 40)];
            logoIGV.backgroundColor = [UIColor clearColor];
            NSString *urlstr = [[NSString stringWithFormat:@"%@/",WLHTTP] stringByAppendingString:[self judgeReturnString:model.hygiene_licenses withReplaceString:@""]];
            [logoIGV sd_setImageWithURL:[NSURL URLWithString:urlstr] placeholderImage:[UIImage imageNamed:@"默认图1"]];
            [cell addSubview:logoIGV];

            
        }else if(indexPath.section == 2 && indexPath.row == 2){
            cell.detailtitleLabel.text = model.shop_dir;
            
        }else if(indexPath.section == 2 && indexPath.row == 3){
            cell.detailtitleLabel.text = model.friendly_msg;
            
        }else if(indexPath.section == 3 && indexPath.row == 0){
            cell.detailtitleLabel.text = model.partner_shop_main_name;
            
        }else if(indexPath.section == 3 && indexPath.row == 1){
            cell.detailtitleLabel.text = model.main_phone;
            
        }else if(indexPath.section == 3 && indexPath.row == 2){
            cell.detailtitleLabel.text = model.wx_sn;
            
        }else if(indexPath.section == 3 && indexPath.row == 3){
            if (model.contact && [model.contact isKindOfClass:[NSDictionary class]] && ![model.contact isKindOfClass:[NSNull class]] ) {
                NSDictionary  *dictionary = model.contact;
                cell.detailtitleLabel.numberOfLines = 2;
                cell.detailtitleLabel.text = [[[dictionary objectForKey:@"mobile"] stringByAppendingString:@"\n"] stringByAppendingString:[dictionary objectForKey:@"phone"]];
            }
            
        }else if(indexPath.section == 4 && indexPath.row == 0){
            if (model.bank_sn && [self judgeString:model.bank_sn]== YES) {
                cell.detailtitleLabel.text = @"已绑定";
            }else{
                cell.detailtitleLabel.text = @"未绑定";
            }
            
        }
        
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)submit:(UIButton *)button {
    
    if (button.tag == 1) {
        NSString *md5str = [NSString stringWithFormat:@"~0;id<zOD.{ll@]JKi(:%@",[[LXUserTool alloc] getUid]];
        md5str = [WXUtil md5:md5str];
        NSDictionary *parameters =@{@"assistant_id":[[LXUserTool alloc] getUid],@"wltoken":md5str,@"status":@"1",@"main_phone":model.main_phone,@"features_eat_partner_id":model.shopid};
        [self sendRequestWithParamers:parameters];
    }else if(button.tag ==2){
        CSHRefuseViewController *refuse = [[CSHRefuseViewController alloc] init];
        refuse.main_phone = model.main_phone;
        refuse.shopid = model.shopid;
        refuse.member_id = model.member_id;
        [self.navigationController pushViewController:refuse animated:YES];
    }
}
-(void)sendRequestWithParamers:(NSDictionary *)parameters{
    NSLog(@"%@",parameters);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:AduitUrl parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *html = operation.responseString;
              NSRange range = [html rangeOfString:@"{"];
              html = [html substringFromIndex:range.location];
  
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
               //NSLog(@"dict = %@ msg =%@" ,dict,[dict objectForKey:@"msg"]);
              if ([[dict objectForKey:@"state"] integerValue] ==1) {
                   [self.navigationController popViewControllerAnimated:YES];
                   [[LXAlterView sharedMyTools] createTishi:[dict objectForKey:@"msg"]];
              }else{
                  [[LXAlterView sharedMyTools] createTishi:[dict objectForKey:@"msg"]];
              }
              
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              
          }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  DPViewController.m
//  WelLv
//
//  Created by liuxin on 15/11/6.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//
#import "JYCRestauantVC.h"
#import "DPViewController.h"
#import "WriteOffViewController.h"
#import "shopSettingViewController.h"
#import "SportSettingViewController.h"

@interface DPViewController ()
{
    UITableView *_tableView;
    NSMutableArray *titleArray;
    NSMutableArray *detailTitleArray;
}
@end

@implementation DPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor(214, 223, 230);
    self.navigationItem.title = @"微旅店家";
    NSArray *array1 = [NSArray arrayWithObjects:@"消费券核销", nil];
    NSArray *array2 = [NSArray arrayWithObjects:@"查看店铺",@"店铺设置", nil];
    NSArray *array3 = [NSArray arrayWithObjects:@"发布店铺活动", nil];
    titleArray = [NSMutableArray arrayWithObjects:array1,array2,array3, nil];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-NavHeight)];
    _tableView.tableFooterView = [[UIView alloc] init];//去掉多余的cell
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = kColor(215, 218, 220);
    [self.view addSubview:_tableView];
    // Do any additional setup after loading the view.
}
#pragma mark -tableView dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  titleArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 13;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[titleArray objectAtIndex:section] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        WriteOffViewController *WriteOff = [[WriteOffViewController alloc] init];
        [self.navigationController pushViewController:WriteOff animated:YES];

        NSLog(@"消费卷核销");
    } else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            JYCRestauantVC *JycDp = [[JYCRestauantVC alloc] init];
            JycDp.type = 2;
            [self.navigationController pushViewController:JycDp animated:YES];
            NSLog(@"查看店铺");
        }
        else{
            shopSettingViewController *shopSet = [[shopSettingViewController alloc] init];
            [self.navigationController pushViewController:shopSet animated:YES];
            NSLog(@"店铺设置");
        }
    }
    else
    {
        SportSettingViewController *sp = [[SportSettingViewController alloc] init];
        [self.navigationController pushViewController:sp animated:YES];
        NSLog(@"发布商铺活动");
    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        UIImageView *zxdBut = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-45, 7.5, 45, 30)];
        [zxdBut setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
        [cell addSubview:zxdBut];
        cell.textLabel.text = [[titleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        //单元格风格
    }
    return cell;
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

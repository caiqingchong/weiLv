//
//  StewardInformationVC.m
//  WelLv
//
//  Created by liuxin on 16/3/23.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//
//管家个人资料界面
#import "StewardInformationVC.h"

@interface StewardInformationVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_zxdTableView;
    NSArray *_zxdArr1;
    NSArray *_zxdArr2;
    NSArray *_zxdArr3;
    NSMutableArray *_zxdArrTitle;//tableviewcell的标题数组
    NSMutableArray *_zxdDetailArr1;
    NSMutableArray *_zxdDetailArr2;
    NSMutableArray *_zxdDetailArr3;
    NSMutableArray *_zxdArrDetail;//右侧信息数组
    
}

@end

@implementation StewardInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTitle];
    [self creatTableView];
}
#pragma mark---界面的标题和背景设置
-(void)creatTitle
{
    //设置标题字体的大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor redColor]}];
    
    

    self.navigationItem.title = @"个人资料";
    self.view.backgroundColor = BgViewColor;
}
#pragma mark---创建TableView
-(void)creatTableView
{
    _zxdArr1 = [NSArray arrayWithObjects:@"头像",@"姓名", @"心情",nil];
    _zxdArr2 = [NSArray arrayWithObjects:@"手机号",@"QQ", @"邮箱",nil];
    _zxdArr3 = [NSArray arrayWithObjects:@"性别",@"籍贯", @"出生日期",@"星座",@"学历",@"职业",@"居住地",nil];
    _zxdArrTitle = [[NSMutableArray alloc] initWithObjects:_zxdArr1,_zxdArr2,_zxdArr3, nil];
    //创建tableView
    _zxdTableView = [[UITableView alloc] init];
    _zxdTableView.frame = CGRectMake(0, 0, windowContentWidth, windowContentHeight);
  //  _zxdTableView.tableFooterView = [[UIView alloc] init];
    _zxdTableView.backgroundColor = BgViewColor;
    _zxdTableView.delegate = self;
    _zxdTableView.dataSource = self;
    [self.view addSubview:_zxdTableView];
}
#pragma mark-----tableView dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _zxdArrTitle.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_zxdArrTitle objectAtIndex:section] count];
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section
{
    return 15;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc] initWithFrame:_zxdTableView.tableFooterView.frame];
    footView.backgroundColor = BgViewColor;
    return footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        return 70;
    }
    else
    {
        return 45;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0&&indexPath.section==0) {
        static NSString *CellIdtifier1 =@"cellIddertifier1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdtifier1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdtifier1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.text = [[_zxdArrTitle objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        return cell;
    }
    else
    {
        static NSString *CellIdtifier2 =@"cellIddertifier2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdtifier2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdtifier2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.text  = [[_zxdArrTitle objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        return cell;
    }
    return nil;
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
